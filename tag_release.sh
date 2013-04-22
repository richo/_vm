#!/bin/sh

current_release=0
release_series="v0.0."
for tag in `git tag`; do
    echo $tag | grep -Eo "${release_series}(\d+)" >/dev/null
    [ $? -gt 0 ] && continue
    this_tag=$(echo $tag | grep -Eo "(\d+)$")
    [ $this_tag -gt $current_release ] && current_release=$this_tag
done

current_release=$(( $current_release + 1 ))

git checkout HEAD^0

mkdir dist
for i in _*; do
    ruby $i > dist/$i
    [ $? -eq 0 ] || exit 1
done
git add dist
git commit -m "Add dist files for ${release_series}${current_release}"

git tag -s ${release_series}${current_release} -m "Release ${release_series}${current_release}"
git update-ref refs/heads/latest HEAD

cat <<EOF
Created a tag and updated branch latest
If all looks good, you can push this out with:

git push --tags
git push origin refs/heads/latest:refs/heads/latest

and then return to the master branch with:

git checkout master
EOF
