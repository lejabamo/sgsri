import React, { useState, useEffect } from 'react';
import {
  Box,
  Card,
  CardContent,
  Typography,
  Grid,
  Chip,
  Tooltip,
  Dialog,
  DialogTitle,
  DialogContent,
  DialogActions,
  Button,
  Table,
  TableBody,
  TableCell,
  TableContainer,
  TableHead,
  TableRow,
  Paper,
  LinearProgress,
  Alert,
  IconButton,
  TextField,
  MenuItem,
  FormControl,
  InputLabel,
  Select,
  Stack
} from '@mui/material';
import {
  TrendingUp,
  TrendingDown,
  Warning,
  CheckCircle,
  Info,
  Download,
  FilterList,
  Close
} from '@mui/icons-material';

// Tipos de datos
interface Risk {
  id: number;
  nombre: string;
  nivel: 'LOW' | 'MEDIUM' | 'HIGH';
  propietario: string;
  fecha: string;
  activo: string;
  proceso: string;
}

interface MatrixCell {
  probabilidad_key: string;
  impacto_key: string;
  count: number;
  risks: Risk[];
}

interface HealthData {
  low: number;
  medium: number;
  high: number;
  score: number;
}

interface MatrixData {
  cells: MatrixCell[];
  health: HealthData;
}

// Configuración de la matriz
const PROBABILIDADES = ['Frecuente', 'Ocasional', 'Posible', 'Improbable'];
const IMPACTOS = ['Insignificante', 'Menor', 'Moderado', 'Mayor', 'Catastrófico'];

// Mapeo de niveles de riesgo
const RISK_LEVELS = {
  'BAJO': { color: '#27AE60', label: 'BAJO' },
  'MEDIO': { color: '#FACC15', label: 'MEDIO' },
  'ALTO': { color: '#D9534F', label: 'ALTO' }
};

// Función para calcular nivel de riesgo (fallback)
const calculateRiskLevel = (probabilidad: string, impacto: string): 'BAJO' | 'MEDIO' | 'ALTO' => {
  const probValues: { [key: string]: number } = {
    'Improbable': 1,
    'Posible': 2,
    'Ocasional': 3,
    'Frecuente': 4
  };
  
  const impactoValues: { [key: string]: number } = {
    'Insignificante': 1,
    'Menor': 2,
    'Moderado': 3,
    'Mayor': 4,
    'Catastrófico': 5
  };
  
  const score = probValues[probabilidad] * impactoValues[impacto];
  
  if (score <= 6) return 'BAJO';
  if (score <= 11) return 'MEDIO';
  return 'ALTO';
};

// Función para obtener recomendaciones
const getRecommendations = (level: 'BAJO' | 'MEDIO' | 'ALTO'): string => {
  const recommendations = {
    'BAJO': 'Monitoreo periódico',
    'MEDIO': 'Evaluar controles y planificar tratamiento',
    'ALTO': 'Priorizar plan de mitigación y asignar responsable'
  };
  return recommendations[level];
};

// Función para obtener estado de salud
const getHealthStatus = (score: number): { status: string; color: string } => {
  if (score >= 70) return { status: 'Salud Buena', color: '#27AE60' };
  if (score >= 40) return { status: 'Salud Moderada', color: '#FACC15' };
  return { status: 'Salud Crítica', color: '#D9534F' };
};

