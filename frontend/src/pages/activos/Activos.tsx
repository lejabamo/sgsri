import React, { useState, useEffect } from 'react';
import {
  Box,
  Button,
  Paper,
  Typography,
  TextField,
  FormControl,
  InputLabel,
  Select,
  MenuItem,
  IconButton,
  Dialog,
  DialogTitle,
  DialogContent,
  DialogActions,
  Grid,
  Chip,
  Alert,
  Card,
  CardContent,
  CardHeader,
  InputAdornment,
  Stack,
  Divider,
  Tooltip,
  Autocomplete,
  Avatar,
} from '@mui/material';
import {
  Add as AddIcon,
  Edit as EditIcon,
  Delete as DeleteIcon,
  Search as SearchIcon,
  FilterList as FilterIcon,
  Security as SecurityIcon,
  TrendingUp as TrendingUpIcon,
  Assessment as AssessmentIcon,
  Clear as ClearIcon,
} from '@mui/icons-material';
import { DataGrid } from '@mui/x-data-grid';
import type { GridColDef, GridRenderCellParams } from '@mui/x-data-grid';
import { useQuery, useMutation, useQueryClient } from '@tanstack/react-query';
import { toast } from 'react-hot-toast';
import { activosService, type Activo } from '../../services/backend';
import '../../styles/design-system.css';

