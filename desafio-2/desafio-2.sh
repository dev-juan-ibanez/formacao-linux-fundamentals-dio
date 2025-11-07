#!/bin/bash

# Configurações iniciais
set -e # Encerra o script em caso de erro

echo "=== Iniciando provisionamento do servidor web ==="

# Atualizar sistema
echo "[1/4] Atualizando o servidor..."
apt-get update
apt-get upgrade -y

# Instalar dependências
echo "[2/4] Instalando pacotes necessários..."
apt-get install -y \
    apache2 \
    unzip \
    curl

# Configurar aplicação
echo "[3/4] Baixando e configurando aplicação web..."
cd /tmp
wget -q https://github.com/denilsonbonatti/linux-site-dio/archive/refs/heads/main.zip
unzip -q main.zip
cp -rf linux-site-dio-main/* /var/www/html/

# Limpeza e finalização
echo "[4/4] Finalizando configuração..."
rm -f main.zip
rm -rf linux-site-dio-main

# Reiniciar Apache
systemctl restart apache2
systemctl enable apache2

echo "=== Servidor web provisionado com sucesso! ==="
echo "Acesse: http://$(curl -s ifconfig.me)"