# 🏛️ Homelab Zero-Trust & Architecture Hybride SD-WAN

Documentation complète de mon infrastructure "Homelab" auto-hébergée. Ce projet représente deux années d'apprentissage intensif en administration système, ingénierie réseau et cybersécurité. 

L'architecture est construite autour d'une segmentation SD-WAN complexe (Tailscale), d'une haute disponibilité avec Proxmox, et d'une sécurité "Zero Trust" implémentant un VPS Bastion, une authentification forte (SSO, YubiKey, LDAP) et des domaines privés.

---

## 🌐 Architecture Réseau & SD-WAN
Le réseau est segmenté physiquement et virtuellement, gérant 3 noms de domaine distincts et de multiples serveurs DHCP.
* **Passerelle FAI (Tête de ligne) :** Ubiquiti EdgeRouter X.
* **Réseau SD-WAN (Tailscale) :** Maillage complet avec 2 nœuds de sortie (Exit Nodes) distincts pour le routage conditionnel.
* **Sous-réseaux Physiques (3 serveurs DHCP) :** Gérés par une flotte de routeurs GL.iNet :
  * Slate AX-1800 (Travail lourd / Nomade puissant).
  * Slate 1300 (Mode AP / Distribution Wi-Fi).
  * Slate 7 GLBE-3600 (Environnement de test et sécurité).
* **Réseau Bluetooth PAN :** Sous-réseau DHCP hors-bande via Bluetooth (dnsmasq) avec filtrage MAC strict pour l'administration locale.
* **Résolution DNS :** Serveur Technitium DNS virtualisé pour le contrôle absolu du trafic local.

## 🛡️ Sécurité Cloud & Bastion (Hostinger)
L'adresse IP de mon domicile n'est jamais exposée. Le point d'entrée public est un VPS Cloud (Hostinger) connecté au tunnel Tailscale :
* **Reverse Proxy (NPM) :** Nginx Proxy Manager mappe les adresses IP privées Tailscale avec des certificats SSL Let's Encrypt valides via un domaine privé *wildcard* (`*.lumanova.cloud`).
* **Identity Provider :** Authelia couplé à une base de données LLDAP.
* **Passerelle Secrète :** Accès conditionnel via un site web piège ➔ Mot de passe à 8 caractères ➔ Redirection ➔ Validation OTP par courriel / YubiKey.

## 🖥️ Topologie Matérielle (Compute & Stockage)
* **Hyperviseurs (Proxmox VE Cluster) :**
  * `pve-lumanova` : Intel i3-6100U (Nœud Principal).
  * `pve-cerbere` : Acer i3-4150T (Nœud Secondaire).
* **Nœud d'Orchestration Docker :** Raspberry Pi 5.
  * *Sécurité des données :* Système hôte sur ext4, données sensibles isolées dans un fichier boucle (Loopback) chiffré **LUKS2** et formaté en **BTRFS compressé**, avec déverrouillage via initramfs ou clé USB physique.
* **Serveur de Backup (Prévu) :** Dell Optiplex 745 (6 To de stockage).

## 📡 Edge Computing & IoT (Internet des Objets)
Un écosystème matériel riche dédié à la domotique avancée et à la recherche :
* **Microcontrôleurs :** Flotte d'ESP32, NanoC6, et ESP32-CAM.
* **Capteurs Avancés :** Capteurs de mouvement mmWave haute précision (détection de respiration).
* [cite_start]**Communication & Hack :** Modules Luckfox Pro/Max [cite: 373] et nRF24L01 (Longue portée radio).

## 🛰️ Administration Tactique & Résilience
* **Tour de Contrôle :** HP Elitebook sous Parrot Security (Connexion VNC via Remmina routée dans Tailscale).
* **Tableau de Bord Nomade :** Raspberry Pi Zero 2 W hébergeant "Homepage" pour un accès depuis la poche.
* **Terminaux Hybrides :** Android TV Box (rootée avec KDE Connect), Z Fold 5 (Termux), Tablette Samsung.
* **Failover WAN (5G) :** En cas de coupure FAI, la tablette Samsung 5G bascule automatiquement en partage de connexion USB (Tethering) pour maintenir l'infrastructure en ligne.

---

## 🐳 Services Docker (Stack sur Pi 5)
* **Automatisation :** Home Assistant, n8n, Zigbee2MQTT, ESPHome, Matter Server, Mosquitto.
* **Observabilité :** Grafana, Prometheus, Node Exporter, Uptime Kuma.
* **Infrastructure :** Portainer, Postgres DB.
* **Cloud & Collaboration :** Nextcloud, Seafile.