const Activos: React.FC = () => {
  const [searchTerm, setSearchTerm] = useState('');
  const [tipoFilter, setTipoFilter] = useState('');
  const [estadoFilter, setEstadoFilter] = useState('');
  const [criticidadFilter, setCriticidadFilter] = useState('');
  const [openDialog, setOpenDialog] = useState(false);
  const [editingActivo, setEditingActivo] = useState<Activo | null>(null);
  const [formData, setFormData] = useState<Partial<Activo>>({
    nombre: '',
    descripcion: '',
    tipo: '',
    estado: 'Activo',
    criticidad: 'Medio',
  });

  const queryClient = useQueryClient();

  // Queries
  const { data: activos = [], isLoading, error } = useQuery({
    queryKey: ['activos', tipoFilter, estadoFilter, criticidadFilter],
    queryFn: async () => {
      try {
        const { activosService } = await import('../../services/backend');
        return await activosService.getAll();
      } catch (error) {
        console.error('Error fetching activos:', error);
        return [];
      }
    },
  });

  // Stats desde backend para consistencia
  const { data: activosStats } = useQuery({
    queryKey: ['activos-stats'],
    queryFn: async () => {
      const { activosService } = await import('../../services/backend');
      return await activosService.getStats();
    }
  });

  // Obtener tipos y estados únicos de los datos reales
  const tiposActivo = [...new Set(activos.map(activo => activo.Tipo_Activo).filter(Boolean))];
  const estadosActivo = [...new Set(activos.map(activo => activo.estado_activo).filter(Boolean))];
  const criticidadesActivo = [...new Set(activos.map(activo => activo.nivel_criticidad_negocio).filter(Boolean))];

  // Mutations
  const createMutation = useMutation({
    mutationFn: async (data: any) => {
      const { activosService } = await import('../../services/backend');
      return await activosService.create(data);
    },
    onSuccess: () => {
      queryClient.invalidateQueries({ queryKey: ['activos'] });
      toast.success('Activo creado exitosamente');
      handleCloseDialog();
    },
    onError: (error: any) => {
      toast.error(`Error al crear activo: ${error.response?.data?.error || error.message}`);
    },
  });

  const updateMutation = useMutation({
    mutationFn: async ({ id, data }: { id: number; data: Partial<Activo> }) => {
      const { activosService } = await import('../../services/backend');
      return await activosService.update(id, data);
    },
    onSuccess: () => {
      queryClient.invalidateQueries({ queryKey: ['activos'] });
      toast.success('Activo actualizado exitosamente');
      handleCloseDialog();
    },
    onError: (error: any) => {
      toast.error(`Error al actualizar activo: ${error.response?.data?.error || error.message}`);
    },
  });

  const deleteMutation = useMutation({
    mutationFn: async (id: number) => {
      const { activosService } = await import('../../services/backend');
      return await activosService.delete(id);
    },
    onSuccess: () => {
      queryClient.invalidateQueries({ queryKey: ['activos'] });
      toast.success('Activo eliminado exitosamente');
    },
    onError: (error: any) => {
      toast.error(`Error al eliminar activo: ${error.response?.data?.error || error.message}`);
    },
  });

  // Filtered activos based on search term and filters
  const filteredActivos = activos.filter(activo => {
    const matchesSearch = !searchTerm || 
      (activo.Nombre || activo.Nombre_Activo || '').toLowerCase().includes(searchTerm.toLowerCase()) ||
      (activo.Descripcion && activo.Descripcion.toLowerCase().includes(searchTerm.toLowerCase()));
    
    const matchesTipo = !tipoFilter || activo.Tipo_Activo === tipoFilter;
    const matchesEstado = !estadoFilter || activo.estado_activo === estadoFilter;
    const matchesCriticidad = !criticidadFilter || activo.nivel_criticidad_negocio === criticidadFilter;
    
    return matchesSearch && matchesTipo && matchesEstado && matchesCriticidad;
  });

  const handleOpenDialog = (activo?: Activo) => {
    if (activo) {
      setEditingActivo(activo);
      setFormData({
        nombre: activo.nombre,
        descripcion: activo.descripcion || '',
        tipo: activo.tipo,
        estado: activo.estado,
        criticidad: activo.criticidad,
        propietario: activo.propietario || '',
        ubicacion: activo.ubicacion || '',
      });
    } else {
      setEditingActivo(null);
      setFormData({
        nombre: '',
        descripcion: '',
        tipo: '',
        estado: 'Activo',
        criticidad: 'Medio',
        propietario: '',
        ubicacion: '',
      });
    }
    setOpenDialog(true);
  };

  const handleCloseDialog = () => {
    setOpenDialog(false);
    setEditingActivo(null);
  };

  const handleSubmit = (e: React.FormEvent) => {
    e.preventDefault();
    if (editingActivo) {
      updateMutation.mutate({ id: editingActivo.ID_Activo, data: formData });
    } else {
      createMutation.mutate(formData);
    }
  };

  const handleDelete = (id: number) => {
    if (window.confirm('¿Está seguro de que desea eliminar este activo?')) {
      deleteMutation.mutate(id);
    }
  };

  const columns: GridColDef[] = [
    { 
      field: 'ID_Activo', 
      headerName: 'ID', 
      width: 80,
      headerAlign: 'center',
      align: 'center',
    },
    { 
      field: 'Nombre', 
      headerName: 'Nombre del Activo', 
      width: 300,
      flex: 1,
      minWidth: 250,
      renderCell: (params: GridRenderCellParams) => {
        const nombre = params.value || 'Sin nombre';
        const iniciales = nombre.split(' ').map((word: string) => word.charAt(0)).join('').substring(0, 3).toUpperCase();
        
        return (
          <Box sx={{ display: 'flex', alignItems: 'center', gap: 2 }}>
            <Avatar sx={{ 
              width: 32, 
              height: 32,
              backgroundColor: '#1E3A8A',
              color: '#FFFFFF',
              fontSize: '0.75rem',
              fontWeight: 600
            }}>
              {iniciales}
            </Avatar>
            <Typography variant="body2" className="font-roboto" sx={{ fontWeight: 500, color: '#374151' }}>
              {nombre}
            </Typography>
          </Box>
        );
      },
    },
    { 
      field: 'Tipo_Activo', 
      headerName: 'Tipo', 
      width: 140,
      headerAlign: 'center',
      align: 'center',
    },
    { 
      field: 'estado_activo', 
      headerName: 'Estado', 
      width: 140,
      headerAlign: 'center',
      align: 'center',
      renderCell: (params: GridRenderCellParams) => (
        <Box>
          <Chip
            label={params.value}
            size="small"
            sx={{
              backgroundColor: params.value === 'En produccion' ? '#D1FAE5' : 
                             params.value === 'Planificado' ? '#FEF3C7' :
                             params.value === 'En desarrollo' ? '#DBEAFE' : '#F3F4F6',
              color: params.value === 'En produccion' ? '#065F46' : 
                     params.value === 'Planificado' ? '#92400E' :
                     params.value === 'En desarrollo' ? '#1E40AF' : '#374151',
              fontWeight: 500,
              fontSize: '0.75rem',
            }}
          />
        </Box>
      ),
    },
    {
      field: 'nivel_criticidad_negocio',
      headerName: 'Criticidad',
      width: 120,
      headerAlign: 'center',
      align: 'center',
      renderCell: (params: GridRenderCellParams) => (
        <Box>
          <Chip
            label={params.value}
            size="small"
            sx={{
              backgroundColor: params.value === 'Crítico' ? '#FEE2E2' :
                             params.value === 'Alto' ? '#FEF3C7' :
                             params.value === 'Medio' ? '#DBEAFE' : '#F3F4F6',
              color: params.value === 'Crítico' ? '#DC2626' :
                     params.value === 'Alto' ? '#D97706' :
                     params.value === 'Medio' ? '#2563EB' : '#6B7280',
              fontWeight: 500,
              fontSize: '0.75rem',
            }}
          />
        </Box>
      ),
    },
    { 
      field: 'fecha_creacion_registro', 
      headerName: 'Fecha Creación', 
      width: 160,
      headerAlign: 'center',
      align: 'center',
      renderCell: (params: GridRenderCellParams) => (
        <Typography variant="body2" className="font-roboto" sx={{ color: '#6B7280', fontSize: '0.875rem' }}>
          {new Date(params.value).toLocaleDateString('es-ES', {
            year: 'numeric',
            month: 'short',
            day: 'numeric'
          })}
        </Typography>
      ),
    },
    {
      field: 'actions',
      headerName: 'Acciones',
      width: 120,
      headerAlign: 'center',
      align: 'center',
      sortable: false,
      renderCell: (params: GridRenderCellParams) => (
        <Box sx={{ display: 'flex', gap: 0.5, justifyContent: 'center' }}>
          <Tooltip title="Editar activo">
            <IconButton
              size="small"
              onClick={() => handleOpenDialog(params.row)}
              sx={{
                color: '#1E3A8A',
                '&:hover': {
                  backgroundColor: '#EFF6FF',
                  color: '#1E40AF',
                },
                transition: 'all 0.2s ease',
              }}
            >
              <EditIcon fontSize="small" />
            </IconButton>
          </Tooltip>
          <Tooltip title="Eliminar activo">
            <IconButton
              size="small"
              onClick={() => handleDelete(params.row.ID_Activo)}
              sx={{
                color: '#EF4444',
                '&:hover': {
                  backgroundColor: '#FEF2F2',
                  color: '#DC2626',
                },
                transition: 'all 0.2s ease',
              }}
            >
              <DeleteIcon fontSize="small" />
            </IconButton>
          </Tooltip>
        </Box>
      ),
    },
  ];

  if (error) {
    return (
      <Box p={3}>
        <Alert severity="error">
          Error al cargar los activos: {error.message}
        </Alert>
      </Box>
    );
  }

  return (
    <Box>
      {/* Header Section */}
      <Box sx={{ mb: 4 }}>
        <Box sx={{ display: 'flex', justifyContent: 'space-between', alignItems: 'flex-start', mb: 3 }}>
          <Box>
            <Typography variant="h4" className="font-poppins" sx={{ color: '#1E3A8A', fontWeight: 600, mb: 1 }}>
              Gestión de Activos
            </Typography>
            <Typography variant="body1" className="font-roboto" sx={{ color: '#6B7280' }}>
              Administra y monitorea todos los activos de información de la organización
            </Typography>
          </Box>
          <Button
            className="btn btn-primary"
            startIcon={<AddIcon />}
            onClick={() => handleOpenDialog()}
            sx={{
              background: 'linear-gradient(135deg, #1E3A8A 0%, #3B82F6 100%)',
              color: '#FFFFFF',
              px: 3,
              py: 1.5,
              borderRadius: '12px',
              textTransform: 'none',
              fontWeight: 500,
              boxShadow: '0 4px 12px rgba(30, 58, 138, 0.3)',
              '&:hover': {
                background: 'linear-gradient(135deg, #1E40AF 0%, #2563EB 100%)',
                transform: 'translateY(-2px)',
                boxShadow: '0 6px 16px rgba(30, 58, 138, 0.4)',
              },
              transition: 'all 0.25s cubic-bezier(0.4, 0, 0.2, 1)'
            }}
          >
            Nuevo Activo
          </Button>
        </Box>

        {/* Stats Cards */}
        <Grid container spacing={3} sx={{ mb: 4 }}>
          <Grid item xs={12} sm={6} md={3}>
            <Card className="card" sx={{ 
              background: 'linear-gradient(135deg, #1E3A8A 0%, #3B82F6 100%)',
              color: '#FFFFFF',
              border: 'none'
            }}>
              <CardContent sx={{ p: 3 }}>
                <Box sx={{ display: 'flex', alignItems: 'center', justifyContent: 'space-between' }}>
                  <Box>
                    <Typography variant="h4" className="font-poppins" sx={{ fontWeight: 600, mb: 0.5 }}>
                      {activosStats?.total ?? activos.length}
                    </Typography>
                    <Typography variant="body2" className="font-roboto" sx={{ opacity: 0.9 }}>
                      Total Activos
                    </Typography>
                  </Box>
                  <SecurityIcon sx={{ fontSize: 40, opacity: 0.8 }} />
                </Box>
              </CardContent>
            </Card>
          </Grid>
          <Grid item xs={12} sm={6} md={3}>
            <Card className="card">
              <CardContent sx={{ p: 3 }}>
                <Box sx={{ display: 'flex', alignItems: 'center', justifyContent: 'space-between' }}>
                  <Box>
                    <Typography variant="h4" className="font-poppins" sx={{ fontWeight: 600, mb: 0.5, color: '#1E3A8A' }}>
                      {activosStats?.en_produccion ?? 0}
                    </Typography>
                    <Typography variant="body2" className="font-roboto" sx={{ color: '#6B7280' }}>
                      En Producción
                    </Typography>
                  </Box>
                  <TrendingUpIcon sx={{ fontSize: 40, color: '#10B981' }} />
                </Box>
              </CardContent>
            </Card>
          </Grid>
          <Grid item xs={12} sm={6} md={3}>
            <Card className="card">
              <CardContent sx={{ p: 3 }}>
                <Box sx={{ display: 'flex', alignItems: 'center', justifyContent: 'space-between' }}>
                  <Box>
                    <Typography variant="h4" className="font-poppins" sx={{ fontWeight: 600, mb: 0.5, color: '#1E3A8A' }}>
                      {activosStats?.alta_criticidad ?? 0}
                    </Typography>
                    <Typography variant="body2" className="font-roboto" sx={{ color: '#6B7280' }}>
                      Alta Criticidad
                    </Typography>
                  </Box>
                  <AssessmentIcon sx={{ fontSize: 40, color: '#F59E0B' }} />
                </Box>
              </CardContent>
            </Card>
          </Grid>
          <Grid item xs={12} sm={6} md={3}>
            <Card className="card">
              <CardContent sx={{ p: 3 }}>
                <Box sx={{ display: 'flex', alignItems: 'center', justifyContent: 'space-between' }}>
                  <Box>
                    <Typography variant="h4" className="font-poppins" sx={{ fontWeight: 600, mb: 0.5, color: '#1E3A8A' }}>
                      {activosStats?.requieren_backup ?? 0}
                    </Typography>
                    <Typography variant="body2" className="font-roboto" sx={{ color: '#6B7280' }}>
                      Requieren Backup
                    </Typography>
                  </Box>
                  <SecurityIcon sx={{ fontSize: 40, color: '#3B82F6' }} />
                </Box>
              </CardContent>
            </Card>
          </Grid>
        </Grid>
      </Box>

      {/* Filters Section */}
      <Card className="card" sx={{ mb: 3 }}>
        <CardHeader 
          title="Filtros y Búsqueda" 
          titleTypographyProps={{ 
            className: 'font-poppins', 
            fontWeight: 500, 
            color: '#1E3A8A',
            fontSize: '1.1rem'
          }}
          sx={{ pb: 1 }}
        />
        <CardContent sx={{ pt: 0 }}>
          <Stack direction={{ xs: 'column', md: 'row' }} spacing={2} alignItems="center">
            <Box sx={{ flex: 1, minWidth: '280px' }}>
              <Autocomplete
                freeSolo
                options={activos.map(activo => activo.Nombre || activo.nombre || '')}
                value={searchTerm}
                onInputChange={(event, newValue) => {
                  setSearchTerm(newValue || '');
                }}
                filterOptions={(options, { inputValue }) => {
                  return options.filter(option =>
                    option.toLowerCase().includes(inputValue.toLowerCase())
                  );
                }}
                renderInput={(params) => (
                  <TextField
                    {...params}
                    placeholder="Buscar activos por nombre o descripción..."
                    className="input"
                    InputProps={{
                      ...params.InputProps,
                      startAdornment: (
                        <InputAdornment position="start">
                          <SearchIcon sx={{ color: '#6B7280' }} />
                        </InputAdornment>
                      ),
                    }}
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
                )}
                renderOption={(props, option) => {
                  const activo = activos.find(a => (a.Nombre || a.nombre) === option);
                  return (
                    <Box component="li" {...props}>
                      <Box>
                        <Typography variant="body2" className="font-roboto" sx={{ fontWeight: 500 }}>
                          {option}
                        </Typography>
                        <Typography variant="caption" className="font-roboto" sx={{ color: '#6B7280' }}>
                          {activo?.Tipo_Activo} • {activo?.estado_activo}
                        </Typography>
                      </Box>
                    </Box>
                  );
                }}
                sx={{
                  '& .MuiAutocomplete-paper': {
                    borderRadius: '12px',
                    boxShadow: '0 4px 20px rgba(0,0,0,0.1)',
                  },
                }}
              />
            </Box>
            
            <FormControl sx={{ minWidth: '140px' }}>
              <InputLabel>Tipo</InputLabel>
              <Select
                value={tipoFilter}
                onChange={(e) => setTipoFilter(e.target.value)}
                label="Tipo"
                sx={{
                  borderRadius: '12px',
                  '& .MuiOutlinedInput-notchedOutline': {
                    borderColor: '#D1D5DB',
                  },
                  '&:hover .MuiOutlinedInput-notchedOutline': {
                    borderColor: '#1E3A8A',
                  },
                  '&.Mui-focused .MuiOutlinedInput-notchedOutline': {
                    borderColor: '#1E3A8A',
                  },
                }}
              >
                <MenuItem value="">Todos los tipos</MenuItem>
                {tiposActivo.map((tipo) => (
                  <MenuItem key={tipo} value={tipo}>{tipo}</MenuItem>
                ))}
              </Select>
            </FormControl>
            
            <FormControl sx={{ minWidth: '140px' }}>
              <InputLabel>Estado</InputLabel>
              <Select
                value={estadoFilter}
                onChange={(e) => setEstadoFilter(e.target.value)}
                label="Estado"
                sx={{
                  borderRadius: '12px',
                  '& .MuiOutlinedInput-notchedOutline': {
                    borderColor: '#D1D5DB',
                  },
                  '&:hover .MuiOutlinedInput-notchedOutline': {
                    borderColor: '#1E3A8A',
                  },
                  '&.Mui-focused .MuiOutlinedInput-notchedOutline': {
                    borderColor: '#1E3A8A',
                  },
                }}
              >
                <MenuItem value="">Todos los estados</MenuItem>
                {estadosActivo.map((estado) => (
                  <MenuItem key={estado} value={estado}>{estado}</MenuItem>
                ))}
              </Select>
            </FormControl>
            
            <FormControl sx={{ minWidth: '140px' }}>
              <InputLabel>Criticidad</InputLabel>
              <Select
                value={criticidadFilter}
                onChange={(e) => setCriticidadFilter(e.target.value)}
                label="Criticidad"
                sx={{
                  borderRadius: '12px',
                  '& .MuiOutlinedInput-notchedOutline': {
                    borderColor: '#D1D5DB',
                  },
                  '&:hover .MuiOutlinedInput-notchedOutline': {
                    borderColor: '#1E3A8A',
                  },
                  '&.Mui-focused .MuiOutlinedInput-notchedOutline': {
                    borderColor: '#1E3A8A',
                  },
                }}
              >
                <MenuItem value="">Todas las criticidades</MenuItem>
                <MenuItem value="Muy Alto">Muy Alto</MenuItem>
                <MenuItem value="Alto">Alto</MenuItem>
                <MenuItem value="Medio">Medio</MenuItem>
                <MenuItem value="Bajo">Bajo</MenuItem>
                <MenuItem value="Muy Bajo">Muy Bajo</MenuItem>
              </Select>
            </FormControl>
            
            <Tooltip title="Limpiar todos los filtros">
              <Button
                className="btn btn-secondary"
                startIcon={<ClearIcon />}
                onClick={() => {
                  setTipoFilter('');
                  setEstadoFilter('');
                  setCriticidadFilter('');
                  setSearchTerm('');
                }}
                sx={{
                  borderRadius: '12px',
                  px: 2,
                  py: 1.5,
                  textTransform: 'none',
                  fontWeight: 500,
                }}
              >
                Limpiar
              </Button>
            </Tooltip>
          </Stack>
        </CardContent>
      </Card>

      {/* Data Grid */}
      <Card className="card">
        <CardHeader 
          title="Lista de Activos" 
          titleTypographyProps={{ 
            className: 'font-poppins', 
            fontWeight: 500, 
            color: '#1E3A8A',
            fontSize: '1.1rem'
          }}
          sx={{ pb: 1 }}
        />
        <CardContent sx={{ pt: 0, p: 0 }}>
          <Box sx={{ height: 600, width: '100%' }}>
            <DataGrid
              rows={filteredActivos}
              columns={columns}
              loading={isLoading}
              getRowId={(row) => row.ID_Activo}
              pageSizeOptions={[10, 25, 50]}
              initialState={{
                pagination: {
                  paginationModel: { pageSize: 10 },
                },
              }}
              sx={{
                border: 'none',
                '& .MuiDataGrid-root': {
                  border: 'none',
                },
                '& .MuiDataGrid-cell': {
                  borderBottom: '1px solid #F3F4F6',
                },
                '& .MuiDataGrid-columnHeaders': {
                  backgroundColor: '#F9FAFB',
                  borderBottom: '2px solid #E5E7EB',
                  '& .MuiDataGrid-columnHeaderTitle': {
                    fontWeight: 600,
                    color: '#1E3A8A',
                    fontFamily: "'Poppins', sans-serif",
                  },
                },
                '& .MuiDataGrid-row:hover': {
                  backgroundColor: '#F9FAFB',
                },
                '& .MuiDataGrid-footerContainer': {
                  borderTop: '1px solid #E5E7EB',
                  backgroundColor: '#F9FAFB',
                },
              }}
            />
          </Box>
        </CardContent>
      </Card>

      {/* Create/Edit Dialog */}
      <Dialog 
        open={openDialog} 
        onClose={handleCloseDialog} 
        maxWidth="md" 
        fullWidth
        PaperProps={{
          sx: {
            borderRadius: '16px',
            boxShadow: '0 20px 25px -5px rgba(0, 0, 0, 0.1), 0 10px 10px -5px rgba(0, 0, 0, 0.04)',
          }
        }}
      >
        <form onSubmit={handleSubmit}>
          <DialogTitle sx={{ 
            pb: 2,
            borderBottom: '1px solid #E5E7EB',
            background: 'linear-gradient(135deg, #1E3A8A 0%, #3B82F6 100%)',
            color: '#FFFFFF',
            borderRadius: '16px 16px 0 0',
          }}>
            <Box sx={{ display: 'flex', alignItems: 'center', gap: 2 }}>
              <SecurityIcon sx={{ fontSize: 28 }} />
              <Box>
                <Typography variant="h6" className="font-poppins" sx={{ fontWeight: 600, mb: 0.5 }}>
                  {editingActivo ? 'Editar Activo' : 'Crear Nuevo Activo'}
                </Typography>
                <Typography variant="body2" className="font-roboto" sx={{ opacity: 0.9 }}>
                  {editingActivo ? 'Modifica la información del activo seleccionado' : 'Agrega un nuevo activo al inventario'}
                </Typography>
              </Box>
            </Box>
          </DialogTitle>
          
          <DialogContent sx={{ p: 3 }}>
            <Stack spacing={3}>
              <Box sx={{ display: 'flex', gap: 2, flexWrap: 'wrap' }}>
                <TextField
                  sx={{ flex: '1 1 300px' }}
                  label="Nombre del Activo"
                  value={formData.Nombre}
                  onChange={(e) => setFormData({ ...formData, Nombre: e.target.value })}
                  required
                  className="input"
                  InputProps={{
                    sx: { borderRadius: '12px' }
                  }}
                />
                <FormControl sx={{ flex: '1 1 200px' }} required>
                  <InputLabel>Tipo de Activo</InputLabel>
                  <Select
                    value={formData.Tipo_Activo}
                    onChange={(e) => setFormData({ ...formData, Tipo_Activo: e.target.value })}
                    label="Tipo de Activo"
                    sx={{ borderRadius: '12px' }}
                  >
                    <MenuItem value="Hardware">Hardware</MenuItem>
                    <MenuItem value="Software">Software</MenuItem>
                    <MenuItem value="Datos">Datos</MenuItem>
                    <MenuItem value="Servicios">Servicios</MenuItem>
                    <MenuItem value="Documentos">Documentos</MenuItem>
                    <MenuItem value="Recurso Humano">Recurso Humano</MenuItem>
                    <MenuItem value="Intangible">Intangible</MenuItem>
                    <MenuItem value="Infraestructura Fisica">Infraestructura Fisica</MenuItem>
                    <MenuItem value="Plataforma">Plataforma</MenuItem>
                    <MenuItem value="Aplicacion/Sistema">Aplicacion/Sistema</MenuItem>
                    <MenuItem value="Otro">Otro</MenuItem>
                  </Select>
                </FormControl>
              </Box>
              
              <TextField
                fullWidth
                multiline
                rows={3}
                label="Descripción del Activo"
                value={formData.Descripcion}
                onChange={(e) => setFormData({ ...formData, Descripcion: e.target.value })}
                className="input"
                InputProps={{
                  sx: { borderRadius: '12px' }
                }}
              />
              
              <Box sx={{ display: 'flex', gap: 2, flexWrap: 'wrap' }}>
                <FormControl sx={{ flex: '1 1 200px' }}>
                  <InputLabel>Estado del Activo</InputLabel>
                  <Select
                    value={formData.estado_activo}
                    onChange={(e) => setFormData({ ...formData, estado_activo: e.target.value })}
                    label="Estado del Activo"
                    sx={{ borderRadius: '12px' }}
                  >
                    <MenuItem value="En produccion">En producción</MenuItem>
                    <MenuItem value="En desarrollo">En desarrollo</MenuItem>
                    <MenuItem value="Obsoleto">Obsoleto</MenuItem>
                    <MenuItem value="Retirado">Retirado</MenuItem>
                    <MenuItem value="En mantenimiento">En mantenimiento</MenuItem>
                    <MenuItem value="Planificado">Planificado</MenuItem>
                    <MenuItem value="En stock">En stock</MenuItem>
                    <MenuItem value="Dañado">Dañado</MenuItem>
                  </Select>
                </FormControl>
                <FormControl sx={{ flex: '1 1 200px' }}>
                  <InputLabel>Nivel de Criticidad</InputLabel>
                  <Select
                    value={formData.nivel_criticidad_negocio}
                    onChange={(e) => setFormData({ ...formData, nivel_criticidad_negocio: e.target.value })}
                    label="Nivel de Criticidad"
                    sx={{ borderRadius: '12px' }}
                  >
                    <MenuItem value="Muy Alto">Muy Alto</MenuItem>
                    <MenuItem value="Alto">Alto</MenuItem>
                    <MenuItem value="Medio">Medio</MenuItem>
                    <MenuItem value="Bajo">Bajo</MenuItem>
                    <MenuItem value="Muy Bajo">Muy Bajo</MenuItem>
                  </Select>
                </FormControl>
              </Box>
            </Stack>
          </DialogContent>
          
          <DialogActions sx={{ p: 3, pt: 2, borderTop: '1px solid #E5E7EB' }}>
            <Button 
              onClick={handleCloseDialog}
              className="btn btn-secondary"
              sx={{
                borderRadius: '12px',
                px: 3,
                py: 1.5,
                textTransform: 'none',
                fontWeight: 500,
              }}
            >
              Cancelar
            </Button>
            <Button
              type="submit"
              className="btn btn-primary"
              disabled={createMutation.isPending || updateMutation.isPending}
              sx={{
                background: 'linear-gradient(135deg, #1E3A8A 0%, #3B82F6 100%)',
                color: '#FFFFFF',
                borderRadius: '12px',
                px: 3,
                py: 1.5,
                textTransform: 'none',
                fontWeight: 500,
                boxShadow: '0 4px 12px rgba(30, 58, 138, 0.3)',
                '&:hover': {
                  background: 'linear-gradient(135deg, #1E40AF 0%, #2563EB 100%)',
                  transform: 'translateY(-1px)',
                  boxShadow: '0 6px 16px rgba(30, 58, 138, 0.4)',
                },
                '&:disabled': {
                  background: '#9CA3AF',
                  transform: 'none',
                  boxShadow: 'none',
                },
                transition: 'all 0.25s cubic-bezier(0.4, 0, 0.2, 1)'
              }}
            >
              {editingActivo ? 'Actualizar Activo' : 'Crear Activo'}
            </Button>
          </DialogActions>
        </form>
      </Dialog>
    </Box>
  );
};

export default Activos;