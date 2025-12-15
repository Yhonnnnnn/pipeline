const express = require("express");
const cors = require("cors");

const app = express();
const PORT = process.env.PORT || 4000;

app.use(cors());
app.use(express.json());

// Endpoint simple para probar el backend (cambio para probar pipeline)
app.get("/api/saludo", (req, res) => {
  res.json({ 
    mensaje: "Cambio de mensaje para probar el pipeline CI/CD 🚧",
    timestamp: new Date().toISOString()
  });
});

// Endpoint de health check
app.get("/health", (req, res) => {
  res.json({ status: "Backend is running!" });
});

app.listen(PORT, () => {
  console.log(`Servidor backend escuchando en http://localhost:${PORT}`);
});

//coment 1
