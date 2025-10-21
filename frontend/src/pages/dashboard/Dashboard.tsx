import React, { useState, useEffect } from "react";
import {
  Box,
  Card,
  CardContent,
  Typography,
  Paper,
} from "@mui/material";
import {
  Security,
  People,
  Assessment,
  TrendingUp,
  ArrowUpward,
  ArrowDownward,
  Remove,
  InfoOutlined,
} from "@mui/icons-material";
import { Tooltip } from "@mui/material";
import { dashboardService } from "../../services/backend";
import { evaluacionRiesgosService } from "../../services/evaluacionRiesgos";
import type { DashboardHistory } from "../../services/backend";

const Dashboard: React.FC = () => {
  const [stats, setStats] = useState([
    { title: "Total Activos", value: "0", icon: <Security />, color: "#1976d2" },
    { title: "Usuarios Activos", value: "0", icon: <People />, color: "#388e3c" },
    { title: "Riesgos Identificados", value: "0", icon: <Assessment />, color: "#f57c00" },
    { title: "Tendencia", value: "0%", icon: <TrendingUp />, color: "#7b1fa2" },
  ]);
  const [assetsByType, setAssetsByType] = useState<{[key: string]: number}>({});
  const [risksByLevel, setRisksByLevel] = useState<{[key: string]: number}>({});
  const [loading, setLoading] = useState(true);
  const [history, setHistory] = useState<DashboardHistory | null>(null);
  const [sisInfoBy, setSisInfoBy] = useState<'criticidad' | 'secretaria'>('criticidad');
  const [sisInfoBreakdown, setSisInfoBreakdown] = useState<{ [key: string]: number }>({});
  const [evaluacionStats, setEvaluacionStats] = useState({
    total_riesgos: 0,
    riesgos_evaluados: 0,
    riesgos_pendientes: 0,
    porcentaje_evaluacion: 0,
    distribucion_niveles: {} as { [key: string]: number }
  });

  useEffect(() => {
    fetchDashboardData();
  }, []);

  const fetchDashboardData = async () => {
    try {
      setLoading(true);
      
      // Fetch data from backend dashboard stats and evaluation stats
      const [dashboardStats, dashboardHistory, sisInfo, evalStats] = await Promise.all([
        dashboardService.getStats(),
        dashboardService.getHistory(),
        dashboardService.getSistemasInfoBreakdown(sisInfoBy),
        evaluacionRiesgosService.getEstadisticas()
      ]);

      // Update stats using backend-provided numbers
      const tendencia = dashboardStats.tendencia;
      const tendenciaColor = tendencia > 0 ? "#2e7d32" : tendencia < 0 ? "#c62828" : "#6b7280";
      const tendenciaIcon = tendencia > 0 ? <ArrowUpward /> : tendencia < 0 ? <ArrowDownward /> : <Remove />;

      setStats([
        { title: "Total Activos", value: String(dashboardStats.total_activos), icon: <Security />, color: "#1976d2" },
        { title: "Usuarios Activos", value: String(dashboardStats.usuarios_activos), icon: <People />, color: "#388e3c" },
        { title: "Riesgos Identificados", value: String(dashboardStats.riesgos_identificados), icon: <Assessment />, color: "#f57c00" },
        { title: "Tendencia", value: `${tendencia > 0 ? '+' : ''}${tendencia}%`, icon: tendenciaIcon, color: tendenciaColor },
      ]);

      // Use server-provided breakdowns
      setAssetsByType(dashboardStats.activos_por_tipo || {});
      
      // Usar datos de evaluación si están disponibles, sino usar estados
      if (evalStats.riesgos_evaluados > 0) {
        setRisksByLevel(evalStats.distribucion_niveles || {});
      } else {
        setRisksByLevel(dashboardStats.riesgos_por_estado || {});
      }
      
      setHistory(dashboardHistory);
      setSisInfoBreakdown(sisInfo.data || {});
      setEvaluacionStats(evalStats);
      setLoading(false);
    } catch (error) {
      console.error('Error fetching dashboard data:', error);
      setLoading(false);
    }
  };

  return (
    <Box sx={{ p: 4, maxWidth: '1400px', mx: 'auto' }}>
      <Box sx={{ mb: 4 }}>
        <Typography
          variant="h3"
          sx={{
            fontFamily: "'Poppins', sans-serif",
            fontWeight: 600,
            color: "#2F3E46",
            mb: 2,
          }}
        >
          Dashboard
        </Typography>
        <Typography
          variant="h6"
          sx={{
            fontFamily: "'Poppins', sans-serif",
            fontWeight: 400,
            color: "#52796F",
            mb: 1,
          }}
        >
          Sistema de Gestión de Riesgos
        </Typography>
        <Typography
          variant="body1"
          sx={{
            color: "#666",
            fontFamily: "'Roboto', sans-serif",
          }}
        >
          de Información
        </Typography>
      </Box>

      <Box sx={{ display: 'flex', flexWrap: 'wrap', gap: 3, mb: 4 }}>
        {stats.map((stat, index) => (
          <Box key={index} sx={{ flex: '1 1 280px', minWidth: '250px' }}>
            <Card
              sx={{
                background: `linear-gradient(135deg, ${stat.color}15 0%, ${stat.color}08 100%)`,
                border: `1px solid ${stat.color}20`,
                transition: 'all 0.3s ease-in-out',
                '&:hover': {
                  transform: 'translateY(-4px)',
                  boxShadow: `0 12px 40px ${stat.color}25`,
                },
              }}
            >
              <CardContent sx={{ p: 3 }}>
                <Box display="flex" alignItems="center">
                  <Box
                    sx={{
                      backgroundColor: stat.color,
                      color: "white",
                      borderRadius: 2,
                      p: 1.5,
                      mr: 3,
                      boxShadow: `0 4px 12px ${stat.color}40`,
                    }}
                  >
                    {stat.icon}
                  </Box>
                  <Box>
                    <Typography
                      variant="h4"
                      sx={{
                        fontFamily: "'Poppins', sans-serif",
                        fontWeight: 600,
                        color: stat.title === 'Tendencia' ? stat.color : "#2F3E46",
                        mb: 0.5,
                      }}
                    >
                      {stat.value}
                    </Typography>
                    <Typography
                      variant="body2"
                      sx={{
                        color: "#666",
                        fontFamily: "'Roboto', sans-serif",
                        fontWeight: 500,
                      }}
                    >
                      {stat.title}
                      {stat.title === 'Tendencia' && (
                        <Tooltip title="Variación porcentual de riesgos creados: último mes vs. mes anterior">
                          <InfoOutlined sx={{ fontSize: 16, color: '#6b7280', ml: 0.5, verticalAlign: 'middle' }} />
                        </Tooltip>
                      )}
                    </Typography>
                  </Box>
                </Box>
              </CardContent>
            </Card>
          </Box>
        ))}
      </Box>

      <Box sx={{ display: 'flex', flexWrap: 'wrap', gap: 3 }}>
        <Box sx={{ flex: '2 1 600px', minWidth: '400px' }}>
          <Paper
            sx={{
              p: 4,
              height: '400px',
              background: 'linear-gradient(135deg, #F6F7F8 0%, #CAD2C5 100%)',
              border: '1px solid #84A98C40',
            }}
          >
            <Typography
              variant="h5"
              sx={{
                fontFamily: "'Poppins', sans-serif",
                fontWeight: 500,
                color: "#2F3E46",
                mb: 3,
                textAlign: 'center',
              }}
            >
              Activos por Tipo
            </Typography>

            {loading ? (
              <Box sx={{ display: 'flex', justifyContent: 'center', alignItems: 'center', height: '250px' }}>
                <Typography sx={{ color: '#666' }}>Cargando datos...</Typography>
              </Box>
            ) : (
              <Box sx={{ height: '280px', overflowY: 'auto' }}>
                {Object.entries(assetsByType).length === 0 ? (
                  <Box sx={{ textAlign: 'center', py: 4 }}>
                    <Typography sx={{ color: '#666', fontFamily: "'Roboto', sans-serif" }}>
                      No hay datos de activos disponibles
                    </Typography>
                  </Box>
                ) : (
                  <Box sx={{ spaceY: 2 }}>
                    {Object.entries(assetsByType).map(([type, count], index) => {
                      const percentage = ((count / Object.values(assetsByType).reduce((a, b) => a + b, 0)) * 100).toFixed(1);
                      const colors = ['#1E3A8A', '#3B82F6', '#6B7280', '#9CA3AF', '#D1D5DB'];

                      return (
                        <Box key={type} sx={{ mb: 3 }}>
                          <Box sx={{ display: 'flex', justifyContent: 'space-between', mb: 1 }}>
                            <Typography
                              sx={{
                                fontFamily: "'Roboto', sans-serif",
                                fontWeight: 500,
                                color: '#2F3E46',
                                fontSize: '0.9rem',
                              }}
                            >
                              {type}
                            </Typography>
                            <Typography
                              sx={{
                                fontFamily: "'Roboto', sans-serif",
                                fontWeight: 600,
                                color: colors[index % colors.length],
                                fontSize: '0.9rem',
                              }}
                            >
                              {count} ({percentage}%)
                            </Typography>
                          </Box>
                          <Box
                            sx={{
                              width: '100%',
                              height: '12px',
                              backgroundColor: '#E0E0E0',
                              borderRadius: '6px',
                              overflow: 'hidden',
                            }}
                          >
                            <Box
                              sx={{
                                width: `${percentage}%`,
                                height: '100%',
                                backgroundColor: colors[index % colors.length],
                                borderRadius: '6px',
                                transition: 'width 0.5s ease-in-out',
                              }}
                            />
                          </Box>
                        </Box>
                      );
                    })}
                  </Box>
                )}
              </Box>
            )}
          </Paper>
        </Box>

        <Box sx={{ flex: '1 1 350px', minWidth: '300px' }}>
          <Paper
            sx={{
              p: 4,
              height: '400px',
              background: 'linear-gradient(135deg, #F6F7F8 0%, #84A98C15 100%)',
              border: '1px solid #84A98C30',
            }}
          >
            <Typography
              variant="h5"
              sx={{
                fontFamily: "'Poppins', sans-serif",
                fontWeight: 500,
                color: "#2F3E46",
                mb: 3,
                textAlign: 'center',
              }}
            >
              Riesgos por Estado
            </Typography>

            {loading ? (
              <Box sx={{ display: 'flex', justifyContent: 'center', alignItems: 'center', height: '250px' }}>
                <Typography sx={{ color: '#666' }}>Cargando riesgos...</Typography>
              </Box>
            ) : (
              <Box sx={{ height: '280px', overflowY: 'auto' }}>
                {Object.entries(risksByLevel).length === 0 ? (
                  <Box sx={{ textAlign: 'center', py: 4 }}>
                    <Typography sx={{ color: '#666', fontFamily: "'Roboto', sans-serif" }}>
                      Los datos de riesgos se actualizarán automáticamente desde la base de datos
                    </Typography>
                  </Box>
                ) : (
                  <Box sx={{ spaceY: 3 }}>
                    {Object.entries(risksByLevel).map(([key, count], index) => {
                      // Determinar si son niveles o estados basado en las claves
                      const isLevel = ['Alto', 'Medio', 'Bajo'].includes(key);
                      const isState = ['Identificado', 'Analizado', 'En tratamiento', 'Mitigado', 'Cerrado', 'Aceptado', 'Escalado'].includes(key);
                      
                      // Colores para niveles
                      const levelColors = {
                        'Alto': '#dc3545',
                        'Medio': '#ffc107', 
                        'Bajo': '#28a745'
                      };
                      
                      // Colores para estados
                      const stateColors = {
                        'Identificado': '#6c757d',
                        'Analizado': '#17a2b8',
                        'En tratamiento': '#fd7e14',
                        'Mitigado': '#28a745',
                        'Cerrado': '#6f42c1',
                        'Aceptado': '#20c997',
                        'Escalado': '#dc3545'
                      };
                      
                      const color = levelColors[key] || stateColors[key] || '#6c757d';
                      const label = isLevel ? `Nivel ${key}` : isState ? `Estado: ${key}` : key;
                      
                      const totalRisks = Object.values(risksByLevel).reduce((a, b) => a + b, 0);
                      const percentage = totalRisks > 0 ? (count / totalRisks) * 100 : 0;
                      
                      return (
                        <Box key={key} sx={{ mb: 3 }}>
                          <Box sx={{ display: 'flex', justifyContent: 'space-between', mb: 1 }}>
                            <Typography
                              sx={{
                                fontFamily: "'Roboto', sans-serif",
                                fontWeight: 500,
                                color: '#2F3E46',
                                fontSize: '0.9rem',
                              }}
                            >
                              {label}
                            </Typography>
                            <Typography
                              sx={{
                                fontFamily: "'Roboto', sans-serif",
                                fontWeight: 600,
                                color: color,
                                fontSize: '0.9rem',
                              }}
                            >
                              {count}
                            </Typography>
                          </Box>
                          <Box
                            sx={{
                              width: '100%',
                              height: '12px',
                              backgroundColor: '#E0E0E0',
                              borderRadius: '6px',
                              overflow: 'hidden',
                            }}
                          >
                            <Box
                              sx={{
                                width: `${percentage}%`,
                                height: '100%',
                                backgroundColor: color,
                                borderRadius: '6px',
                                transition: 'width 0.5s ease-in-out',
                              }}
                            />
                          </Box>
                        </Box>
                      );
                    })}
                  </Box>
                )}

                {/* Sección de progreso de evaluación */}
                {evaluacionStats.total_riesgos > 0 && (
                  <Box sx={{ mt: 3, pt: 3, borderTop: '1px solid #E0E0E0' }}>
                    <Typography
                      sx={{
                        fontFamily: "'Roboto', sans-serif",
                        fontSize: '0.9rem',
                        fontWeight: 600,
                        color: '#2F3E46',
                        mb: 2
                      }}
                    >
                      Progreso de Evaluación
                    </Typography>
                    
                    <Box sx={{ display: 'flex', alignItems: 'center', mb: 2 }}>
                      <Box sx={{ flex: 1, mr: 2 }}>
                        <Box
                          sx={{
                            width: '100%',
                            height: '8px',
                            backgroundColor: '#E0E0E0',
                            borderRadius: '4px',
                            overflow: 'hidden',
                          }}
                        >
                          <Box
                            sx={{
                              width: `${evaluacionStats.porcentaje_evaluacion}%`,
                              height: '100%',
                              backgroundColor: evaluacionStats.porcentaje_evaluacion > 80 ? '#28a745' : 
                                             evaluacionStats.porcentaje_evaluacion > 50 ? '#ffc107' : '#dc3545',
                              borderRadius: '4px',
                              transition: 'width 0.5s ease-in-out',
                            }}
                          />
                        </Box>
                      </Box>
                      <Typography
                        sx={{
                          fontFamily: "'Roboto', sans-serif",
                          fontSize: '0.8rem',
                          fontWeight: 600,
                          color: '#2F3E46',
                          minWidth: '60px'
                        }}
                      >
                        {evaluacionStats.porcentaje_evaluacion}%
                      </Typography>
                    </Box>
                    
                    <Box sx={{ display: 'flex', justifyContent: 'space-between', fontSize: '0.8rem' }}>
                      <Typography sx={{ color: '#666', fontFamily: "'Roboto', sans-serif" }}>
                        Evaluados: {evaluacionStats.riesgos_evaluados}
                      </Typography>
                      <Typography sx={{ color: '#666', fontFamily: "'Roboto', sans-serif" }}>
                        Pendientes: {evaluacionStats.riesgos_pendientes}
                      </Typography>
                    </Box>
                  </Box>
                )}

                <Box sx={{ mt: 3, pt: 3, borderTop: '1px solid #E0E0E0' }}>
                  <Typography
                    sx={{
                      fontFamily: "'Roboto', sans-serif",
                      fontSize: '0.85rem',
                      color: '#666',
                      textAlign: 'center',
                    }}
                  >
                    Los datos de riesgos se actualizarán automáticamente desde la base de datos
                  </Typography>
                </Box>
              </Box>
            )}
          </Paper>
        </Box>
      </Box>

      {/* Resumen histórico simple */}
      {history && (
        <Box sx={{ mt: 4, display: 'flex', gap: 3, flexWrap: 'wrap' }}>
          <Paper sx={{ p: 3, flex: '1 1 600px', minWidth: '320px' }}>
            <Typography variant="h6" sx={{ fontFamily: "'Poppins', sans-serif", mb: 2, color: '#2F3E46' }}>
              Histórico de Activos (12 meses)
            </Typography>
            <Box sx={{ display: 'flex', flexWrap: 'wrap', gap: 1 }}>
              {history.activos.monthly.map((p) => (
                <Box key={p.month} sx={{ p: 1, border: '1px solid #E5E7EB', borderRadius: 1, minWidth: 90 }}>
                  <Typography sx={{ fontSize: '0.75rem', color: '#6b7280' }}>{p.month}</Typography>
                  <Typography sx={{ fontWeight: 600 }}>{p.count}</Typography>
                  <Typography sx={{ fontSize: '0.75rem', color: '#6b7280' }}>Acum: {p.cumulative}</Typography>
                </Box>
              ))}
            </Box>
            <Box sx={{ mt: 2 }}>
              <Typography sx={{ color: '#6b7280' }}>Total acumulado: {history.activos.total}</Typography>
            </Box>
          </Paper>

          <Paper sx={{ p: 3, flex: '1 1 600px', minWidth: '320px' }}>
            <Typography variant="h6" sx={{ fontFamily: "'Poppins', sans-serif", mb: 2, color: '#2F3E46' }}>
              Histórico de Riesgos (12 meses)
            </Typography>
            <Box sx={{ display: 'flex', flexWrap: 'wrap', gap: 1 }}>
              {history.riesgos.monthly.map((p) => (
                <Box key={p.month} sx={{ p: 1, border: '1px solid #E5E7EB', borderRadius: 1, minWidth: 90 }}>
                  <Typography sx={{ fontSize: '0.75rem', color: '#6b7280' }}>{p.month}</Typography>
                  <Typography sx={{ fontWeight: 600 }}>{p.count}</Typography>
                  <Typography sx={{ fontSize: '0.75rem', color: '#6b7280' }}>Acum: {p.cumulative}</Typography>
                </Box>
              ))}
            </Box>
            <Box sx={{ mt: 2 }}>
              <Typography sx={{ color: '#6b7280' }}>Total acumulado: {history.riesgos.total}</Typography>
            </Box>
          </Paper>
        </Box>
      )}

      {/* Sistemas de Información Breakdown */}
      <Box sx={{ mt: 4 }}>
        <Paper sx={{ p: 3 }}>
          <Box sx={{ display: 'flex', justifyContent: 'space-between', alignItems: 'center', mb: 2 }}>
            <Typography variant="h6" sx={{ fontFamily: "'Poppins', sans-serif", color: '#2F3E46' }}>
              Sistemas de Información por {sisInfoBy === 'criticidad' ? 'Nivel de Criticidad' : 'Secretaría'}
            </Typography>
            <Box>
              <select
                value={sisInfoBy}
                onChange={async (e) => {
                  const val = e.target.value as 'criticidad' | 'secretaria';
                  setSisInfoBy(val);
                  try {
                    const res = await dashboardService.getSistemasInfoBreakdown(val);
                    setSisInfoBreakdown(res.data || {});
                  } catch {}
                }}
                style={{ padding: '8px 12px', borderRadius: 8, border: '1px solid #E5E7EB' }}
              >
                <option value="criticidad">Por criticidad</option>
                <option value="secretaria">Por secretaría</option>
              </select>
            </Box>
          </Box>
          {Object.keys(sisInfoBreakdown).length === 0 ? (
            <Typography sx={{ color: '#6b7280' }}>No hay datos para mostrar.</Typography>
          ) : (
            <Box sx={{ display: 'flex', flexWrap: 'wrap', gap: 2 }}>
              {Object.entries(sisInfoBreakdown).map(([key, count]) => (
                <Box key={key} sx={{ p: 2, border: '1px solid #E5E7EB', borderRadius: 2, minWidth: 200 }}>
                  <Typography sx={{ fontWeight: 600 }}>{key}</Typography>
                  <Typography sx={{ color: '#6b7280' }}>{count} sistemas</Typography>
                </Box>
              ))}
            </Box>
          )}
        </Paper>
      </Box>
    </Box>
  );
};

export default Dashboard;
