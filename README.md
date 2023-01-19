[![Publish Docker image](https://github.com/bibbox/img-phenotips/actions/workflows/docker-publish.yml/badge.svg)](https://github.com/bibbox/img-phenotips/actions/workflows/docker-publish.yml)

# PHENOTIPS image for BIBBOX application

Check out the app repository [app-phenotips](https://github.com/bibbox/app-phenotips).

## Build and push to dockerhub

```
docker build . -t bibbox/phenotips:1.4.9

docker push bibbox/phenotips:1.4.9
```
