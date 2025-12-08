# 📋 COMANDOS ÚTILES - Pipeline CI/CD

## 🚀 INICIALIZACIÓN Y CONFIGURACIÓN

### 1. Clonar/Configurar el proyecto
```bash
cd pipeline

# Instalar dependencias
cd backend && npm install && cd ..
cd frontend && npm install && cd ..

# O todo junto:
npm install --prefix backend && npm install --prefix frontend
```

### 2. Inicializar Git y GitHub
```bash
git init
git add .
git commit -m "Proyecto Express + Vite con CI/CD"
git branch -M main

# Cambiar TU_USUARIO y REPO_NAME
git remote add origin https://github.com/TU_USUARIO/REPO_NAME.git
git push -u origin main
```

### 3. Crear secretos en GitHub (por CLI)
```bash
# Requiere gh CLI instalado: https://cli.github.com/
gh secret set DOCKERHUB_USERNAME --body "tu_usuario"
gh secret set DOCKERHUB_TOKEN --body "tu_token"
```

---

## 💻 DESARROLLO LOCAL

### Backend (Express)
```bash
# Terminal 1
cd backend

# Modo desarrollo (con hot reload)
npm run dev

# Modo producción
npm start

# Tests
npm test

# Lint
npm lint
```

### Frontend (Vite + React)
```bash
# Terminal 2
cd frontend

# Modo desarrollo
npm run dev

# Build para producción
npm run build

# Preview del build
npm run preview

# Tests
npm test

# Lint
npm lint
```

### Acceder a la aplicación
- Frontend: http://localhost:5173
- Backend: http://localhost:4000
- API: http://localhost:4000/api/saludo

---

## 🐳 DOCKER

### Build de imagen local
```bash
cd backend
docker build -t mi-backend:latest .
docker build -t mi-backend:1.0.0 .
```

### Ejecutar contenedor
```bash
# Simple
docker run -p 4000:4000 mi-backend:latest

# Con variables de entorno
docker run -p 4000:4000 -e PORT=4000 mi-backend:latest

# Con logs
docker run -p 4000:4000 mi-backend:latest --logs
```

### Docker Compose (desarrollo)
```bash
# Iniciar servicios
docker-compose up

# En background
docker-compose up -d

# Detener servicios
docker-compose down

# Logs
docker-compose logs -f

# Reconstruir
docker-compose up --build
```

---

## 🔄 GITHUB ACTIONS / CI-CD

### Disparar pipeline manualmente
```bash
# Push a main dispara automáticamente
git add .
git commit -m "Cambios"
git push

# Ver estado
gh workflow view ci-cd.yml
gh run list
```

### Monitorear en GitHub
1. Ir a: https://github.com/TU_USUARIO/REPO/actions
2. Click en el workflow que corre
3. Ver logs en tiempo real

### Forzar re-run de un job fallido
```bash
gh run rerun RUN_ID
```

---

## 📦 ACTUALIZAR DEPENDENCIAS

### Verificar actualizaciones
```bash
npm outdated --prefix backend
npm outdated --prefix frontend
```

### Actualizar dependencias
```bash
# Backend
cd backend
npm update                    # Actualizar dentro de versión
npm install express@latest   # Actualizar a última

# Frontend
cd frontend
npm update
npm install react@latest react-dom@latest
```

---

## 🧪 TESTING Y VALIDACIÓN

### Ejecutar todos los tests
```bash
npm test --prefix backend
npm test --prefix frontend

# Ambos
npm run test:all
```

### Lint (validar código)
```bash
npm run lint --prefix backend
npm run lint --prefix frontend
```

### Build para producción
```bash
cd frontend
npm run build

# Ver resultado
ls -la dist/
```

---

## 🌐 GITHUB PAGES

### Activar/Configurar
1. GitHub → Settings → Pages
2. Source: gh-pages (rama)
3. Guardar

### Ver deploy
- URL: https://TU_USUARIO.github.io/REPO_NAME
- Rama automática: gh-pages
- Archivos publicados desde: `frontend/dist`

### Troubleshooting
```bash
# Ver rama gh-pages
git branch -a

# Si no existe, crear:
git checkout --orphan gh-pages
git rm -rf .
echo "# GitHub Pages" > README.md
git add .
git commit -m "Initial commit"
git push origin gh-pages
```

---

## 📤 DOCKER HUB

### Login
```bash
docker login -u TU_USUARIO -p TU_TOKEN
```

### Push de imagen
```bash
# Tag correcto (usuario/nombre:tag)
docker tag mi-backend:latest TU_USUARIO/backend-express-ci-cd:latest
docker tag mi-backend:latest TU_USUARIO/backend-express-ci-cd:1.0.0

# Push
docker push TU_USUARIO/backend-express-ci-cd:latest
docker push TU_USUARIO/backend-express-ci-cd:1.0.0
```

### Descargar y ejecutar desde Docker Hub
```bash
docker pull TU_USUARIO/backend-express-ci-cd:latest
docker run -p 4000:4000 TU_USUARIO/backend-express-ci-cd:latest
```

---

## 🔍 DEBUGGING

### Ver logs del backend
```bash
cd backend && npm run dev
# O con Docker:
docker logs CONTAINER_ID -f
```

### Ver logs del frontend
```bash
cd frontend && npm run dev
# Abre la consola del navegador (F12)
```

### Ver logs de GitHub Actions
1. Abre el workflow en GitHub
2. Click en el job que falla
3. Click en el step para expandir
4. Ver salida completa

### Conectar a contenedor en ejecución
```bash
docker exec -it CONTAINER_ID sh
```

---

## 🧹 LIMPIAR

### Limpiar node_modules
```bash
rm -rf backend/node_modules frontend/node_modules
npm install --prefix backend
npm install --prefix frontend
```

### Limpiar build
```bash
rm -rf frontend/dist
npm run build --prefix frontend
```

### Limpiar Docker
```bash
# Eliminar imagen
docker rmi mi-backend:latest

# Eliminar contenedores detenidos
docker container prune

# Limpiar todo (⚠️ cuidado)
docker system prune -a
```

---

## 📚 REFERENCIAS ÚTILES

### Documentación
- Express: https://expressjs.com/
- Vite: https://vitejs.dev/
- React: https://react.dev/
- GitHub Actions: https://docs.github.com/en/actions
- Docker: https://docs.docker.com/

### Herramientas CLI
- gh (GitHub CLI): https://cli.github.com/
- docker: https://www.docker.com/
- node/npm: https://nodejs.org/

### Recursos
- GitHub Pages: https://pages.github.com/
- Docker Hub: https://hub.docker.com/
- VS Code: https://code.visualstudio.com/

---

## ⚡ SHORTCUTS / ALIASES

### Agregar a `.bashrc` o `.zshrc`
```bash
alias backend="cd backend"
alias frontend="cd frontend"
alias dev-backend="cd backend && npm run dev"
alias dev-frontend="cd frontend && npm run dev"
alias install-all="npm install --prefix backend && npm install --prefix frontend"
alias build-all="npm run build --prefix frontend"
alias test-all="npm test --prefix backend && npm test --prefix frontend"
```

---

**💡 TIP:** Guarda este archivo para consulta rápida de comandos útiles.
