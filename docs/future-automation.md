# Future Automation

Deployment automation is intentionally deferred until the manual deployment process is stable and fully understood.

Potential future deployment workflow:

```text
Local development
    ↓
GitHub push
    ↓
SSH into Lightsail
    ↓
git pull
    ↓
nginx validation
    ↓
nginx reload
```

Potential future improvements:

- GitHub Actions deployment
- Automated SSH deployment
- Automated nginx validation
- Rollback scripts
- Health checks
- Monitoring integration

Automation should only be added once:
- deployment flow is stable
- rollback procedures are proven
- infrastructure structure is stable