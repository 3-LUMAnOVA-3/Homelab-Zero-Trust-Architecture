# 🛡️ Architecture de Sécurité Hybride (Zero Trust)

Cette section détaille le cœur de la sécurité de mon infrastructure. Pour maximiser la protection et cacher l'adresse IP de mon domicile, j'utilise une architecture de **Relais VPS (Bastion Host)**.

## ☁️ Le Nœud Cloud (VPS Hostinger)
Au lieu d'ouvrir les ports de mon routeur domestique, mon point d'entrée public est un serveur VPS hébergé chez Hostinger. Ce serveur fait tourner :
* **Nginx Proxy Manager (NPM) :** Il gère le routage et les certificats SSL (Let's Encrypt).
* **Authelia & LLDAP :** Le portail SSO qui exige une authentification forte (Mot de passe + OTP Email / YubiKey) avant même de voir mes services.

## 🔐 Le Tunnel SD-WAN (Tailscale)
Le VPS Hostinger est connecté au reste de mon Homelab via un réseau maillé **Tailscale**. 
* **Sécurité HTTPS Interne :** J'ai configuré NPM pour générer et forcer des certificats HTTPS valides directement sur les adresses IP privées Tailscale de mes services (ex: port 81 pour l'admin NPM).
* **Isolation :** Aucun trafic ne passe en clair. Une fois authentifié par Authelia sur le cloud, le trafic est chiffré dans le tunnel Tailscale pour redescendre vers les instances Proxmox (Cerbère et Lumanova) ou le cluster Docker (Pi 5) à la maison.
