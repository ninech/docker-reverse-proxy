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
- `IPS_ACCESS_WHITELIST` optional comma separated list of IPs/subnets that are allowed to access the proxy
- `REMOTE_USER_REGEX` optional regex the `REMOTE_USER` must match against (e.g. `!@example.net$`)

# Testing it locally

To run it locally, you can use the following commands:

```
docker build -t docker-reverse-proxy:latest .
docker run -ti -p 9999:8080 -e PROXY_TARGET_URL='http://example.net/' docker-reverse-proxy
```
