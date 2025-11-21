import React, { useState, useEffect } from 'react';
import {
  Box,
  Card,
  CardContent,
  Typography,
  Button,
  Chip,
  Grid,
  Alert,
  Dialog,
  DialogTitle,
  DialogContent,
  DialogActions,
  List,
  ListItem,
  ListItemText,
  ListItemIcon,
  Divider,
  CircularProgress
} from '@mui/material';
import {
  ContentCopy as CloneIcon,
  Info as InfoIcon,
  CheckCircle as CheckCircleIcon,
  Warning as WarningIcon,
  Computer as ComputerIcon,
  Storage as StorageIcon,
  Cloud as CloudIcon
} from '@mui/icons-material';

interface TwinAsset {
  id: string;
  nombre: string;
  tipo: string;
  descripcion: string;
  criticidad: string;
  ultimaEvaluacion: string;
  nivelRiesgo: string;
  similitud: number;
  evaluacionExistente: {
    amenaza: string;
    vulnerabilidad: string;
    controles: string[];
    justificacion: string;
  };
}

interface TwinAssetSuggestionProps {
  currentAsset: {
    nombre: string;
    tipo: string;
    descripcion: string;
  };
  onCloneEvaluation?: (twinAsset: TwinAsset) => void;
}

const TwinAssetSuggestion: React.FC<TwinAssetSuggestionProps> = ({
  currentAsset,
  onCloneEvaluation
}) => {
  const [twinAssets, setTwinAssets] = useState<TwinAsset[]>([]);
  const [isLoading, setIsLoading] = useState(false);
  const [selectedTwin, setSelectedTwin] = useState<TwinAsset | null>(null);
  const [isDialogOpen, setIsDialogOpen] = useState(false);

  const loadTwinAssets = async () => {
    setIsLoading(true);
    
    try {
      // Simular búsqueda de activos gemelos
      const mockTwinAssets: TwinAsset[] = [
        {
          id: '1',
          nombre: 'Servidor Web Principal',
          tipo: 'Servidor',
          descripcion: 'Servidor web para aplicaciones críticas',
          criticidad: 'Alta',
          ultimaEvaluacion: '2024-01-15',
          nivelRiesgo: 'MEDIUM',
          similitud: 0.95,
          evaluacionExistente: {
            amenaza: 'Malware',
            vulnerabilidad: 'Software Desactualizado',
            controles: ['Antivirus', 'Actualizaciones Automáticas', 'Monitoreo de Red'],
            justificacion: 'El servidor web es vulnerable a ataques de malware debido a software desactualizado. Se implementaron controles de antivirus y actualizaciones automáticas.'
          }
        },
        {
          id: '2',
          nombre: 'Base de Datos de Usuarios',
          tipo: 'Base de Datos',
          descripcion: 'Base de datos principal del sistema',
          criticidad: 'Crítica',
          ultimaEvaluacion: '2024-01-10',
          nivelRiesgo: 'HIGH',
          similitud: 0.88,
          evaluacionExistente: {
            amenaza: 'Acceso No Autorizado',
            vulnerabilidad: 'Falta de Autenticación',
            controles: ['Autenticación Multifactor', 'Cifrado de Datos', 'Auditoría de Acceso'],
            justificacion: 'La base de datos requiere autenticación robusta y cifrado para proteger información sensible de usuarios.'
          }
        },
        {
          id: '3',
          nombre: 'Servidor de Archivos',
          tipo: 'Servidor',
          descripcion: 'Servidor para almacenamiento de documentos',
          criticidad: 'Media',
          ultimaEvaluacion: '2024-01-05',
          nivelRiesgo: 'LOW',
          similitud: 0.82,
          evaluacionExistente: {
            amenaza: 'Pérdida de Datos',
            vulnerabilidad: 'Falta de Respaldo',
            controles: ['Respaldos Regulares', 'Replicación de Datos', 'Monitoreo de Integridad'],
            justificacion: 'Se implementaron respaldos automáticos y replicación para prevenir pérdida de datos críticos.'
          }
        }
      ];

      // Filtrar activos similares (similitud > 0.8)
      const similarAssets = mockTwinAssets.filter(asset => 
        asset.similitud >= 0.8 && 
        asset.tipo.toLowerCase() === currentAsset.tipo.toLowerCase()
      );

      setTwinAssets(similarAssets);
    } catch (error) {
      console.error('Error loading twin assets:', error);
    } finally {
      setIsLoading(false);
    }
  };

  const handleCloneEvaluation = (twinAsset: TwinAsset) => {
    setSelectedTwin(twinAsset);
    setIsDialogOpen(true);
  };

  const confirmClone = () => {
    if (selectedTwin && onCloneEvaluation) {
      onCloneEvaluation(selectedTwin);
    }
    setIsDialogOpen(false);
    setSelectedTwin(null);
  };

  const getAssetIcon = (tipo: string) => {
    switch (tipo.toLowerCase()) {
      case 'servidor': return <ComputerIcon />;
      case 'base de datos': return <StorageIcon />;
      case 'aplicación': return <CloudIcon />;
      default: return <ComputerIcon />;
    }
  };

  const getRiskLevelColor = (nivel: string) => {
    switch (nivel) {
      case 'LOW': return '#4CAF50';
      case 'MEDIUM': return '#FF9800';
      case 'HIGH': return '#F44336';
      default: return '#9E9E9E';
    }
  };

  const getCriticityColor = (criticidad: string) => {
    switch (criticidad.toLowerCase()) {
      case 'crítica': return '#D32F2F';
      case 'alta': return '#F57C00';
      case 'media': return '#FFC107';
      case 'baja': return '#4CAF50';
      default: return '#9E9E9E';
    }
  };

  useEffect(() => {
    loadTwinAssets();
  }, [currentAsset]);

  if (isLoading) {
    return (
      <Box display="flex" justifyContent="center" alignItems="center" p={2}>
        <CircularProgress size={20} />
        <Typography variant="body2" sx={{ ml: 2 }}>
          Buscando activos similares...
        </Typography>
      </Box>
    );
  }

  if (twinAssets.length === 0) {
    return (
      <Alert severity="info" sx={{ mb: 2 }}>
        <Typography variant="body2">
          No se encontraron activos similares con evaluaciones previas.
        </Typography>
      </Alert>
    );
  }

  return (
    <Box>
      <Alert severity="success" sx={{ mb: 3 }}>
        <Box display="flex" alignItems="center">
          <InfoIcon sx={{ mr: 1 }} />
          <Typography variant="body2">
            <strong>¡Encontramos {twinAssets.length} activo(s) similar(es) con evaluaciones previas!</strong>
            <br />
            Puedes clonar la evaluación existente para acelerar el proceso.
          </Typography>
        </Box>
      </Alert>

      <Grid container spacing={2}>
        {twinAssets.map((twin) => (
          <Grid item xs={12} md={6} key={twin.id}>
            <Card sx={{ height: '100%', border: '2px solid #E3F2FD' }}>
              <CardContent>
                <Box display="flex" alignItems="center" mb={2}>
                  {getAssetIcon(twin.tipo)}
                  <Typography variant="h6" sx={{ ml: 1, color: '#1E3A8A', fontWeight: 'bold' }}>
                    {twin.nombre}
                  </Typography>
                </Box>

                <Typography variant="body2" color="text.secondary" sx={{ mb: 2 }}>
                  {twin.descripcion}
                </Typography>

                <Box display="flex" flexWrap="wrap" gap={1} mb={2}>
                  <Chip
                    label={`${(twin.similitud * 100).toFixed(0)}% Similitud`}
                    size="small"
                    sx={{ backgroundColor: '#1E3A8A', color: 'white' }}
                  />
                  <Chip
                    label={twin.criticidad}
                    size="small"
                    sx={{ 
                      backgroundColor: getCriticityColor(twin.criticidad),
                      color: 'white'
                    }}
                  />
                  <Chip
                    label={twin.nivelRiesgo}
                    size="small"
                    sx={{ 
                      backgroundColor: getRiskLevelColor(twin.nivelRiesgo),
                      color: 'white'
                    }}
                  />
                </Box>

                <Typography variant="body2" color="text.secondary" sx={{ mb: 2 }}>
                  <strong>Última evaluación:</strong> {twin.ultimaEvaluacion}
                </Typography>

                <Box sx={{ mb: 2 }}>
                  <Typography variant="subtitle2" sx={{ color: '#1E3A8A', mb: 1 }}>
                    Evaluación Existente:
                  </Typography>
                  <Typography variant="body2" sx={{ mb: 1 }}>
                    <strong>Amenaza:</strong> {twin.evaluacionExistente.amenaza}
                  </Typography>
                  <Typography variant="body2" sx={{ mb: 1 }}>
                    <strong>Vulnerabilidad:</strong> {twin.evaluacionExistente.vulnerabilidad}
                  </Typography>
                  <Typography variant="body2" sx={{ mb: 1 }}>
                    <strong>Controles:</strong> {twin.evaluacionExistente.controles.join(', ')}
                  </Typography>
                </Box>

                <Button
                  variant="contained"
                  startIcon={<CloneIcon />}
                  onClick={() => handleCloneEvaluation(twin)}
                  fullWidth
                  sx={{
                    backgroundColor: '#4CAF50',
                    '&:hover': { backgroundColor: '#45A049' }
                  }}
                >
                  Clonar Evaluación
                </Button>
              </CardContent>
            </Card>
          </Grid>
        ))}
      </Grid>

      {/* Dialog de confirmación de clonación */}
      <Dialog open={isDialogOpen} onClose={() => setIsDialogOpen(false)} maxWidth="md" fullWidth>
        <DialogTitle>
          <Box display="flex" alignItems="center">
            <CloneIcon sx={{ mr: 1, color: '#4CAF50' }} />
            Confirmar Clonación de Evaluación
          </Box>
        </DialogTitle>
        
        <DialogContent>
          {selectedTwin && (
            <Box>
              <Alert severity="warning" sx={{ mb: 3 }}>
                <Typography variant="body2">
                  <strong>¿Estás seguro de que quieres clonar la evaluación de "{selectedTwin.nombre}"?</strong>
                  <br />
                  Esto copiará la amenaza, vulnerabilidad, controles y justificación a tu evaluación actual.
                </Typography>
              </Alert>

              <Typography variant="h6" sx={{ color: '#1E3A8A', mb: 2 }}>
                Detalles de la Evaluación a Clonar:
              </Typography>

              <List>
                <ListItem>
                  <ListItemIcon>
                    <WarningIcon color="primary" />
                  </ListItemIcon>
                  <ListItemText
                    primary="Amenaza"
                    secondary={selectedTwin.evaluacionExistente.amenaza}
                  />
                </ListItem>
                
                <ListItem>
                  <ListItemIcon>
                    <InfoIcon color="primary" />
                  </ListItemIcon>
                  <ListItemText
                    primary="Vulnerabilidad"
                    secondary={selectedTwin.evaluacionExistente.vulnerabilidad}
                  />
                </ListItem>
                
                <ListItem>
                  <ListItemIcon>
                    <CheckCircleIcon color="primary" />
                  </ListItemIcon>
                  <ListItemText
                    primary="Controles"
                    secondary={selectedTwin.evaluacionExistente.controles.join(', ')}
                  />
                </ListItem>
              </List>

              <Divider sx={{ my: 2 }} />

              <Typography variant="body2" color="text.secondary">
                <strong>Justificación:</strong> {selectedTwin.evaluacionExistente.justificacion}
              </Typography>
            </Box>
          )}
        </DialogContent>
        
        <DialogActions>
          <Button onClick={() => setIsDialogOpen(false)}>
            Cancelar
          </Button>
          <Button
            onClick={confirmClone}
            variant="contained"
            startIcon={<CloneIcon />}
            sx={{ backgroundColor: '#4CAF50' }}
          >
            Confirmar Clonación
          </Button>
        </DialogActions>
      </Dialog>
    </Box>
  );
};

export default TwinAssetSuggestion;








