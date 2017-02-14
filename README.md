# docker-reverse-proxy

## Environment variabels

- `CAS_ENABLED` (enable CAS authentication)
  - `CAS_LOGIN_URL`
  - `CAS_VALIDATE_URL`
  - `CAS_PROXY_VALIDATE_URL`
- `IPS_ACCESS_WHITELIST` (comma separate list of ips/subnets that are allowed to connect)


docker run -ti -p 9999:80 -e CAS_ENABLED=0 -e CAS_LOGIN_URL="https://sso.nine.ch/" -e CAS_VALIDATE_URL="https://sso.nine.ch/serviceValidate" -e CAS_PROXY_VALIDATE_URL="https://sso.nine.ch/proxyValidate" -e IPS_ACCESS_WHITELIST="172.17.0.0/24,192.168.0.10" docker-reverse-proxy
