# 🖥️ Cluster Proxmox VE & Virtualisation

Cette section détaille l'infrastructure de virtualisation qui fournit la puissance de calcul (Compute) au Homelab. L'environnement est conçu pour la redondance et est administrable de manière 100% sécurisée via un réseau SD-WAN.

## 🧱 Les Nœuds (Nodes)
Le cluster est composé de deux hyperviseurs physiques ("Bare-Metal") :
1. **`pve-lumanova` :** Nœud principal (Intel i3-6100U). Héberge les services critiques et les passerelles réseau.
2. **`pve-cerbere` :** Nœud secondaire (Acer i3-4150T). Assure la répartition de charge et la redondance.

## 🌐 Virtualisation Réseau (OPNsense)
Au lieu d'utiliser un pare-feu matériel rigide, le routage avancé est virtualisé :
* **OPNsense** tourne en tant que Machine Virtuelle (VM) au sein de Proxmox.
* Il gère le filtrage inter-VLAN et la sécurité locale avant que le trafic ne rejoigne le maillage Tailscale.

## 🔒 Administration Zero Trust
* **Aucun port ouvert :** Les interfaces web d'administration de Proxmox (port 8006) ne sont pas exposées sur Internet ni sur le réseau local standard.
* L'accès se fait *uniquement* via une adresse IP Tailscale, authentifiée par la "Clé Maîtresse" matérielle (Pi Zero 2) ou la tour de contrôle sécurisée.
