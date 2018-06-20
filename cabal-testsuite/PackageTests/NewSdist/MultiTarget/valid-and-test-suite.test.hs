import Test.Cabal.Prelude
main = cabalTest $ withSourceCopy $ do
  cwd <- testCurrentDir <$> getTestEnv
  fails $ cabal "new-sdist" ["a", "b", "a-test"]
  shouldNotExist $ cwd </> "dist-newstyle/sdist/a-0.1.tar.gz"
  shouldNotExist $ cwd </> "dist-newstyle/sdist/b-0.1.tar.gz"
