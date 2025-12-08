# 🎯 GUÍA RÁPIDA DE INICIO

## 1️⃣ Configuración Inicial

```bash
# Inicializar repositorio Git
git init
git add .
git commit -m "Proyecto Express + Vite con CI/CD"
git branch -M main
git remote add origin https://github.com/TU_USUARIO/mi-proyecto-ci-cd.git
git push -u origin main
```

## 2️⃣ Configurar Secretos en GitHub

### En el repositorio de GitHub:
1. **Settings** → **Secrets and variables** → **Actions**
2. **New repository secret** - Crea dos:

```
Name: DOCKERHUB_USERNAME
Value: tu_usuario_dockerhub

Name: DOCKERHUB_TOKEN
Value: tu_token_de_acceso
```

**Para obtener el token:**
- Login en hub.docker.com
- Account Settings → Security → New Access Token
- Cópialo y úsalo como secreto

## 3️⃣ Configurar GitHub Pages

1. **Settings** → **Pages**
2. En "Source": Selecciona rama `gh-pages`
3. Espera a que se construya (2-3 minutos)
4. Tu sitio estará en: `https://TU_USUARIO.github.io/NOMBRE_REPO`

## 4️⃣ Pruebas Locales

### Instalar dependencias:
```bash
cd backend && npm install && cd ../frontend && npm install && cd ..
```

### Ejecutar Backend:
```bash
cd backend && npm run dev
```

### Ejecutar Frontend (otra terminal):
```bash
cd frontend && npm run dev
```

Abre: http://localhost:5173

## 5️⃣ Hacer tu primer cambio

```bash
# Edita un archivo (ej: backend/src/index.js)
# Luego:
git add .
git commit -m "Mi primer cambio en el pipeline"
git push
```

## 🔍 Monitorear el Pipeline

1. Ve a tu repositorio en GitHub
2. Click en pestaña **Actions**
3. Verás los 3 jobs:
   - ✅ **ci** - Tests, lint, build
   - ✅ **deploy_frontend** - GitHub Pages
   - ✅ **build_and_push_backend** - Docker Hub

## 📊 Estructura Creada

```
pipeline/
├── 📁 backend/
│   ├── src/index.js (API Express)
│   ├── package.json
│   └── Dockerfile
├── 📁 frontend/
│   ├── src/ (Componentes React + Styles)
│   ├── index.html
│   ├── vite.config.js
│   └── package.json
├── 📁 .github/workflows/
│   └── ci-cd.yml (Pipeline automático)
├── .gitignore
├── .env.example
├── docker-compose.yml
└── README.md
```

## 🚨 Troubleshooting

**Pipeline fallando en GitHub?**
- Revisa la pestaña Actions para ver el error
- Verifica que los secretos DOCKERHUB_* estén correctos

**Frontend no ve al backend?**
- En desarrollo: El frontend intenta conectar a localhost:4000 (funciona si ejecutas ambos)
- En producción: GitHub Pages no puede conectar a APIs (solo frontend)
  → Configura una URL de API real en `frontend/src/App.jsx`

**Imagen no aparece en Docker Hub?**
- Verifica los secretos: `DOCKERHUB_USERNAME` y `DOCKERHUB_TOKEN`
- Token debe tener permisos de lectura y escritura

---

**¡Listo! Tu pipeline CI/CD está completamente configurado.** 🚀
