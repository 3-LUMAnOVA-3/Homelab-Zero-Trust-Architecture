# Homelab-Zero-Trust-Architecture
Homelab-Zero-Trust
Documentation complète de mon infrastructure "Homelab" auto-hébergée. Ce projet représente deux années d'apprentissage intensif en administration système, réseaux et sécurité. L'architecture repose sur une segmentation SD-WAN via Tailscale, une haute disponibilité avec Proxmox, et une gestion de conteneurs avec Docker, le tout protégé par des politiques d'accès Zero Trust (Authelia, YubiKey).

🏗️ Topologie Matérielle
Routeur Principal : EdgeRouter X (Passerelle FAI).

Nœuds Proxmox (Virtualisation) :

pve-lumanova : Intel i3-6100U

pve-cerbere : Acer i3-4150T

Serveur de Sauvegarde (Prévu) : Dell Optiplex 745 (6 To de stockage).

Nœud d'Orchestration (Docker) : Raspberry Pi 5.

Tableau de Bord / Accès Nomade : Raspberry Pi Zero 2 (héberge le dashboard "Homepage").

Réseau Nomade / Tactique : Routeurs GL.iNet Slate AX-1800 (travail lourd) et Slate 7 GLEBE-3600 (test/sécurité), plus un Slate en mode AP.

Terminaux d'Administration : HP Elitebook (Parrot Security, VNC/Remmina), Android Box (rootée, KDE), Tablette Samsung, et téléphone Z Fold 5.

🌐 Architecture Réseau & Sécurité
SD-WAN & VPN : Réseau maillé propulsé par Tailscale avec des ACL (Access Control Lists) strictes.

Pare-feu : OPNsense virtualisé sous Proxmox.

Résolution DNS : Technitium DNS pour le contrôle du trafic local.

Portail d'Authentification Sécurisé : * Reverse Proxy via Nginx Proxy Manager (NPM).

Système SSO Authelia avec clé physique YubiKey.

Portail d'accès personnalisé (Mot de passe 8 caractères ➔ Redirection ➔ Validation OTP par courriel) pour accéder aux instances Proxmox.

🐳 Services & Conteneurs (Stack Docker sur Pi 5)
Automatisation & IoT : Home Assistant, n8n, Zigbee2MQTT, ESPHome, Matter Server, Mosquitto (MQTT).

Observabilité & Monitoring : Grafana, Prometheus, Node Exporter, Uptime Kuma.

Infrastructure : Portainer, Postgres DB, NPM.

Cloud & Stockage : Nextcloud, Seafile (hébergés sur l'infrastructure).
