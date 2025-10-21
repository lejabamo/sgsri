import React from "react";
import {
  Box,
  Paper,
  Typography,
  Grid,
  Card,
  CardContent,
} from "@mui/material";
import {
  Assessment,
  TrendingUp,
  Security,
  People,
} from "@mui/icons-material";

const Reportes: React.FC = () => {
  const reportes = [
    {
      titulo: "Informe de Riesgos",
      descripcion: "Análisis completo de riesgos identificados y su estado",
      icono: <Assessment sx={{ fontSize: 40, color: "#1976d2" }} />,
    },
    {
      titulo: "Estadísticas de Activos",
      descripcion: "Métricas y análisis de la gestión de activos",
      icono: <Security sx={{ fontSize: 40, color: "#388e3c" }} />,
    },
    {
      titulo: "Tendencias de Seguridad",
      descripcion: "Análisis de tendencias en seguridad de la información",
      icono: <TrendingUp sx={{ fontSize: 40, color: "#f57c00" }} />,
    },
    {
      titulo: "Reportes de Usuarios",
      descripcion: "Informes sobre actividad y gestión de usuarios",
      icono: <People sx={{ fontSize: 40, color: "#7b1fa2" }} />,
    },
  ];

  return (
    <Box p={3}>
      <Typography variant="h4" component="h1" gutterBottom>
        Reportes y Estadísticas
      </Typography>
      <Typography variant="body1" color="text.secondary" sx={{ mb: 3 }}>
        Sistema de reportes del SGRI - Gestión de Riesgos de Información
      </Typography>

      <Box sx={{ display: 'flex', flexWrap: 'wrap', gap: 3 }}>
        {reportes.map((reporte, index) => (
          <Box key={index} sx={{ flex: '1 1 300px', minWidth: '250px' }}>
            <Card sx={{ height: '100%' }}>
              <CardContent sx={{ textAlign: 'center', p: 3 }}>
                <Box sx={{ mb: 2 }}>
                  {reporte.icono}
                </Box>
                <Typography variant="h6" gutterBottom>
                  {reporte.titulo}
                </Typography>
                <Typography variant="body2" color="text.secondary">
                  {reporte.descripcion}
                </Typography>
              </CardContent>
            </Card>
          </Box>
        ))}
      </Box>

      <Paper sx={{ p: 3, mt: 3 }}>
        <Typography variant="h6" gutterBottom>
          Funcionalidad en Desarrollo
        </Typography>
        <Typography variant="body2" color="text.secondary">
          Los reportes detallados estarán disponibles próximamente. Esta sección incluirá:
        </Typography>
        <Box component="ul" sx={{ mt: 1, pl: 3 }}>
          <li>Reportes PDF de riesgos por categoría</li>
          <li>Gráficos interactivos de tendencias</li>
          <li>Exportación de datos en múltiples formatos</li>
          <li>Dashboards personalizables</li>
          <li>Reportes automáticos por email</li>
        </Box>
      </Paper>
    </Box>
  );
};

export default Reportes;