import System.Environment (getArgs)
import System.IO (withBinaryFile, IOMode(..), hPutStrLn)
import System.Random.Mersenne
import Data.Maybe (catMaybes, listToMaybe)
import Data.List (sort)
import qualified Data.ByteString.Char8 as B

data Vec = Vec {
      x :: Double,
      y :: Double,
      z :: Double
    } deriving (Eq)

data Isect = Isect {
      isect_t :: Double,
      isect_p :: Vec,
      isect_n :: Vec
    } deriving (Eq)

instance Ord Isect where
    i1 < i2   = isect_t i1 < isect_t i2
    i1 > i2   = isect_t i1 > isect_t i2
    i1 <= i2  = isect_t i1 <= isect_t i2
    i1 >= i2  = isect_t i1 >= isect_t i2

data Sphere = Sphere {
      sphere_center :: Vec,
      sphere_radius :: Double
    }

data Plane = Plane {
      plane_p :: Vec,
      plane_n :: Vec
    }

data Ray = Ray {
      ray_org :: Vec,
      ray_dir :: Vec
    }

type Point = (Int, Int)

-- Floatint-point Color
type FColor = Vec

sq :: Num a => a -> a
sq x = x * x

clamp :: Ord a => a -> a -> a -> a
clamp lower upper = min upper . max lower

i2d :: Int -> Double
i2d = toEnum

fpcol2icol vec = (f2i (x vec), f2i (y vec), f2i (z vec))
f2i = clamp 0 255 . floor . (* 255.99)

drand48 :: IO Double
drand48 = getStdGen >>= random

justIf :: a -> Bool -> Maybe a
val `justIf` cond
    | cond      = Just val
    | otherwise = Nothing

zerovec = Vec { x = 0, y = 0, z = 0 }
white = Vec { x = 1, y = 1, z = 1 }

v0 `vadd` v1 = Vec (x v0 + x v1) (y v0 + y v1) (z v0 + z v1)
v0 `vsub` v1 = Vec (x v0 - x v1) (y v0 - y v1) (z v0 - z v1)
v0 `vscale` s = Vec (x v0 * s) (y v0 * s) (z v0 * s)

v0 `vdot` v1 = (x v0 * x v1) + (y v0 * y v1) + (z v0 * z v1)

v0 `vcross` v1 = Vec cx cy cz
    where
      cx = y v0 * z v1 - z v0 * y v1
      cy = z v0 * x v1 - x v0 * z v1
      cz = x v0 * y v1 - y v0 * x v1

vlength c = sqrt $ c `vdot` c

vnormalize c
    | l > 1.0e-17	= c `vscale` (1.0 / l)
    | otherwise		= c
    where
      l = vlength c

vaverage :: [Vec] -> Vec
vaverage vecs = vsum `vscale` (1.0 / i2d vecnum)
    where vsum = foldl vadd zerovec vecs
          vecnum = length vecs

ray_sphere_intersect :: Ray -> Sphere -> Maybe Isect
ray_sphere_intersect ray sphere =
    isect `justIf` (d > 0.0 && t > 0.0)
    where
      rs = ray_org ray `vsub` sphere_center sphere
      b = rs `vdot` ray_dir ray
      c = rs `vdot` rs - sq (sphere_radius sphere)
      d = b * b - c
      t = -b - sqrt d
      hitpos = ray_org ray `vadd` (ray_dir ray `vscale` t)
      isect = Isect {
		isect_t = t,
		isect_p = hitpos,
		isect_n = vnormalize $ hitpos `vsub` sphere_center sphere
	      }

ray_plane_intersect :: Ray -> Plane -> Maybe Isect
ray_plane_intersect ray plane =
    isect `justIf` (abs v >= 1.0e-17 && t > 0)
    where
      d = -(plane_p plane `vdot` plane_n plane)
      v = ray_dir ray `vdot` plane_n plane
      t = -(ray_org ray `vdot` plane_n plane + d) / v
      isect = Isect {
		isect_t = t,
		isect_p = ray_org ray `vadd` (ray_dir ray `vscale` t),
		isect_n = plane_n plane
	      }

orthoBasis :: Vec -> (Vec, Vec, Vec)
orthoBasis n = (basis0, basis1, basis2)
    where
      basis2 = n
      basis1'
          | x n < 0.6 && x n > -0.6  = Vec { x = 1, y = 0, z = 0 }
          | y n < 0.6 && y n > -0.6  = Vec { x = 0, y = 1, z = 0 }
	  | z n < 0.6 && z n > -0.6  = Vec { x = 0, y = 0, z = 1 }
	  | otherwise                = Vec { x = 1, y = 0, z = 0 }
      basis0 = vnormalize $ basis1' `vcross` basis2
      basis1 = vnormalize $ basis2 `vcross` basis0

hemisphereDirectionRay :: Vec -> (Vec, Vec, Vec) -> Double -> Double -> Ray
hemisphereDirectionRay p (basis0, basis1, basis2) r1 r2 =
    Ray { ray_org = p, ray_dir = r }
    where
      theta = sqrt r1
      phi = 2.0 * pi * r2
      v = Vec {
	    x = cos phi * theta,
	    y = sin phi * theta,
	    z = sqrt $ 1.0 - sq theta
	  }
      -- local -> global
      r = Vec {
	    x = x v * x basis0 + y v * x basis1 + z v * x basis2,
	    y = x v * y basis0 + y v * y basis1 + z v * y basis2,
	    z = x v * z basis0 + y v * z basis1 + z v * z basis2
	  }

