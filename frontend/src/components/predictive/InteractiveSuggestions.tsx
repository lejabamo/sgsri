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
  Grid,
  Paper,
  Tooltip,
  Fade,
  Zoom
} from '@mui/material';
import {
  Security as SecurityIcon,
  BugReport as BugReportIcon,
  Shield as ShieldIcon,
  TouchApp as TouchAppIcon,
  CheckCircle as CheckCircleIcon
} from '@mui/icons-material';
import { apiRequest } from '../../services/api';

interface Suggestion {
  id: string;
  nombre: string;
  descripcion: string;
  categoria: string;
  confianza: number;
}

interface InteractiveSuggestionsProps {
  assetType: string;
  context?: string;
  onSuggestionSelect?: (suggestion: { type: string; data: any }) => void;
  selectedThreat?: string;
  selectedVulnerability?: string;
}

const InteractiveSuggestions: React.FC<InteractiveSuggestionsProps> = ({
  assetType,
  context = '',
  onSuggestionSelect,
  selectedThreat,
  selectedVulnerability
}) => {
  const [suggestions, setSuggestions] = useState<{
    amenazas: Suggestion[];
    vulnerabilidades: Suggestion[];
    controles: Suggestion[];
  }>({
    amenazas: [],
    vulnerabilidades: [],
    controles: []
  });
  
  const [isLoading, setIsLoading] = useState(false);
  const [error, setError] = useState<string | null>(null);
  const [hoveredSuggestion, setHoveredSuggestion] = useState<string | null>(null);

  const loadSuggestions = async () => {
    setIsLoading(true);
    setError(null);
    
    try {
      const response = await apiRequest('/predictive/suggestions/complete', {
        method: 'POST',
        headers: {
          'Content-Type': 'application/json',
        },
        body: JSON.stringify({
          asset_type: assetType,
          context: context
        })
      });

      if (response.success) {
        setSuggestions(response.data);
      } else {
        setError('Error al cargar sugerencias');
      }
    } catch (err) {
      console.error('Error loading suggestions:', err);
      setError('Error al cargar sugerencias');
    } finally {
      setIsLoading(false);
    }
  };

  const handleSuggestionClick = (type: string, suggestion: Suggestion) => {
    if (onSuggestionSelect) {
      onSuggestionSelect({ type, data: suggestion });
    }
  };

  const getConfidenceColor = (confidence: number) => {
    if (confidence >= 0.8) return '#4CAF50';
    if (confidence >= 0.6) return '#FF9800';
    return '#F44336';
  };

  const getCategoryIcon = (type: string) => {
    switch (type) {
      case 'amenazas':
        return <SecurityIcon />;
      case 'vulnerabilidades':
        return <BugReportIcon />;
      case 'controles':
        return <ShieldIcon />;
      default:
        return <TouchAppIcon />;
    }
  };

  const getCategoryColor = (type: string) => {
    switch (type) {
      case 'amenazas':
        return '#E3F2FD';
      case 'vulnerabilidades':
        return '#FCE4EC';
      case 'controles':
        return '#E8F5E8';
      default:
        return '#F5F5F5';
    }
  };

  useEffect(() => {
    if (assetType) {
      loadSuggestions();
    }
  }, [assetType]);

  if (isLoading) {
    return (
      <Box display="flex" justifyContent="center" alignItems="center" p={4}>
        <CircularProgress size={24} />
        <Typography variant="body2" sx={{ ml: 2 }}>
          Cargando sugerencias...
        </Typography>
      </Box>
    );
  }

  if (error) {
    return (
      <Alert severity="error" action={
        <Button color="inherit" size="small" onClick={loadSuggestions}>
          Reintentar
        </Button>
      }>
        {error}
      </Alert>
    );
  }

  const renderSuggestionBubbles = (type: string, items: Suggestion[]) => {
    return (
      <Box>
        <Box display="flex" alignItems="center" mb={2}>
          {getCategoryIcon(type)}
          <Typography variant="h6" sx={{ ml: 1, color: '#1E3A8A' }}>
            {type === 'amenazas' ? 'Amenazas' : 
             type === 'vulnerabilidades' ? 'Vulnerabilidades' : 'Controles'}
          </Typography>
        </Box>
        
        <Box display="flex" flexWrap="wrap" gap={1.5}>
          {items.map((item, index) => (
            <Zoom
              key={`interactive-${type}-${item.id}-${index}`}
              in={true}
              timeout={300 + index * 100}
              style={{ transitionDelay: `${index * 100}ms` }}
            >
              <Tooltip
                title={
                  <Box>
                    <Typography variant="subtitle2" sx={{ fontWeight: 'bold' }}>
                      {item.nombre}
                    </Typography>
                    <Typography variant="body2" sx={{ mt: 1 }}>
                      {item.descripcion}
                    </Typography>
                    <Box display="flex" gap={1} mt={1}>
                      <Chip
                        label={`${(item.confianza * 100).toFixed(0)}%`}
                        size="small"
                        sx={{ 
                          backgroundColor: getConfidenceColor(item.confianza),
                          color: 'white',
                          fontSize: '0.7rem'
                        }}
                      />
                      <Chip
                        label={item.categoria}
                        size="small"
                        variant="outlined"
                        sx={{ fontSize: '0.7rem' }}
                      />
                    </Box>
                  </Box>
                }
                arrow
                placement="top"
              >
                <Paper
                  elevation={hoveredSuggestion === item.id ? 8 : 2}
                  sx={{
                    p: 2,
                    cursor: 'pointer',
                    backgroundColor: getCategoryColor(type),
                    border: '2px solid transparent',
                    transition: 'all 0.3s ease',
                    transform: hoveredSuggestion === item.id ? 'scale(1.05)' : 'scale(1)',
                    '&:hover': {
                      borderColor: '#1E3A8A',
                      backgroundColor: getCategoryColor(type),
                    },
                    minWidth: '120px',
                    textAlign: 'center',
                    position: 'relative',
                    overflow: 'hidden'
                  }}
                  onMouseEnter={() => setHoveredSuggestion(item.id)}
                  onMouseLeave={() => setHoveredSuggestion(null)}
                  onClick={() => handleSuggestionClick(type, item)}
                >
                  <Box display="flex" flexDirection="column" alignItems="center">
                    <Box
                      sx={{
                        width: 40,
                        height: 40,
                        borderRadius: '50%',
                        backgroundColor: '#1E3A8A',
                        display: 'flex',
                        alignItems: 'center',
                        justifyContent: 'center',
                        mb: 1,
                        color: 'white'
                      }}
                    >
                      {getCategoryIcon(type)}
                    </Box>
                    
                    <Typography
                      variant="body2"
                      sx={{
                        fontWeight: 'bold',
                        fontSize: '0.8rem',
                        textAlign: 'center',
                        lineHeight: 1.2,
                        mb: 0.5
                      }}
                    >
                      {item.nombre}
                    </Typography>
                    
                    <Box display="flex" gap={0.5} justifyContent="center">
                      <Box
                        sx={{
                          width: 8,
                          height: 8,
                          borderRadius: '50%',
                          backgroundColor: getConfidenceColor(item.confianza)
                        }}
                      />
                      <Typography
                        variant="caption"
                        sx={{
                          fontSize: '0.7rem',
                          color: 'text.secondary'
                        }}
                      >
                        {item.categoria}
                      </Typography>
                    </Box>
                  </Box>
                  
                  {/* Indicador de selección */}
                  {(type === 'amenazas' && selectedThreat === item.id) ||
                   (type === 'vulnerabilidades' && selectedVulnerability === item.id) ? (
                    <Box
                      sx={{
                        position: 'absolute',
                        top: 4,
                        right: 4,
                        backgroundColor: '#4CAF50',
                        borderRadius: '50%',
                        width: 20,
                        height: 20,
                        display: 'flex',
                        alignItems: 'center',
                        justifyContent: 'center'
                      }}
                    >
                      <CheckCircleIcon sx={{ fontSize: 14, color: 'white' }} />
                    </Box>
                  ) : null}
                </Paper>
              </Tooltip>
            </Zoom>
          ))}
        </Box>
      </Box>
    );
  };

  return (
    <Card sx={{ height: '100%' }}>
      <CardContent sx={{ height: '100%', display: 'flex', flexDirection: 'column' }}>
        <Typography variant="h6" sx={{ color: '#1E3A8A', mb: 3, textAlign: 'center' }}>
          🎯 Sugerencias Interactivas
        </Typography>
        
        <Box sx={{ flex: 1, overflow: 'auto' }}>
          <Grid container spacing={3}>
            <Grid item xs={12}>
              {renderSuggestionBubbles('amenazas', suggestions.amenazas)}
            </Grid>
            
            <Grid item xs={12}>
              {renderSuggestionBubbles('vulnerabilidades', suggestions.vulnerabilidades)}
            </Grid>
            
            <Grid item xs={12}>
              {renderSuggestionBubbles('controles', suggestions.controles)}
            </Grid>
          </Grid>
        </Box>
        
        <Box sx={{ mt: 2, textAlign: 'center' }}>
          <Typography variant="caption" color="text.secondary">
            💡 Haz clic en cualquier globo para auto-completar el formulario
          </Typography>
        </Box>
      </CardContent>
    </Card>
  );
};

export default InteractiveSuggestions;





