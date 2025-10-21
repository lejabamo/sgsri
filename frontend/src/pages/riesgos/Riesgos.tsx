import React, { useState } from 'react';
import {
  Box,
  Card,
  CardContent,
  Typography,
  Grid,
  Button,
  Chip,
  LinearProgress,
  Avatar,
  List,
  ListItem,
  ListItemText,
  ListItemIcon,
  Divider,
  Alert,
  Tabs,
  Tab,
} from '@mui/material';
import {
  Security as SecurityIcon,
  TrendingUp as TrendingUpIcon,
  Warning as WarningIcon,
  CheckCircle as CheckCircleIcon,
  Assessment as AssessmentIcon,
  Timeline as TimelineIcon,
  Lightbulb as LightbulbIcon,
  Speed as SpeedIcon,
  Shield as ShieldIcon,
  BugReport as BugReportIcon,
  Lock as LockIcon,
  Public as PublicIcon,
} from '@mui/icons-material';
import {
  PieChart,
  Pie,
  Cell,
  BarChart,
  Bar,
  XAxis,
  YAxis,
  CartesianGrid,
  Tooltip,
  Legend,
  ResponsiveContainer,
  LineChart,
  Line,
} from 'recharts';
import RiskMatrix from '../../components/common/RiskMatrix';
import RiskMatrix4x5 from '../../components/riesgos/RiskMatrix4x5';
import '../../styles/design-system.css';

interface TabPanelProps {
  children?: React.ReactNode;
  index: number;
  value: number;
}

function TabPanel(props: TabPanelProps) {
  const { children, value, index, ...other } = props;

  return (
    <div
      role="tabpanel"
      hidden={value !== index}
      id={`simple-tabpanel-${index}`}
      aria-labelledby={`simple-tab-${index}`}
      {...other}
    >
      {value === index && <Box sx={{ p: 3 }}>{children}</Box>}
    </div>
  );
}

