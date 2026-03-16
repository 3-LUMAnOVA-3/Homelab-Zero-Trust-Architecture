#!/bin/bash
# ==============================================================================
# Script : btrfs_integrity_check.sh
# Rôle : Audit BTRFS et validation SHA256 des archives (Exécuté via Cron)
# ==============================================================================

# Variables (Chemins relatifs au répertoire home de l'utilisateur)
BACKUP_DIR="/home/rowbinweb"
BACKUP_FILE="$BACKUP_DIR/restauration_systeme.tar.gz"
CHECKSUM_FILE="$BACKUP_DIR/restauration_systeme.tar.gz.sha256"
LOG_DIR="$BACKUP_DIR/System_Logs"
DATE=$(date +"%Y-%m-%d_%H-%M-%S")
LOG_FILE="$LOG_DIR/btrfs_audit_$DATE.log"

# Création du dossier de logs s'il n'existe pas
mkdir -p "$LOG_DIR"

echo "=== Audit d'Intégrité Démarré : $DATE ===" > "$LOG_FILE"

# 1. Validation de l'archive principale
if [ -f "$BACKUP_FILE" ] && [ -f "$CHECKSUM_FILE" ]; then
    echo "[*] Validation SHA256 de $BACKUP_FILE en cours..." | tee -a "$LOG_FILE"
    cd "$BACKUP_DIR" || exit
    
    if sha256sum -c "$CHECKSUM_FILE" >> "$LOG_FILE" 2>&1; then
        echo "[SUCCESS] Archive saine." | tee -a "$LOG_FILE"
    else
        echo "[CRITICAL] Corruption détectée dans l'archive !" | tee -a "$LOG_FILE"
        # Ici, on pourrait ajouter une ligne pour envoyer une alerte n8n ou Gotify
    fi
else
    echo "[WARNING] Fichiers de sauvegarde introuvables." | tee -a "$LOG_FILE"
fi

# 2. Audit du système de fichiers BTRFS
echo "[*] Exécution de 'btrfs device stats'..." | tee -a "$LOG_FILE"
sudo btrfs device stats / >> "$LOG_FILE" 2>&1

# Vérification des erreurs non nulles dans la sortie BTRFS
if sudo btrfs device stats / | awk '{print $2}' | grep -q "[1-9]"; then
    echo "[CRITICAL] Erreurs BTRFS détectées sur le volume physique !" | tee -a "$LOG_FILE"
else
    echo "[SUCCESS] BTRFS stable. Aucune erreur matérielle." | tee -a "$LOG_FILE"
fi

echo "=== Audit Terminé ===" >> "$LOG_FILE"
