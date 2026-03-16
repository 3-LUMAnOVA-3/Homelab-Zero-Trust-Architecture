# 🗄️ Architecture de Stockage & Cryptographie Avancée

Cette section documente la stratégie de stockage hybride et sécurisée mise en place sur mon nœud Docker principal (Raspberry Pi 5). L'objectif est de concilier redémarrage autonome du système hôte et protection absolue des données applicatives (Data-at-Rest).

## 🧱 Isolation par Fichier Boucle (Loopback) & LUKS2
Au lieu de chiffrer l'intégralité du disque (ce qui bloquerait le redémarrage à distance en cas de coupure de courant), j'ai opté pour un chiffrement ciblé :
* **Système Hôte (`/`) :** Partition standard (120 Go) non chiffrée. Le Pi 5 et le service Docker démarrent de manière autonome.
* **Le Coffre-Fort Docker (`/var/lib/docker`) :** Un fichier conteneur de 50 Go (`loop0`) formaté en LUKS2 (`docker_crypt`). Ce volume virtuel intercepte toutes les données des conteneurs (volumes, bases de données, configurations). Si le serveur est volé et éteint, les données Docker sont totalement illisibles.

## 🗃️ BTRFS & Compression Transparente
À l'intérieur du conteneur LUKS, le système de fichiers **BTRFS** est utilisé avec l'option de compression transparente (ZSTD).
* **Avantages :** Maximise l'espace de stockage du conteneur de 50 Go, réduit les cycles d'écriture (usure du SSD/SD) et accélère les I/O virtuels.
* L'outil `compsize` est utilisé pour auditer le ratio d'économie d'espace en temps réel.

## ⚙️ Intégrité & Automatisation (Cron)
Pour m'assurer de la stabilité du système BTRFS et de l'intégrité de mes sauvegardes (`restauration_systeme.tar.gz`), une tâche planifiée **Cron** exécute un script Bash de vérification par Checksum (SHA256) et d'audit BTRFS, générant des rapports dans le dossier `System_Logs/`.
