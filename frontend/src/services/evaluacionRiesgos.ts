import { apiRequest } from './api';

export interface NivelProbabilidad {
  id: number;
  nombre: string;
  valor: number;
  descripcion: string;
  color: string;
}

export interface NivelImpacto {
  id: number;
  nombre: string;
  valor: number;
  descripcion: string;
  color: string;
}

export interface ControlSeguridad {
  id: number;
  nombre: string;
  descripcion: string;
  categoria: string;
  tipo: string;
  eficacia_esperada: string;
}

export interface RiesgoPendiente {
  id: number;
  nombre: string;
  descripcion: string;
  tipo_riesgo: string;
  estado: string;
  fecha_identificacion: string;
}

export interface EvaluacionRiesgo {
  id_riesgo: number;
  id_activo: number;
  probabilidad_inherente: number;
  impacto_inherente: number;
  justificacion_inherente: string;
  probabilidad_residual?: number;
  impacto_residual?: number;
  justificacion_residual?: string;
}

export interface EstadisticasEvaluacion {
  total_riesgos: number;
  riesgos_evaluados: number;
  riesgos_pendientes: number;
  porcentaje_evaluacion: number;
  distribucion_niveles: { [key: string]: number };
}

export const evaluacionRiesgosService = {
  // Obtener niveles de probabilidad
  async getNivelesProbabilidad(): Promise<NivelProbabilidad[]> {
    try {
      return await apiRequest<NivelProbabilidad[]>('/evaluacion-riesgos/niveles-probabilidad');
    } catch (error) {
      console.error('Error fetching niveles probabilidad:', error);
      return [];
    }
  },

  // Obtener niveles de impacto
  async getNivelesImpacto(): Promise<NivelImpacto[]> {
    try {
      return await apiRequest<NivelImpacto[]>('/evaluacion-riesgos/niveles-impacto');
    } catch (error) {
      console.error('Error fetching niveles impacto:', error);
      return [];
    }
  },

  // Obtener controles de seguridad
  async getControles(): Promise<ControlSeguridad[]> {
    try {
      return await apiRequest<ControlSeguridad[]>('/evaluacion-riesgos/controles');
    } catch (error) {
      console.error('Error fetching controles:', error);
      return [];
    }
  },

  // Obtener riesgos pendientes de evaluación
  async getRiesgosPendientes(): Promise<RiesgoPendiente[]> {
    try {
      return await apiRequest<RiesgoPendiente[]>('/evaluacion-riesgos/riesgos-pendientes');
    } catch (error) {
      console.error('Error fetching riesgos pendientes:', error);
      return [];
    }
  },

  // Crear evaluación de riesgo
  async crearEvaluacion(evaluacion: EvaluacionRiesgo): Promise<any> {
    try {
      return await apiRequest('/evaluacion-riesgos/evaluar', {
        method: 'POST',
        body: JSON.stringify(evaluacion),
        headers: {
          'Content-Type': 'application/json',
        },
      });
    } catch (error) {
      console.error('Error creating evaluacion:', error);
      throw error;
    }
  },

  // Obtener matriz de riesgo
  async getMatrizRiesgo(): Promise<{ [key: string]: number }> {
    try {
      return await apiRequest<{ [key: string]: number }>('/evaluacion-riesgos/matriz-riesgo');
    } catch (error) {
      console.error('Error fetching matriz riesgo:', error);
      return {};
    }
  },

  // Obtener estadísticas de evaluación
  async getEstadisticas(): Promise<EstadisticasEvaluacion> {
    try {
      return await apiRequest<EstadisticasEvaluacion>('/evaluacion-riesgos/estadisticas');
    } catch (error) {
      console.error('Error fetching estadisticas:', error);
      return {
        total_riesgos: 0,
        riesgos_evaluados: 0,
        riesgos_pendientes: 0,
        porcentaje_evaluacion: 0,
        distribucion_niveles: {}
      };
    }
  },

  // Obtener todas las evaluaciones
  async getEvaluaciones(): Promise<any[]> {
    try {
      return await apiRequest<any[]>('/evaluacion-riesgos/evaluaciones');
    } catch (error) {
      console.error('Error fetching evaluaciones:', error);
      return [];
    }
  }
};





