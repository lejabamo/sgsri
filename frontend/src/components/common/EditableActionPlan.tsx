import React, { useState } from 'react';
import {
  Box,
  Card,
  CardContent,
  Typography,
  Button,
  IconButton,
  Dialog,
  DialogTitle,
  DialogContent,
  DialogActions,
  TextField,
  Grid,
  Chip,
  FormControl,
  InputLabel,
  Select,
  MenuItem,
  FormControlLabel,
  Switch,
  Divider
} from '@mui/material';
import {
  Edit as EditIcon,
  Add as AddIcon,
  Delete as DeleteIcon,
  Save as SaveIcon,
  Cancel as CancelIcon,
  Assignment as AssignmentIcon,
  Person as PersonIcon,
  Schedule as ScheduleIcon,
  Flag as FlagIcon
} from '@mui/icons-material';

interface ActionItem {
  id: string;
  titulo: string;
  descripcion: string;
  responsable: string;
  fechaInicio: string;
  fechaFin: string;
  estado: 'pendiente' | 'en_progreso' | 'completada' | 'cancelada';
  prioridad: 'baja' | 'media' | 'alta' | 'critica';
  comentarios: string;
}

interface EditableActionPlanProps {
  actionItems: ActionItem[];
  onActionItemsChange: (items: ActionItem[]) => void;
  readOnly?: boolean;
}

