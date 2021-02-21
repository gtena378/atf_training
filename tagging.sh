#!/bin/bash

cw=`date +%-V`
echo "Week number: $cw"

cwu=`date +%-U`
echo "Week number: $cwu"

yn=`date +%y`
echo "Year number: $yn"

current_tag="$yn.$cw"
echo "Current tag: $current_tag"

tag=$(git describe --tags `git rev-list --tags --max-count=1`)
echo "Latest tag: $tag"

if [[ $tag == *$current_tag* ]]; then
  echo "It's there."
  current_patch=$(echo $tag| cut -d'.' -f 3)
  echo "current_patch: $current_patch"
  new_patch=$(echo $((current_patch+1)))
  echo "new_patch: $new_patch"
  new_tag=$current_tag.$new_patch

  # echo "git tag $current_tag.$new_patch"
  # git tag $current_tag.$new_patch
else
  echo "There's none"
  new_tag=$current_tag.0

  # echo "git tag $current_tag.0"
  # git tag $current_tag.0 
fi

echo "new tag: $new_tag"
# git tag $new_tag
echo "pushing tags into remote..."
# git push --tags

export BUILD_BUILDID=$new_tag
export BUILD_NUMBER=$new_tag

echo "BUILD_NUMBER: $BUILD_NUMBER"