const RiskMatrix4x5: React.FC = () => {
  const [matrixData, setMatrixData] = useState<MatrixData | null>(null);
  const [loading, setLoading] = useState(true);
  const [selectedCell, setSelectedCell] = useState<MatrixCell | null>(null);
  const [modalOpen, setModalOpen] = useState(false);
  const [filters, setFilters] = useState({
    activo: '',
    propietario: '',
    proceso: '',
    fechaInicio: '',
    fechaFin: ''
  });

  // Datos de ejemplo (simulando respuesta del backend)
  const mockData: MatrixData = {
    cells: [
      {
        probabilidad_key: 'Frecuente',
        impacto_key: 'Insignificante',
        count: 3,
        risks: [
          { id: 1, nombre: 'Falla de sistema menor', nivel: 'MEDIUM', propietario: 'Juan Pérez', fecha: '2025-01-15', activo: 'Servidor Web', proceso: 'Operaciones' },
          { id: 2, nombre: 'Interrupción temporal', nivel: 'MEDIUM', propietario: 'María García', fecha: '2025-01-10', activo: 'Base de Datos', proceso: 'Desarrollo' }
        ]
      },
      {
        probabilidad_key: 'Frecuente',
        impacto_key: 'Menor',
        count: 2,
        risks: [
          { id: 3, nombre: 'Error de configuración', nivel: 'MEDIUM', propietario: 'Carlos López', fecha: '2025-01-12', activo: 'Firewall', proceso: 'Seguridad' }
        ]
      },
      {
        probabilidad_key: 'Frecuente',
        impacto_key: 'Moderado',
        count: 5,
        risks: [
          { id: 4, nombre: 'Brecha de seguridad', nivel: 'HIGH', propietario: 'Ana Martínez', fecha: '2025-01-08', activo: 'Sistema de Autenticación', proceso: 'Seguridad' },
          { id: 5, nombre: 'Pérdida de datos', nivel: 'HIGH', propietario: 'Luis Rodríguez', fecha: '2025-01-05', activo: 'Backup System', proceso: 'Operaciones' }
        ]
      },
      {
        probabilidad_key: 'Ocasional',
        impacto_key: 'Insignificante',
        count: 1,
        risks: [
          { id: 6, nombre: 'Retraso menor', nivel: 'LOW', propietario: 'Pedro Sánchez', fecha: '2025-01-14', activo: 'Sistema de Reportes', proceso: 'Administración' }
        ]
      },
      {
        probabilidad_key: 'Ocasional',
        impacto_key: 'Menor',
        count: 4,
        risks: [
          { id: 7, nombre: 'Falla de red', nivel: 'MEDIUM', propietario: 'Elena Ruiz', fecha: '2025-01-11', activo: 'Router Principal', proceso: 'Infraestructura' }
        ]
      },
      {
        probabilidad_key: 'Posible',
        impacto_key: 'Insignificante',
        count: 2,
        risks: [
          { id: 8, nombre: 'Actualización pendiente', nivel: 'LOW', propietario: 'Miguel Torres', fecha: '2025-01-13', activo: 'Sistema de Monitoreo', proceso: 'Mantenimiento' }
        ]
      },
      {
        probabilidad_key: 'Improbable',
        impacto_key: 'Catastrófico',
        count: 1,
        risks: [
          { id: 9, nombre: 'Desastre natural', nivel: 'MEDIUM', propietario: 'Sistema', fecha: '2025-01-01', activo: 'Centro de Datos', proceso: 'Infraestructura' }
        ]
      }
    ],
    health: {
      low: 40,
      medium: 35,
      high: 25,
      score: 71
    }
  };

  useEffect(() => {
    const fetchMatrixData = async () => {
      setLoading(true);
      try {
        // Importar el servicio de riesgos dinámicamente para evitar dependencias circulares
        const { riesgosService } = await import('../../services/backend');
        const data = await riesgosService.getMatrix('2025-Q3');
        setMatrixData(data);
      } catch (error) {
        console.error('Error fetching matrix data:', error);
        // Usar datos mock en caso de error
        setMatrixData(mockData);
      } finally {
        setLoading(false);
      }
    };

    fetchMatrixData();
  }, []);

  const handleCellClick = (cell: MatrixCell) => {
    setSelectedCell(cell);
    setModalOpen(true);
  };

  const handleExport = (format: 'PDF' | 'CSV') => {
    // Implementar exportación
    console.log(`Exporting to ${format}`);
  };

  const getCellData = (probabilidad: string, impacto: string): MatrixCell | null => {
    if (!matrixData) return null;
    return matrixData.cells.find(
      cell => cell.probabilidad_key === probabilidad && cell.impacto_key === impacto
    ) || null;
  };

  const getRiskLevel = (probabilidad: string, impacto: string): 'BAJO' | 'MEDIO' | 'ALTO' => {
    const cell = getCellData(probabilidad, impacto);
    if (cell && cell.risks.length > 0) {
      // Si hay riesgos, usar el nivel más alto
      const levels = cell.risks.map(risk => risk.nivel);
      if (levels.includes('HIGH')) return 'ALTO';
      if (levels.includes('MEDIUM')) return 'MEDIO';
      return 'BAJO';
    }
    // Fallback al cálculo local
    return calculateRiskLevel(probabilidad, impacto);
  };

  if (loading) {
    return (
      <Box sx={{ p: 3 }}>
        <LinearProgress />
        <Typography variant="body2" sx={{ mt: 2, textAlign: 'center' }}>
          Cargando matriz de riesgos...
        </Typography>
      </Box>
    );
  }

  if (!matrixData) {
    return (
      <Alert severity="error" sx={{ m: 3 }}>
        Error al cargar los datos de la matriz de riesgos
      </Alert>
    );
  }

  const healthStatus = getHealthStatus(matrixData.health.score);

  return (
    <Box sx={{ p: 3 }}>
      <Grid container spacing={3}>
        {/* Matriz de Riesgos */}
        <Grid item xs={12} lg={8}>
          <Card sx={{ borderRadius: '16px', boxShadow: '0 4px 20px rgba(0,0,0,0.1)' }}>
            <CardContent sx={{ p: 3 }}>
              <Box sx={{ display: 'flex', justifyContent: 'space-between', alignItems: 'center', mb: 3 }}>
                <Typography variant="h5" className="font-poppins" sx={{ color: '#1E3A8A', fontWeight: 600 }}>
                  Matriz de Evaluación de Riesgo
                </Typography>
                <Stack direction="row" spacing={1}>
                  <Button
                    variant="outlined"
                    startIcon={<FilterList />}
                    size="small"
                    sx={{ borderRadius: '8px' }}
                  >
                    Filtros
                  </Button>
                  <Button
                    variant="outlined"
                    startIcon={<Download />}
                    size="small"
                    sx={{ borderRadius: '8px' }}
                    onClick={() => handleExport('PDF')}
                  >
                    Exportar
                  </Button>
                </Stack>
              </Box>

              {/* Matriz Grid */}
              <Box sx={{ overflowX: 'auto' }}>
                <Box sx={{ minWidth: '600px' }}>
                  {/* Header con etiquetas de impacto */}
                  <Box sx={{ display: 'flex', mb: 1 }}>
                    <Box sx={{ width: '120px' }} /> {/* Espacio para etiquetas de probabilidad */}
                    {IMPACTOS.map((impacto) => (
                      <Box
                        key={impacto}
                        sx={{
                          flex: 1,
                          textAlign: 'center',
                          py: 1,
                          px: 0.5
                        }}
                      >
                        <Typography
                          variant="body2"
                          className="font-roboto"
                          sx={{
                            color: '#1E3A8A',
                            fontWeight: 600,
                            fontSize: '0.75rem',
                            lineHeight: 1.2
                          }}
                        >
                          {impacto}
                        </Typography>
                      </Box>
                    ))}
                  </Box>

                  {/* Filas de la matriz */}
                  {PROBABILIDADES.map((probabilidad) => (
                    <Box key={probabilidad} sx={{ display: 'flex', mb: 1 }}>
                      {/* Etiqueta de probabilidad */}
                      <Box
                        sx={{
                          width: '120px',
                          display: 'flex',
                          alignItems: 'center',
                          pr: 2
                        }}
                      >
                        <Typography
                          variant="body2"
                          className="font-roboto"
                          sx={{
                            color: '#1E3A8A',
                            fontWeight: 600,
                            fontSize: '0.75rem'
                          }}
                        >
                          {probabilidad}
                        </Typography>
                      </Box>

                      {/* Celdas de la matriz */}
                      {IMPACTOS.map((impacto) => {
                        const cellData = getCellData(probabilidad, impacto);
                        const riskLevel = getRiskLevel(probabilidad, impacto);
                        const levelConfig = RISK_LEVELS[riskLevel];
                        const count = cellData?.count || 0;

                        return (
                          <Tooltip
                            key={`${probabilidad}-${impacto}`}
                            title={
                              cellData && cellData.risks.length > 0 ? (
                                <Box>
                                  <Typography variant="body2" sx={{ fontWeight: 600, mb: 1 }}>
                                    Top 3 Riesgos:
                                  </Typography>
                                  {cellData.risks.slice(0, 3).map((risk) => (
                                    <Box key={risk.id} sx={{ mb: 0.5 }}>
                                      <Typography variant="caption" sx={{ display: 'block' }}>
                                        {risk.nombre} - {risk.propietario}
                                      </Typography>
                                      <Typography variant="caption" sx={{ color: '#9CA3AF' }}>
                                        {risk.fecha}
                                      </Typography>
                                    </Box>
                                  ))}
                                </Box>
                              ) : (
                                'Sin riesgos registrados'
                              )
                            }
                            arrow
                          >
                            <Box
                              onClick={() => cellData && handleCellClick(cellData)}
                              sx={{
                                flex: 1,
                                height: '60px',
                                backgroundColor: levelConfig.color,
                                borderRadius: '8px',
                                display: 'flex',
                                flexDirection: 'column',
                                alignItems: 'center',
                                justifyContent: 'center',
                                cursor: cellData ? 'pointer' : 'default',
                                border: '2px solid transparent',
                                transition: 'all 0.2s ease',
                                mx: 0.5,
                                '&:hover': cellData ? {
                                  transform: 'scale(1.05)',
                                  boxShadow: '0 4px 12px rgba(0,0,0,0.2)',
                                  border: '2px solid #1E3A8A'
                                } : {}
                              }}
                            >
                              <Typography
                                variant="h6"
                                className="font-poppins"
                                sx={{
                                  color: '#FFFFFF',
                                  fontWeight: 700,
                                  fontSize: '1.2rem',
                                  lineHeight: 1
                                }}
                              >
                                {count}
                              </Typography>
                              <Typography
                                variant="caption"
                                className="font-roboto"
                                sx={{
                                  color: '#FFFFFF',
                                  fontWeight: 600,
                                  fontSize: '0.7rem',
                                  opacity: 0.9
                                }}
                              >
                                {levelConfig.label}
                              </Typography>
                            </Box>
                          </Tooltip>
                        );
                      })}
                    </Box>
                  ))}
                </Box>
              </Box>

              {/* Leyenda */}
              <Box sx={{ mt: 3, display: 'flex', justifyContent: 'center', gap: 3, flexWrap: 'wrap' }}>
                {Object.entries(RISK_LEVELS).map(([level, config]) => (
                  <Box key={level} sx={{ display: 'flex', alignItems: 'center', gap: 1 }}>
                    <Box
                      sx={{
                        width: 16,
                        height: 16,
                        backgroundColor: config.color,
                        borderRadius: '4px'
                      }}
                    />
                    <Typography variant="body2" className="font-roboto" sx={{ color: '#6B7280' }}>
                      {config.label}
                    </Typography>
                  </Box>
                ))}
              </Box>
            </CardContent>
          </Card>
        </Grid>

        {/* Panel de Salud Institucional */}
        <Grid item xs={12} lg={4}>
          <Card sx={{ borderRadius: '16px', boxShadow: '0 4px 20px rgba(0,0,0,0.1)' }}>
            <CardContent sx={{ p: 3 }}>
              <Typography variant="h6" className="font-poppins" sx={{ color: '#1E3A8A', fontWeight: 600, mb: 3 }}>
                Salud Institucional
              </Typography>

              {/* Score Principal */}
              <Box sx={{ textAlign: 'center', mb: 3 }}>
                <Typography variant="h2" className="font-poppins" sx={{ color: healthStatus.color, fontWeight: 700 }}>
                  {matrixData.health.score}%
                </Typography>
                <Typography variant="h6" className="font-roboto" sx={{ color: healthStatus.color, fontWeight: 600 }}>
                  {healthStatus.status}
                </Typography>
                <LinearProgress
                  variant="determinate"
                  value={matrixData.health.score}
                  sx={{
                    mt: 2,
                    height: 8,
                    borderRadius: 4,
                    backgroundColor: '#E5E7EB',
                    '& .MuiLinearProgress-bar': {
                      backgroundColor: healthStatus.color,
                      borderRadius: 4
                    }
                  }}
                />
              </Box>

              {/* Distribución de Riesgos */}
              <Box sx={{ mb: 3 }}>
                <Typography variant="subtitle2" className="font-roboto" sx={{ color: '#374151', fontWeight: 600, mb: 2 }}>
                  Distribución de Riesgos
                </Typography>
                
                <Stack spacing={2}>
                  <Box>
                    <Box sx={{ display: 'flex', justifyContent: 'space-between', mb: 1 }}>
                      <Typography variant="body2" className="font-roboto" sx={{ color: '#6B7280' }}>
                        Riesgos Bajos
                      </Typography>
                      <Typography variant="body2" className="font-roboto" sx={{ color: '#6B7280', fontWeight: 600 }}>
                        {matrixData.health.low}%
                      </Typography>
                    </Box>
                    <LinearProgress
                      variant="determinate"
                      value={matrixData.health.low}
                      sx={{
                        height: 6,
                        borderRadius: 3,
                        backgroundColor: '#E5E7EB',
                        '& .MuiLinearProgress-bar': {
                          backgroundColor: '#27AE60',
                          borderRadius: 3
                        }
                      }}
                    />
                  </Box>

                  <Box>
                    <Box sx={{ display: 'flex', justifyContent: 'space-between', mb: 1 }}>
                      <Typography variant="body2" className="font-roboto" sx={{ color: '#6B7280' }}>
                        Riesgos Medios
                      </Typography>
                      <Typography variant="body2" className="font-roboto" sx={{ color: '#6B7280', fontWeight: 600 }}>
                        {matrixData.health.medium}%
                      </Typography>
                    </Box>
                    <LinearProgress
                      variant="determinate"
                      value={matrixData.health.medium}
                      sx={{
                        height: 6,
                        borderRadius: 3,
                        backgroundColor: '#E5E7EB',
                        '& .MuiLinearProgress-bar': {
                          backgroundColor: '#FACC15',
                          borderRadius: 3
                        }
                      }}
                    />
                  </Box>

                  <Box>
                    <Box sx={{ display: 'flex', justifyContent: 'space-between', mb: 1 }}>
                      <Typography variant="body2" className="font-roboto" sx={{ color: '#6B7280' }}>
                        Riesgos Altos
                      </Typography>
                      <Typography variant="body2" className="font-roboto" sx={{ color: '#6B7280', fontWeight: 600 }}>
                        {matrixData.health.high}%
                      </Typography>
                    </Box>
                    <LinearProgress
                      variant="determinate"
                      value={matrixData.health.high}
                      sx={{
                        height: 6,
                        borderRadius: 3,
                        backgroundColor: '#E5E7EB',
                        '& .MuiLinearProgress-bar': {
                          backgroundColor: '#D9534F',
                          borderRadius: 3
                        }
                      }}
                    />
                  </Box>
                </Stack>
              </Box>

              {/* Recomendaciones */}
              <Box>
                <Typography variant="subtitle2" className="font-roboto" sx={{ color: '#374151', fontWeight: 600, mb: 2 }}>
                  Recomendaciones
                </Typography>
                
                <Stack spacing={1}>
                  {matrixData.health.high > 20 && (
                    <Alert severity="error" sx={{ fontSize: '0.75rem', py: 0.5 }}>
                      {getRecommendations('ALTO')}
                    </Alert>
                  )}
                  {matrixData.health.medium > 30 && (
                    <Alert severity="warning" sx={{ fontSize: '0.75rem', py: 0.5 }}>
                      {getRecommendations('MEDIO')}
                    </Alert>
                  )}
                  {matrixData.health.low > 50 && (
                    <Alert severity="success" sx={{ fontSize: '0.75rem', py: 0.5 }}>
                      {getRecommendations('BAJO')}
                    </Alert>
                  )}
                </Stack>
              </Box>
            </CardContent>
          </Card>
        </Grid>
      </Grid>

      {/* Modal de Detalles */}
      <Dialog
        open={modalOpen}
        onClose={() => setModalOpen(false)}
        maxWidth="md"
        fullWidth
        PaperProps={{
          sx: { borderRadius: '16px' }
        }}
      >
        <DialogTitle sx={{ display: 'flex', justifyContent: 'space-between', alignItems: 'center' }}>
          <Typography variant="h6" className="font-poppins" sx={{ color: '#1E3A8A', fontWeight: 600 }}>
            Riesgos: {selectedCell?.probabilidad_key} - {selectedCell?.impacto_key}
          </Typography>
          <IconButton onClick={() => setModalOpen(false)}>
            <Close />
          </IconButton>
        </DialogTitle>
        
        <DialogContent>
          {selectedCell && (
            <Box>
              <Box sx={{ mb: 3, display: 'flex', justifyContent: 'space-between', alignItems: 'center' }}>
                <Typography variant="body1" className="font-roboto" sx={{ color: '#6B7280' }}>
                  Total de riesgos: {selectedCell.count}
                </Typography>
                <Chip
                  label={getRiskLevel(selectedCell.probabilidad_key, selectedCell.impacto_key)}
                  sx={{
                    backgroundColor: RISK_LEVELS[getRiskLevel(selectedCell.probabilidad_key, selectedCell.impacto_key)].color,
                    color: '#FFFFFF',
                    fontWeight: 600
                  }}
                />
              </Box>

              <TableContainer component={Paper} sx={{ borderRadius: '12px' }}>
                <Table>
                  <TableHead>
                    <TableRow>
                      <TableCell>Riesgo</TableCell>
                      <TableCell>Nivel</TableCell>
                      <TableCell>Propietario</TableCell>
                      <TableCell>Activo</TableCell>
                      <TableCell>Fecha</TableCell>
                      <TableCell>Acciones</TableCell>
                    </TableRow>
                  </TableHead>
                  <TableBody>
                    {selectedCell.risks.map((risk) => (
                      <TableRow key={risk.id}>
                        <TableCell>
                          <Typography variant="body2" className="font-roboto" sx={{ fontWeight: 500 }}>
                            {risk.nombre}
                          </Typography>
                        </TableCell>
                        <TableCell>
                          <Chip
                            label={risk.nivel}
                            size="small"
                            sx={{
                              backgroundColor: RISK_LEVELS[risk.nivel === 'HIGH' ? 'ALTO' : risk.nivel === 'MEDIUM' ? 'MEDIO' : 'BAJO'].color,
                              color: '#FFFFFF',
                              fontWeight: 600
                            }}
                          />
                        </TableCell>
                        <TableCell>{risk.propietario}</TableCell>
                        <TableCell>{risk.activo}</TableCell>
                        <TableCell>{risk.fecha}</TableCell>
                        <TableCell>
                          <Stack direction="row" spacing={1}>
                            <Button size="small" variant="outlined">
                              Ver
                            </Button>
                            <Button size="small" variant="contained">
                              Tratar
                            </Button>
                          </Stack>
                        </TableCell>
                      </TableRow>
                    ))}
                  </TableBody>
                </Table>
              </TableContainer>
            </Box>
          )}
        </DialogContent>
        
        <DialogActions sx={{ p: 3 }}>
          <Button onClick={() => setModalOpen(false)}>
            Cerrar
          </Button>
          <Button variant="contained" startIcon={<Download />}>
            Exportar Listado
          </Button>
        </DialogActions>
      </Dialog>
    </Box>
  );
};

export default RiskMatrix4x5;
