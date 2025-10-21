import api from './api';

export interface Activo {
  ID_Activo: number;
  Nombre: string;
  Descripcion?: string;
  Tipo_Activo: string;
  subtipo_activo?: string;
  ID_Propietario?: number;
  ID_Custodio?: number;
  Nivel_Clasificacion_Confidencialidad: string;
  Nivel_Clasificacion_Integridad: string;
  Nivel_Clasificacion_Disponibilidad: string;
  justificacion_clasificacion_cia?: string;
  nivel_criticidad_negocio: string;
  estado_activo: string;
  fuente_datos_principal?: string;
  id_externo_glpi?: string;
  id_externo_inventario_si?: string;
  fecha_adquisicion?: string;
  version_general_activo?: string;
  requiere_backup: boolean;
  frecuencia_backup_general?: string;
  tiempo_retencion_general?: string;
  fecha_proxima_revision_sgsi?: string;
  procedimiento_eliminacion_segura_ref?: string;
  fecha_creacion_registro: string;
  fecha_ultima_actualizacion_sgsi?: string;
}

export interface CreateActivoData {
  Nombre: string;
  Descripcion?: string;
  Tipo_Activo: string;
  subtipo_activo?: string;
  ID_Propietario?: number;
  ID_Custodio?: number;
  Nivel_Clasificacion_Confidencialidad?: string;
  Nivel_Clasificacion_Integridad?: string;
  Nivel_Clasificacion_Disponibilidad?: string;
  justificacion_clasificacion_cia?: string;
  nivel_criticidad_negocio?: string;
  estado_activo?: string;
  fuente_datos_principal?: string;
  id_externo_glpi?: string;
  id_externo_inventario_si?: string;
  fecha_adquisicion?: string;
  version_general_activo?: string;
  requiere_backup?: boolean;
  frecuencia_backup_general?: string;
  tiempo_retencion_general?: string;
  fecha_proxima_revision_sgsi?: string;
  procedimiento_eliminacion_segura_ref?: string;
}

export interface UpdateActivoData extends Partial<CreateActivoData> {}

export const activosService = {
  // Obtener todos los activos con filtros opcionales
  async getActivos(filters?: {
    tipo_activo?: string;
    estado?: string;
    nivel_criticidad?: string;
  }): Promise<Activo[]> {
    const params = new URLSearchParams();
    if (filters?.tipo_activo) params.append('tipo_activo', filters.tipo_activo);
    if (filters?.estado) params.append('estado', filters.estado);
    if (filters?.nivel_criticidad) params.append('nivel_criticidad', filters.nivel_criticidad);

    const response = await api.get(`/activos/?${params.toString()}`);
    return response.data;
  },

  // Obtener un activo específico
  async getActivo(id: number): Promise<Activo> {
    const response = await api.get(`/activos/${id}`);
    return response.data;
  },

  // Crear un nuevo activo
  async createActivo(data: CreateActivoData): Promise<Activo> {
    const response = await api.post('/activos/', data);
    return response.data;
  },

  // Actualizar un activo
  async updateActivo(id: number, data: UpdateActivoData): Promise<Activo> {
    const response = await api.put(`/activos/${id}`, data);
    return response.data;
  },

  // Eliminar un activo
  async deleteActivo(id: number): Promise<void> {
    await api.delete(`/activos/${id}`);
  },

  // Obtener tipos de activo únicos
  async getTiposActivo(): Promise<string[]> {
    const response = await api.get('/activos/tipos');
    return response.data;
  },

  // Obtener estados de activo únicos
  async getEstadosActivo(): Promise<string[]> {
    const response = await api.get('/activos/estados');
    return response.data;
  },

  // Obtener riesgos asociados a un activo
  async getRiesgosActivo(activoId: number): Promise<any[]> {
    const response = await api.get(`/activos/${activoId}/riesgos`);
    return response.data;
  }
};