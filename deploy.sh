touch ./build/stat489/.nojekyll
git add build/ -f
git add ./build/stat489/.nojekyll -f
git commit -m "Added the current build and .nojekyll file as part of deployment"
git subtree push --prefix build/stat489 origin gh-pages
