## Semantic Versioning

```text
MAJOR.MINOR.PATCH
```

| Thay đổi                   | Tăng  |
| -------------------------- | ----- |
| Thay base OS / breaking FS | MAJOR |
| Thêm package / user        | MINOR |
| Security patch             | PATCH |

### Ví dụ

```text
1.0.0  Initial production release
1.0.1  CVE patch
1.1.0  Add jq, openssl
2.0.0  Debian upgrade
```

## Tag Policy

- latest is updated manually
- Production must pin exact version

## Deprecation Policy

- Old MAJOR versions supported for 6–12 months
- Security patches only, no new features
