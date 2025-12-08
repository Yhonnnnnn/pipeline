#!/bin/bash

# Script de Setup para Pipeline CI/CD
# Facilita la configuración inicial del proyecto

set -e

echo "=========================================="
echo "🚀 Setup Pipeline CI/CD"
echo "=========================================="
echo ""

# Variables
read -p "¿Cuál es tu usuario de GitHub? " GITHUB_USER
read -p "¿Cuál es tu usuario de Docker Hub? " DOCKER_USER
read -sp "¿Cuál es tu token de Docker Hub? " DOCKER_TOKEN
echo ""
echo ""

# 1. Instalar dependencias
echo "📦 Instalando dependencias..."
echo ""

echo "  Backend..."
cd backend
npm install > /dev/null 2>&1
cd ..

echo "  Frontend..."
cd frontend
npm install > /dev/null 2>&1
cd ..

echo "✅ Dependencias instaladas"
echo ""

# 2. Inicializar Git
echo "📝 Inicializando repositorio Git..."
git init > /dev/null 2>&1
git add . > /dev/null 2>&1
git commit -m "Proyecto Express + Vite con CI/CD" > /dev/null 2>&1
git branch -M main > /dev/null 2>&1

echo "✅ Repositorio Git inicializado"
echo ""

# 3. Agregar remote
echo "🔗 Configurando GitHub..."
REPO_NAME="mi-proyecto-ci-cd"
read -p "¿Nombre del repositorio GitHub? [${REPO_NAME}] " REPO_INPUT
REPO_NAME=${REPO_INPUT:-$REPO_NAME}

git remote add origin https://github.com/${GITHUB_USER}/${REPO_NAME}.git > /dev/null 2>&1
git push -u origin main > /dev/null 2>&1

echo "✅ Repositorio GitHub configurado"
echo "   URL: https://github.com/${GITHUB_USER}/${REPO_NAME}"
echo ""

# 4. Instrucciones para secretos
echo "⚙️  Configuración Manual Requerida"
echo "=========================================="
echo ""
echo "1️⃣  Ve a GitHub y crea los siguientes secretos:"
echo "   Settings → Secrets and variables → Actions"
echo ""
echo "   DOCKERHUB_USERNAME: ${DOCKER_USER}"
echo "   DOCKERHUB_TOKEN:    ${DOCKER_TOKEN}"
echo ""
echo "2️⃣  Activa GitHub Pages:"
echo "   Settings → Pages → Source: gh-pages"
echo ""
echo "3️⃣  Tu sitio estará disponible en:"
echo "   https://${GITHUB_USER}.github.io/${REPO_NAME}"
echo ""
echo "=========================================="
echo ""
echo "✨ ¡Setup completado!"
echo ""
echo "Próximos pasos:"
echo "  1. npm run dev  (para ejecutar localmente)"
echo "  2. Haz cambios y git push"
echo "  3. Abre Actions en GitHub para ver el pipeline"
echo ""
