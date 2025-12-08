# 🐛 TROUBLESHOOTING - Solución de Problemas Comunes

## 🔴 PROBLEMAS DE GIT/GITHUB

### ❌ Error: "fatal: destination path 'origin' already exists"
```bash
# Ya existe un remote
git remote -v          # Ver remotes existentes
git remote remove origin  # Eliminar el existente
git remote add origin https://...  # Agregar de nuevo
```

### ❌ "Authentication failed"
```bash
# Problema con SSH o HTTPS
# Solución 1: Usar HTTPS con token
git remote set-url origin https://TU_TOKEN@github.com/USUARIO/REPO.git

# Solución 2: Generar SSH key
ssh-keygen -t ed25519 -C "tu@email.com"
# Agregar la clave pública a GitHub
```

### ❌ "Permission denied (publickey)"
```bash
# Problema SSH
ssh -T git@github.com  # Probar conexión
ssh-keygen -t ed25519  # Generar nueva clave
# Agregar la clave en GitHub → Settings → SSH and GPG keys
```

---

## 🔴 PROBLEMAS DE DEPENDENCIAS

### ❌ "Cannot find module 'express'"
```bash
cd backend
npm install          # Instalar todas las dependencias
npm install express  # Instalar específicamente
```

### ❌ "npm WARN old lockfile"
```bash
# Actualizar el package-lock.json
cd backend && npm install && cd ..
cd frontend && npm install && cd ..

# O eliminar y regenerar
rm package-lock.json
npm install
```

### ❌ "Permission denied while trying to connect to Docker"
```bash
# Problema de permisos con Docker
sudo usermod -aG docker $USER
newgrp docker
# Reiniciar la terminal o máquina
```

---

## 🔴 PROBLEMAS DE DESARROLLO LOCAL

### ❌ "Port 4000 is already in use"
```bash
# Backend no inicia por puerto ocupado

# Opción 1: Cambiar puerto
PORT=5000 npm run dev

# Opción 2: Liberar puerto
# Windows
netstat -ano | findstr :4000
taskkill /PID <PID> /F

# Linux/Mac
lsof -i :4000
kill -9 <PID>
```

### ❌ "Port 5173 is already in use"
```bash
# Frontend no inicia por puerto ocupado
# Solución igual que arriba, pero puerto 5173

# O dejar que Vite use otro puerto:
npm run dev -- --port 3000
```

### ❌ El frontend no conecta con el backend
```bash
# En App.jsx, verificar URL:
// Desarrollo
fetch('http://localhost:4000/api/saludo')

// Producción (GitHub Pages)
fetch('https://tu-api.ejemplo.com/api/saludo')

// Asegúrate que:
// 1. Backend está ejecutándose (npm run dev)
// 2. URL es correcta
// 3. CORS está habilitado en backend (está en code)
```

### ❌ "Vite does not recognize 'react'"
```bash
cd frontend
npm install react react-dom

# O reinstalar todas las deps
rm -rf node_modules package-lock.json
npm install
```

---

## 🔴 PROBLEMAS DE DOCKER

### ❌ "docker: command not found"
```bash
# Docker no está instalado
# Descargar desde: https://www.docker.com/products/docker-desktop
```

### ❌ "Error response from daemon: Cannot connect to Docker daemon"
```bash
# Docker daemon no está ejecutándose

# Windows/Mac: Abrir Docker Desktop
# Linux:
sudo systemctl start docker
```

### ❌ "unauthorized: incorrect username or password"
```bash
# Error al hacer push a Docker Hub
docker logout  # Cerrar sesión actual
docker login   # Volver a login

# Verificar:
# - Usuario correcto
# - Token válido (no contraseña)
# - Token tiene permisos read/write
```

### ❌ "dockerfile: Dockerfile (No such file or directory)"
```bash
# Dockerfile no existe en la ruta correcta
cd backend
ls -la Dockerfile  # Verificar que existe

# O crear uno nuevo:
cat > Dockerfile << 'EOF'
FROM node:20-alpine
WORKDIR /app
COPY package*.json ./
RUN npm install --only=production
COPY src ./src
EXPOSE 4000
CMD ["node", "src/index.js"]
EOF
```

### ❌ "Error building image"
```bash
# Verificar logs
docker build -t mi-backend:latest . -v

# Problemas comunes:
# - package.json no existe
# - src/ no existe
# - RUN npm install falla (revisa dependencias)
```

---

## 🔴 PROBLEMAS DE GITHUB ACTIONS

### ❌ Workflow no ejecuta
```
Posibles causas:
1. Rama no es 'main'
   → Cambiar en ci-cd.yml o pushear a 'main'
2. Archivo no está en .github/workflows/
   → Verificar ruta exacta
3. YAML syntax error
   → Validar con https://www.yamllint.com/
```

### ❌ "Authentication failed during workflow"
```
Problema: Secrets DOCKERHUB_* no están configurados

Solución:
1. GitHub → Settings → Secrets and variables → Actions
2. Crear:
   - DOCKERHUB_USERNAME
   - DOCKERHUB_TOKEN
3. Esperar 30 segundos y re-trigger
```

### ❌ Job CI falla
```
Ver logs:
1. GitHub → Actions → workflow
2. Click en job "ci"
3. Expandir cada step para ver error

Causas comunes:
- npm install falla (dependencias)
- Tests fallan (código)
- Lint da errores (syntax)

Solución:
- Fixear el problema localmente
- git add . && git commit && git push
```