randomHemisphereRay :: Vec -> Vec -> IO Ray
randomHemisphereRay p n = do
  r1 <- drand48
  r2 <- drand48
  return $ hemisphereDirectionRay p (orthoBasis n) r1 r2

data Object = ObjSphere Sphere | ObjPlane Plane

findRayObjIntersect :: Ray -> Object -> Maybe Isect
findRayObjIntersect ray (ObjSphere sphere) = ray_sphere_intersect ray sphere
findRayObjIntersect ray (ObjPlane  plane)  = ray_plane_intersect  ray plane

isHitOccluder :: [Object] -> Ray -> Bool
isHitOccluder objs ray =
    not $ null $ catMaybes $ map (findRayObjIntersect ray) objs

ambient_occlusion :: [Object] -> Int -> Isect -> IO FColor
ambient_occlusion objs nao_samples isect = do
  randomRays <- sequence $ replicate nsample $ randomHemisphereRay p n
  let occludedNum = length [ray | ray <- randomRays, isHitOccluder objs ray]
  return $ vscale white $ 1.0 - occludedRatio occludedNum
    where
      eps = 0.0001
      n = isect_n isect
      p = isect_p isect `vadd` (n `vscale` eps)
      nsample = sq nao_samples
      occludedRatio occludedSampleNum =
          i2d occludedSampleNum / i2d nsample

screenRay :: Int -> Int -> Point -> Ray
screenRay w h (x, y) =
    Ray { ray_org = zerovec, ray_dir = vnormalize (Vec { x = px, y = py, z = -1 }) }
    where
      px = (i2d x - w_2) / w_2
      py = -(i2d y - h_2) / h_2
      w_2 = i2d w / 2.0
      h_2 = i2d h / 2.0

findNearestIsect :: [Object] -> Ray -> Maybe Isect
findNearestIsect objs ray =
    listToMaybe $ sort $ catMaybes $ map (findRayObjIntersect ray) objs

data Scene = Scene {
      scene_objs :: [Object]
    }

raytrace :: (Maybe Isect -> IO FColor) -> [Object] -> Ray -> IO FColor
raytrace fShading objs ray =
    fShading $ findNearestIsect objs ray

oversampling :: (Point -> IO FColor) -> Int -> IO FColor
oversampling fCalcCol nsubsamples =
  mapM fCalcCol subpixels >>= return . vaverage
    where
      subpixels = [(u, v) | v <- [0 .. nsubsamples-1], u <- [0 .. nsubsamples-1]]

renderSubsampledRayTracePixel :: (Ray -> IO FColor) -> Int -> Int -> Int -> Point -> IO FColor
renderSubsampledRayTracePixel fTrace w h nsubsamples (x, y) =
  oversampling calcCol nsubsamples
    where
      calcCol = fTrace . screenRay subedWidth subedHeight . subedPoint
      subedPoint (u, v) = (x * nsubsamples + u, y * nsubsamples + v)
      subedWidth = w * nsubsamples
      subedHeight = h * nsubsamples

renderScreen :: Int -> Int -> (Point -> IO col) -> IO [col]
renderScreen w h fRenderPixel =
  mapM fRenderPixel screenPixels
    where
      screenPixels = [(x, y) | y <- [0 .. h-1], x <- [0 .. w-1]]

renderAmbientOcclusionScene :: Scene -> Int -> Int -> Int -> Int -> IO [(Int, Int, Int)]
renderAmbientOcclusionScene scene w h nsubsamples nao_samples = do
  fimg <- renderScreen w h calcPixelColor
  return $ map fpcol2icol fimg
    where
      calcPixelColor = renderSubsampledRayTracePixel (raytrace shading objs) w h nsubsamples
      shading Nothing = return zerovec
      shading (Just isect) = ambient_occlusion objs nao_samples isect
      objs = scene_objs scene

saveppm :: String -> Int -> Int -> [(Int, Int, Int)] -> IO ()
saveppm fname w h img =
    withBinaryFile fname WriteMode $ \fp -> do
      hPutStrLn fp "P6"
      hPutStrLn fp $ show w ++ " " ++ show h
      hPutStrLn fp "255"
      B.hPut fp $ B.pack $ map toEnum $ concatMap (\(r,g,b) -> [r,g,b]) img

init_scene = Scene {
	       scene_objs = [
		ObjSphere (Sphere { sphere_center = Vec { x = -2.0, y = 0.0, z = -3.5 }, sphere_radius = 0.5 }),
		ObjSphere (Sphere { sphere_center = Vec { x = -0.5, y = 0.0, z = -3.0 }, sphere_radius = 0.5 }),
		ObjSphere (Sphere { sphere_center = Vec { x =  1.0, y = 0.0, z = -2.2 }, sphere_radius = 0.5 }),
		ObjPlane  (Plane  { plane_p = Vec { x = 0.0, y = -0.5, z = 0.0 }, plane_n = Vec { x = 0.0, y = 1.0, z = 0.0 } })
	       ]
	     }

getParam idx defaultVal args
    | length args > idx  = args !! idx
    | otherwise          = defaultVal

main = do
  args <- getArgs
  let width  = read $ getParam 0 "256" args
  let height = read $ getParam 1 "256" args
  let nsubsamples = read $ getParam 2 "2" args
  let nao_samples = read $ getParam 3 "8" args

  img <- renderAmbientOcclusionScene init_scene width height nsubsamples nao_samples
  saveppm "ao.ppm" width height img
