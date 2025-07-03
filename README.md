# Shadowsocks + Obfs (TLS disguise) on Railway

## 🚀 How to Deploy

1. Fork this repo.
2. Go to [https://railway.app](https://railway.app)
3. Click **New Project → Deploy from GitHub Repo**
4. Select this repo.
5. Set these variables:

| Key           | Value                 |
|---------------|-----------------------|
| PASSWORD      | yourpassword          |
| OBFS_DOMAIN   | www.microsoft.com     |
| SERVER_PORT   | 8388 (or keep default)|
| METHOD        | chacha20-ietf-poly1305|
| OBFS          | http                  |

---

## ✅ Connect Using Shadowsocks Client

Plugin: `obfs-local`  
Plugin Options: `obfs=http;obfs-host=www.microsoft.com`