const EditableActionPlan: React.FC<EditableActionPlanProps> = ({
  actionItems,
  onActionItemsChange,
  readOnly = false
}) => {
  const [editingItem, setEditingItem] = useState<ActionItem | null>(null);
  const [isDialogOpen, setIsDialogOpen] = useState(false);
  const [newItem, setNewItem] = useState<Partial<ActionItem>>({
    titulo: '',
    descripcion: '',
    responsable: '',
    fechaInicio: '',
    fechaFin: '',
    estado: 'pendiente',
    prioridad: 'media',
    comentarios: ''
  });

  const handleAddItem = () => {
    setEditingItem(null);
    setNewItem({
      titulo: '',
      descripcion: '',
      responsable: '',
      fechaInicio: '',
      fechaFin: '',
      estado: 'pendiente',
      prioridad: 'media',
      comentarios: ''
    });
    setIsDialogOpen(true);
  };

  const handleEditItem = (item: ActionItem) => {
    setEditingItem(item);
    setNewItem(item);
    setIsDialogOpen(true);
  };

  const handleDeleteItem = (id: string) => {
    const updatedItems = actionItems.filter(item => item.id !== id);
    onActionItemsChange(updatedItems);
  };

  const handleSaveItem = () => {
    if (!newItem.titulo || !newItem.descripcion) {
      return;
    }

    const itemToSave: ActionItem = {
      id: editingItem?.id || Date.now().toString(),
      titulo: newItem.titulo,
      descripcion: newItem.descripcion,
      responsable: newItem.responsable || '',
      fechaInicio: newItem.fechaInicio || '',
      fechaFin: newItem.fechaFin || '',
      estado: newItem.estado || 'pendiente',
      prioridad: newItem.prioridad || 'media',
      comentarios: newItem.comentarios || ''
    };

    if (editingItem) {
      const updatedItems = actionItems.map(item => 
        item.id === editingItem.id ? itemToSave : item
      );
      onActionItemsChange(updatedItems);
    } else {
      onActionItemsChange([...actionItems, itemToSave]);
    }

    setIsDialogOpen(false);
    setEditingItem(null);
  };

  const getStatusColor = (estado: string) => {
    switch (estado) {
      case 'completada': return '#4CAF50';
      case 'en_progreso': return '#2196F3';
      case 'pendiente': return '#FF9800';
      case 'cancelada': return '#F44336';
      default: return '#9E9E9E';
    }
  };

  const getPriorityColor = (prioridad: string) => {
    switch (prioridad) {
      case 'critica': return '#D32F2F';
      case 'alta': return '#F57C00';
      case 'media': return '#FFC107';
      case 'baja': return '#4CAF50';
      default: return '#9E9E9E';
    }
  };

  const getStatusIcon = (estado: string) => {
    switch (estado) {
      case 'completada': return '✅';
      case 'en_progreso': return '🔄';
      case 'pendiente': return '⏳';
      case 'cancelada': return '❌';
      default: return '❓';
    }
  };

  return (
    <Box>
      <Box display="flex" alignItems="center" justifyContent="space-between" mb={3}>
        <Box display="flex" alignItems="center">
          <AssignmentIcon sx={{ color: '#1E3A8A', mr: 1 }} />
          <Typography variant="h6" sx={{ color: '#1E3A8A', fontWeight: 'bold' }}>
            📋 Plan de Acción
          </Typography>
        </Box>
        
        {!readOnly && (
          <Button
            variant="contained"
            startIcon={<AddIcon />}
            onClick={handleAddItem}
            sx={{
              backgroundColor: '#1E3A8A',
              '&:hover': { backgroundColor: '#1E40AF' }
            }}
          >
            Agregar Acción
          </Button>
        )}
      </Box>

      {actionItems.length === 0 ? (
        <Card sx={{ p: 4, textAlign: 'center', backgroundColor: '#F8F9FA' }}>
          <Typography variant="body1" color="text.secondary">
            No hay acciones en el plan. {!readOnly && 'Haz clic en "Agregar Acción" para comenzar.'}
          </Typography>
        </Card>
      ) : (
        <Grid container spacing={2}>
          {actionItems.map((item, index) => (
            <Grid item xs={12} md={6} key={item.id}>
              <Card sx={{ height: '100%', position: 'relative' }}>
                <CardContent>
                  <Box display="flex" alignItems="center" justifyContent="space-between" mb={2}>
                    <Typography variant="h6" sx={{ color: '#1E3A8A', fontWeight: 'bold' }}>
                      {getStatusIcon(item.estado)} {item.titulo}
                    </Typography>
                    
                    {!readOnly && (
                      <Box>
                        <IconButton
                          size="small"
                          onClick={() => handleEditItem(item)}
                          sx={{ color: '#1E3A8A' }}
                        >
                          <EditIcon />
                        </IconButton>
                        <IconButton
                          size="small"
                          onClick={() => handleDeleteItem(item.id)}
                          sx={{ color: '#F44336' }}
                        >
                          <DeleteIcon />
                        </IconButton>
                      </Box>
                    )}
                  </Box>

                  <Typography variant="body2" color="text.secondary" sx={{ mb: 2 }}>
                    {item.descripcion}
                  </Typography>

                  <Box display="flex" flexWrap="wrap" gap={1} mb={2}>
                    <Chip
                      label={item.estado.replace('_', ' ').toUpperCase()}
                      size="small"
                      sx={{
                        backgroundColor: getStatusColor(item.estado),
                        color: 'white',
                        fontWeight: 'bold'
                      }}
                    />
                    <Chip
                      label={item.prioridad.toUpperCase()}
                      size="small"
                      sx={{
                        backgroundColor: getPriorityColor(item.prioridad),
                        color: 'white',
                        fontWeight: 'bold'
                      }}
                    />
                  </Box>

                  <Grid container spacing={1}>
                    {item.responsable && (
                      <Grid item xs={12}>
                        <Box display="flex" alignItems="center">
                          <PersonIcon sx={{ fontSize: 16, mr: 1, color: '#666' }} />
                          <Typography variant="body2" color="text.secondary">
                            <strong>Responsable:</strong> {item.responsable}
                          </Typography>
                        </Box>
                      </Grid>
                    )}
                    
                    {(item.fechaInicio || item.fechaFin) && (
                      <Grid item xs={12}>
                        <Box display="flex" alignItems="center">
                          <ScheduleIcon sx={{ fontSize: 16, mr: 1, color: '#666' }} />
                          <Typography variant="body2" color="text.secondary">
                            <strong>Período:</strong> {item.fechaInicio} - {item.fechaFin}
                          </Typography>
                        </Box>
                      </Grid>
                    )}
                    
                    {item.comentarios && (
                      <Grid item xs={12}>
                        <Typography variant="body2" color="text.secondary" sx={{ fontStyle: 'italic' }}>
                          <strong>Comentarios:</strong> {item.comentarios}
                        </Typography>
                      </Grid>
                    )}
                  </Grid>
                </CardContent>
              </Card>
            </Grid>
          ))}
        </Grid>
      )}

      {/* Dialog para editar/agregar acción */}
      <Dialog open={isDialogOpen} onClose={() => setIsDialogOpen(false)} maxWidth="md" fullWidth>
        <DialogTitle>
          {editingItem ? 'Editar Acción' : 'Agregar Nueva Acción'}
        </DialogTitle>
        
        <DialogContent>
          <Grid container spacing={2} sx={{ mt: 1 }}>
            <Grid item xs={12}>
              <TextField
                fullWidth
                label="Título de la Acción"
                value={newItem.titulo || ''}
                onChange={(e) => setNewItem({ ...newItem, titulo: e.target.value })}
                required
              />
            </Grid>
            
            <Grid item xs={12}>
              <TextField
                fullWidth
                multiline
                rows={3}
                label="Descripción"
                value={newItem.descripcion || ''}
                onChange={(e) => setNewItem({ ...newItem, descripcion: e.target.value })}
                required
              />
            </Grid>
            
            <Grid item xs={12} md={6}>
              <TextField
                fullWidth
                label="Responsable"
                value={newItem.responsable || ''}
                onChange={(e) => setNewItem({ ...newItem, responsable: e.target.value })}
              />
            </Grid>
            
            <Grid item xs={12} md={6}>
              <FormControl fullWidth>
                <InputLabel>Prioridad</InputLabel>
                <Select
                  value={newItem.prioridad || 'media'}
                  onChange={(e) => setNewItem({ ...newItem, prioridad: e.target.value as any })}
                  label="Prioridad"
                >
                  <MenuItem value="baja">Baja</MenuItem>
                  <MenuItem value="media">Media</MenuItem>
                  <MenuItem value="alta">Alta</MenuItem>
                  <MenuItem value="critica">Crítica</MenuItem>
                </Select>
              </FormControl>
            </Grid>
            
            <Grid item xs={12} md={6}>
              <TextField
                fullWidth
                type="date"
                label="Fecha de Inicio"
                value={newItem.fechaInicio || ''}
                onChange={(e) => setNewItem({ ...newItem, fechaInicio: e.target.value })}
                InputLabelProps={{ shrink: true }}
              />
            </Grid>
            
            <Grid item xs={12} md={6}>
              <TextField
                fullWidth
                type="date"
                label="Fecha de Finalización"
                value={newItem.fechaFin || ''}
                onChange={(e) => setNewItem({ ...newItem, fechaFin: e.target.value })}
                InputLabelProps={{ shrink: true }}
              />
            </Grid>
            
            <Grid item xs={12}>
              <TextField
                fullWidth
                multiline
                rows={2}
                label="Comentarios"
                value={newItem.comentarios || ''}
                onChange={(e) => setNewItem({ ...newItem, comentarios: e.target.value })}
              />
            </Grid>
          </Grid>
        </DialogContent>
        
        <DialogActions>
          <Button onClick={() => setIsDialogOpen(false)} startIcon={<CancelIcon />}>
            Cancelar
          </Button>
          <Button
            onClick={handleSaveItem}
            variant="contained"
            startIcon={<SaveIcon />}
            disabled={!newItem.titulo || !newItem.descripcion}
            sx={{ backgroundColor: '#1E3A8A' }}
          >
            {editingItem ? 'Actualizar' : 'Agregar'}
          </Button>
        </DialogActions>
      </Dialog>
    </Box>
  );
};

export default EditableActionPlan;


