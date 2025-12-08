@echo off
REM Script de Setup para Pipeline CI/CD (Windows)

echo.
echo ==========================================
echo 🚀 Setup Pipeline CI/CD
echo ==========================================
echo.

REM Pedir datos
set /p GITHUB_USER="¿Cuál es tu usuario de GitHub? "
set /p DOCKER_USER="¿Cuál es tu usuario de Docker Hub? "
set /p DOCKER_TOKEN="¿Cuál es tu token de Docker Hub? "

echo.
echo ==========================================
echo.

REM 1. Instalar dependencias
echo 📦 Instalando dependencias...
echo.

echo   Backend...
cd backend
call npm install >nul 2>&1
cd ..

echo   Frontend...
cd frontend
call npm install >nul 2>&1
cd ..

echo ✅ Dependencias instaladas
echo.

REM 2. Inicializar Git
echo 📝 Inicializando repositorio Git...
call git init >nul 2>&1
call git add . >nul 2>&1
call git commit -m "Proyecto Express + Vite con CI/CD" >nul 2>&1
call git branch -M main >nul 2>&1

echo ✅ Repositorio Git inicializado
echo.

REM 3. Agregar remote
echo 🔗 Configurando GitHub...
set REPO_NAME=mi-proyecto-ci-cd
set /p REPO_INPUT="¿Nombre del repositorio GitHub? [%REPO_NAME%] "
if not "%REPO_INPUT%"=="" set REPO_NAME=%REPO_INPUT%

call git remote add origin https://github.com/%GITHUB_USER%/%REPO_NAME%.git >nul 2>&1
call git push -u origin main >nul 2>&1

echo ✅ Repositorio GitHub configurado
echo    URL: https://github.com/%GITHUB_USER%/%REPO_NAME%
echo.

REM 4. Instrucciones
echo ⚙️  Configuración Manual Requerida
echo ==========================================
echo.
echo 1️⃣  Ve a GitHub y crea los siguientes secretos:
echo    Settings ^→ Secrets and variables ^→ Actions
echo.
echo    DOCKERHUB_USERNAME: %DOCKER_USER%
echo    DOCKERHUB_TOKEN:    %DOCKER_TOKEN%
echo.
echo 2️⃣  Activa GitHub Pages:
echo    Settings ^→ Pages ^→ Source: gh-pages
echo.
echo 3️⃣  Tu sitio estará disponible en:
echo    https://%GITHUB_USER%.github.io/%REPO_NAME%
echo.
echo ==========================================
echo.
echo ✨ ¡Setup completado!
echo.
echo Próximos pasos:
echo   1. npm run dev  (para ejecutar localmente)
echo   2. Haz cambios y git push
echo   3. Abre Actions en GitHub para ver el pipeline
echo.
pause
