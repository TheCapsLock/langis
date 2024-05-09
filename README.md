# Cleanup

## gitlab.com git repository

TODO : be careful: when we hit the 10GB quota it is impossible to do cleanup : the fastest way to do it then is to ... delete the project, reconfigure gitlab pages, and re-add ssh key for fdroid repository manager, ...

## git.legeox.net artifacts

With a owner access token, cleanup all the artifacts in one batch:

```bash
curl --request DELETE --header "PRIVATE-TOKEN: glpat-XXXXXX" "https://git.legeox.net/api/v4/projects/77/artifacts"
```