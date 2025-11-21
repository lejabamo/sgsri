import React, { useState, useEffect } from 'react';
import {
  Box,
  Card,
  CardContent,
  Typography,
  Button,
  Chip,
  List,
  ListItem,
  ListItemText,
  ListItemIcon,
  Divider,
  CircularProgress,
  Alert,
  IconButton,
  Collapse
} from '@mui/material';
import {
  Security as SecurityIcon,
  ExpandMore as ExpandMoreIcon,
  ExpandLess as ExpandLessIcon,
  Refresh as RefreshIcon,
  CheckCircle as CheckCircleIcon,
  Info as InfoIcon
} from '@mui/icons-material';

interface ISOSuggestion {
  nombre: string;
  categoria: string;
  descripcion: string;
  norma_iso: string;
  eficacia: string;
  implementacion: string;
  monitoreo: string;
}

interface ISOSuggestionsProps {
  amenaza: string;
  vulnerabilidad: string;
  onSuggestionSelect?: (suggestion: ISOSuggestion) => void;
}

const ISOSuggestions: React.FC<ISOSuggestionsProps> = ({
  amenaza,
  vulnerabilidad,
  onSuggestionSelect
}) => {
  const [suggestions, setSuggestions] = useState<ISOSuggestion[]>([]);
  const [loading, setLoading] = useState(false);
  const [error, setError] = useState<string | null>(null);
  const [expanded, setExpanded] = useState(false);

  const fetchSuggestions = async () => {
    if (!amenaza || !vulnerabilidad) return;
    
    setLoading(true);
    setError(null);
    
    try {
      // El endpoint /api/iso/control-suggestions no existe aún
      // Usar sugerencias de fallback directamente basadas en amenaza y vulnerabilidad
      const fallbackSuggestions = generateFallbackSuggestions(amenaza, vulnerabilidad);
      setSuggestions(fallbackSuggestions);
      setExpanded(true);
      
      // TODO: Cuando se implemente el endpoint, descomentar el siguiente código:
      /*
      const response = await fetch('/api/iso/control-suggestions', {
        method: 'POST',
        headers: {
          'Content-Type': 'application/json',
        },
        body: JSON.stringify({
          threat_name: amenaza,
          vulnerability_name: vulnerabilidad
        })
      });
      
      if (!response.ok) {
        throw new Error(`HTTP error! status: ${response.status}`);
      }
      
      const data = await response.json();
      
      if (data.success && data.suggestions) {
        setSuggestions(data.suggestions);
        setExpanded(true);
      } else {
        setError('No se pudieron obtener sugerencias');
      }
      */
    } catch (err) {
      console.error('Error obteniendo sugerencias ISO:', err);
      setError('Error al obtener sugerencias ISO');
      
      // Sugerencias de fallback basadas en amenaza y vulnerabilidad
      const fallbackSuggestions = generateFallbackSuggestions(amenaza, vulnerabilidad);
      setSuggestions(fallbackSuggestions);
      setExpanded(true);
    } finally {
      setLoading(false);
    }
  };

  const generateFallbackSuggestions = (amenaza: string, vulnerabilidad: string): ISOSuggestion[] => {
    const suggestions: ISOSuggestion[] = [];
    
    // Controles basados en amenaza
    if (amenaza.toLowerCase().includes('acceso') || amenaza.toLowerCase().includes('autorizado')) {
      suggestions.push({
        nombre: 'Autenticación Multifactor',
        categoria: 'Tecnológico',
        descripcion: 'Sistema de autenticación que requiere múltiples factores de verificación',
        norma_iso: 'ISO 27001 A.9.2.3',
        eficacia: 'Alta',
        implementacion: 'Implementar MFA para todos los accesos críticos usando tokens, SMS o aplicaciones autenticadoras',
        monitoreo: 'Auditar accesos fallidos y configurar alertas'
      });
      
      suggestions.push({
        nombre: 'Control de Accesos',
        categoria: 'Tecnológico',
        descripcion: 'Sistema de gestión de permisos basado en roles y responsabilidades',
        norma_iso: 'ISO 27001 A.9.1 - A.9.4',
        eficacia: 'Alta',
        implementacion: 'Implementar RBAC (Role-Based Access Control) y revisar permisos regularmente',
        monitoreo: 'Auditar accesos y revisar permisos trimestralmente'
      });
    }
    
    if (amenaza.toLowerCase().includes('malware')) {
      suggestions.push({
        nombre: 'Antivirus Empresarial',
        categoria: 'Tecnológico',
        descripcion: 'Solución de protección contra malware para endpoints y servidores',
        norma_iso: 'ISO 27001 A.12.2',
        eficacia: 'Alta',
        implementacion: 'Desplegar antivirus en todos los endpoints con actualizaciones automáticas',
        monitoreo: 'Monitorear detecciones y actualizar firmas diariamente'
      });
    }
    
    if (amenaza.toLowerCase().includes('perdida') || amenaza.toLowerCase().includes('datos')) {
      suggestions.push({
        nombre: 'Respaldos Automáticos',
        categoria: 'Tecnológico',
        descripcion: 'Sistema automatizado de respaldo de información crítica',
        norma_iso: 'ISO 27001 A.12.3',
        eficacia: 'Crítica',
        implementacion: 'Implementar respaldos automáticos con estrategia 3-2-1 (3 copias, 2 medios, 1 offsite)',
        monitoreo: 'Probar restauración mensualmente y verificar integridad'
      });
    }
    
    if (amenaza.toLowerCase().includes('interrupcion') || amenaza.toLowerCase().includes('servicio')) {
      suggestions.push({
        nombre: 'Monitoreo Continuo',
        categoria: 'Tecnológico',
        descripcion: 'Sistema de monitoreo 24/7 de infraestructura y aplicaciones',
        norma_iso: 'ISO 27001 A.12.4',
        eficacia: 'Alta',
        implementacion: 'Implementar SIEM y monitoreo de infraestructura con alertas automáticas',
        monitoreo: 'Revisar logs diariamente y configurar alertas proactivas'
      });
    }
    
    // Controles basados en vulnerabilidad
    if (vulnerabilidad.toLowerCase().includes('autenticacion')) {
      suggestions.push({
        nombre: 'Autenticación Multifactor',
        categoria: 'Tecnológico',
        descripcion: 'Sistema de autenticación que requiere múltiples factores de verificación',
        norma_iso: 'ISO 27001 A.9.2.3',
        eficacia: 'Alta',
        implementacion: 'Implementar MFA para todos los accesos críticos',
        monitoreo: 'Auditar accesos fallidos y configurar alertas'
      });
    }
    
    if (vulnerabilidad.toLowerCase().includes('software') || vulnerabilidad.toLowerCase().includes('desactualizado')) {
      suggestions.push({
        nombre: 'Gestión de Parches',
        categoria: 'Tecnológico',
        descripcion: 'Sistema automatizado de actualización de software y parches de seguridad',
        norma_iso: 'ISO 27001 A.12.6',
        eficacia: 'Alta',
        implementacion: 'Implementar programa de gestión de parches con actualizaciones automáticas',
        monitoreo: 'Monitorear vulnerabilidades conocidas y aplicar parches críticos'
      });
    }
    
    if (vulnerabilidad.toLowerCase().includes('respaldo')) {
      suggestions.push({
        nombre: 'Respaldos Automáticos',
        categoria: 'Tecnológico',
        descripcion: 'Sistema automatizado de respaldo de información crítica',
        norma_iso: 'ISO 27001 A.12.3',
        eficacia: 'Crítica',
        implementacion: 'Implementar respaldos automáticos con estrategia 3-2-1',
        monitoreo: 'Probar restauración mensualmente y verificar integridad'
      });
    }
    
    return suggestions.slice(0, 5); // Máximo 5 sugerencias
  };

  useEffect(() => {
    if (amenaza && vulnerabilidad) {
      fetchSuggestions();
    }
  }, [amenaza, vulnerabilidad]);

  const handleSuggestionSelect = (suggestion: ISOSuggestion) => {
    if (onSuggestionSelect) {
      onSuggestionSelect(suggestion);
    }
  };

  return (
    <Card sx={{ mb: 2 }}>
      <CardContent>
        <Box sx={{ display: 'flex', alignItems: 'center', justifyContent: 'space-between', mb: 2 }}>
          <Box sx={{ display: 'flex', alignItems: 'center', gap: 1 }}>
            <SecurityIcon sx={{ color: '#1E3A8A' }} />
            <Typography variant="h6" sx={{ color: '#1E3A8A', fontWeight: 600 }}>
              Controles Sugeridos ISO 27002
            </Typography>
          </Box>
          
          <Box sx={{ display: 'flex', gap: 1 }}>
            <Button
              variant="outlined"
              size="small"
              startIcon={<RefreshIcon />}
              onClick={fetchSuggestions}
              disabled={loading}
              sx={{ 
                borderColor: '#1E3A8A',
                color: '#1E3A8A',
                '&:hover': {
                  borderColor: '#1E40AF',
                  backgroundColor: '#1E3A8A10'
                }
              }}
            >
              Actualizar
            </Button>
            
            <IconButton
              onClick={() => setExpanded(!expanded)}
              sx={{ color: '#1E3A8A' }}
            >
              {expanded ? <ExpandLessIcon /> : <ExpandMoreIcon />}
            </IconButton>
          </Box>
        </Box>

        {loading && (
          <Box sx={{ display: 'flex', justifyContent: 'center', py: 2 }}>
            <CircularProgress size={24} />
          </Box>
        )}

        {error && (
          <Alert severity="warning" sx={{ mb: 2 }}>
            {error}
          </Alert>
        )}

        <Collapse in={expanded}>
          {suggestions.length === 0 && !loading ? (
            <Box sx={{ textAlign: 'center', py: 2 }}>
              <Typography variant="body2" sx={{ color: '#6B7280' }}>
                No hay controles sugeridos disponibles
              </Typography>
            </Box>
          ) : (
            <List>
              {suggestions.map((suggestion, index) => (
                <React.Fragment key={`iso-suggestion-${suggestion.id || suggestion.codigo || index}-${index}`}>
                  <ListItem
                    sx={{
                      border: '1px solid #E5E7EB',
                      borderRadius: 1,
                      mb: 1,
                      backgroundColor: '#F9FAFB',
                      '&:hover': {
                        backgroundColor: '#F3F4F6'
                      }
                    }}
                  >
                    <ListItemIcon>
                      <CheckCircleIcon sx={{ color: '#10B981' }} />
                    </ListItemIcon>
                    
                    <ListItemText
                      primary={
                        <Box component="div" sx={{ display: 'flex', alignItems: 'center', gap: 1, mb: 1 }}>
                          <Typography variant="h6" component="span" sx={{ color: '#1E3A8A', fontWeight: 600 }}>
                            {suggestion.nombre}
                          </Typography>
                          <Chip
                            label={suggestion.categoria}
                            size="small"
                            sx={{
                              backgroundColor: '#E3F2FD',
                              color: '#1976D2',
                              fontWeight: 600
                            }}
                          />
                          <Chip
                            label={suggestion.eficacia}
                            size="small"
                            sx={{
                              backgroundColor: suggestion.eficacia === 'Crítica' ? '#FEE2E2' : 
                                             suggestion.eficacia === 'Alta' ? '#FEF3C7' : '#D1FAE5',
                              color: suggestion.eficacia === 'Crítica' ? '#DC2626' : 
                                     suggestion.eficacia === 'Alta' ? '#D97706' : '#059669',
                              fontWeight: 600
                            }}
                          />
                        </Box>
                      }
                      secondary={
                        <Box component="div">
                          <Typography variant="body2" component="div" sx={{ color: '#6B7280', mb: 1 }}>
                            {suggestion.descripcion}
                          </Typography>
                          
                          <Box sx={{ display: 'flex', alignItems: 'center', gap: 1, mb: 1 }}>
                            <InfoIcon sx={{ fontSize: 16, color: '#6B7280' }} />
                            <Typography variant="caption" component="span" sx={{ color: '#6B7280' }}>
                              <strong>Norma ISO:</strong> {suggestion.norma_iso}
                            </Typography>
                          </Box>
                          
                          <Typography variant="body2" component="div" sx={{ color: '#374151', mb: 1 }}>
                            <strong>Implementación:</strong> {suggestion.implementacion}
                          </Typography>
                          
                          <Typography variant="body2" component="div" sx={{ color: '#374151' }}>
                            <strong>Monitoreo:</strong> {suggestion.monitoreo}
                          </Typography>
                        </Box>
                      }
                    />
                    
                    <Button
                      variant="contained"
                      size="small"
                      onClick={() => handleSuggestionSelect(suggestion)}
                      sx={{
                        backgroundColor: '#1E3A8A',
                        '&:hover': {
                          backgroundColor: '#1E40AF'
                        }
                      }}
                    >
                      Seleccionar
                    </Button>
                  </ListItem>
                  
                  {index < suggestions.length - 1 && <Divider />}
                </React.Fragment>
              ))}
            </List>
          )}
        </Collapse>
      </CardContent>
    </Card>
  );
};

export default ISOSuggestions;
