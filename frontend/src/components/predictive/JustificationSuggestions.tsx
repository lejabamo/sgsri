import React, { useState, useEffect } from 'react';
import {
  Box,
  Card,
  CardContent,
  Typography,
  Chip,
  Button,
  CircularProgress,
  Alert,
  Paper,
  Tooltip,
  Fade,
  Zoom
} from '@mui/material';
import {
  Lightbulb as LightbulbIcon,
  CheckCircle as CheckCircleIcon,
  Refresh as RefreshIcon
} from '@mui/icons-material';
import { apiRequest } from '../../services/api';

interface JustificationSuggestion {
  id: string;
  titulo: string;
  descripcion: string;
  norma: string;
  articulo: string;
  confianza: number;
}

interface JustificationSuggestionsProps {
  riskType: string;
  controls: string[];
  onJustificationSelect?: (justification: string) => void;
}

const JustificationSuggestions: React.FC<JustificationSuggestionsProps> = ({
  riskType,
  controls,
  onJustificationSelect
}) => {
  const [suggestions, setSuggestions] = useState<JustificationSuggestion[]>([]);
  const [isLoading, setIsLoading] = useState(false);
  const [error, setError] = useState<string | null>(null);
  const [hoveredSuggestion, setHoveredSuggestion] = useState<string | null>(null);

  const loadJustificationSuggestions = async () => {
    setIsLoading(true);
    setError(null);
    
    try {
      // Simular sugerencias basadas en controles seleccionados
      const mockSuggestions: JustificationSuggestion[] = [
        {
          id: '1',
          titulo: 'Control de Acceso',
          descripcion: 'Los controles de acceso restringen el acceso no autorizado a los sistemas y datos, reduciendo la probabilidad de exposición de información confidencial.',
          norma: 'ISO 27002',
          articulo: 'A.9.1.1',
          confianza: 0.9
        },
        {
          id: '2',
          titulo: 'Cifrado de Datos',
          descripcion: 'El cifrado protege la confidencialidad e integridad de los datos, incluso en caso de acceso no autorizado, minimizando el impacto del riesgo.',
          norma: 'ISO 27002',
          articulo: 'A.10.1.1',
          confianza: 0.85
        },
        {
          id: '3',
          titulo: 'Monitoreo Continuo',
          descripcion: 'El monitoreo continuo permite detectar y responder rápidamente a incidentes de seguridad, reduciendo el tiempo de exposición.',
          norma: 'ISO 27002',
          articulo: 'A.12.4.1',
          confianza: 0.8
        },
        {
          id: '4',
          titulo: 'Capacitación en Seguridad',
          descripcion: 'La capacitación reduce el factor humano en los incidentes de seguridad, disminuyendo la probabilidad de errores que generen riesgos.',
          norma: 'ISO 27002',
          articulo: 'A.7.2.2',
          confianza: 0.75
        },
        {
          id: '5',
          titulo: 'Respaldos Regulares',
          descripcion: 'Los respaldos regulares permiten la recuperación rápida de datos en caso de pérdida, minimizando el impacto operacional.',
          norma: 'ISO 27002',
          articulo: 'A.12.3.1',
          confianza: 0.9
        }
      ];

      // Filtrar sugerencias basadas en controles seleccionados
      const filteredSuggestions = mockSuggestions.filter(suggestion => 
        controls.some(control => 
          control.toLowerCase().includes(suggestion.titulo.toLowerCase().split(' ')[0]) ||
          suggestion.titulo.toLowerCase().includes(control.toLowerCase().split(' ')[0])
        )
      );

      setSuggestions(filteredSuggestions);
    } catch (err) {
      console.error('Error loading justification suggestions:', err);
      setError('Error al cargar sugerencias de justificación');
    } finally {
      setIsLoading(false);
    }
  };

  const handleJustificationClick = (suggestion: JustificationSuggestion) => {
    if (onJustificationSelect) {
      onJustificationSelect(suggestion.descripcion);
    }
  };

  const getConfidenceColor = (confidence: number) => {
    if (confidence >= 0.8) return '#4CAF50';
    if (confidence >= 0.6) return '#FF9800';
    return '#F44336';
  };

  useEffect(() => {
    if (controls.length > 0) {
      loadJustificationSuggestions();
    }
  }, [controls]);

  if (isLoading) {
    return (
      <Box display="flex" justifyContent="center" alignItems="center" p={2}>
        <CircularProgress size={20} />
        <Typography variant="body2" sx={{ ml: 2 }}>
          Cargando justificaciones...
        </Typography>
      </Box>
    );
  }

  if (error) {
    return (
      <Alert severity="error" action={
        <Button color="inherit" size="small" onClick={loadJustificationSuggestions}>
          Reintentar
        </Button>
      }>
        {error}
      </Alert>
    );
  }

  if (suggestions.length === 0) {
    return (
      <Box sx={{ textAlign: 'center', py: 2 }}>
        <Typography variant="body2" color="text.secondary">
          Selecciona controles para ver justificaciones sugeridas
        </Typography>
      </Box>
    );
  }

  return (
    <Box>
      <Box display="flex" alignItems="center" mb={2}>
        <LightbulbIcon sx={{ color: '#1E3A8A', mr: 1 }} />
        <Typography variant="h6" sx={{ color: '#1E3A8A', fontWeight: 'bold' }}>
          💡 Justificaciones Sugeridas ISO 27002
        </Typography>
      </Box>

      <Box display="flex" flexWrap="wrap" gap={1.5}>
        {suggestions.map((suggestion, index) => (
          <Zoom
            key={suggestion.id}
            in={true}
            timeout={300 + index * 100}
            style={{ transitionDelay: `${index * 100}ms` }}
          >
            <Tooltip
              title={
                <Box>
                  <Typography variant="subtitle2" sx={{ fontWeight: 'bold', mb: 1 }}>
                    {suggestion.titulo}
                  </Typography>
                  <Typography variant="body2" sx={{ mb: 1 }}>
                    {suggestion.descripcion}
                  </Typography>
                  <Box display="flex" gap={1} flexWrap="wrap">
                    <Chip
                      label={`${suggestion.norma} ${suggestion.articulo}`}
                      size="small"
                      sx={{ 
                        backgroundColor: '#1E3A8A',
                        color: 'white',
                        fontSize: '0.7rem'
                      }}
                    />
                    <Chip
                      label={`${(suggestion.confianza * 100).toFixed(0)}%`}
                      size="small"
                      sx={{ 
                        backgroundColor: getConfidenceColor(suggestion.confianza),
                        color: 'white',
                        fontSize: '0.7rem'
                      }}
                    />
                  </Box>
                </Box>
              }
              arrow
              placement="top"
            >
              <Paper
                elevation={hoveredSuggestion === suggestion.id ? 8 : 2}
                sx={{
                  p: 2,
                  cursor: 'pointer',
                  backgroundColor: '#FFF8E1',
                  border: '2px solid transparent',
                  transition: 'all 0.3s ease',
                  transform: hoveredSuggestion === suggestion.id ? 'scale(1.05)' : 'scale(1)',
                  '&:hover': {
                    borderColor: '#FF9800',
                    backgroundColor: '#FFF3E0',
                  },
                  minWidth: '120px',
                  textAlign: 'center',
                  position: 'relative',
                  overflow: 'hidden'
                }}
                onMouseEnter={() => setHoveredSuggestion(suggestion.id)}
                onMouseLeave={() => setHoveredSuggestion(null)}
                onClick={() => handleJustificationClick(suggestion)}
              >
                <Box display="flex" flexDirection="column" alignItems="center">
                  <Box
                    sx={{
                      width: 40,
                      height: 40,
                      borderRadius: '50%',
                      backgroundColor: '#FF9800',
                      display: 'flex',
                      alignItems: 'center',
                      justifyContent: 'center',
                      mb: 1,
                      color: 'white'
                    }}
                  >
                    <LightbulbIcon />
                  </Box>
                  
                  <Typography
                    variant="body2"
                    sx={{
                      fontWeight: 'bold',
                      fontSize: '0.8rem',
                      textAlign: 'center',
                      lineHeight: 1.2,
                      mb: 0.5,
                      color: '#E65100'
                    }}
                  >
                    {suggestion.titulo}
                  </Typography>
                  
                  <Box display="flex" gap={0.5} justifyContent="center">
                    <Box
                      sx={{
                        width: 8,
                        height: 8,
                        borderRadius: '50%',
                        backgroundColor: getConfidenceColor(suggestion.confianza)
                      }}
                    />
                    <Typography
                      variant="caption"
                      sx={{
                        fontSize: '0.7rem',
                        color: 'text.secondary'
                      }}
                    >
                      {suggestion.norma}
                    </Typography>
                  </Box>
                </Box>
              </Paper>
            </Tooltip>
          </Zoom>
        ))}
      </Box>
    </Box>
  );
};

export default JustificationSuggestions;


