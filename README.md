# docker-reverse-proxy

`docker-reverse-proxy` acts as a proxy container for your application. It is based
on Apache and allows to restrict access with a CAS SSO, IP restrictions, and/or REMOTE_USER matching.

It runs fine on OpenShift and binds port 8080 per default.

## Environment variabels

- `PROXY_TARGET_URL` URL of the application to proxy to, must end with a trailing slash `/`. On OpenShift, this usually is something like `http://service:port/`
- `CAS_ENABLED` enable CAS authentication (disabled by default)
  - `CAS_LOGIN_URL` the login URL of your CAS service (e.g. https://sso.example.net/login)
  - `CAS_VALIDATE_URL` the CAS validate URL of your CAS service (e.g. https://sso.example.net/serviceValidate)
  - `CAS_PROXY_VALIDATE_URL` the CAS proxy validate URL of your CAS service (e.g. https://sso.example.net/proxyValidate)
  - `CAS_SERVICE_URL` the domain of the service the proxy is running at, usually this is the URL that you connect to this application afterwards, it is used to tell the CAS service where to redirect back
- `OIDC_ENABLED` enable OpenID Connect authentication (disabled by default)
  - `OIDC_PROVIDER_METADATA_URL` the metadata url of your OpenID Connect provider (e.g. https://keycloak.example.com/auth/realms/master/.well-known/openid-configuration)
  - `OIDC_CLIENT_ID` the oidc client id
  - `OIDC_CLIENT_SECRET` the oidc client secret
  - `OIDC_REDIRECT_URL` the redirect url of your application
  - `OIDC_CRYPTO_PASSPHRASE` the passphrase with which Apache encrypts temporary state cookies and cache entries. (see https://github.com/zmartzone/mod_auth_openidc/blob/master/auth_openidc.conf#L16)
- `IPS_ACCESS_WHITELIST` optional comma separated list of IPs/subnets that are allowed to access the proxy
- `REMOTE_USER_REGEX` optional regex the `REMOTE_USER` must match against (e.g. `!@example.net$`)
- `LOG_LEVEL` optional log level for Apache (default is `info`)
- `HEALTHCHECK_ENABLED` when enabled, this will proxy /health (no authentication needed) to the given target path (see below) of the target URL (disabled by default)
  - `HEALTHCHECK_TARGET_PATH` target path for the health check on the target url (`PROXY_TARGET_URL`)
  - `HEALTHCHECK_IPS` optional comma separated list of IPs/subnets that are allowed to access the /health endpoint

## Testing it locally

To run it locally, you can use the following commands:

```sh
docker build -t docker-reverse-proxy:latest .
docker run -ti -p 9999:8080 -e PROXY_TARGET_URL='http://example.net/' docker-reverse-proxy
```

With OpenID Connect authentication (Keycloak for example):

```sh
docker run -e OIDC_ENABLED=1 \
           -e OIDC_PROVIDER_METADATA_URL=https://keycloak.domain.com/auth/realms/master/.well-known/openid-configuration \
           -e OIDC_CLIENT_SECRET=03d6350b-5c29-443a-94a1-2320bb16ef49 \
           -e OIDC_CLIENT_ID=apache-test \
           -e OIDC_REDIRECT_URL=http://localhost:8080/oauth2callback \
           -e OIDC_CRYPTO_PASSPHRASE=QdkxCr3cSdcNCUxHw \
           -e PROXY_TARGET_URL=http://localhost \
           -p 8080:8080 apache-test
```
