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
  Chip,
  Alert,
  Card,
  CardContent,
  CardHeader,
  InputAdornment,
  Stack,
  Divider,
  Tooltip,
  Avatar,
  Autocomplete,
} from '@mui/material';
import { Grid } from '@mui/material';
import {
  Add as AddIcon,
  Edit as EditIcon,
  Delete as DeleteIcon,
  Search as SearchIcon,
  FilterList as FilterIcon,
  People as PeopleIcon,
  PersonAdd as PersonAddIcon,
  Group as GroupIcon,
  Clear as ClearIcon,
  Email as EmailIcon,
  Work as WorkIcon,
} from '@mui/icons-material';
import { DataGrid } from '@mui/x-data-grid';
import type { GridColDef, GridRenderCellParams } from '@mui/x-data-grid';
import { useQuery, useMutation, useQueryClient } from '@tanstack/react-query';
import { toast } from 'react-hot-toast';
import { usuariosService, type Usuario } from '../../services/backend';
import '../../styles/design-system.css';

const Usuarios: React.FC = () => {
  const [searchTerm, setSearchTerm] = useState('');
  const [puestoFilter, setPuestoFilter] = useState('');
  const [estadoFilter, setEstadoFilter] = useState('');
  const [openDialog, setOpenDialog] = useState(false);
  const [editingUsuario, setEditingUsuario] = useState<Usuario | null>(null);
  const [formData, setFormData] = useState<CreateUsuarioData>({
    nombre_completo: '',
    email_institucional: '',
    puesto_organizacion: '',
    estado_usuario: 'Activo',
  });

  const queryClient = useQueryClient();

  // Queries
  const { data: usuarios = [], isLoading, error } = useQuery({
    queryKey: ['usuarios', puestoFilter, estadoFilter],
    queryFn: async () => {
      try {
        const { usuariosService } = await import('../../services/backend');
        return await usuariosService.getAll();
      } catch (error) {
        console.error('Error fetching usuarios:', error);
        return [];
      }
    },
  });

  const { data: puestos = [] } = useQuery({
    queryKey: ['puestos-usuario'],
    queryFn: async () => {
      // Datos mock para puestos
      return ['Administrador', 'Consultor', 'Analista', 'Gerente', 'Director'];
    },
  });

  const { data: estados = [] } = useQuery({
    queryKey: ['estados-usuario'],
    queryFn: async () => {
      // Datos mock para estados
      return ['Activo', 'Inactivo', 'Bloqueado', 'Pendiente'];
    },
  });

  // Mutations
  const createMutation = useMutation({
    mutationFn: async (data: any) => {
      const { usuariosService } = await import('../../services/backend');
      return await usuariosService.create(data);
    },
    onSuccess: () => {
      queryClient.invalidateQueries({ queryKey: ['usuarios'] });
      toast.success('Usuario creado exitosamente');
      handleCloseDialog();
    },
    onError: (error: any) => {
      toast.error(`Error al crear usuario: ${error.response?.data?.error || error.message}`);
    },
  });

  const updateMutation = useMutation({
    mutationFn: async ({ id, data }: { id: number; data: UpdateUsuarioData }) => {
      const { usuariosService } = await import('../../services/backend');
      return await usuariosService.update(id, data);
    },
    onSuccess: () => {
      queryClient.invalidateQueries({ queryKey: ['usuarios'] });
      toast.success('Usuario actualizado exitosamente');
      handleCloseDialog();
    },
    onError: (error: any) => {
      toast.error(`Error al actualizar usuario: ${error.response?.data?.error || error.message}`);
    },
  });

  const deleteMutation = useMutation({
    mutationFn: async (id: number) => {
      const { usuariosService } = await import('../../services/backend');
      return await usuariosService.delete(id);
    },
    onSuccess: () => {
      queryClient.invalidateQueries({ queryKey: ['usuarios'] });
      toast.success('Usuario eliminado exitosamente');
    },
    onError: (error: any) => {
      toast.error(`Error al eliminar usuario: ${error.response?.data?.error || error.message}`);
    },
  });

  // Filtered usuarios based on search term and filters
  const filteredUsuarios = usuarios.filter(usuario => {
    const matchesSearch = !searchTerm || 
      (usuario.nombre_completo || '').toLowerCase().includes(searchTerm.toLowerCase()) ||
      (usuario.email_institucional || '').toLowerCase().includes(searchTerm.toLowerCase()) ||
      (usuario.rol && usuario.rol.toLowerCase().includes(searchTerm.toLowerCase()));
    
    const matchesPuesto = !puestoFilter || usuario.rol === puestoFilter;
    const matchesEstado = !estadoFilter || usuario.estado_usuario === estadoFilter;
    
    return matchesSearch && matchesPuesto && matchesEstado;
  });

  const handleOpenDialog = (usuario?: Usuario) => {
    if (usuario) {
      setEditingUsuario(usuario);
      setFormData({
        nombre_completo: usuario.nombre_completo,
        email_institucional: usuario.email_institucional,
        puesto_organizacion: usuario.puesto_organizacion || '',
        estado_usuario: usuario.estado_usuario,
      });
    } else {
      setEditingUsuario(null);
      setFormData({
        nombre_completo: '',
        email_institucional: '',
        puesto_organizacion: '',
        estado_usuario: 'Activo',
      });
    }
    setOpenDialog(true);
  };

  const handleCloseDialog = () => {
    setOpenDialog(false);
    setEditingUsuario(null);
  };

  const handleSubmit = (e: React.FormEvent) => {
    e.preventDefault();
    if (editingUsuario) {
      updateMutation.mutate({ id: editingUsuario.id_usuario, data: formData });
    } else {
      createMutation.mutate(formData);
    }
  };

  const handleDelete = (id: number) => {
    if (window.confirm('¿Está seguro de que desea eliminar este usuario?')) {
      deleteMutation.mutate(id);
    }
  };

  const columns: GridColDef[] = [
    { 
      field: 'id_usuario', 
      headerName: 'ID', 
      width: 80,
      headerAlign: 'center',
      align: 'center',
    },
    { 
      field: 'nombre_completo', 
      headerName: 'Nombre Completo', 
      width: 250,
      flex: 1,
      minWidth: 200,
      renderCell: (params: GridRenderCellParams) => (
        <Box sx={{ display: 'flex', alignItems: 'center', gap: 2 }}>
          <Avatar sx={{ 
            width: 32, 
            height: 32, 
            background: 'linear-gradient(135deg, #1E3A8A 0%, #3B82F6 100%)',
            color: '#FFFFFF',
            fontSize: '0.875rem',
            fontWeight: 600
          }}>
            {params.value?.split(' ').map((n: string) => n[0]).join('').toUpperCase()}
          </Avatar>
          <Typography variant="body2" className="font-roboto" sx={{ color: '#374151', fontWeight: 500 }}>
            {params.value}
          </Typography>
        </Box>
      ),
    },
    { 
      field: 'email_institucional', 
      headerName: 'Email Institucional', 
      width: 280,
      renderCell: (params: GridRenderCellParams) => (
        <Box sx={{ display: 'flex', alignItems: 'center', gap: 1 }}>
          <EmailIcon sx={{ fontSize: 16, color: '#6B7280' }} />
          <Typography variant="body2" className="font-roboto" sx={{ color: '#6B7280', fontSize: '0.875rem' }}>
            {params.value}
          </Typography>
        </Box>
      ),
    },
    { 
      field: 'puesto_organizacion', 
      headerName: 'Puesto', 
      width: 180,
      headerAlign: 'center',
      align: 'center',
      renderCell: (params: GridRenderCellParams) => (
        <Box sx={{ display: 'flex', alignItems: 'center', gap: 1, justifyContent: 'center' }}>
          <WorkIcon sx={{ fontSize: 16, color: '#6B7280' }} />
          <Typography variant="body2" className="font-roboto" sx={{ color: '#374151', fontSize: '0.875rem' }}>
            {params.value || 'No especificado'}
          </Typography>
        </Box>
      ),
    },
    {
      field: 'estado_usuario',
      headerName: 'Estado',
      width: 120,
      headerAlign: 'center',
      align: 'center',
      renderCell: (params: GridRenderCellParams) => (
        <Box>
          <Chip
            label={params.value}
            size="small"
            sx={{
              backgroundColor: params.value === 'Activo' ? '#D1FAE5' :
                             params.value === 'Inactivo' ? '#FEF3C7' :
                             params.value === 'Bloqueado' ? '#FEE2E2' : '#F3F4F6',
              color: params.value === 'Activo' ? '#065F46' :
                     params.value === 'Inactivo' ? '#92400E' :
                     params.value === 'Bloqueado' ? '#DC2626' : '#6B7280',
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
          <Tooltip title="Editar usuario">
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
          <Tooltip title="Eliminar usuario">
            <IconButton
              size="small"
              onClick={() => handleDelete(params.row.id_usuario)}
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
          Error al cargar los usuarios: {error.message}
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
              Gestión de Usuarios
            </Typography>
            <Typography variant="body1" className="font-roboto" sx={{ color: '#6B7280' }}>
              Administra los usuarios del sistema y sus roles organizacionales
            </Typography>
          </Box>
          <Button
            className="btn btn-primary"
            startIcon={<PersonAddIcon />}
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
            Nuevo Usuario
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
                      {usuarios.length}
                    </Typography>
                    <Typography variant="body2" className="font-roboto" sx={{ opacity: 0.9 }}>
                      Total Usuarios
                    </Typography>
                  </Box>
                  <PeopleIcon sx={{ fontSize: 40, opacity: 0.8 }} />
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
                      {usuarios.filter(u => u.estado_usuario === 'Activo').length}
                    </Typography>
                    <Typography variant="body2" className="font-roboto" sx={{ color: '#6B7280' }}>
                      Usuarios Activos
                    </Typography>
                  </Box>
                  <PersonAddIcon sx={{ fontSize: 40, color: '#10B981' }} />
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
                      {usuarios.filter(u => u.estado_usuario === 'Inactivo').length}
                    </Typography>
                    <Typography variant="body2" className="font-roboto" sx={{ color: '#6B7280' }}>
                      Usuarios Inactivos
                    </Typography>
                  </Box>
                  <GroupIcon sx={{ fontSize: 40, color: '#F59E0B' }} />
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
                      {usuarios.filter(u => u.estado_usuario === 'Bloqueado').length}
                    </Typography>
                    <Typography variant="body2" className="font-roboto" sx={{ color: '#6B7280' }}>
                      Usuarios Bloqueados
                    </Typography>
                  </Box>
                  <PeopleIcon sx={{ fontSize: 40, color: '#EF4444' }} />
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
                options={usuarios.map(usuario => usuario.nombre_completo || usuario.nombre || '')}
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
                    placeholder="Buscar usuarios por nombre, email o puesto..."
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
                renderOption={(props, option) => (
                  <Box component="li" {...props}>
                    <Box>
                      <Typography variant="body2" className="font-roboto" sx={{ fontWeight: 500 }}>
                        {option}
                      </Typography>
                      <Typography variant="caption" className="font-roboto" sx={{ color: '#6B7280' }}>
                        {usuarios.find(u => u.nombre === option)?.email} • {usuarios.find(u => u.nombre === option)?.rol}
                      </Typography>
                    </Box>
                  </Box>
                )}
                sx={{
                  '& .MuiAutocomplete-paper': {
                    borderRadius: '12px',
                    boxShadow: '0 4px 20px rgba(0,0,0,0.1)',
                  },
                }}
              />
            </Box>
            
            <FormControl sx={{ minWidth: '160px' }}>
              <InputLabel>Puesto</InputLabel>
              <Select
                value={puestoFilter}
                onChange={(e) => setPuestoFilter(e.target.value)}
                label="Puesto"
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
                <MenuItem value="">Todos los puestos</MenuItem>
                {puestos.map((puesto) => (
                  <MenuItem key={puesto} value={puesto}>{puesto}</MenuItem>
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
                {estados.map((estado) => (
                  <MenuItem key={estado} value={estado}>{estado}</MenuItem>
                ))}
              </Select>
            </FormControl>
            
            <Tooltip title="Limpiar todos los filtros">
              <Button
                className="btn btn-secondary"
                startIcon={<ClearIcon />}
                onClick={() => {
                  setPuestoFilter('');
                  setEstadoFilter('');
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
          title="Lista de Usuarios" 
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
              rows={filteredUsuarios}
              columns={columns}
              loading={isLoading}
              getRowId={(row) => row.id_usuario}
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
              <PeopleIcon sx={{ fontSize: 28 }} />
              <Box>
                <Typography variant="h6" className="font-poppins" sx={{ fontWeight: 600, mb: 0.5 }}>
                  {editingUsuario ? 'Editar Usuario' : 'Crear Nuevo Usuario'}
                </Typography>
                <Typography variant="body2" className="font-roboto" sx={{ opacity: 0.9 }}>
                  {editingUsuario ? 'Modifica la información del usuario seleccionado' : 'Agrega un nuevo usuario al sistema'}
                </Typography>
              </Box>
            </Box>
          </DialogTitle>
          
          <DialogContent sx={{ p: 3 }}>
            <Stack spacing={3}>
              <Box sx={{ display: 'flex', gap: 2, flexWrap: 'wrap' }}>
                <TextField
                  sx={{ flex: '1 1 300px' }}
                  label="Nombre Completo"
                  value={formData.nombre_completo}
                  onChange={(e) => setFormData({ ...formData, nombre_completo: e.target.value })}
                  required
                  className="input"
                  InputProps={{
                    sx: { borderRadius: '12px' }
                  }}
                />
                <TextField
                  sx={{ flex: '1 1 300px' }}
                  label="Email Institucional"
                  type="email"
                  value={formData.email_institucional}
                  onChange={(e) => setFormData({ ...formData, email_institucional: e.target.value })}
                  required
                  className="input"
                  InputProps={{
                    sx: { borderRadius: '12px' }
                  }}
                />
              </Box>
              
              <Box sx={{ display: 'flex', gap: 2, flexWrap: 'wrap' }}>
                <TextField
                  sx={{ flex: '1 1 300px' }}
                  label="Puesto Organizacional"
                  value={formData.puesto_organizacion}
                  onChange={(e) => setFormData({ ...formData, puesto_organizacion: e.target.value })}
                  className="input"
                  InputProps={{
                    sx: { borderRadius: '12px' }
                  }}
                />
                <FormControl sx={{ flex: '1 1 200px' }}>
                  <InputLabel>Estado del Usuario</InputLabel>
                  <Select
                    value={formData.estado_usuario}
                    onChange={(e) => setFormData({ ...formData, estado_usuario: e.target.value })}
                    label="Estado del Usuario"
                    sx={{ borderRadius: '12px' }}
                  >
                    <MenuItem value="Activo">Activo</MenuItem>
                    <MenuItem value="Inactivo">Inactivo</MenuItem>
                    <MenuItem value="Bloqueado">Bloqueado</MenuItem>
                    <MenuItem value="Pendiente_Activacion">Pendiente Activación</MenuItem>
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
              {editingUsuario ? 'Actualizar Usuario' : 'Crear Usuario'}
            </Button>
          </DialogActions>
        </form>
      </Dialog>
    </Box>
  );
};

export default Usuarios;