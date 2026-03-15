# 📱 Administration Tactique & Interface Nomade

Cette section documente les outils d'administration portables et l'écosystème mobile de mon Homelab, conçus pour une gestion sécurisée "On-The-Go".

## 🎮 La "Manette de Contrôle" (Raspberry Pi Zero 2)
Pour garder un accès permanent à mon infrastructure sans dépendre d'un PC fixe, j'ai conçu un tableau de bord ultra-portable :
* **Matériel :** Raspberry Pi Zero 2 W, alimenté par une batterie externe (Powerbank). Il tient dans la poche.
* **Connectivité :** Connecté en permanence au tunnel SD-WAN Tailscale.
* **Interface (Homepage) :** Le Pi Zero héberge un conteneur Docker avec le service **Homepage**, qui regroupe tous les liens, statuts et accès sécurisés de mes serveurs Proxmox et de mes services cloud (Nextcloud, Seafile).
* **Accès Client :** L'interface est consultée depuis mon Samsung Z Fold 5, souvent via un terminal personnalisé sous **Termux** pour l'exécution rapide de scripts Bash à distance.

## 🤖 Écosystème Android & Réseau Bluetooth PAN
Une intégration poussée a été réalisée avec des appareils Android modifiés pour étendre le réseau local de manière non conventionnelle :
* **Android TV Box (Rootée) :** Intégration dans l'écosystème avec **KDE Connect** pour un contrôle croisé avec mes autres terminaux (Z Fold 5, Tablette Samsung).
* **Serveur Bluetooth PAN (Personal Area Network) :**
  * Création d'un sous-réseau privé via Bluetooth (support NAP - Network Access Point).
  * Le service **dnsmasq** est configuré pour attribuer des IP sur ce réseau Bluetooth.
  * **Sécurité par filtrage MAC :** Les appareils sont segmentés en 4 catégories distinctes basées sur les adresses MAC des fabricants, garantissant que seuls mes terminaux autorisés peuvent rejoindre ce réseau hors-bande.
