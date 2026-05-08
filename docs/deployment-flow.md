# Deployment Flow

## Current State

The portfolio site is currently developed locally, pushed to GitHub, and manually pulled onto the Lightsail server.

The public nginx root is still:

```text
/var/www/html
```

The prepared repository deployment path is:

```text
/var/www/portfolio-site
```

nginx has not yet been switched to serve directly from `/var/www/portfolio-site`.

---

## Application Repository

Repository:

```text
https://github.com/jamesarris-dev/portfolio-site
```

Local development path:

```text
~/Developer/portfolio-site
```

Server deployment path:

```text
/var/www/portfolio-site
```

---

## Current Manual Deployment Process

### 1. Make changes locally

```bash
cd ~/Developer/portfolio-site
```

Edit site files.

---

### 2. Test locally

```bash
python3 -m http.server 8080
```

Open:

```text
http://localhost:8080
```

Stop server:

```text
CTRL + C
```

---

### 3. Commit and push

```bash
git status
git add .
git commit -m "update portfolio site"
git push
```

---

### 4. SSH into server

```bash
ssh -i ~/.ssh/LightsailDefaultKey-eu-west-2.pem ubuntu@16.60.101.13
```

---

### 5. Pull latest site version

```bash
cd /var/www/portfolio-site
git pull
```

---

## nginx Serving Plan

Current live root:

```text
/var/www/html
```

Target live root:

```text
/var/www/portfolio-site
```

Required nginx config change:

```nginx
root /var/www/portfolio-site;
```

This should be changed only inside the active `jamesarris.dev` HTTPS server block.

Certbot-managed TLS lines must not be removed.

---

## Validation After nginx Change

After editing nginx config:

```bash
sudo nginx -t
```

If config test passes:

```bash
sudo systemctl reload nginx
```

Then validate:

```bash
curl -I https://jamesarris.dev
```

Expected:

```text
HTTP/2 200
```

Then open:

```text
https://jamesarris.dev
```

---

## Rollback Plan

If the site breaks, restore the nginx root back to:

```text
/var/www/html
```

Then run:

```bash
sudo nginx -t
sudo systemctl reload nginx
```

---

## Future Automation

A future deployment script may:

1. SSH into the server
2. `cd /var/www/portfolio-site`
3. `git pull`
4. test nginx
5. reload nginx if needed

Automation is not implemented yet.