# Cleanup

## gitlab.com git repository

TODO : be careful: when we hit the 10GB quota it is impossible to do cleanup : the fastest way to do it then is to ... delete the project, reconfigure gitlab pages, and re-add ssh key for fdroid repository manager, ...

## git.legeox.net artifacts

With a owner access token, cleanup all the artifacts in one batch:

```bash
curl --request DELETE --header "PRIVATE-TOKEN: glpat-XXXXXX" "https://git.legeox.net/api/v4/projects/77/artifacts"
```

## Maintenance

```shell
rm -Rf Signal-Android
git clone --depth 1 --recurse-submodules -b "$(curl https://api.github.com/repos/signalapp/Signal-Android/tags | jq -r '.[] .name' | sed '/-/!{s/$/_/}' | sort -V | grep -v nightly | sed 's/_$//'|tail -n1)" https://github.com/WhisperSystems/Signal-Android
cd Signal-Android
for f in ../0000-*.patch; do echo "$f"; git apply "$f"; done
```
