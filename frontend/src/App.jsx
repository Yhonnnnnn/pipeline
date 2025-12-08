import { useEffect, useState } from "react";
import "./App.css";

function App() {
  const [mensaje, setMensaje] = useState("Cargando...");
  const [loading, setLoading] = useState(true);

  useEffect(() => {
    // Detectar si estamos en producción (GitHub Pages) o desarrollo
    const backendUrl = import.meta.env.PROD 
      ? "https://api.ejemplo.com/api/saludo"  // URL de producción del backend
      : "http://localhost:4000/api/saludo";   // URL local

    fetch(backendUrl)
      .then((res) => res.json())
      .then((data) => {
        setMensaje(data.mensaje);
        setLoading(false);
      })
      .catch((err) => {
        console.error("Error:", err);
        setMensaje("No se pudo conectar con el backend (solo frontend) 😅");
        setLoading(false);
      });
  }, []);

  return (
    <div className="container">
      <h1>🚀 Frontend Vite + React</h1>
      <p className="subtitle">Con CI/CD y GitHub Actions</p>
      
      <div className="card">
        <h2>Mensaje desde el backend:</h2>
        <pre className="message">
          {loading ? "⏳ Cargando..." : mensaje}
        </pre>
      </div>

      <div className="info">
        <h3>Características del Pipeline:</h3>
        <ul>
          <li>✅ CI: Tests, Lint, Build automático</li>
          <li>📦 Artefactos de build generados</li>
          <li>🌐 Despliegue automático a GitHub Pages</li>
          <li>🐳 Imagen Docker del backend en Docker Hub</li>
        </ul>
      </div>
    </div>
  );
}

export default App;
