import React, { useState, useEffect } from 'react';
import {
  Box,
  Card,
  CardContent,
  Typography,
  Slider,
  FormControl,
  InputLabel,
  Select,
  MenuItem,
  TextField,
  Chip,
  Grid,
  Paper,
  Tooltip,
  IconButton,
  Alert,
  Fade,
  Stack,
} from '@mui/material';
import {
  Info as InfoIcon,
  TrendingUp as TrendingUpIcon,
  Warning as WarningIcon,
  CheckCircle as CheckCircleIcon,
  Help as HelpIcon,
} from '@mui/icons-material';
import '../../styles/design-system.css';

interface InherentEvaluationStepProps {
  data: {
    probabilidad: string;
    impacto: string;
    nivelRiesgo: string;
    justificacion: string;
  };
  onUpdate: (data: {
    probabilidad: string;
    impacto: string;
    nivelRiesgo: string;
    justificacion: string;
  }) => void;
}

interface LevelDefinition {
  value: string;
  label: string;
  description: string;
  color: string;
  icon: React.ReactNode;
  examples: string[];
}

const InherentEvaluationStep: React.FC<InherentEvaluationStepProps> = ({
  data,
  onUpdate
}) => {
  const [currentStep, setCurrentStep] = useState<'probability' | 'impact' | 'justification'>('probability');
  const [probabilityValue, setProbabilityValue] = useState(0);
  const [impactValue, setImpactValue] = useState(0);
  const [justification, setJustification] = useState(data.justificacion || '');

  // Definiciones de niveles con contexto
  const probabilityLevels: LevelDefinition[] = [
    {
      value: 'Frecuente',
      label: 'Frecuente',
      description: 'Ocurre varias veces al año',
      color: '#EF4444',
      icon: <WarningIcon />,
      examples: ['Fallas diarias de sistema', 'Ataques de phishing semanales', 'Errores de usuario frecuentes']
    },
    {
      value: 'Probable',
      label: 'Probable',
      description: 'Ocurre al menos una vez al año',
      color: '#F59E0B',
      icon: <TrendingUpIcon />,
      examples: ['Fallas mensuales', 'Incidentes de seguridad trimestrales', 'Errores de configuración']
    },
    {
      value: 'Ocasional',
      label: 'Ocasional',
      description: 'Ocurre cada 2-3 años',
      color: '#F59E0B',
      icon: <InfoIcon />,
      examples: ['Fallas de hardware', 'Ataques dirigidos', 'Errores de software críticos']
    },
    {
      value: 'Posible',
      label: 'Posible',
      description: 'Ocurre cada 5-10 años',
      color: '#10B981',
      icon: <CheckCircleIcon />,
      examples: ['Desastres naturales', 'Ataques avanzados', 'Fallas de infraestructura']
    },
    {
      value: 'Improbable',
      label: 'Improbable',
      description: 'Muy raro, menos de una vez cada 10 años',
      color: '#10B981',
      icon: <CheckCircleIcon />,
      examples: ['Ataques de estado', 'Desastres catastróficos', 'Fallas múltiples simultáneas']
    }
  ];

  const impactLevels: LevelDefinition[] = [
    {
      value: 'Insignificante',
      label: 'Insignificante',
      description: 'Sin impacto significativo en la operación',
      color: '#10B981',
      icon: <CheckCircleIcon />,
      examples: ['Interrupción menor', 'Pérdida de datos no críticos', 'Retraso mínimo']
    },
    {
      value: 'Menor',
      label: 'Menor',
      description: 'Impacto limitado, recuperación rápida',
      color: '#10B981',
      icon: <CheckCircleIcon />,
      examples: ['Interrupción de horas', 'Pérdida de datos recuperables', 'Retraso de días']
    },
    {
      value: 'Moderado',
      label: 'Moderado',
      description: 'Impacto significativo pero manejable',
      color: '#F59E0B',
      icon: <WarningIcon />,
      examples: ['Interrupción de días', 'Pérdida de datos parcial', 'Retraso de semanas']
    },
    {
      value: 'Mayor',
      label: 'Mayor',
      description: 'Impacto severo en operaciones críticas',
      color: '#EF4444',
      icon: <WarningIcon />,
      examples: ['Interrupción de semanas', 'Pérdida de datos importantes', 'Retraso de meses']
    },
    {
      value: 'Catastrófico',
      label: 'Catastrófico',
      description: 'Pérdida total o impacto crítico',
      color: '#EF4444',
      icon: <WarningIcon />,
      examples: ['Pérdida total del activo', 'Interrupción permanente', 'Impacto legal severo']
    }
  ];

  // Función para calcular el nivel de riesgo
  const calculateRiskLevel = (prob: string, imp: string): string => {
    const probIndex = probabilityLevels.findIndex(p => p.value === prob);
    const impIndex = impactLevels.findIndex(i => i.value === imp);
    
    if (probIndex === -1 || impIndex === -1) return 'LOW';
    
    // Matriz de riesgo (probabilidad x impacto)
    // Orden: Insignificante, Menor, Moderado, Mayor, Catastrófico
    const riskMatrix = [
      ['MEDIUM', 'HIGH', 'HIGH', 'HIGH', 'HIGH'],      // Frecuente
      ['MEDIUM', 'MEDIUM', 'HIGH', 'HIGH', 'HIGH'],    // Probable
      ['LOW', 'MEDIUM', 'MEDIUM', 'HIGH', 'HIGH'],     // Ocasional
      ['LOW', 'LOW', 'MEDIUM', 'MEDIUM', 'HIGH'],      // Posible
      ['LOW', 'LOW', 'LOW', 'MEDIUM', 'MEDIUM']        // Improbable
    ];
    
    return riskMatrix[probIndex][impIndex];
  };

  // Función para obtener el color del nivel de riesgo
  const getRiskColor = (level: string): string => {
    switch (level) {
      case 'LOW': return '#10B981';
      case 'MEDIUM': return '#F59E0B';
      case 'HIGH': return '#EF4444';
      default: return '#6B7280';
    }
  };

  // Función para obtener el texto del nivel de riesgo
  const getRiskText = (level: string): string => {
    switch (level) {
      case 'LOW': return 'BAJO';
      case 'MEDIUM': return 'MEDIO';
      case 'HIGH': return 'ALTO';
      default: return 'NO DEFINIDO';
    }
  };

  // Efectos para sincronizar con datos externos
  useEffect(() => {
    const probIndex = probabilityLevels.findIndex(p => p.value === data.probabilidad);
    const impIndex = impactLevels.findIndex(i => i.value === data.impacto);
    setProbabilityValue(probIndex >= 0 ? probIndex : 0);
    setImpactValue(impIndex >= 0 ? impIndex : 0);
    setJustification(data.justificacion || '');
  }, [data]);

  // Actualizar datos cuando cambian los valores (solo probabilidad e impacto, no justificación)
  useEffect(() => {
    if (probabilityValue >= 0 && impactValue >= 0) {
      const selectedProb = probabilityLevels[probabilityValue];
      const selectedImp = impactLevels[impactValue];
      const riskLevel = calculateRiskLevel(selectedProb.value, selectedImp.value);
      
      onUpdate({
        probabilidad: selectedProb.value,
        impacto: selectedImp.value,
        nivelRiesgo: riskLevel,
        justificacion: justification
      });
    }
    // eslint-disable-next-line react-hooks/exhaustive-deps
  }, [probabilityValue, impactValue]);

  const handleProbabilityChange = (event: Event, newValue: number | number[]) => {
    setProbabilityValue(newValue as number);
    setCurrentStep('impact');
  };

  const handleImpactChange = (event: Event, newValue: number | number[]) => {
    setImpactValue(newValue as number);
    setCurrentStep('justification');
  };

  const handleJustificationChange = (event: React.ChangeEvent<HTMLInputElement>) => {
    const newValue = event.target.value;
    setJustification(newValue);
    // Actualizar inmediatamente sin esperar al useEffect para evitar bucles
    if (probabilityValue >= 0 && impactValue >= 0) {
      const selectedProb = probabilityLevels[probabilityValue];
      const selectedImp = impactLevels[impactValue];
      const riskLevel = calculateRiskLevel(selectedProb.value, selectedImp.value);
      
      onUpdate({
        probabilidad: selectedProb.value,
        impacto: selectedImp.value,
        nivelRiesgo: riskLevel,
        justificacion: newValue
      });
    }
  };

  const selectedProbability = probabilityLevels[probabilityValue];
  const selectedImpact = impactLevels[impactValue];
  const currentRiskLevel = calculateRiskLevel(selectedProbability?.value || '', selectedImpact?.value || '');

  return (
    <Box>
      {/* Header con progreso */}
      <Box sx={{ mb: 4 }}>
        <Typography variant="h6" className="font-poppins" sx={{ color: '#1E3A8A', mb: 2 }}>
          Evaluación Inherente del Riesgo
        </Typography>
        
        {/* Indicador de pasos */}
        <Box sx={{ display: 'flex', alignItems: 'center', gap: 2, mb: 3 }}>
          <Chip
            label="1. Probabilidad"
            color={currentStep === 'probability' ? 'primary' : 'default'}
            variant={currentStep === 'probability' ? 'filled' : 'outlined'}
            onClick={() => setCurrentStep('probability')}
            sx={{ cursor: 'pointer' }}
          />
          <Chip
            label="2. Impacto"
            color={currentStep === 'impact' ? 'primary' : 'default'}
            variant={currentStep === 'impact' ? 'filled' : 'outlined'}
            onClick={() => setCurrentStep('impact')}
            sx={{ cursor: 'pointer' }}
          />
          <Chip
            label="3. Justificación"
            color={currentStep === 'justification' ? 'primary' : 'default'}
            variant={currentStep === 'justification' ? 'filled' : 'outlined'}
            onClick={() => setCurrentStep('justification')}
            sx={{ cursor: 'pointer' }}
          />
        </Box>
      </Box>

      <Grid container spacing={3}>
        {/* Panel Principal - Evaluación Paso a Paso */}
        <Grid item xs={12} md={8}>
          <Card sx={{ borderRadius: '16px', boxShadow: '0 4px 20px rgba(0,0,0,0.1)' }}>
            <CardContent sx={{ p: 4 }}>
              {/* Paso 1: Probabilidad */}
              <Fade in={currentStep === 'probability'}>
                <Box>
                  <Typography variant="h6" className="font-poppins" sx={{ color: '#1E3A8A', mb: 3 }}>
                    Paso 1: ¿Con qué frecuencia puede ocurrir este riesgo?
                  </Typography>
                  
                  <Box sx={{ mb: 4 }}>
                    <Slider
                      value={probabilityValue}
                      onChange={handleProbabilityChange}
                      min={0}
                      max={probabilityLevels.length - 1}
                      step={1}
                      marks={probabilityLevels.map((_, index) => ({
                        value: index,
                        label: probabilityLevels[index].label
                      }))}
                      sx={{
                        '& .MuiSlider-thumb': {
                          width: 24,
                          height: 24,
                          backgroundColor: '#1E3A8A',
                        },
                        '& .MuiSlider-track': {
                          backgroundColor: '#1E3A8A',
                        },
                        '& .MuiSlider-rail': {
                          backgroundColor: '#E5E7EB',
                        },
                      }}
                    />
                  </Box>

                  {selectedProbability && (
                    <Alert 
                      severity="info" 
                      sx={{ 
                        mb: 3, 
                        borderRadius: '12px',
                        backgroundColor: '#F0F9FF',
                        border: `2px solid ${selectedProbability.color}20`
                      }}
                    >
                      <Box sx={{ display: 'flex', alignItems: 'center', gap: 2 }}>
                        <Box sx={{ color: selectedProbability.color }}>
                          {selectedProbability.icon}
                        </Box>
                        <Box>
                          <Typography variant="subtitle1" className="font-poppins" sx={{ fontWeight: 600 }}>
                            {selectedProbability.label}
                          </Typography>
                          <Typography variant="body2" className="font-roboto">
                            {selectedProbability.description}
                          </Typography>
                          <Typography variant="caption" className="font-roboto" sx={{ color: '#6B7280', mt: 1, display: 'block' }}>
                            Ejemplos: {selectedProbability.examples.join(', ')}
                          </Typography>
                        </Box>
                      </Box>
                    </Alert>
                  )}
                </Box>
              </Fade>

              {/* Paso 2: Impacto */}
              <Fade in={currentStep === 'impact'}>
                <Box>
                  <Typography variant="h6" className="font-poppins" sx={{ color: '#1E3A8A', mb: 3 }}>
                    Paso 2: ¿Cuál sería el impacto si ocurriera?
                  </Typography>
                  
                  <Box sx={{ mb: 4 }}>
                    <Slider
                      value={impactValue}
                      onChange={handleImpactChange}
                      min={0}
                      max={impactLevels.length - 1}
                      step={1}
                      marks={impactLevels.map((_, index) => ({
                        value: index,
                        label: impactLevels[index].label
                      }))}
                      sx={{
                        '& .MuiSlider-thumb': {
                          width: 24,
                          height: 24,
                          backgroundColor: '#1E3A8A',
                        },
                        '& .MuiSlider-track': {
                          backgroundColor: '#1E3A8A',
                        },
                        '& .MuiSlider-rail': {
                          backgroundColor: '#E5E7EB',
                        },
                      }}
                    />
                  </Box>

                  {selectedImpact && (
                    <Alert 
                      severity="info" 
                      sx={{ 
                        mb: 3, 
                        borderRadius: '12px',
                        backgroundColor: '#F0F9FF',
                        border: `2px solid ${selectedImpact.color}20`
                      }}
                    >
                      <Box sx={{ display: 'flex', alignItems: 'center', gap: 2 }}>
                        <Box sx={{ color: selectedImpact.color }}>
                          {selectedImpact.icon}
                        </Box>
                        <Box>
                          <Typography variant="subtitle1" className="font-poppins" sx={{ fontWeight: 600 }}>
                            {selectedImpact.label}
                          </Typography>
                          <Typography variant="body2" className="font-roboto">
                            {selectedImpact.description}
                          </Typography>
                          <Typography variant="caption" className="font-roboto" sx={{ color: '#6B7280', mt: 1, display: 'block' }}>
                            Ejemplos: {selectedImpact.examples.join(', ')}
                          </Typography>
                        </Box>
                      </Box>
                    </Alert>
                  )}
                </Box>
              </Fade>

              {/* Paso 3: Justificación */}
              <Fade in={currentStep === 'justification'}>
                <Box>
                  <Typography variant="h6" className="font-poppins" sx={{ color: '#1E3A8A', mb: 3 }}>
                    Paso 3: Justifica tu evaluación
                  </Typography>
                  
                  <TextField
                    fullWidth
                    multiline
                    rows={4}
                    value={justification}
                    onChange={handleJustificationChange}
                    placeholder="Explica por qué seleccionaste estos niveles de probabilidad e impacto. Incluye evidencia, datos históricos, o análisis que respalde tu evaluación..."
                    sx={{
                      '& .MuiOutlinedInput-root': {
                        borderRadius: '12px',
                        '&:hover .MuiOutlinedInput-notchedOutline': {
                          borderColor: '#1E3A8A',
                        },
                        '&.Mui-focused .MuiOutlinedInput-notchedOutline': {
                          borderColor: '#1E3A8A',
                          borderWidth: 2,
                        },
                      },
                    }}
                  />
                  
                  <Typography variant="caption" className="font-roboto" sx={{ color: '#6B7280', mt: 1, display: 'block' }}>
                    💡 Tip: Una justificación sólida incluye evidencia específica, datos históricos, o análisis técnico que respalde la evaluación.
                  </Typography>
                </Box>
              </Fade>
            </CardContent>
          </Card>
        </Grid>

        {/* Panel Lateral - Resultado y Referencia */}
        <Grid item xs={12} md={4}>
          <Stack spacing={3}>
            {/* Resultado en Tiempo Real */}
            <Card sx={{ borderRadius: '16px', boxShadow: '0 4px 20px rgba(0,0,0,0.1)' }}>
              <CardContent sx={{ p: 3 }}>
                <Typography variant="h6" className="font-poppins" sx={{ color: '#1E3A8A', mb: 3 }}>
                  Resultado de la Evaluación
                </Typography>
                
                {selectedProbability && selectedImpact ? (
                  <Box>
                    <Box sx={{ 
                      p: 3, 
                      borderRadius: '12px', 
                      backgroundColor: `${getRiskColor(currentRiskLevel)}20`,
                      border: `2px solid ${getRiskColor(currentRiskLevel)}`,
                      textAlign: 'center',
                      mb: 3
                    }}>
                      <Typography variant="h4" className="font-poppins" sx={{ 
                        color: getRiskColor(currentRiskLevel),
                        fontWeight: 700,
                        mb: 1
                      }}>
                        {getRiskText(currentRiskLevel)}
                      </Typography>
                      <Typography variant="body2" className="font-roboto" sx={{ color: '#6B7280' }}>
                        Nivel de Riesgo Inherente
                      </Typography>
                    </Box>
                    
                    <Box sx={{ mb: 2 }}>
                      <Typography variant="subtitle2" className="font-poppins" sx={{ color: '#374151', mb: 1 }}>
                        Probabilidad: {selectedProbability.label}
                      </Typography>
                      <Typography variant="body2" className="font-roboto" sx={{ color: '#6B7280', mb: 2 }}>
                        {selectedProbability.description}
                      </Typography>
                    </Box>
                    
                    <Box>
                      <Typography variant="subtitle2" className="font-poppins" sx={{ color: '#374151', mb: 1 }}>
                        Impacto: {selectedImpact.label}
                      </Typography>
                      <Typography variant="body2" className="font-roboto" sx={{ color: '#6B7280' }}>
                        {selectedImpact.description}
                      </Typography>
                    </Box>
                  </Box>
                ) : (
                  <Box sx={{ textAlign: 'center', py: 4 }}>
                    <Typography variant="body1" className="font-roboto" sx={{ color: '#6B7280' }}>
                      Completa la evaluación para ver el resultado
                    </Typography>
                  </Box>
                )}
              </CardContent>
            </Card>

            {/* Matriz de Referencia */}
            <Card sx={{ borderRadius: '16px', boxShadow: '0 4px 20px rgba(0,0,0,0.1)' }}>
              <CardContent sx={{ p: 3 }}>
                <Typography variant="h6" className="font-poppins" sx={{ color: '#1E3A8A', mb: 3 }}>
                  Matriz de Referencia
                </Typography>
                
                <Box sx={{ fontSize: '0.75rem' }}>
                  <Box sx={{ display: 'grid', gridTemplateColumns: 'repeat(6, 1fr)', gap: 0.5, mb: 1 }}>
                    <Box></Box>
                    {impactLevels.map((level, index) => (
                      <Typography key={`impact-${level.value}-${index}`} variant="caption" className="font-roboto" sx={{ 
                        textAlign: 'center', 
                        fontWeight: 600,
                        color: '#374151'
                      }}>
                        {level.label}
                      </Typography>
                    ))}
                  </Box>
                  
                  {probabilityLevels.map((probLevel, probIndex) => (
                    <Box key={`prob-${probLevel.value}-${probIndex}`} sx={{ display: 'grid', gridTemplateColumns: 'repeat(6, 1fr)', gap: 0.5, mb: 0.5 }}>
                      <Typography variant="caption" className="font-roboto" sx={{ 
                        fontWeight: 600,
                        color: '#374151',
                        display: 'flex',
                        alignItems: 'center'
                      }}>
                        {probLevel.label}
                      </Typography>
                      {impactLevels.map((impLevel, impIndex) => {
                        const riskLevel = calculateRiskLevel(probLevel.value, impLevel.value);
                        const isSelected = selectedProbability?.value === probLevel.value && selectedImpact?.value === impLevel.value;
                        return (
                          <Box
                            key={`prob-${probLevel.value}-imp-${impLevel.value}-${probIndex}-${impIndex}`}
                            sx={{
                              width: '100%',
                              height: 20,
                              backgroundColor: getRiskColor(riskLevel),
                              borderRadius: '4px',
                              display: 'flex',
                              alignItems: 'center',
                              justifyContent: 'center',
                              border: isSelected ? '2px solid #1E3A8A' : '1px solid #E5E7EB',
                              cursor: 'pointer',
                              '&:hover': {
                                opacity: 0.8
                              }
                            }}
                            onClick={() => {
                              setProbabilityValue(probIndex);
                              setImpactValue(impIndex);
                              setCurrentStep('justification');
                            }}
                          >
                            <Typography variant="caption" sx={{ 
                              color: 'white', 
                              fontWeight: 600,
                              fontSize: '0.6rem'
                            }}>
                              {getRiskText(riskLevel).charAt(0)}
                            </Typography>
                          </Box>
                        );
                      })}
                    </Box>
                  ))}
                </Box>
                
                <Box sx={{ mt: 2, display: 'flex', gap: 2, justifyContent: 'center' }}>
                  <Box sx={{ display: 'flex', alignItems: 'center', gap: 1 }}>
                    <Box sx={{ width: 12, height: 12, backgroundColor: '#10B981', borderRadius: '2px' }}></Box>
                    <Typography variant="caption" className="font-roboto">Bajo</Typography>
                  </Box>
                  <Box sx={{ display: 'flex', alignItems: 'center', gap: 1 }}>
                    <Box sx={{ width: 12, height: 12, backgroundColor: '#F59E0B', borderRadius: '2px' }}></Box>
                    <Typography variant="caption" className="font-roboto">Medio</Typography>
                  </Box>
                  <Box sx={{ display: 'flex', alignItems: 'center', gap: 1 }}>
                    <Box sx={{ width: 12, height: 12, backgroundColor: '#EF4444', borderRadius: '2px' }}></Box>
                    <Typography variant="caption" className="font-roboto">Alto</Typography>
                  </Box>
                </Box>
              </CardContent>
            </Card>
          </Stack>
        </Grid>
      </Grid>
    </Box>
  );
};

export default InherentEvaluationStep;





