# 🌐 Architecture Réseau SD-WAN & Haute Disponibilité

Ce document présente la topologie de mon réseau défini par logiciel (SD-WAN) et les mécanismes de redondance mis en place pour garantir un accès continu et sécurisé à mon infrastructure.

## 🔗 Le Cœur du Réseau : SD-WAN Tailscale
Le réseau physique est totalement abstrait grâce à un maillage VPN **Tailscale**.
* **Zero Trust :** Tous les appareils (Serveurs, Routeurs GL.iNet, PC portables, Téléphones) sont authentifiés et le trafic est chiffré de bout en bout.
* **Résolution DNS Locale :** J'utilise un conteneur **Technitium DNS** intégré à Tailscale pour gérer les noms de domaine internes de mon Homelab, permettant un routage transparent sans exposer mes adresses IP.

## 🖥️ Infrastructure de Virtualisation (Haute Disponibilité)
[cite_start]La puissance de calcul repose sur deux serveurs hyperviseurs **Proxmox VE**[cite: 361, 363]:
1. **pve-lumanova :** Nœud principal (Intel i3-6100U).
2. **pve-cerbere :** Nœud secondaire (Acer i3-4150T).
3. **A venir Proxmox-Backup-Serveur (Dell Optiplex 745) 6T HDD ....Presentement en Maintenance en attende piece...! 
* *Note :* Ces serveurs sont administrables de n'importe où via le tunnel Tailscale, sans exposition publique.

## 🛰️ La Tour de Contrôle (Administration Tactique)
Pour l'administration avancée et la gestion des urgences, j'utilise une "Tour de Contrôle" sécurisée :
* **Matériel :** HP Elitebook.
* **OS :** Parrot Security (Optimisé pour l'administration système et le pentesting).
* **Accès Graphique :** Connexion **VNC via Remmina**, routée exclusivement à travers le tunnel Tailscale pour un accès complet aux serveurs Proxmox et aux environnements de bureau virtuels (KVM).

## 📡 Redondance WAN (Failover 5G)
Pour garantir une disponibilité à 100% même en cas de panne de mon Fournisseur d'Accès Internet (EdgeRouter X) :
* **Dispositif de Secours :** Tablette Samsung Android Rootée avec puce 5G.
* **Mécanisme :** En cas de coupure, la tablette est connectée en USB Tethering (Partage de connexion réseau USB). [cite_start]Le routage bascule automatiquement sur la 5G de la tablette, maintenant le SD-WAN et les serveurs en ligne.
