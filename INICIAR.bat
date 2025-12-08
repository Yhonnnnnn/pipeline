@echo off
REM ============================================
REM Script de Inicio Rápido - Pipeline CI/CD
REM ============================================
REM Este script instala dependencias y configura todo

cd /d "%~dp0"

echo.
echo ✨ ============================================
echo    🚀 SETUP PIPELINE CI/CD
echo    ============================================
echo.
echo Este script va a:
echo   1. Instalar dependencias del backend
echo   2. Instalar dependencias del frontend
echo   3. Mostrar pasos siguientes
echo.

REM Esperar a que el usuario presione algo
pause

echo.
echo 📦 Instalando Backend...
cd backend
call npm install
if errorlevel 1 (
    echo ❌ Error instalando backend
    pause
    exit /b 1
)
cd ..

echo.
echo 📦 Instalando Frontend...
cd frontend
call npm install
if errorlevel 1 (
    echo ❌ Error instalando frontend
    pause
    exit /b 1
)
cd ..

echo.
echo ✅ ============================================
echo    ✅ DEPENDENCIAS INSTALADAS
echo    ============================================
echo.
echo 🚀 PRÓXIMOS PASOS:
echo.
echo   1️⃣  Abre DOS TERMINALES:
echo.
echo   Terminal 1 - BACKEND:
echo   ┌─────────────────────────────────┐
echo   │ cd backend                      │
echo   │ npm run dev                     │
echo   └─────────────────────────────────┘
echo.
echo   Terminal 2 - FRONTEND:
echo   ┌─────────────────────────────────┐
echo   │ cd frontend                     │
echo   │ npm run dev                     │
echo   └─────────────────────────────────┘
echo.
echo   2️⃣  Abre tu navegador:
echo   http://localhost:5173
echo.
echo   3️⃣  Para GitHub, sigue el README.md
echo.
echo ============================================
echo.

pause
