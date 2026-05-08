# Current Infrastructure

## Server

Provider: AWS Lightsail  
OS: Ubuntu 24.04.4 LTS  
Public IP: 16.60.101.13  
SSH user: ubuntu  

---

## SSH Access

Local SSH access is configured using a Lightsail PEM key.

Example connection:

```bash
ssh -i ~/.ssh/LightsailDefaultKey-eu-west-2.pem ubuntu@16.60.101.13
```

---

## Domain

Primary domain:

jamesarris.dev

DNS is managed through Cloudflare.

Current DNS records:

```text
A      @       16.60.101.13       DNS only
CNAME  www     jamesarris.dev     DNS only
```

Cloudflare proxy is currently disabled.

---

## Web Server

Web server:

nginx

Current live nginx web root:

```text
/var/www/html
```

Prepared portfolio deployment directory:

```text
/var/www/portfolio-site
```

---

## TLS / HTTPS

TLS is provided using:

Let's Encrypt + Certbot

Likely nginx config locations:

```text
/etc/nginx/sites-available/default
/etc/nginx/sites-enabled/default
```

---

## Deployment State

Current production website is still served from:

```text
/var/www/html
```

Portfolio repository has been cloned to:

```text
/var/www/portfolio-site
```

nginx has not yet been switched to serve the portfolio-site repository.

---

## Current Stack

Infrastructure currently includes:

- AWS Lightsail
- Ubuntu Linux
- nginx
- Cloudflare DNS
- Let's Encrypt
- GitHub repositories
- SSH key authentication