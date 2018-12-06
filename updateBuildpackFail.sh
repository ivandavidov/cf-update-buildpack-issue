#!/bin/bash

# Uncomment the next line for "fast-fail"
#set -e
set -x

# Check the CF CLI version
cf --version



### INITIAL CLEANUP ###

# Remove the dymmy buildpack with 'cflinuxfs2' stack
if [ "`cf buildpacks | grep dummy_buildpack.*cflinuxfs2`" ] ; then
  cf delete-buildpack dummy_buildpack -s cflinuxfs2 -f
fi

# Remove the dymmy buildpack with 'cflinuxfs3' stack
if [ "`cf buildpacks | grep dummy_buildpack.*cflinuxfs3`" ] ; then
  cf delete-buildpack dummy_buildpack -s cflinuxfs3 -f
fi



### GENERATE DUMMY BUILDPACK (cflinuxfs2) ###

# Update the manifest and specify 'cflinuxfs2' stack
sed -i "s|\\(.*\\)cflinuxfs.*|\\1cflinuxfs2|g" dummy_buildpack/manifest.yml

# Let's see what we have in the manifest file
cat dummy_buildpack/manifest.yml

# Now we create the dummy buildpack with 'cflinuxfs2' stack
cf create-buildpack dummy_buildpack dummy_buildpack/ 1

# Let's see what's going on with all buildpacks
cf buildpacks



### GENERATE DUMMY BUILDPACK (cflinuxfs3) ###

# Update the manifest and specify 'cflinuxfs3' stack
sed -i "s|\\(.*\\)cflinuxfs.*|\\1cflinuxfs3|g" dummy_buildpack/manifest.yml

# Let's see what we have in the manifest file
cat dummy_buildpack/manifest.yml

# Now we create the dummy buildpack with 'cflinuxfs3' stack
cf create-buildpack dummy_buildpack dummy_buildpack/ 1

# Let's see what's going on with all buildpacks
cf buildpacks



###   FAIL - UPDATE BUILDPACK (cflinuxfs2)   ###

# Update the manifest and specify 'cflinuxfs2' stack
sed -i "s|\\(.*\\)cflinuxfs.*|\\1cflinuxfs2|g" dummy_buildpack/manifest.yml

# Let's see what we have in the manifest file
cat dummy_buildpack/manifest.yml

# (FAILURE AT THIS POINT) Update the buildpack and move it to position 6
cf update-buildpack dummy_buildpack -p dummy_buildpack -s cflinuxfs2

# Let's see what's going on with all buildpacks
cf buildpacks



###   FAIL - UPDATE BUILDPACK (cflinuxfs3)   ###

# Update the manifest and specify 'cflinuxfs3' stack
sed -i "s|\\(.*\\)cflinuxfs.*|\\1cflinuxfs3|g" dummy_buildpack/manifest.yml

# Let's see what we have in the manifest file
cat dummy_buildpack/manifest.yml

# (FAILURE AT THIS POINT) Update the buildpack and move it to position 6
cf update-buildpack dummy_buildpack -p dummy_buildpack -s cflinuxfs3

# Let's see what's going on with all buildpacks
cf buildpacks
