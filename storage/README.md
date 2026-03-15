# 🗄️ Architecture de Stockage & Cryptographie Avancée

Cette section documente la stratégie de stockage sécurisé mise en place sur le nœud principal (Raspberry Pi 5), conçue pour résister au vol physique tout en maintenant une haute disponibilité.

## 🧱 Structure des Partitions (Hybride)
Pour garantir que les services de base redémarrent automatiquement après une coupure de courant, tout en protégeant les données sensibles :
* **Partition Système & Moteur Docker (ext4) :** Non chiffrée. Permet au système d'exploitation et au service Docker de démarrer de manière autonome.
* **Conteneur Sécurisé (LUKS2) :** Un fichier conteneur ou une partition dédiée chiffrée avec LUKS2, qui contient tous les volumes de données sensibles (Bases de données, configurations privées).

## 🗃️ Système de Fichiers BTRFS
À l'intérieur du conteneur LUKS2, les données sont formatées en **BTRFS** pour bénéficier de :
* **Compression transparente (ZSTD) :** Optimisation de l'espace et réduction de l'usure de la carte SD/SSD.
* **Protection contre la corruption (Checksums) :** Un script automatisé (Cron) vérifie régulièrement l'intégrité des archives et la santé du système BTRFS.

## 🔐 Mécanismes de Déverrouillage (Unlock)
Le conteneur LUKS2 dispose de plusieurs clés d'accès selon le niveau de sécurité requis :
1. **Déverrouillage Physique (USB Keyfile) :** Un périphérique USB contenant un fichier de "bruit" cryptographique (Keyfile). Si la clé est branchée au démarrage, le système monte le conteneur automatiquement. Idéal quand je suis physiquement présent.
2. **Déverrouillage à Distance (Initramfs) :** Injection d'un serveur SSH léger (Dropbear) dans l'initramfs. En cas de redémarrage à distance sans la clé USB, je peux me connecter en SSH sur la couche de pré-démarrage pour entrer la phrase de passe LUKS.
3. **Déverrouillage Manuel (Alias Bash) :** Des alias Bash obfusqués (ex: `sesam ...`) sont configurés dans mon profil pour monter ou démonter le coffre-fort à la volée via le terminal.
