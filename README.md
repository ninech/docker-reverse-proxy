# docker-reverse-proxy

## Environment variabels

- `PROXY_TARGET_URL` URL of your application, must have a trailing slash `/`
- `CAS_ENABLED` enable CAS authentication (disabled by default)
  - `CAS_LOGIN_URL`
  - `CAS_VALIDATE_URL`
  - `CAS_PROXY_VALIDATE_URL`
  - `CAS_SERVICE_URL` the domain of this service, will be used for redirection to the CAS service
- `IPS_ACCESS_WHITELIST` optional comma separated list of ips/subnets that are allowed to access
- `REMOTE_USER_REGEX` optional regex the remote user must match against (e.g. `!@nine.ch$`)
