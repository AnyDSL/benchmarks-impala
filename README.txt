# impala

all benchmarks have been performed with the "cgo" branch:

git clone git@github.com:AnyDSL/thorin.git
git clone git@github.com:AnyDSL/impala.git

# GHC

using cabal you can install all dependencies via:

cabal update
cabal install mersenne-random parallel regex-pcre vector
