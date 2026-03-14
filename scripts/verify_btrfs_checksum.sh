#!/bin/bash
# ==============================================================================
# Script : verify_btrfs_checksum.sh
# Rôle : Vérification de l'intégrité de la sauvegarde et stabilité BTRFS
# ==============================================================================

BACKUP_FILE="restauration_systeme.tar.gz"
CHECKSUM_FILE="restauration_systeme.tar.gz.sha256"
LOG_DIR="System_Logs"
DATE=$(date +"%Y-%m-%d_%H-%M-%S")

echo "[*] Début de la vérification du système à $DATE"

# 1. Vérification de la somme de contrôle
if [ -f "$BACKUP_FILE" ] && [ -f "$CHECKSUM_FILE" ]; then
    echo "[*] Vérification de l'archive $BACKUP_FILE..."
    sha256sum -c "$CHECKSUM_FILE"
    if [ $? -eq 0 ]; then
        echo "[OK] L'intégrité de la sauvegarde est validée."
    else
        echo "[ERREUR] La somme de contrôle ne correspond pas. Fichier corrompu !"
        exit 1
    fi
else
    echo "[!] Fichier de sauvegarde ou de checksum introuvable."
fi

# 2. Vérification rapide du système de fichiers BTRFS
echo "[*] Vérification des erreurs BTRFS sur la racine..."
sudo btrfs device stats / > "$LOG_DIR/btrfs_stats_$DATE.log"
if grep -q "[1-9]" <<< "$(sudo btrfs device stats / | awk '{print $2}')"; then
    echo "[ALERTE] Des erreurs BTRFS ont été détectées. Vérifiez les logs !"
else
    echo "[OK] BTRFS stable. Aucune erreur matérielle ou de corruption détectée."
fi

echo "[*] Terminé."