### ❌ "Deploy to GitHub Pages failed"
```
Posibles causas:
1. Rama gh-pages no existe
   → El workflow la crea automáticamente
   → Ir a Settings → Pages y seleccionar
2. Permisos insuficientes
   → Verificar que tienes permisos en el repo
3. Token GITHUB_TOKEN expirado
   → Usar secrets.GITHUB_TOKEN (automático)

Solución:
1. Verificar en Settings → Pages
2. Seleccionar rama gh-pages como source
3. Esperar 2-3 minutos a que publique
```

### ❌ Docker push falla en workflow
```
Error: "no basic auth credentials"

Solución:
1. Verificar secretos en GitHub:
   - DOCKERHUB_USERNAME
   - DOCKERHUB_TOKEN
2. Token debe tener permisos de lectura/escritura
3. No debe estar expirado
4. Esperar 30 segundos después de crear secret

En docker-compose.yml:
# Asegurate que está en ubuntu-latest
runs-on: ubuntu-latest
```

---

## 🔴 PROBLEMAS DE GITHUB PAGES

### ❌ "404 Not Found" en GitHub Pages
```
Causas:
1. Rama gh-pages no está publicada
   → Ver Settings → Pages
2. No hay archivos en el directorio
   → Ver la rama gh-pages en Git
3. URL incorrecta
   → Debe ser: https://USUARIO.github.io/REPO

Solución:
1. Ir a Settings → Pages
2. Seleccionar Source: gh-pages
3. Esperar que GitHub publish
4. Acceder a la URL (2-3 min)
```

### ❌ CSS y JS no cargan en GitHub Pages
```
Problema: Vite está usando rutas absolutas

Solución en frontend/vite.config.js:
export default defineConfig({
  base: './',  // Rutas relativas para GitHub Pages
  plugins: [react()]
})

Luego rebuild:
npm run build
git add . && git commit && git push
```

### ❌ "Your site is published at..."  pero no se ve
```
Cosas a verificar:
1. Rama gh-pages existe en GitHub
2. Contiene archivos (especialmente index.html)
3. Esperaste 2-3 minutos
4. Abriste en incógnita (sin cache)
5. Verificar URL correcta en Settings → Pages

Debug:
- Ver rama gh-pages en GitHub
- Descargar y verificar que index.html existe
```

---

## 🔴 PROBLEMAS GENERALES

### ❌ "Cannot read property 'message' of undefined"
```javascript
// En App.jsx, el API no responde
const [mensaje, setMensaje] = useState("Cargando...");

useEffect(() => {
  fetch("http://localhost:4000/api/saludo")
    .then(res => res.json())
    .then(data => {
      console.log("Respuesta:", data);  // Verificar qué llega
      setMensaje(data.mensaje);
    })
    .catch(err => {
      console.error("Error:", err);
      setMensaje("Error conectando");
    });
}, []);
```

### ❌ "CORS error in console"
```javascript
// Error: "Access to XMLHttpRequest from 'http://localhost:5173'"
// Solución en backend/src/index.js:

const cors = require("cors");
app.use(cors());  // Ya está habilitado

// Si necesitas más específico:
app.use(cors({
  origin: "http://localhost:5173",
  credentials: true
}));
```

### ❌ Cambios no se reflejan
```bash
# Frontend no actualiza cambios
# Solución 1: Guardar archivos (Ctrl+S)
# Solución 2: Hard refresh (Ctrl+Shift+R)
# Solución 3: Limpiar cache
# Solución 4: Reiniciar servidor

npm run dev  # Matar y reiniciar
```

---

## ✅ CHECKLIST DE SETUP

- [ ] Git instalado: `git --version`
- [ ] Node.js v18+: `node -v && npm -v`
- [ ] Docker instalado: `docker --version`
- [ ] Repositorio GitHub creado
- [ ] Secretos DOCKERHUB_* configurados
- [ ] GitHub Pages habilitado
- [ ] npm install en backend y frontend
- [ ] Backend funciona: `npm run dev` (backend/)
- [ ] Frontend funciona: `npm run dev` (frontend/)
- [ ] API responde: `curl http://localhost:4000/api/saludo`
- [ ] First push a 'main' ejecutó workflow
- [ ] Todos los jobs del workflow pasaron
- [ ] GitHub Pages publicó el frontend
- [ ] Docker image en Docker Hub

---

## 📞 RECURSOS DE AYUDA

### Documentación Oficial
- Express: https://expressjs.com/
- Vite: https://vitejs.dev/
- React: https://react.dev/
- GitHub Actions: https://docs.github.com/en/actions
- Docker: https://docs.docker.com/

### Comunidades
- Stack Overflow: https://stackoverflow.com/
- GitHub Discussions: https://github.com/.../discussions
- Reddit: r/node, r/reactjs, r/learnprogramming

### Herramientas Online
- YAML Linter: https://www.yamllint.com/
- JSON Validator: https://jsonlint.com/
- Docker Image Inspector: https://hub.docker.com/

---

**💡 Última opción: Elimina todo y empieza de cero**

```bash
# Si todo está muy roto:
rm -rf .git node_modules dist backend/node_modules frontend/node_modules
git init
git add .
git commit -m "Clean restart"
# Continúa con setup normal
```

---

**⏰ Fecha de última actualización:** Diciembre 2025
**✍️ Contribuciones:** Siéntete libre de reportar problemas nuevos