const Riesgos: React.FC = () => {
  const [tabValue, setTabValue] = useState(0);

  const handleTabChange = (event: React.SyntheticEvent, newValue: number) => {
    setTabValue(newValue);
  };

  // Datos de ejemplo para el dashboard
  const saludInstitucional = {
    puntuacion: 78,
    nivel: 'BUENO',
    color: '#10B981',
    tendencia: '+5%'
  };

  const distribucionRiesgos = [
    { name: 'LOW', value: 45, color: '#10B981' },
    { name: 'MEDIUM', value: 35, color: '#F59E0B' },
    { name: 'HIGH', value: 20, color: '#EF4444' },
  ];

  const riesgosPorTipo = [
    { tipo: 'Técnico', cantidad: 12, tendencia: '+2' },
    { tipo: 'Operacional', cantidad: 8, tendencia: '-1' },
    { tipo: 'Seguridad', cantidad: 15, tendencia: '+3' },
    { tipo: 'Legal', cantidad: 5, tendencia: '0' },
    { tipo: 'Financiero', cantidad: 7, tendencia: '+1' },
  ];

  const tendenciaRiesgos = [
    { mes: 'Ene', riesgos: 25, mitigados: 5 },
    { mes: 'Feb', riesgos: 28, mitigados: 8 },
    { mes: 'Mar', riesgos: 32, mitigados: 12 },
    { mes: 'Abr', riesgos: 30, mitigados: 15 },
    { mes: 'May', riesgos: 27, mitigados: 18 },
    { mes: 'Jun', riesgos: 24, mitigados: 20 },
  ];

  const recomendaciones = [
    {
      id: 1,
      tipo: 'Crítica',
      titulo: 'Implementar autenticación multifactor',
      descripcion: 'Se detectaron 5 riesgos de seguridad relacionados con autenticación débil',
      prioridad: 'Alta',
      icono: <LockIcon />,
      color: '#EF4444'
    },
    {
      id: 2,
      tipo: 'Importante',
      titulo: 'Actualizar políticas de respaldo',
      descripcion: 'Los controles de respaldo necesitan revisión y actualización',
      prioridad: 'Media',
      icono: <ShieldIcon />,
      color: '#F59E0B'
    },
    {
      id: 3,
      tipo: 'Preventiva',
      titulo: 'Capacitación en ciberseguridad',
      descripcion: 'Implementar programa de concientización para reducir riesgos humanos',
      prioridad: 'Baja',
      icono: <PublicIcon />,
      color: '#3B82F6'
    },
    {
      id: 4,
      tipo: 'Técnica',
      titulo: 'Auditoría de vulnerabilidades',
      descripcion: 'Realizar escaneo completo de vulnerabilidades en sistemas críticos',
      prioridad: 'Alta',
      icono: <BugReportIcon />,
      color: '#EF4444'
    }
  ];

  const getNivelSalud = (puntuacion: number) => {
    if (puntuacion >= 80) return { nivel: 'EXCELENTE', color: '#10B981' };
    if (puntuacion >= 60) return { nivel: 'BUENO', color: '#3B82F6' };
    if (puntuacion >= 40) return { nivel: 'REGULAR', color: '#F59E0B' };
    return { nivel: 'CRÍTICO', color: '#EF4444' };
  };

  const nivelSalud = getNivelSalud(saludInstitucional.puntuacion);

  return (
    <Box>
      {/* Header */}
      <Box sx={{ mb: 4 }}>
        <Typography variant="h4" className="font-poppins" sx={{ color: '#1E3A8A', fontWeight: 600, mb: 1 }}>
          Dashboard de Salud Institucional
        </Typography>
        <Typography variant="body1" className="font-roboto" sx={{ color: '#6B7280' }}>
          Monitoreo integral de riesgos y salud de la organización
        </Typography>
      </Box>

      {/* Indicadores Principales */}
      <Grid container spacing={3} sx={{ mb: 4 }}>
        <Grid item xs={12} md={3}>
          <Card className="card">
            <CardContent sx={{ p: 3, textAlign: 'center' }}>
              <Avatar sx={{ 
                backgroundColor: nivelSalud.color,
                color: '#FFFFFF',
                width: 64,
                height: 64,
                mx: 'auto',
                mb: 2
              }}>
                <AssessmentIcon sx={{ fontSize: 32 }} />
              </Avatar>
              <Typography variant="h4" className="font-poppins" sx={{ color: '#1E3A8A', fontWeight: 700, mb: 1 }}>
                {saludInstitucional.puntuacion}%
              </Typography>
              <Typography variant="h6" className="font-poppins" sx={{ color: nivelSalud.color, fontWeight: 600, mb: 1 }}>
                {nivelSalud.nivel}
              </Typography>
              <Typography variant="body2" className="font-roboto" sx={{ color: '#6B7280' }}>
                Salud Institucional
              </Typography>
              <LinearProgress 
                variant="determinate" 
                value={saludInstitucional.puntuacion} 
                sx={{ 
                  mt: 2, 
                  height: 8, 
                  borderRadius: 4,
                  backgroundColor: '#E5E7EB',
                  '& .MuiLinearProgress-bar': {
                    backgroundColor: nivelSalud.color,
                    borderRadius: 4
                  }
                }} 
              />
            </CardContent>
          </Card>
        </Grid>

        <Grid item xs={12} md={3}>
          <Card className="card">
            <CardContent sx={{ p: 3, textAlign: 'center' }}>
              <Avatar sx={{ 
                backgroundColor: '#EF4444',
                color: '#FFFFFF',
                width: 64,
                height: 64,
                mx: 'auto',
                mb: 2
              }}>
                <WarningIcon sx={{ fontSize: 32 }} />
              </Avatar>
              <Typography variant="h4" className="font-poppins" sx={{ color: '#1E3A8A', fontWeight: 700, mb: 1 }}>
                47
              </Typography>
              <Typography variant="h6" className="font-poppins" sx={{ color: '#EF4444', fontWeight: 600, mb: 1 }}>
                Riesgos Activos
              </Typography>
              <Typography variant="body2" className="font-roboto" sx={{ color: '#6B7280' }}>
                Requieren atención
              </Typography>
            </CardContent>
          </Card>
        </Grid>

        <Grid item xs={12} md={3}>
          <Card className="card">
            <CardContent sx={{ p: 3, textAlign: 'center' }}>
              <Avatar sx={{ 
                backgroundColor: '#10B981',
                color: '#FFFFFF',
                width: 64,
                height: 64,
                mx: 'auto',
                mb: 2
              }}>
                <CheckCircleIcon sx={{ fontSize: 32 }} />
              </Avatar>
              <Typography variant="h4" className="font-poppins" sx={{ color: '#1E3A8A', fontWeight: 700, mb: 1 }}>
                23
              </Typography>
              <Typography variant="h6" className="font-poppins" sx={{ color: '#10B981', fontWeight: 600, mb: 1 }}>
                Mitigados
              </Typography>
              <Typography variant="body2" className="font-roboto" sx={{ color: '#6B7280' }}>
                Este mes
              </Typography>
            </CardContent>
          </Card>
        </Grid>

        <Grid item xs={12} md={3}>
          <Card className="card">
            <CardContent sx={{ p: 3, textAlign: 'center' }}>
              <Avatar sx={{ 
                backgroundColor: '#3B82F6',
                color: '#FFFFFF',
                width: 64,
                height: 64,
                mx: 'auto',
                mb: 2
              }}>
                <SpeedIcon sx={{ fontSize: 32 }} />
              </Avatar>
              <Typography variant="h4" className="font-poppins" sx={{ color: '#1E3A8A', fontWeight: 700, mb: 1 }}>
                {saludInstitucional.tendencia}
              </Typography>
              <Typography variant="h6" className="font-poppins" sx={{ color: '#3B82F6', fontWeight: 600, mb: 1 }}>
                Tendencia
              </Typography>
              <Typography variant="body2" className="font-roboto" sx={{ color: '#6B7280' }}>
                Último mes
              </Typography>
            </CardContent>
          </Card>
        </Grid>
      </Grid>

      {/* Tabs */}
      <Card className="card" sx={{ mb: 3 }}>
        <Box sx={{ borderBottom: 1, borderColor: 'divider' }}>
          <Tabs value={tabValue} onChange={handleTabChange} aria-label="dashboard tabs">
            <Tab label="Matriz de Riesgos" icon={<AssessmentIcon />} iconPosition="start" />
            <Tab label="Análisis" icon={<TrendingUpIcon />} iconPosition="start" />
            <Tab label="Recomendaciones" icon={<LightbulbIcon />} iconPosition="start" />
            <Tab label="Tendencias" icon={<TimelineIcon />} iconPosition="start" />
          </Tabs>
        </Box>

        {/* Tab 1: Matriz de Riesgos */}
        <TabPanel value={tabValue} index={0}>
          <RiskMatrix4x5 />
        </TabPanel>

        {/* Tab 2: Análisis */}
        <TabPanel value={tabValue} index={1}>
          <Grid container spacing={3}>
            <Grid item xs={12} md={6}>
              <Card className="card">
                <CardContent sx={{ p: 3 }}>
                  <Typography variant="h6" className="font-poppins" sx={{ color: '#1E3A8A', mb: 2 }}>
                    Riesgos por Tipo
                  </Typography>
                  <Box sx={{ height: 300 }}>
                    <ResponsiveContainer width="100%" height="100%">
                      <BarChart data={riesgosPorTipo}>
                        <CartesianGrid strokeDasharray="3 3" />
                        <XAxis dataKey="tipo" />
                        <YAxis />
                        <Tooltip />
                        <Bar dataKey="cantidad" fill="#1E3A8A" />
                      </BarChart>
                    </ResponsiveContainer>
      </Box>
                </CardContent>
              </Card>
            </Grid>
            <Grid item xs={12} md={6}>
              <Card className="card">
                <CardContent sx={{ p: 3 }}>
                  <Typography variant="h6" className="font-poppins" sx={{ color: '#1E3A8A', mb: 2 }}>
                    Top Riesgos Críticos
                  </Typography>
                  <List>
                    {[
                      { nombre: 'Acceso no autorizado a BD', nivel: 'HIGH', tipo: 'Seguridad' },
                      { nombre: 'Falta de respaldo crítico', nivel: 'HIGH', tipo: 'Operacional' },
                      { nombre: 'Software desactualizado', nivel: 'MEDIUM', tipo: 'Técnico' },
                      { nombre: 'Políticas de acceso débiles', nivel: 'MEDIUM', tipo: 'Seguridad' },
                      { nombre: 'Falta de capacitación', nivel: 'MEDIUM', tipo: 'Operacional' }
                    ].map((riesgo, index) => (
                      <React.Fragment key={index}>
                        <ListItem sx={{ px: 0 }}>
                          <ListItemIcon>
                            <Avatar sx={{ 
                              backgroundColor: riesgo.nivel === 'HIGH' ? '#EF4444' : '#F59E0B',
                              color: '#FFFFFF',
                              width: 32,
                              height: 32
                            }}>
                              <WarningIcon sx={{ fontSize: 16 }} />
                            </Avatar>
                          </ListItemIcon>
                          <ListItemText
                            primary={
                              <Typography variant="body1" className="font-poppins" sx={{ color: '#1E3A8A', fontWeight: 500 }}>
                                {riesgo.nombre}
                              </Typography>
                            }
                            secondary={
                              <Box sx={{ display: 'flex', alignItems: 'center', gap: 1, mt: 0.5 }}>
                                <Chip
                                  label={riesgo.nivel}
                                  size="small"
                                  sx={{
                                    backgroundColor: riesgo.nivel === 'HIGH' ? '#EF4444' : '#F59E0B',
                                    color: '#FFFFFF',
                                    fontWeight: 500,
                                    fontSize: '0.75rem'
                                  }}
                                />
                                <Typography variant="caption" className="font-roboto" sx={{ color: '#6B7280' }}>
                                  {riesgo.tipo}
        </Typography>
      </Box>
                            }
                          />
                        </ListItem>
                        {index < 4 && <Divider />}
                      </React.Fragment>
                    ))}
                  </List>
                </CardContent>
              </Card>
            </Grid>
          </Grid>
        </TabPanel>

        {/* Tab 3: Recomendaciones */}
        <TabPanel value={tabValue} index={2}>
          <Grid container spacing={3}>
            {recomendaciones.map((recomendacion) => (
              <Grid item xs={12} md={6} key={recomendacion.id}>
                <Card className="card" sx={{ height: '100%' }}>
                  <CardContent sx={{ p: 3 }}>
                    <Box sx={{ display: 'flex', alignItems: 'flex-start', gap: 2, mb: 2 }}>
                      <Avatar sx={{ 
                        backgroundColor: recomendacion.color,
                        color: '#FFFFFF',
                        width: 48,
                        height: 48
                      }}>
                        {recomendacion.icono}
                      </Avatar>
                      <Box sx={{ flex: 1 }}>
                        <Box sx={{ display: 'flex', alignItems: 'center', gap: 1, mb: 1 }}>
                          <Chip
                            label={recomendacion.tipo}
                            size="small"
                            sx={{
                              backgroundColor: recomendacion.color,
                              color: '#FFFFFF',
                              fontWeight: 500,
                              fontSize: '0.75rem'
                            }}
                          />
                          <Chip
                            label={recomendacion.prioridad}
                            size="small"
                            variant="outlined"
                            sx={{
                              borderColor: recomendacion.color,
                              color: recomendacion.color,
                              fontWeight: 500,
                              fontSize: '0.75rem'
              }}
            />
          </Box>
                        <Typography variant="h6" className="font-poppins" sx={{ color: '#1E3A8A', fontWeight: 600, mb: 1 }}>
                          {recomendacion.titulo}
                        </Typography>
                        <Typography variant="body2" className="font-roboto" sx={{ color: '#6B7280', mb: 2 }}>
                          {recomendacion.descripcion}
                        </Typography>
            <Button
              variant="outlined"
                          size="small"
                          sx={{
                            borderColor: recomendacion.color,
                            color: recomendacion.color,
                            borderRadius: '8px',
                            textTransform: 'none',
                            fontWeight: 500
                          }}
                        >
                          Ver Detalles
            </Button>
          </Box>
        </Box>
                  </CardContent>
                </Card>
              </Grid>
            ))}
          </Grid>
        </TabPanel>

        {/* Tab 4: Tendencias */}
        <TabPanel value={tabValue} index={3}>
          <Grid container spacing={3}>
            <Grid item xs={12}>
              <Card className="card">
                <CardContent sx={{ p: 3 }}>
                  <Typography variant="h6" className="font-poppins" sx={{ color: '#1E3A8A', mb: 2 }}>
                    Evolución de Riesgos (Últimos 6 meses)
                  </Typography>
                  <Box sx={{ height: 400 }}>
                    <ResponsiveContainer width="100%" height="100%">
                      <LineChart data={tendenciaRiesgos}>
                        <CartesianGrid strokeDasharray="3 3" />
                        <XAxis dataKey="mes" />
                        <YAxis />
                        <Tooltip />
                        <Legend />
                        <Line type="monotone" dataKey="riesgos" stroke="#EF4444" strokeWidth={3} name="Riesgos Identificados" />
                        <Line type="monotone" dataKey="mitigados" stroke="#10B981" strokeWidth={3} name="Riesgos Mitigados" />
                      </LineChart>
                    </ResponsiveContainer>
                  </Box>
                </CardContent>
              </Card>
            </Grid>
          </Grid>
        </TabPanel>
      </Card>

      {/* Alertas Críticas */}
      <Alert 
        severity="warning" 
        sx={{ 
          mb: 3,
          borderRadius: '12px',
          '& .MuiAlert-message': {
            width: '100%'
          }
        }}
      >
        <Typography variant="h6" className="font-poppins" sx={{ color: '#1E3A8A', fontWeight: 600, mb: 1 }}>
          ⚠️ Atención Requerida
        </Typography>
        <Typography variant="body1" className="font-roboto" sx={{ color: '#6B7280' }}>
          Se han identificado 3 riesgos críticos que requieren atención inmediata. 
          Se recomienda revisar las recomendaciones prioritarias y implementar las medidas de mitigación correspondientes.
        </Typography>
      </Alert>
    </Box>
  );
};

export default Riesgos;
