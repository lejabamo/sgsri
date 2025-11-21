import React, { useState, useEffect } from 'react';
import EvaluationAvatar from '../../components/common/EvaluationAvatar';
import ISOSuggestions from '../../components/common/ISOSuggestions';
import {
  Box,
  Card,
  CardContent,
  Typography,
  Button,
  Stepper,
  Step,
  StepLabel,
  Grid,
  TextField,
  FormControl,
  InputLabel,
  Select,
  MenuItem,
  Chip,
  InputAdornment,
  Stack,
  Avatar,
  FormGroup,
  FormControlLabel,
  Checkbox,
  Dialog,
  DialogTitle,
  DialogContent,
  DialogActions,
  IconButton,
  List,
  ListItem,
  ListItemText,
  ListItemSecondaryAction,
  Autocomplete,
  Paper,
  Alert,
  Snackbar,
  Divider,
} from '@mui/material';
import {
  ArrowBack as ArrowBackIcon,
  ArrowForward as ArrowForwardIcon,
  Search as SearchIcon,
  Add as AddIcon,
  Security as SecurityIcon,
  Assessment as AssessmentIcon,
  Delete as DeleteIcon,
  Edit as EditIcon,
  Assignment as AssignmentIcon,
  Download as DownloadIcon,
  Save as SaveIcon,
  CheckCircle as CheckCircleIcon,
  Warning as WarningIcon,
  Info as InfoIcon,
  Email as EmailIcon,
  Phone as PhoneIcon,
  Send as SendIcon,
  Task as TaskIcon,
  PictureAsPdf as PdfIcon,
  Description as WordIcon,
  TableChart as ExcelIcon,
  Image as ImageIcon,
  InsertDriveFile as FileIcon,
  TrendingUp as TrendingUpIcon,
  Visibility as VisibilityIcon,
} from '@mui/icons-material';
import jsPDF from 'jspdf';
import html2canvas from 'html2canvas';
import * as XLSX from 'xlsx';
import { saveAs } from 'file-saver';
import { useQuery, useQueryClient } from '@tanstack/react-query';
import { toast } from 'react-hot-toast';
import { activosService } from '../../services/activos';
import { evaluacionRiesgosService } from '../../services/evaluacionRiesgos';
import RiskMatrix from '../../components/common/RiskMatrix';
import InherentEvaluationStep from '../../components/wizard/InherentEvaluationStep';
import ActivoDetailCard from '../../components/activos/ActivoDetailCard';
import DocumentManager from '../../components/common/DocumentManager';
import type { DocumentoAdjunto, AccionPlan } from '../../services/documentos';
import { documentosService } from '../../services/documentos';
import InteractiveSuggestions from '../../components/predictive/InteractiveSuggestions';
import ControlSuggestions from '../../components/predictive/ControlSuggestions';
import JustificationSuggestions from '../../components/predictive/JustificationSuggestions';
import ResidualRiskSuggestions from '../../components/predictive/ResidualRiskSuggestions';
import CurrencyInput from '../../components/common/CurrencyInput';
import DateRangeInput from '../../components/common/DateRangeInput';
import CriticityCalculator from '../../components/common/CriticityCalculator';
import ThreatVulnerabilityLink from '../../components/common/ThreatVulnerabilityLink';
import EditableActionPlan from '../../components/common/EditableActionPlan';
import TwinAssetSuggestion from '../../components/common/TwinAssetSuggestion';
import '../../styles/design-system.css';

interface WizardData {
  selectedActivo: any;
  newRiesgo: {
    amenaza: string;
    vulnerabilidad: string;
    descripcion: string;
    tipoRiesgo: string;
  };
  evaluacionInherente: {
    probabilidad: string;
    impacto: string;
    nivelRiesgo: string;
    justificacion: string;
  };
  controles: {
    seleccionados: string[];
    eficacia: string;
    justificacion: string;
  };
  evaluacionResidual: {
    probabilidad: string;
    impacto: string;
    nivelRiesgo: string;
    justificacion: string;
  };
  tratamiento: {
    opcion: string;
    responsable: string;
    fechaInicio: string;
    fechaFin: string;
    presupuesto: string;
  };
  planAccion: {
    acciones: AccionPlan[];
  };
}

const RiskAssessmentWizard: React.FC = () => {
  const queryClient = useQueryClient();
  const [activeStep, setActiveStep] = useState(0);
  const [wizardData, setWizardData] = useState<WizardData>({
    selectedActivo: null,
    newRiesgo: { amenaza: '', vulnerabilidad: '', descripcion: '', tipoRiesgo: '' },
    evaluacionInherente: { probabilidad: '', impacto: '', nivelRiesgo: '', justificacion: '' },
    controles: { seleccionados: [], eficacia: '', justificacion: '' },
    evaluacionResidual: { probabilidad: '', impacto: '', nivelRiesgo: '', justificacion: '' },
    tratamiento: { opcion: '', responsable: '', fechaInicio: '', fechaFin: '', presupuesto: '' },
    planAccion: { acciones: [] }
  });

  const [searchTerm, setSearchTerm] = useState('');
  const [openDialog, setOpenDialog] = useState(false);
  const [openDetailDialog, setOpenDetailDialog] = useState(false);
  const [openRiesgoDialog, setOpenRiesgoDialog] = useState(false);
  const [selectedActivoDetail, setSelectedActivoDetail] = useState(null);
  const [formData, setFormData] = useState({
    nombre: '',
    descripcion: '',
    tipo: '',
    estado: 'Planificado',
    criticidad: 'Medio',
  });
  
  // Función para mapear formData a CreateActivoData
  const mapFormDataToCreateActivoData = (data: typeof formData) => {
    return {
      Nombre: data.nombre,
      Descripcion: data.descripcion || undefined,
      Tipo_Activo: data.tipo,
      estado_activo: data.estado,
      nivel_criticidad_negocio: data.criticidad,
    };
  };
  const [riesgoFormData, setRiesgoFormData] = useState({
    nombre: '',
    amenaza: '',
    vulnerabilidad: '',
    descripcion: '',
  });
  const [tiposRiesgo, setTiposRiesgo] = useState<string[]>([]);
  const [riesgosExistentes, setRiesgosExistentes] = useState([
    'Malware en servidores críticos',
    'Ataques de phishing a usuarios',
    'Acceso no autorizado a bases de datos',
    'Pérdida de datos por fallos de hardware',
    'Interrupción del servicio por ataques DDoS',
    'Vulnerabilidades en software desactualizado',
    'Acceso físico no controlado a equipos',
    'Falta de respaldo de información crítica'
  ]);

  const [actionPlanItems, setActionPlanItems] = useState<any[]>([]);
  const [criticityData, setCriticityData] = useState({
    confidencialidad: 3,
    disponibilidad: 3,
    integridad: 3,
    promedio: 3,
    clasificacion: 'Media'
  });
  const [openAccionDialog, setOpenAccionDialog] = useState(false);
  const [newAccion, setNewAccion] = useState<AccionPlan>({
    id: '',
    descripcion: '',
    responsable: '',
    fechaInicio: '',
    fechaFin: '',
    estado: 'Pendiente',
    comentarios: '',
    documentos: []
  });
  const [isEvaluacionCompletada, setIsEvaluacionCompletada] = useState(false);
  const [isExportando, setIsExportando] = useState(false);
  const [openNotificacionDialog, setOpenNotificacionDialog] = useState(false);
  const [showSuccessMessage, setShowSuccessMessage] = useState(false);
  const [showExportMessage, setShowExportMessage] = useState(false);
  const [openSummaryDialog, setOpenSummaryDialog] = useState(false);
  const [evaluacionesCompletadas, setEvaluacionesCompletadas] = useState<{[key: string]: any}>({});
  const [exportMessage, setExportMessage] = useState('');

  // Cargar tipos de riesgo disponibles
  useEffect(() => {
    const cargarTiposRiesgo = async () => {
      try {
        const { apiRequest } = await import('../../services/api');
        const tipos = await apiRequest<string[]>('/riesgos/tipos');
        setTiposRiesgo(tipos || []);
      } catch (error) {
        console.error('Error cargando tipos de riesgo:', error);
        // Valores por defecto si falla la carga
        setTiposRiesgo(['Operacional', 'Tecnológico', 'Legal', 'Estratégico', 'Financiero', 'Reputacional']);
      }
    };
    
    cargarTiposRiesgo();
  }, []);

  // Cargar evaluaciones completadas desde la base de datos
  useEffect(() => {
    let isMounted = true;
    
    const cargarEvaluacionesCompletadas = async () => {
      try {
        const { evaluacionRiesgosService } = await import('../../services/evaluacionRiesgos');
        const evaluaciones = await evaluacionRiesgosService.getEvaluacionesCompletadas();
        
        if (isMounted) {
          setEvaluacionesCompletadas(evaluaciones);
        }
      } catch (error) {
        console.error('Error cargando evaluaciones completadas:', error);
        // En caso de error, usar datos vacíos para evitar loops
        if (isMounted) {
          setEvaluacionesCompletadas({});
        }
      }
    };
    
    cargarEvaluacionesCompletadas();
    
    return () => {
      isMounted = false;
    };
  }, []); // Dependencias vacías para evitar loops

  // Función para guardar evaluación parcial
  const guardarEvaluacionParcial = async (activoId: number, progreso: number) => {
    try {
      // Guardar en localStorage como respaldo
      const datosParciales = {
        activo_id: activoId,
        wizard_data: wizardData,
        progreso: progreso,
        fecha_guardado: new Date().toISOString()
      };
      
      localStorage.setItem(`evaluacion_parcial_${activoId}`, JSON.stringify(datosParciales));
      
      // Intentar guardar en el backend también
      try {
        const { evaluacionRiesgosService } = await import('../../services/evaluacionRiesgos');
        await evaluacionRiesgosService.guardarEvaluacionParcial(activoId, wizardData, progreso);
        console.log('Evaluación parcial guardada en backend exitosamente');
      } catch (backendError) {
        console.warn('No se pudo guardar en backend, usando localStorage:', backendError);
        // No lanzar error para evitar loops
      }
      
      console.log('Evaluación parcial guardada exitosamente');
    } catch (error) {
      console.error('Error guardando evaluación parcial:', error);
    }
  };

  // Función para cargar evaluación parcial
  const cargarEvaluacionParcial = async (activoId: number) => {
    try {
      // Primero intentar cargar desde localStorage
      const evaluacionParcialGuardada = localStorage.getItem(`evaluacion_parcial_${activoId}`);
      if (evaluacionParcialGuardada) {
        const datosParciales = JSON.parse(evaluacionParcialGuardada);
        setWizardData(datosParciales.wizard_data);
        // Calcular el paso actual basado en el progreso
        const pasoActual = Math.floor(datosParciales.progreso / 20);
        setActiveStep(pasoActual);
        console.log('Evaluación parcial cargada desde localStorage exitosamente');
        return;
      }
      
      // Si no hay datos en localStorage, intentar cargar desde backend
      const { evaluacionRiesgosService } = await import('../../services/evaluacionRiesgos');
      const evaluacionParcial = await evaluacionRiesgosService.obtenerEvaluacionParcial(activoId);
      
      if (evaluacionParcial.existe) {
        setWizardData(evaluacionParcial.wizard_data);
        // Calcular el paso actual basado en el progreso
        const pasoActual = Math.floor(evaluacionParcial.progreso / 20);
        setActiveStep(pasoActual);
        console.log('Evaluación parcial cargada desde backend exitosamente');
      }
    } catch (error) {
      console.error('Error cargando evaluación parcial:', error);
    }
  };

  const { data: activos = [] } = useQuery({
    queryKey: ['activos'],
    queryFn: async () => {
      try {
        const { activosService } = await import('../../services/backend');
        return await activosService.getAll();
      } catch (error) {
        console.error('Error fetching activos:', error);
        // Retornar array vacío en caso de error - NO usar datos hardcodeados
        return [];
      }
    }
  });

  // Cargar controles de la base de datos
  const { data: controlesBD = [] } = useQuery({
    queryKey: ['controles'],
    queryFn: async () => {
      try {
        return await evaluacionRiesgosService.getControles();
      } catch (error) {
        console.error('Error fetching controles:', error);
        return [];
      }
    }
  });

  // Estado para control manual
  const [nuevoControlManual, setNuevoControlManual] = useState('');
  const [mostrarInputManual, setMostrarInputManual] = useState(false);

  const steps = [
    'Selección de Activo',
    'Identificación de Riesgo',
    'Evaluación Inherente',
    'Controles Existentes',
    'Evaluación Residual',
    'Opciones de Tratamiento',
    'Plan de Acción',
    'Resultados Finales'
  ];

  const filteredActivos = activos.filter(activo => {
    if (!activo || !searchTerm) return true;
    const nombre = activo.nombre || activo.Nombre || activo.Nombre_Activo || '';
    return nombre.toLowerCase().includes(searchTerm.toLowerCase());
  });

  const handleNext = () => {
    // Validación específica para el paso 1 (Identificación de Riesgo)
    if (activeStep === 1) {
      if (!wizardData.newRiesgo.amenaza || !wizardData.newRiesgo.vulnerabilidad) {
        toast.error('Por favor, completa la amenaza y vulnerabilidad antes de continuar');
        return;
      }
      // Validar tipo de riesgo si es obligatorio
      if (!wizardData.newRiesgo.tipoRiesgo) {
        toast.error('El tipo de riesgo es obligatorio. Por favor, selecciona un tipo de riesgo.');
        return;
      }
    }
    
    // Validación para el paso 3 (Controles Existentes) - OBLIGATORIO
    if (activeStep === 3) {
      if (!wizardData.controles.seleccionados || wizardData.controles.seleccionados.length === 0) {
        toast.error('⚠️ Es obligatorio seleccionar al menos un control. Puedes elegir controles de la base de datos, sugerencias ISO 27001/27002/27005, o agregar uno manualmente.');
        return;
      }
      if (!wizardData.controles.eficacia) {
        toast.error('Por favor, selecciona el nivel de eficacia de los controles.');
        return;
      }
    }
    
    if (activeStep < steps.length - 1) {
      setActiveStep(activeStep + 1);
    }
  };

  const handleBack = () => {
    if (activeStep > 0) {
      setActiveStep(activeStep - 1);
    }
  };

  const handleActivoSelect = (activo: any) => {
    const evaluacionEstado = getEvaluacionEstado(activo);
    
    // Si el activo ya está completamente evaluado, mostrar resumen
    if (evaluacionEstado.estado === 'completa' && evaluacionEstado.evaluacion) {
      setSelectedActivoDetail(activo);
      setOpenSummaryDialog(true);
      return;
    }
    
    // Si hay evaluación parcial, preguntar si continuar
    if (evaluacionEstado.estado === 'parcial' && evaluacionEstado.puedeContinuar) {
      const continuar = window.confirm(
        `Este activo tiene una evaluación parcial (${evaluacionEstado.porcentaje}% completado). ¿Desea continuar desde donde se quedó?`
      );
      
      if (continuar) {
        cargarEvaluacionParcial(activo.ID_Activo || activo.id);
        return;
      }
    }
    
    // Si no está evaluado o se cancela continuar, iniciar wizard desde cero
    setWizardData({ ...wizardData, selectedActivo: activo });
    setSelectedActivoDetail(activo);
    setOpenDetailDialog(true);
  };

  const handleCloseDialog = () => {
    setOpenDialog(false);
    setFormData({
      nombre: '',
      descripcion: '',
      tipo: '',
      estado: 'Planificado',
      criticidad: 'Medio',
    });
  };

  const handleCreateActivo = async () => {
    try {
      // Validaciones
      if (!formData.nombre || !formData.nombre.trim()) {
        toast.error('❌ El nombre del activo es obligatorio');
        return;
      }
      if (!formData.tipo) {
        toast.error('❌ El tipo de activo es obligatorio');
        return;
      }
      
      // Mapear formData a CreateActivoData
      const activoData = mapFormDataToCreateActivoData(formData);
      
      console.log('Creating activo with data:', activoData);
      
      // Usar el servicio correcto
      const nuevoActivo = await activosService.createActivo(activoData);
      
      console.log('Activo creado exitosamente:', nuevoActivo);
      
      toast.success('✅ Activo creado exitosamente');
      
      // Cerrar el diálogo
      handleCloseDialog();
      
      // Resetear el formulario
      setFormData({
        nombre: '',
        descripcion: '',
        tipo: '',
        estado: 'Planificado',
        criticidad: 'Medio',
      });
      
      // Recargar la página para mostrar el nuevo activo
      window.location.reload();
    } catch (error: any) {
      console.error('Error al crear activo:', error);
      let errorMessage = 'Error desconocido';
      
      if (error.response) {
        errorMessage = error.response.data?.error || error.response.data?.message || `Error ${error.response.status}: ${error.response.statusText}`;
      } else if (error.request) {
        errorMessage = 'No se pudo conectar con el servidor. Verifica que el backend esté corriendo.';
      } else {
        errorMessage = error.message || 'Error desconocido';
      }
      
      toast.error(`❌ Error al crear activo: ${errorMessage}`);
    }
  };

  const handleCloseRiesgoDialog = () => {
    setOpenRiesgoDialog(false);
    setRiesgoFormData({
      nombre: '',
      amenaza: '',
      vulnerabilidad: '',
      descripcion: '',
    });
  };

  const handleCreateRiesgo = () => {
    // Crear el nombre del riesgo combinando amenaza y vulnerabilidad
    const nombreRiesgo = `${riesgoFormData.amenaza} - ${riesgoFormData.vulnerabilidad}`;
    
    // Agregar el nuevo riesgo a la lista de riesgos existentes
    setRiesgosExistentes(prev => [...prev, nombreRiesgo]);
    
    // Actualizar el wizard data con el nuevo riesgo
    setWizardData({
      ...wizardData,
      newRiesgo: {
        amenaza: riesgoFormData.amenaza,
        vulnerabilidad: riesgoFormData.vulnerabilidad,
        descripcion: riesgoFormData.descripcion
      }
    });
    
    // Limpiar el formulario
    setRiesgoFormData({
      nombre: '',
      amenaza: '',
      vulnerabilidad: '',
      descripcion: '',
    });
    
    handleCloseRiesgoDialog();
  };

  const calculateRiskLevel = (probabilidad: string, impacto: string) => {
    const matrix: { [key: string]: { [key: string]: string } } = {
      'Frecuente': { 
        'Insignificante': 'MEDIUM', 'Menor': 'MEDIUM', 'Moderado': 'HIGH', 
        'Mayor': 'HIGH', 'Catastrófico': 'HIGH' 
      },
      'Probable': { 
        'Insignificante': 'LOW', 'Menor': 'MEDIUM', 'Moderado': 'MEDIUM', 
        'Mayor': 'HIGH', 'Catastrófico': 'HIGH' 
      },
      'Ocasional': { 
        'Insignificante': 'LOW', 'Menor': 'MEDIUM', 'Moderado': 'MEDIUM', 
        'Mayor': 'HIGH', 'Catastrófico': 'HIGH' 
      },
      'Posible': { 
        'Insignificante': 'LOW', 'Menor': 'LOW', 'Moderado': 'MEDIUM', 
        'Mayor': 'HIGH', 'Catastrófico': 'HIGH' 
      },
      'Improbable': { 
        'Insignificante': 'LOW', 'Menor': 'LOW', 'Moderado': 'LOW', 
        'Mayor': 'LOW', 'Catastrófico': 'MEDIUM' 
      }
    };
    return matrix[probabilidad]?.[impacto] || 'LOW';
  };

  const getRiskColor = (nivel: string) => {
    const colors: { [key: string]: string } = {
      'LOW': '#10B981',
      'MEDIUM': '#F59E0B',
      'HIGH': '#EF4444'
    };
    return colors[nivel] || '#6B7280';
  };

  const addAccion = () => {
    const accion = {
      ...newAccion,
      id: Date.now().toString()
    };
    setWizardData({
      ...wizardData,
      planAccion: {
        acciones: [...wizardData.planAccion.acciones, accion]
      }
    });
    setNewAccion({
      id: '',
      descripcion: '',
      responsable: '',
      fechaInicio: '',
      fechaFin: '',
      estado: 'Pendiente',
      comentarios: '',
      documentos: []
    });
    setOpenAccionDialog(false);
  };

  const deleteAccion = (id: string) => {
    setWizardData({
      ...wizardData,
      planAccion: {
        acciones: wizardData.planAccion.acciones.filter(accion => accion.id !== id)
      }
    });
  };

  // Función para exportar a PDF
  const exportToPDF = async () => {
    setIsExportando(true);
    try {
      const element = document.getElementById('wizard-content');
      if (!element) return;

      const canvas = await html2canvas(element, {
        scale: 2,
        useCORS: true,
        allowTaint: true
      });

      const imgData = canvas.toDataURL('image/png');
      const pdf = new jsPDF('p', 'mm', 'a4');
      const imgWidth = 210;
      const pageHeight = 295;
      const imgHeight = (canvas.height * imgWidth) / canvas.width;
      let heightLeft = imgHeight;

      let position = 0;

      pdf.addImage(imgData, 'PNG', 0, position, imgWidth, imgHeight);
      heightLeft -= pageHeight;

      while (heightLeft >= 0) {
        position = heightLeft - imgHeight;
        pdf.addPage();
        pdf.addImage(imgData, 'PNG', 0, position, imgWidth, imgHeight);
        heightLeft -= pageHeight;
      }

      pdf.save('evaluacion-riesgo.pdf');
      setExportMessage('Evaluación exportada a PDF exitosamente');
      setShowExportMessage(true);
    } catch (error) {
      console.error('Error al exportar PDF:', error);
      setExportMessage('Error al exportar PDF');
      setShowExportMessage(true);
    } finally {
      setIsExportando(false);
    }
  };

  // Función para exportar a Excel
  const exportToExcel = () => {
    setIsExportando(true);
    try {
      const workbook = XLSX.utils.book_new();
      
      // Hoja de resumen
      const resumenData = [
        ['Evaluación de Riesgo de Activos de Información'],
        [''],
        ['Activo Seleccionado:', wizardData.selectedActivo?.Nombre || wizardData.selectedActivo?.nombre || 'No seleccionado'],
        ['Tipo de Activo:', wizardData.selectedActivo?.Tipo_Activo || wizardData.selectedActivo?.tipo || 'No especificado'],
        [''],
        ['Riesgo Identificado:', wizardData.newRiesgo.descripcion || 'No especificado'],
        ['Amenaza:', wizardData.newRiesgo.amenaza || 'No especificada'],
        ['Vulnerabilidad:', wizardData.newRiesgo.vulnerabilidad || 'No especificada'],
        [''],
        ['Evaluación Inherente:'],
        ['Probabilidad:', wizardData.evaluacionInherente.probabilidad],
        ['Impacto:', wizardData.evaluacionInherente.impacto],
        ['Nivel de Riesgo:', wizardData.evaluacionInherente.nivelRiesgo],
        ['Justificación:', wizardData.evaluacionInherente.justificacion],
        [''],
        ['Evaluación Residual:'],
        ['Probabilidad:', wizardData.evaluacionResidual.probabilidad],
        ['Impacto:', wizardData.evaluacionResidual.impacto],
        ['Nivel de Riesgo:', wizardData.evaluacionResidual.nivelRiesgo],
        ['Justificación:', wizardData.evaluacionResidual.justificacion],
        [''],
        ['Opciones de Tratamiento:'],
        ['Opción:', wizardData.tratamiento.opcion],
        ['Responsable:', wizardData.tratamiento.responsable],
        ['Fecha Inicio:', wizardData.tratamiento.fechaInicio],
        ['Fecha Fin:', wizardData.tratamiento.fechaFin],
        ['Presupuesto:', wizardData.tratamiento.presupuesto],
      ];

      const resumenSheet = XLSX.utils.aoa_to_sheet(resumenData);
      XLSX.utils.book_append_sheet(workbook, resumenSheet, 'Resumen');

      // Hoja de controles
      if (wizardData.controles.seleccionados.length > 0) {
        const controlesData = [
          ['Controles Seleccionados', 'Eficacia', 'Justificación'],
          ...wizardData.controles.seleccionados.map(control => [
            control,
            wizardData.controles.efficacy,
            wizardData.controles.justification
          ])
        ];
        const controlesSheet = XLSX.utils.aoa_to_sheet(controlesData);
        XLSX.utils.book_append_sheet(workbook, controlesSheet, 'Controles');
      }

      // Hoja de plan de acción
      if (wizardData.planAccion.acciones.length > 0) {
        const accionesData = [
          ['Descripción', 'Responsable', 'Fecha Inicio', 'Fecha Fin', 'Estado', 'Comentarios'],
          ...wizardData.planAccion.acciones.map(accion => [
            accion.descripcion,
            accion.responsable,
            accion.fechaInicio,
            accion.fechaFin,
            accion.estado,
            accion.comentarios
          ])
        ];
        const accionesSheet = XLSX.utils.aoa_to_sheet(accionesData);
        XLSX.utils.book_append_sheet(workbook, accionesSheet, 'Plan de Acción');
      }

      XLSX.writeFile(workbook, 'evaluacion-riesgo.xlsx');
      setExportMessage('Evaluación exportada a Excel exitosamente');
      setShowExportMessage(true);
    } catch (error) {
      console.error('Error al exportar Excel:', error);
      setExportMessage('Error al exportar Excel');
      setShowExportMessage(true);
    } finally {
      setIsExportando(false);
    }
  };

  // Función para guardar evaluación
  const guardarEvaluacion = async () => {
    setIsExportando(true);
    try {
      const activoId = wizardData.selectedActivo?.ID_Activo || wizardData.selectedActivo?.id;
      if (!activoId) {
        throw new Error('No hay activo seleccionado');
      }

      // Obtener el ID del riesgo (siempre creamos uno nuevo desde newRiesgo)
      let riesgoId = null;
      
      // Crear el riesgo nuevo
      // Verificar si hay amenaza y vulnerabilidad (requisitos mínimos para crear un riesgo)
      if (wizardData.newRiesgo.amenaza && wizardData.newRiesgo.vulnerabilidad) {
        try {
          const { apiRequest } = await import('../../services/api');
          // Generar nombre y descripción del riesgo
          const nombreRiesgo = wizardData.newRiesgo.descripcion 
            ? wizardData.newRiesgo.descripcion 
            : `${wizardData.newRiesgo.amenaza} - ${wizardData.newRiesgo.vulnerabilidad}`;
          const descripcionRiesgo = wizardData.newRiesgo.descripcion 
            ? wizardData.newRiesgo.descripcion 
            : `Riesgo asociado a la amenaza "${wizardData.newRiesgo.amenaza}" y la vulnerabilidad "${wizardData.newRiesgo.vulnerabilidad}"`;
          
          const nuevoRiesgo = await apiRequest<any>('/riesgos/', {
            method: 'POST',
            headers: { 'Content-Type': 'application/json' },
            body: JSON.stringify({
              Nombre: nombreRiesgo,
              Descripcion: descripcionRiesgo,
              tipo_riesgo: wizardData.newRiesgo.tipoRiesgo || null,
              Estado_Riesgo_General: 'Identificado',
            }),
          });
          riesgoId = nuevoRiesgo.ID_Riesgo || nuevoRiesgo.id;
        } catch (error: any) {
          console.error('Error creando riesgo:', error);
          const errorMessage = error?.message || 'No se pudo crear el riesgo';
          throw new Error(errorMessage);
        }
      }

      if (!riesgoId) {
        throw new Error('No hay riesgo seleccionado o creado');
      }

      // Obtener IDs de probabilidad e impacto inherente
      const { evaluacionRiesgosService } = await import('../../services/evaluacionRiesgos');
      const nivelesProb = await evaluacionRiesgosService.getNivelesProbabilidad();
      const nivelesImp = await evaluacionRiesgosService.getNivelesImpacto();
      
      // Mapeo de valores del wizard a valores de la base de datos
      // La BD tiene: 'Alto', 'Bajo', 'Medio', 'Muy Alto', 'Muy Bajo'
      // El wizard usa: 'Frecuente', 'Probable', 'Ocasional', 'Posible', 'Improbable'
      const probabilidadMapping: { [key: string]: string[] } = {
        'Frecuente': ['Muy Alto', 'Alto'],
        'Probable': ['Alto', 'Medio'],
        'Ocasional': ['Medio'],
        'Posible': ['Bajo', 'Medio'],
        'Improbable': ['Muy Bajo', 'Bajo']
      };
      
      // Función helper para normalizar nombres (case-insensitive, sin acentos, sin espacios extra)
      const normalizeName = (name: string) => {
        return name?.toLowerCase().trim().normalize('NFD').replace(/[\u0300-\u036f]/g, '') || '';
      };
      
      // Buscar probabilidad usando el mapeo
      const probWizardValue = wizardData.evaluacionInherente.probabilidad;
      const probDbNames = probabilidadMapping[probWizardValue] || [probWizardValue];
      const probInherente = nivelesProb.find(p => 
        probDbNames.some(dbName => normalizeName(p.nombre) === normalizeName(dbName))
      );
      
      // Los impactos coinciden directamente
      const impInherente = nivelesImp.find(i => 
        normalizeName(i.nombre) === normalizeName(wizardData.evaluacionInherente.impacto)
      );

      if (!probInherente || !impInherente) {
        console.error('Niveles disponibles - Probabilidad:', nivelesProb.map(p => p.nombre));
        console.error('Niveles disponibles - Impacto:', nivelesImp.map(i => i.nombre));
        console.error('Valores buscados - Probabilidad:', wizardData.evaluacionInherente.probabilidad);
        console.error('Valores buscados - Impacto:', wizardData.evaluacionInherente.impacto);
        throw new Error(`Niveles de probabilidad o impacto no válidos. Probabilidad buscada: "${wizardData.evaluacionInherente.probabilidad}", Impacto buscado: "${wizardData.evaluacionInherente.impacto}"`);
      }

      // Crear evaluación inherente
      const evaluacionData: any = {
        id_riesgo: riesgoId,
        id_activo: activoId,
        probabilidad_inherente: probInherente.id,
        impacto_inherente: impInherente.id,
        justificacion_inherente: wizardData.evaluacionInherente.justificacion || '',
      };

      // Si hay evaluación residual, agregarla
      if (wizardData.evaluacionResidual.probabilidad && wizardData.evaluacionResidual.impacto) {
        const probResidualWizardValue = wizardData.evaluacionResidual.probabilidad;
        const probResidualDbNames = probabilidadMapping[probResidualWizardValue] || [probResidualWizardValue];
        const probResidual = nivelesProb.find(p => 
          probResidualDbNames.some(dbName => normalizeName(p.nombre) === normalizeName(dbName))
        );
        const impResidual = nivelesImp.find(i => 
          normalizeName(i.nombre) === normalizeName(wizardData.evaluacionResidual.impacto)
        );

        if (probResidual && impResidual) {
          evaluacionData.probabilidad_residual = probResidual.id;
          evaluacionData.impacto_residual = impResidual.id;
          evaluacionData.justificacion_residual = wizardData.evaluacionResidual.justificacion || '';
        }
      }

      // Guardar evaluación en el backend
      const evaluacionResult = await evaluacionRiesgosService.crearEvaluacion(evaluacionData);
      const idEvaluacion = evaluacionResult.id;

      // Guardar controles si hay
      if (wizardData.controles.seleccionados && wizardData.controles.seleccionados.length > 0) {
        try {
          const { apiRequest } = await import('../../services/api');
          await apiRequest('/controles-evaluacion/guardar-controles-evaluacion', {
            method: 'POST',
            headers: { 'Content-Type': 'application/json' },
            body: JSON.stringify({
              id_evaluacion_riesgo_activo: idEvaluacion,
              controles: wizardData.controles.seleccionados.map((ctrl: any) => ({
                ID_Control: ctrl.ID_Control || ctrl.id,
                justificacion: ctrl.justificacion || wizardData.controles.justificacion || '',
                eficacia: ctrl.eficacia || wizardData.controles.eficacia || 'Media',
              })),
            }),
          });
        } catch (ctrlError) {
          console.warn('Error guardando controles:', ctrlError);
          // No fallar la evaluación completa si falla guardar controles
        }
      }

      // Guardar plan de acción con documentos si hay
      if (wizardData.planAccion.acciones && wizardData.planAccion.acciones.length > 0) {
        try {
          const { apiRequest } = await import('../../services/api');
          await apiRequest('/evaluacion-riesgos/guardar-plan-accion', {
            method: 'POST',
            headers: { 'Content-Type': 'application/json' },
            body: JSON.stringify({
              id_evaluacion: idEvaluacion,
              id_activo: activoId,
              acciones: wizardData.planAccion.acciones.map((accion: any) => ({
                id: accion.id,
                titulo: accion.titulo || accion.descripcion,
                descripcion: accion.descripcion,
                responsable: accion.responsable || wizardData.tratamiento.responsable,
                fechaInicio: accion.fechaInicio || wizardData.tratamiento.fechaInicio,
                fechaFin: accion.fechaFin || wizardData.tratamiento.fechaFin,
                estado: accion.estado || 'pendiente',
                comentarios: accion.comentarios || '',
                documentos: accion.documentos || []
              }))
            }),
          });
        } catch (planError) {
          console.warn('Error guardando plan de acción:', planError);
          // No fallar la evaluación completa si falla guardar plan de acción
        }
      }

      // Guardar la evaluación en el estado local
      setEvaluacionesCompletadas(prev => ({
        ...prev,
        [activoId]: {
          activo: wizardData.selectedActivo,
          evaluacion: wizardData,
          fechaCompletada: new Date().toISOString(),
          completada: true,
          idEvaluacion: idEvaluacion,
        }
      }));

      // Limpiar evaluación parcial guardada
      localStorage.removeItem(`evaluacion_parcial_${activoId}`);

      setIsEvaluacionCompletada(true);
      setShowSuccessMessage(true);
      setExportMessage('Evaluación guardada exitosamente en la base de datos');
      setShowExportMessage(true);
      
      // Invalidar caché de React Query para actualizar dashboard y otros componentes
      queryClient.invalidateQueries({ queryKey: ['dashboard'] });
      queryClient.invalidateQueries({ queryKey: ['activos'] });
      queryClient.invalidateQueries({ queryKey: ['evaluaciones'] });
      queryClient.invalidateQueries({ queryKey: ['estadisticas'] });
      
      // Recargar la página después de 2 segundos para reflejar los cambios
      setTimeout(() => {
        window.location.reload();
      }, 2000);
    } catch (error: any) {
      console.error('Error al guardar:', error);
      setExportMessage(`Error al guardar la evaluación: ${error.message || 'Error desconocido'}`);
      setShowExportMessage(true);
      toast.error(`Error al guardar: ${error.message || 'Error desconocido'}`);
    } finally {
      setIsExportando(false);
    }
  };

  // Función para finalizar evaluación
  const finalizarEvaluacion = () => {
    if (isEvaluacionCompletada) {
      // Redirigir al dashboard o mostrar mensaje de éxito
      setShowSuccessMessage(true);
      setExportMessage('¡Evaluación completada exitosamente!');
      setShowExportMessage(true);
    } else {
      // Primero guardar, luego finalizar
      guardarEvaluacion();
    }
  };

  // Función para exportar resumen a PDF
  const exportarResumenPDF = async (evaluacion: any, activo: any) => {
    setIsExportando(true);
    try {
      // Usar wizardData si no hay evaluación guardada
      const datosEvaluacion = evaluacion?.evaluacion || evaluacion || wizardData;
      
      // Debug logging
      console.log('Generando PDF con datos:', {
        evaluacion: datosEvaluacion,
        activo: activo,
        evaluacionKeys: Object.keys(datosEvaluacion || {}),
        activoKeys: Object.keys(activo || {})
      });
      
      const pdf = new jsPDF();
      const pageWidth = pdf.internal.pageSize.getWidth();
      const pageHeight = pdf.internal.pageSize.getHeight();
      let yPosition = 20;

      // Título
      pdf.setFontSize(20);
      pdf.setFont('helvetica', 'bold');
      pdf.text('Resumen de Evaluación de Riesgo', pageWidth / 2, yPosition, { align: 'center' });
      yPosition += 20;

      // Información del activo
      pdf.setFontSize(14);
      pdf.setFont('helvetica', 'bold');
      pdf.text('Activo Evaluado:', 20, yPosition);
      yPosition += 10;
      
      pdf.setFontSize(12);
      pdf.setFont('helvetica', 'normal');
      pdf.text(`Nombre: ${activo?.Nombre || activo?.nombre || 'N/A'}`, 20, yPosition);
      yPosition += 8;
      pdf.text(`Tipo: ${activo?.Tipo_Activo || activo?.tipo || 'N/A'}`, 20, yPosition);
      yPosition += 8;
      pdf.text(`Criticidad: ${activo?.nivel_criticidad_negocio || 'N/A'}`, 20, yPosition);
      yPosition += 15;

      // Información del riesgo
      pdf.setFontSize(14);
      pdf.setFont('helvetica', 'bold');
      pdf.text('Riesgo Identificado:', 20, yPosition);
      yPosition += 10;
      
      pdf.setFontSize(12);
      pdf.setFont('helvetica', 'normal');
      pdf.text(`Amenaza: ${datosEvaluacion?.newRiesgo?.amenaza || 'N/A'}`, 20, yPosition);
      yPosition += 8;
      pdf.text(`Vulnerabilidad: ${datosEvaluacion?.newRiesgo?.vulnerabilidad || 'N/A'}`, 20, yPosition);
      yPosition += 8;
      pdf.text(`Descripción: ${datosEvaluacion?.newRiesgo?.descripcion || 'N/A'}`, 20, yPosition);
      yPosition += 15;

      // Evaluación inherente
      pdf.setFontSize(14);
      pdf.setFont('helvetica', 'bold');
      pdf.text('Evaluación Inherente:', 20, yPosition);
      yPosition += 10;
      
      pdf.setFontSize(12);
      pdf.setFont('helvetica', 'normal');
      pdf.text(`Probabilidad: ${datosEvaluacion?.evaluacionInherente?.probabilidad || 'N/A'}`, 20, yPosition);
      yPosition += 8;
      pdf.text(`Impacto: ${datosEvaluacion?.evaluacionInherente?.impacto || 'N/A'}`, 20, yPosition);
      yPosition += 8;
      pdf.text(`Nivel de Riesgo: ${datosEvaluacion?.evaluacionInherente?.nivelRiesgo || 'N/A'}`, 20, yPosition);
      yPosition += 8;
      pdf.text(`Justificación: ${datosEvaluacion?.evaluacionInherente?.justificacion || 'N/A'}`, 20, yPosition);
      yPosition += 15;

      // Evaluación residual
      pdf.setFontSize(14);
      pdf.setFont('helvetica', 'bold');
      pdf.text('Evaluación Residual:', 20, yPosition);
      yPosition += 10;
      
      pdf.setFontSize(12);
      pdf.setFont('helvetica', 'normal');
      pdf.text(`Probabilidad: ${datosEvaluacion?.evaluacionResidual?.probabilidad || 'N/A'}`, 20, yPosition);
      yPosition += 8;
      pdf.text(`Impacto: ${datosEvaluacion?.evaluacionResidual?.impacto || 'N/A'}`, 20, yPosition);
      yPosition += 8;
      pdf.text(`Nivel de Riesgo: ${datosEvaluacion?.evaluacionResidual?.nivelRiesgo || 'N/A'}`, 20, yPosition);
      yPosition += 8;
      pdf.text(`Justificación: ${datosEvaluacion?.evaluacionResidual?.justificacion || 'N/A'}`, 20, yPosition);
      yPosition += 15;

      // Controles seleccionados
      if (datosEvaluacion?.controles?.seleccionados && datosEvaluacion.controles.seleccionados.length > 0) {
        pdf.setFontSize(14);
        pdf.setFont('helvetica', 'bold');
        pdf.text('Controles Seleccionados:', 20, yPosition);
        yPosition += 10;
        
        pdf.setFontSize(12);
        pdf.setFont('helvetica', 'normal');
        datosEvaluacion.controles.seleccionados.forEach((control: string) => {
          pdf.text(`• ${control}`, 20, yPosition);
          yPosition += 8;
        });
        yPosition += 10;
      }

      // Plan de acción
      if (datosEvaluacion?.planAccion?.acciones && datosEvaluacion.planAccion.acciones.length > 0) {
        pdf.setFontSize(14);
        pdf.setFont('helvetica', 'bold');
        pdf.text('Plan de Acción:', 20, yPosition);
        yPosition += 10;
        
        pdf.setFontSize(12);
        pdf.setFont('helvetica', 'normal');
        datosEvaluacion.planAccion.acciones.forEach((accion: any) => {
          pdf.text(`• ${accion.titulo || accion.descripcion || 'Acción'}: ${accion.responsable || 'N/A'}`, 20, yPosition);
          yPosition += 8;
        });
        yPosition += 10;
      }

      // Pie de página
      pdf.setFontSize(10);
      pdf.setFont('helvetica', 'normal');
      pdf.text(`Generado el: ${new Date().toLocaleDateString()}`, 20, pageHeight - 20);
      pdf.text(`Sistema de Gestión de Riesgos de Información`, pageWidth - 20, pageHeight - 20, { align: 'right' });

      // Guardar el PDF
      pdf.save(`evaluacion-riesgo-${activo?.Nombre || activo?.nombre || 'activo'}.pdf`);
      
      setExportMessage('Resumen exportado a PDF exitosamente');
      setShowExportMessage(true);
    } catch (error) {
      console.error('Error al exportar PDF:', error);
      setExportMessage('Error al exportar PDF');
      setShowExportMessage(true);
    } finally {
      setIsExportando(false);
    }
  };

  const getEstadoColor = (estado: string) => {
    const colors: { [key: string]: string } = {
      'Pendiente': '#F59E0B',
      'En Progreso': '#3B82F6',
      'Completado': '#10B981',
      'Cancelado': '#EF4444'
    };
    return colors[estado] || '#6B7280';
  };

  // Función para determinar el estado de evaluación de un activo
  const getEvaluacionEstado = (activo: any) => {
    const activoId = activo.ID_Activo || activo.id;
    const evaluacionGuardada = evaluacionesCompletadas[activoId];
    
    // Debug logging
    console.log(`Evaluando activo ${activoId}:`, {
      evaluacionGuardada: !!evaluacionGuardada,
      evaluaciones: evaluacionGuardada?.evaluaciones?.length || 0
    });
    
    // Si hay una evaluación guardada para este activo
    if (evaluacionGuardada) {
      // Obtener la primera evaluación del activo
      const primeraEvaluacion = evaluacionGuardada.evaluaciones && evaluacionGuardada.evaluaciones.length > 0 
        ? evaluacionGuardada.evaluaciones[0] 
        : null;
      
      console.log(`Activo ${activoId} - Estado: COMPLETA`, {
        evaluacion: !!primeraEvaluacion,
        color: '#10B981'
      });
      
      return { 
        estado: 'completa', 
        porcentaje: 100, 
        color: '#10B981',
        evaluacion: primeraEvaluacion
      };
    }
    
    // Verificar si hay datos parciales en el wizard actual
    if (wizardData.selectedActivo?.ID_Activo === activoId) {
      let porcentajeParcial = 0;
      
      // Calcular progreso basado en los pasos completados
      // Requerir amenaza, vulnerabilidad, tipo de riesgo y descripción para considerar el paso completo
      if (wizardData.newRiesgo.amenaza && wizardData.newRiesgo.vulnerabilidad && wizardData.newRiesgo.tipoRiesgo && wizardData.newRiesgo.descripcion) {
        porcentajeParcial += 20; // Identificación de riesgo completa
      } else if (wizardData.newRiesgo.amenaza && wizardData.newRiesgo.vulnerabilidad && wizardData.newRiesgo.tipoRiesgo) {
        // Si tiene amenaza, vulnerabilidad y tipo, dar 18% (casi completo, falta descripción)
        porcentajeParcial += 18;
      } else if (wizardData.newRiesgo.amenaza && wizardData.newRiesgo.vulnerabilidad) {
        // Si solo tiene amenaza y vulnerabilidad, dar 15% (parcial)
        porcentajeParcial += 15;
      }
      if (wizardData.evaluacionInherente.probabilidad && wizardData.evaluacionInherente.impacto) {
        porcentajeParcial += 20; // Evaluación inherente
      }
      if (wizardData.controles.seleccionados.length > 0) {
        porcentajeParcial += 20; // Controles existentes
      }
      if (wizardData.evaluacionResidual.probabilidad && wizardData.evaluacionResidual.impacto) {
        porcentajeParcial += 20; // Evaluación residual
      }
      if (wizardData.tratamiento.opcion) {
        porcentajeParcial += 20; // Opciones de tratamiento
      }
      
      // Solo mostrar como parcial si no está 100% completo
      if (porcentajeParcial > 0 && porcentajeParcial < 100) {
        // Guardar automáticamente la evaluación parcial
        guardarEvaluacionParcial(activoId, porcentajeParcial);
        
        return { 
          estado: 'parcial', 
          porcentaje: porcentajeParcial, 
          color: '#F59E0B',
          puedeContinuar: true
        };
      }
      
      // Si está 100% completo, tratarlo como evaluación completa
      if (porcentajeParcial === 100) {
        return { 
          estado: 'completa', 
          porcentaje: 100, 
          color: '#10B981',
          evaluacion: wizardData
        };
      }
    }
    
    // Verificar si hay evaluación parcial guardada
    const evaluacionParcialGuardada = localStorage.getItem(`evaluacion_parcial_${activoId}`);
    if (evaluacionParcialGuardada) {
      try {
        const datosParciales = JSON.parse(evaluacionParcialGuardada);
        const porcentaje = datosParciales.progreso || 0;
        
        // Si está 100% completo, tratarlo como evaluación completa
        if (porcentaje === 100) {
          return {
            estado: 'completa',
            porcentaje: 100,
            color: '#10B981',
            evaluacion: datosParciales.wizard_data || datosParciales.wizardData
          };
        }
        
        return {
          estado: 'parcial',
          porcentaje: porcentaje,
          color: '#F59E0B',
          puedeContinuar: true,
          datosParciales: datosParciales
        };
      } catch (error) {
        console.error('Error parseando evaluación parcial:', error);
      }
    }
    
    // Datos de fallback del activo
    const evaluacionCompleta = activo.evaluacion_completa || false;
    const porcentajeEvaluacion = activo.porcentaje_evaluacion || 0;
    
    if (evaluacionCompleta) {
      return { estado: 'completa', porcentaje: 100, color: '#10B981' };
    } else if (porcentajeEvaluacion > 0) {
      return { estado: 'parcial', porcentaje: porcentajeEvaluacion, color: '#F59E0B' };
    } else {
      return { estado: 'no_evaluado', porcentaje: 0, color: '#3B82F6' };
    }
  };

  // Función para obtener el color del paso basado en el progreso de evaluación
  const getStepColor = (stepIndex: number) => {
    if (!wizardData.selectedActivo) return '#D1D5DB';
    
    // Pasos normales - mantener azul oscuro para todos los pasos
    if (stepIndex < activeStep) return '#1E3A8A';
    if (stepIndex === activeStep) return '#1E3A8A';
    return '#D1D5DB';
  };

  // Funciones auxiliares para la matriz de riesgo 5x5
  const getNumericValue = (textValue: string): number => {
    const mapping: { [key: string]: number } = {
      'Frecuente': 1,
      'Probable': 2,
      'Ocasional': 3,
      'Posible': 4,
      'Improbable': 5,
      'Insignificante': 1,
      'Menor': 2,
      'Moderado': 3,
      'Mayor': 4,
      'Catastrófico': 5
    };
    return mapping[textValue] || 1;
  };

  const getTextValue = (numericValue: number, type: 'probabilidad' | 'impacto'): string => {
    if (type === 'probabilidad') {
      const mapping: { [key: number]: string } = {
        1: 'Frecuente',
        2: 'Probable',
        3: 'Ocasional',
        4: 'Posible',
        5: 'Improbable'
      };
      return mapping[numericValue] || 'Frecuente';
    } else {
      const mapping: { [key: number]: string } = {
        1: 'Insignificante',
        2: 'Menor',
        3: 'Moderado',
        4: 'Mayor',
        5: 'Catastrófico'
      };
      return mapping[numericValue] || 'Insignificante';
    }
  };

  const renderStepContent = (step: number) => {
    switch (step) {
      case 0:
        return (
          <Box>
            <Box sx={{ display: 'flex', justifyContent: 'space-between', alignItems: 'center', mb: 2 }}>
              <Typography variant="h6" className="font-poppins" sx={{ color: '#1E3A8A' }}>
                Selecciona el activo de información a evaluar
              </Typography>
              
              {/* Leyenda de colores */}
              <Box sx={{ display: 'flex', gap: 2, alignItems: 'center' }}>
                <Box sx={{ display: 'flex', alignItems: 'center', gap: 1 }}>
                  <Box sx={{ width: 12, height: 12, borderRadius: '50%', backgroundColor: '#10B981' }} />
                  <Typography variant="caption" className="font-roboto" sx={{ color: '#6B7280' }}>
                    Evaluado
                  </Typography>
                </Box>
                <Box sx={{ display: 'flex', alignItems: 'center', gap: 1 }}>
                  <Box sx={{ width: 12, height: 12, borderRadius: '50%', backgroundColor: '#F59E0B' }} />
                  <Typography variant="caption" className="font-roboto" sx={{ color: '#6B7280' }}>
                    Parcial
                  </Typography>
                </Box>
                <Box sx={{ display: 'flex', alignItems: 'center', gap: 1 }}>
                  <Box sx={{ width: 12, height: 12, borderRadius: '50%', backgroundColor: '#3B82F6' }} />
                  <Typography variant="caption" className="font-roboto" sx={{ color: '#6B7280' }}>
                    Pendiente
                  </Typography>
                </Box>
              </Box>
            </Box>
            
            <Box sx={{ display: 'flex', gap: 2, mb: 3 }}>
              <Autocomplete
                fullWidth
                freeSolo
                options={activos}
                isOptionEqualToValue={(option, value) => {
                  if (!option || !value) return false;
                  const optionId = option.ID_Activo || option.id;
                  const valueId = value.ID_Activo || value.id;
                  return optionId === valueId;
                }}
                getOptionLabel={(option) => {
                  if (!option) return '';
                  if (typeof option === 'string') return option;
                  return option.nombre || option.Nombre || option.Nombre_Activo || '';
                }}
                value={wizardData.selectedActivo}
                onInputChange={(event, newValue) => {
                  setSearchTerm(newValue || '');
                }}
                filterOptions={(options, { inputValue }) => {
                  const filtered = options.filter(option => {
                    if (!option) return false;
                    const nombre = option.nombre || option.Nombre || option.Nombre_Activo || '';
                    const tipo = option.tipo || option.Tipo_Activo || '';
                    return nombre.toLowerCase().includes(inputValue.toLowerCase()) ||
                           tipo.toLowerCase().includes(inputValue.toLowerCase());
                  });
                  return filtered;
                }}
                renderInput={(params) => (
                  <TextField
                    {...params}
                    placeholder="Buscar activo por nombre..."
                    InputProps={{
                      ...params.InputProps,
                      startAdornment: (
                        <InputAdornment position="start">
                          <SearchIcon sx={{ color: '#6B7280' }} />
                        </InputAdornment>
                      ),
                    }}
                    sx={{ borderRadius: '12px' }}
                  />
                )}
                PaperComponent={({ children, ...other }) => (
                  <Paper 
                    {...other} 
                    sx={{ 
                      borderRadius: '12px',
                      boxShadow: '0 8px 32px rgba(0, 0, 0, 0.12)',
                      border: '1px solid #E5E7EB',
                      mt: 1
                    }}
                  >
                    {children}
                  </Paper>
                )}
                renderOption={(props, option) => {
                  if (!option) return null;
                  // Material-UI maneja las keys automáticamente a través de props
                  const optionId = option.ID_Activo || option.id;
                  return (
                    <Box component="li" {...props} data-option-id={optionId} sx={{ py: 1.5, px: 2 }}>
                      <Box sx={{ display: 'flex', alignItems: 'center', gap: 2 }}>
                        <Avatar sx={{ 
                          width: 32, 
                          height: 32,
                          background: 'linear-gradient(135deg, #1E3A8A 0%, #3B82F6 100%)',
                          color: '#FFFFFF',
                          fontSize: '0.875rem'
                        }}>
                          <SecurityIcon sx={{ fontSize: 18 }} />
                        </Avatar>
                        <Box>
                          <Typography variant="body1" className="font-poppins" sx={{ color: '#1E3A8A', fontWeight: 500 }}>
                            {option.nombre || option.Nombre || option.Nombre_Activo || 'Sin nombre'}
                          </Typography>
                          <Typography variant="caption" className="font-roboto" sx={{ color: '#6B7280' }}>
                            {option.tipo || option.Tipo_Activo || 'Sin tipo'} • {option.estado || option.estado_activo || option.Estado_Activo || 'Sin estado'} • Criticidad: {option.criticidad || option.nivel_criticidad_negocio || option.Nivel_Clasificacion_Confidencialidad || 'Sin criticidad'}
                          </Typography>
                        </Box>
                      </Box>
                    </Box>
                  );
                }}
                noOptionsText={
                  <Box sx={{ textAlign: 'center', py: 2 }}>
                    <Typography variant="body2" className="font-roboto" sx={{ color: '#6B7280' }}>
                      No se encontraron activos
                    </Typography>
                  </Box>
                }
                onChange={(event, newValue) => {
                  if (newValue) {
                    setWizardData(prev => ({
                      ...prev,
                      selectedActivo: newValue
                    }));
                  }
                }}
              />
              <Button
                variant="contained"
                startIcon={<AddIcon />}
                onClick={() => setOpenDialog(true)}
                sx={{ 
                  borderRadius: '12px', 
                  px: 3,
                  backgroundColor: '#1E3A8A',
                  '&:hover': {
                    backgroundColor: '#1E40AF',
                  }
                }}
              >
                Crear Activo
              </Button>
            </Box>

            <Grid container spacing={2}>
              {filteredActivos.map((activo, activoIndex) => {
                const evaluacionEstado = getEvaluacionEstado(activo);
                const activoKey = activo.ID_Activo || activo.id || `activo-${activoIndex}`;
                return (
                  <Grid item xs={12} sm={6} md={4} key={`activo-card-${activoKey}-${activoIndex}`}>
                    <Card
                      className="card"
                      sx={{
                        cursor: 'pointer',
                        border: wizardData.selectedActivo?.ID_Activo === activo.ID_Activo ? `2px solid ${evaluacionEstado.color}` : `1px solid ${evaluacionEstado.color}40`,
                        '&:hover': {
                          transform: 'translateY(-2px)',
                          boxShadow: `0 8px 25px ${evaluacionEstado.color}20`,
                        },
                        transition: 'all 0.25s ease',
                        position: 'relative',
                        overflow: 'visible'
                      }}
                      onClick={() => handleActivoSelect(activo)}
                    >
                      {/* Indicador de estado de evaluación */}
                      <Box
                        sx={{
                          position: 'absolute',
                          top: -8,
                          right: -8,
                          width: 20,
                          height: 20,
                          borderRadius: '50%',
                          backgroundColor: evaluacionEstado.color,
                          display: 'flex',
                          alignItems: 'center',
                          justifyContent: 'center',
                          boxShadow: '0 2px 8px rgba(0, 0, 0, 0.15)',
                          zIndex: 1
                        }}
                      >
                        {evaluacionEstado.estado === 'completa' && (
                          <CheckCircleIcon sx={{ fontSize: 12, color: '#FFFFFF' }} />
                        )}
                        {evaluacionEstado.estado === 'parcial' && (
                          <Typography sx={{ fontSize: 10, color: '#FFFFFF', fontWeight: 'bold' }}>
                            {evaluacionEstado.porcentaje}%
                          </Typography>
                        )}
                        {evaluacionEstado.estado === 'no_evaluado' && (
                          <Typography sx={{ fontSize: 10, color: '#FFFFFF', fontWeight: 'bold' }}>
                            ?
                          </Typography>
                        )}
                      </Box>

                      <CardContent sx={{ p: 3 }}>
                        <Box sx={{ display: 'flex', alignItems: 'center', gap: 2, mb: 2 }}>
                          <Avatar sx={{ 
                            background: `linear-gradient(135deg, ${evaluacionEstado.color} 0%, ${evaluacionEstado.color}CC 100%)`,
                            color: '#FFFFFF'
                          }}>
                            <SecurityIcon />
                          </Avatar>
                          <Box>
                            <Typography variant="h6" className="font-poppins" sx={{ color: evaluacionEstado.color, fontWeight: 600 }}>
                              {activo.Nombre || activo.nombre || 'Sin nombre'}
                            </Typography>
                            <Typography variant="body2" className="font-roboto" sx={{ color: '#6B7280' }}>
                              {activo.Tipo_Activo || activo.tipo || 'Sin tipo'}
                            </Typography>
                          </Box>
                        </Box>
                        
                        {/* Barra de progreso de evaluación */}
                        {evaluacionEstado.estado !== 'no_evaluado' && (
                          <Box sx={{ mb: 2 }}>
                            <Box sx={{ display: 'flex', justifyContent: 'space-between', alignItems: 'center', mb: 1 }}>
                              <Typography variant="caption" className="font-roboto" sx={{ color: '#6B7280' }}>
                                Progreso de Evaluación
                              </Typography>
                              <Typography variant="caption" className="font-roboto" sx={{ color: evaluacionEstado.color, fontWeight: 600 }}>
                                {evaluacionEstado.porcentaje}%
                              </Typography>
                            </Box>
                            <Box
                              sx={{
                                width: '100%',
                                height: 4,
                                backgroundColor: '#E5E7EB',
                                borderRadius: 2,
                                overflow: 'hidden'
                              }}
                            >
                              <Box
                                sx={{
                                  width: `${evaluacionEstado.porcentaje}%`,
                                  height: '100%',
                                  backgroundColor: evaluacionEstado.color,
                                  transition: 'width 0.3s ease'
                                }}
                              />
                            </Box>
                          </Box>
                        )}

                        <Box sx={{ display: 'flex', gap: 1, alignItems: 'center', flexWrap: 'wrap' }}>
                          <Chip
                            label={activo.nivel_criticidad_negocio}
                            size="small"
                            sx={{
                              backgroundColor: activo.nivel_criticidad_negocio === 'Crítico' ? '#FEE2E2' :
                                             activo.nivel_criticidad_negocio === 'Alto' ? '#FEF3C7' :
                                             activo.nivel_criticidad_negocio === 'Medio' ? '#DBEAFE' : '#F3F4F6',
                              color: activo.nivel_criticidad_negocio === 'Crítico' ? '#DC2626' :
                                     activo.nivel_criticidad_negocio === 'Alto' ? '#D97706' :
                                     activo.nivel_criticidad_negocio === 'Medio' ? '#2563EB' : '#6B7280',
                              fontWeight: 500
                            }}
                          />
                          
                          {/* Botón para continuar evaluación parcial */}
                          {evaluacionEstado.estado === 'parcial' && evaluacionEstado.puedeContinuar && (
                            <Button
                              size="small"
                              variant="outlined"
                              sx={{
                                borderColor: '#F59E0B',
                                color: '#F59E0B',
                                fontSize: '0.75rem',
                                py: 0.5,
                                px: 1,
                                '&:hover': {
                                  backgroundColor: '#FEF3C7',
                                  borderColor: '#D97706'
                                }
                              }}
                              onClick={() => {
                                cargarEvaluacionParcial(activo.ID_Activo || activo.id);
                              }}
                            >
                              Continuar
                            </Button>
                          )}
                        </Box>
                      </CardContent>
                    </Card>
                  </Grid>
                );
              })}
            </Grid>
          </Box>
        );

      case 1:
        return (
          <Box>
            <Box sx={{ mb: 3 }}>
              <Typography variant="h6" className="font-poppins" sx={{ color: '#1E3A8A', mb: 1 }}>
                Identifica el riesgo a evaluar
              </Typography>
              <Typography variant="body2" className="font-roboto" sx={{ color: '#6B7280', fontSize: '0.875rem' }}>
                Completa todos los campos marcados con <span style={{ color: '#EF4444' }}>*</span> para continuar. El tipo de riesgo es obligatorio.
              </Typography>
            </Box>
            
            <Grid container spacing={3}>
              {/* Columna izquierda - Formulario principal */}
              <Grid item xs={12} md={8}>
                {/* Opciones de Selección */}
                <Grid container spacing={3} sx={{ mb: 3 }}>
              <Grid item xs={12} md={6}>
                <Card className="card" sx={{ height: '100%' }}>
                  <CardContent sx={{ p: 3, height: '100%', display: 'flex', flexDirection: 'column' }}>
                    <Typography variant="h6" className="font-poppins" sx={{ color: '#1E3A8A', mb: 2 }}>
                      Seleccionar Riesgo Existente
                    </Typography>
                    <Typography variant="body2" className="font-roboto" sx={{ color: '#6B7280', mb: 3 }}>
                      Busca y selecciona un riesgo de la base de datos existente
                    </Typography>
                    <Autocomplete
                      fullWidth
                      freeSolo
                      options={riesgosExistentes}
                      renderInput={(params) => (
                        <TextField
                          {...params}
                          placeholder="Buscar riesgo existente..."
                          InputProps={{
                            ...params.InputProps,
                            startAdornment: (
                              <InputAdornment position="start">
                                <SearchIcon sx={{ color: '#6B7280' }} />
                              </InputAdornment>
                            ),
                          }}
                          sx={{ borderRadius: '12px' }}
                        />
                      )}
                      PaperComponent={({ children, ...other }) => (
                        <Paper 
                          {...other} 
                          sx={{ 
                            borderRadius: '12px',
                            boxShadow: '0 8px 32px rgba(0, 0, 0, 0.12)',
                            border: '1px solid #E5E7EB',
                            mt: 1
                          }}
                        >
                          {children}
                        </Paper>
                      )}
                      renderOption={(props, option) => {
                        if (!option) return null;
                        // Material-UI maneja las keys automáticamente a través de props
                        const optionId = typeof option === 'string' ? option : (option.ID_Riesgo || option.id);
                        return (
                          <Box component="li" {...props} data-option-id={optionId} sx={{ py: 1.5, px: 2 }}>
                            <Typography variant="body1" className="font-roboto" sx={{ color: '#374151' }}>
                              {option}
                            </Typography>
                          </Box>
                        );
                      }}
                      noOptionsText={
                        <Box sx={{ textAlign: 'center', py: 2 }}>
                          <Typography variant="body2" className="font-roboto" sx={{ color: '#6B7280' }}>
                            No se encontraron riesgos
                          </Typography>
                        </Box>
                      }
                    />
                  </CardContent>
                </Card>
              </Grid>

              <Grid item xs={12} md={6}>
                <Card className="card" sx={{ height: '100%' }}>
                  <CardContent sx={{ p: 3, height: '100%', display: 'flex', flexDirection: 'column' }}>
                    <Typography variant="h6" className="font-poppins" sx={{ color: '#1E3A8A', mb: 2 }}>
                      Crear Nuevo Riesgo
                    </Typography>
                    <Typography variant="body2" className="font-roboto" sx={{ color: '#6B7280', mb: 3 }}>
                      Define un nuevo riesgo específico para este activo
                    </Typography>
                    <Button
                      variant="contained"
                      startIcon={<AddIcon />}
                      onClick={() => setOpenRiesgoDialog(true)}
                      className="btn btn-primary"
                      sx={{
                        background: 'linear-gradient(135deg, #1E3A8A 0%, #3B82F6 100%)',
                        color: '#FFFFFF',
                        borderRadius: '12px',
                        py: 2,
                        textTransform: 'none',
                        fontWeight: 500,
                        boxShadow: '0 4px 12px rgba(30, 58, 138, 0.3)',
                        '&:hover': {
                          background: 'linear-gradient(135deg, #1E40AF 0%, #2563EB 100%)',
                          transform: 'translateY(-1px)',
                          boxShadow: '0 6px 16px rgba(30, 58, 138, 0.4)',
                        },
                        transition: 'all 0.25s cubic-bezier(0.4, 0, 0.2, 1)'
                      }}
                    >
                      Crear Nuevo Riesgo
                    </Button>
                  </CardContent>
                </Card>
              </Grid>
                </Grid>

                {/* Detalles del Riesgo */}
                <Card className="card">
              <CardContent sx={{ p: 4 }}>
                <Box sx={{ mb: 3 }}>
                  <Typography variant="h6" className="font-poppins" sx={{ color: '#1E3A8A', mb: 1 }}>
                    Detalles del Riesgo
                  </Typography>
                  <Typography variant="body2" className="font-roboto" sx={{ color: '#6B7280', fontSize: '0.875rem' }}>
                    Los campos marcados con <span style={{ color: '#EF4444' }}>*</span> son obligatorios
                  </Typography>
                </Box>
                <Grid container spacing={3}>
                  <Grid item xs={12} md={6}>
                    <FormControl fullWidth required>
                      <InputLabel>Amenaza *</InputLabel>
                      <Select
                        value={wizardData.newRiesgo.amenaza}
                        onChange={(e) => setWizardData({
                          ...wizardData,
                          newRiesgo: { ...wizardData.newRiesgo, amenaza: e.target.value }
                        })}
                        label="Amenaza *"
                        sx={{ borderRadius: '12px' }}
                      >
                        <MenuItem value="">
                          <em>Seleccionar amenaza...</em>
                        </MenuItem>
                        <MenuItem value="Malware">Malware</MenuItem>
                        <MenuItem value="Ataques de Phishing">Ataques de Phishing</MenuItem>
                        <MenuItem value="Acceso No Autorizado">Acceso No Autorizado</MenuItem>
                        <MenuItem value="Pérdida de Datos">Pérdida de Datos</MenuItem>
                        <MenuItem value="Interrupción del Servicio">Interrupción del Servicio</MenuItem>
                        <MenuItem value="Acceso Físico No Controlado">Acceso Físico No Controlado</MenuItem>
                        <MenuItem value="Ingeniería Social">Ingeniería Social</MenuItem>
                        <MenuItem value="Ataques DDoS">Ataques DDoS</MenuItem>
                      </Select>
                    </FormControl>
                  </Grid>
                  <Grid item xs={12} md={6}>
                    <FormControl fullWidth required>
                      <InputLabel>Vulnerabilidad *</InputLabel>
                      <Select
                        value={wizardData.newRiesgo.vulnerabilidad}
                        onChange={(e) => setWizardData({
                          ...wizardData,
                          newRiesgo: { ...wizardData.newRiesgo, vulnerabilidad: e.target.value }
                        })}
                        label="Vulnerabilidad *"
                        sx={{ borderRadius: '12px' }}
                      >
                        <MenuItem value="">
                          <em>Seleccionar vulnerabilidad...</em>
                        </MenuItem>
                        <MenuItem value="Configuración Insegura">Configuración Insegura</MenuItem>
                        <MenuItem value="Software Desactualizado">Software Desactualizado</MenuItem>
                        <MenuItem value="Falta de Autenticación">Falta de Autenticación</MenuItem>
                        <MenuItem value="Acceso Físico No Controlado">Acceso Físico No Controlado</MenuItem>
                        <MenuItem value="Falta de Respaldo">Falta de Respaldo</MenuItem>
                        <MenuItem value="Contraseñas Débiles">Contraseñas Débiles</MenuItem>
                        <MenuItem value="Falta de Cifrado">Falta de Cifrado</MenuItem>
                        <MenuItem value="Ausencia de Monitoreo">Ausencia de Monitoreo</MenuItem>
                      </Select>
                    </FormControl>
                  </Grid>
                  <Grid item xs={12} md={6}>
                    <FormControl fullWidth required>
                      <InputLabel>Tipo de Riesgo *</InputLabel>
                      <Select
                        value={wizardData.newRiesgo.tipoRiesgo}
                        onChange={(e) => setWizardData({
                          ...wizardData,
                          newRiesgo: { ...wizardData.newRiesgo, tipoRiesgo: e.target.value }
                        })}
                        label="Tipo de Riesgo *"
                        error={!wizardData.newRiesgo.tipoRiesgo && wizardData.newRiesgo.amenaza !== ''}
                        sx={{ borderRadius: '12px' }}
                      >
                        <MenuItem value="">
                          <em>Seleccionar tipo de riesgo...</em>
                        </MenuItem>
                        {tiposRiesgo.length > 0 ? (
                          tiposRiesgo.map((tipo) => (
                            <MenuItem key={tipo} value={tipo}>{tipo}</MenuItem>
                          ))
                        ) : (
                          <>
                            <MenuItem value="Operacional">Operacional</MenuItem>
                            <MenuItem value="Tecnológico">Tecnológico</MenuItem>
                            <MenuItem value="Legal">Legal</MenuItem>
                            <MenuItem value="Estratégico">Estratégico</MenuItem>
                            <MenuItem value="Financiero">Financiero</MenuItem>
                            <MenuItem value="Reputacional">Reputacional</MenuItem>
                          </>
                        )}
                      </Select>
                      {!wizardData.newRiesgo.tipoRiesgo && wizardData.newRiesgo.amenaza !== '' && (
                        <Typography variant="caption" color="error" sx={{ mt: 0.5, ml: 1.75 }}>
                          El tipo de riesgo es obligatorio
                        </Typography>
                      )}
                    </FormControl>
                  </Grid>
                  <Grid item xs={12} md={6}>
                    <TextField
                      fullWidth
                      multiline
                      rows={4}
                      label="Descripción del Riesgo"
                      placeholder="Descripción detallada del riesgo identificado..."
                      value={wizardData.newRiesgo.descripcion}
                      onChange={(e) => setWizardData({
                        ...wizardData,
                        newRiesgo: { ...wizardData.newRiesgo, descripcion: e.target.value }
                      })}
                      sx={{ 
                        borderRadius: '12px',
                        '& .MuiOutlinedInput-root': {
                          '& fieldset': {
                            borderColor: '#E5E7EB',
                          },
                          '&:hover fieldset': {
                            borderColor: '#1E3A8A',
                          },
                          '&.Mui-focused fieldset': {
                            borderColor: '#1E3A8A',
                          },
                        }
                      }}
                    />
                  </Grid>
                </Grid>
              </CardContent>
            </Card>

            {/* Vinculación de Amenaza y Vulnerabilidad */}
            {wizardData.newRiesgo.amenaza && wizardData.newRiesgo.vulnerabilidad && (
              <Box sx={{ mt: 3 }}>
                <ThreatVulnerabilityLink
                  threat={wizardData.newRiesgo.amenaza}
                  vulnerability={wizardData.newRiesgo.vulnerabilidad}
                  riskDescription={wizardData.newRiesgo.descripcion}
                  onEdit={() => {
                    // Lógica para editar la vinculación
                    console.log('Editar vinculación');
                  }}
                />
              </Box>
            )}

            {/* Sugerencia de Activos Gemelos */}
            {wizardData.selectedActivo && (
              <Box sx={{ mt: 3 }}>
                <TwinAssetSuggestion
                  currentAsset={{
                    nombre: wizardData.selectedActivo.nombre || wizardData.selectedActivo.Nombre || 'Sin nombre',
                    tipo: wizardData.selectedActivo.tipo || 'servidor',
                    descripcion: wizardData.selectedActivo.descripcion || wizardData.selectedActivo.Descripcion || 'Sin descripción'
                  }}
                  onCloneEvaluation={(twinAsset) => {
                    // Clonar la evaluación del activo gemelo
                    setWizardData({
                      ...wizardData,
                      newRiesgo: {
                        amenaza: twinAsset.evaluacionExistente.amenaza,
                        vulnerabilidad: twinAsset.evaluacionExistente.vulnerabilidad,
                        descripcion: twinAsset.evaluacionExistente.justificacion
                      },
                      controles: {
                        ...wizardData.controles,
                        seleccionados: twinAsset.evaluacionExistente.controles,
                        justificacion: twinAsset.evaluacionExistente.justificacion
                      }
                    });
                  }}
                />
              </Box>
            )}

              </Grid>

              {/* Columna derecha - Sugerencias Interactivas */}
              <Grid item xs={12} md={4}>
                {wizardData.selectedActivo ? (
                  <InteractiveSuggestions
                    assetType={wizardData.selectedActivo.tipo || 'servidor'}
                    context={`Activo: ${wizardData.selectedActivo.nombre || wizardData.selectedActivo.Nombre || 'Sin nombre'}`}
                    selectedThreat={wizardData.newRiesgo.amenaza}
                    selectedVulnerability={wizardData.newRiesgo.vulnerabilidad}
                    onSuggestionSelect={(suggestion) => {
                      console.log('Sugerencia seleccionada:', suggestion);
                      if (suggestion.type === 'amenazas') {
                        setWizardData({
                          ...wizardData,
                          newRiesgo: {
                            ...wizardData.newRiesgo,
                            amenaza: suggestion.data.nombre
                          }
                        });
                      } else if (suggestion.type === 'vulnerabilidades') {
                        setWizardData({
                          ...wizardData,
                          newRiesgo: {
                            ...wizardData.newRiesgo,
                            vulnerabilidad: suggestion.data.nombre
                          }
                        });
                      }
                    }}
                  />
                ) : (
                  <Card className="card">
                    <CardContent sx={{ p: 4, textAlign: 'center' }}>
                      <Typography variant="h6" color="text.secondary">
                        Selecciona un activo para ver sugerencias
                      </Typography>
                    </CardContent>
                  </Card>
                )}
              </Grid>
            </Grid>
          </Box>
        );

      case 2:
        return (
          <Box>
            {/* Cálculo de Criticidad */}
            <CriticityCalculator
              onCriticityChange={(criticity) => {
                setCriticityData(criticity);
                setWizardData({
                  ...wizardData,
                  evaluacionInherente: {
                    ...wizardData.evaluacionInherente,
                    criticidad: criticidad.clasificacion,
                    confidencialidad: criticidad.confidencialidad,
                    disponibilidad: criticidad.disponibilidad,
                    integridad: criticidad.integridad
                  }
                });
              }}
              initialValues={{
                confidencialidad: wizardData.evaluacionInherente.confidencialidad || 3,
                disponibilidad: wizardData.evaluacionInherente.disponibilidad || 3,
                integridad: wizardData.evaluacionInherente.integridad || 3
              }}
            />

            {/* Evaluación Inherente */}
            <InherentEvaluationStep
              data={wizardData.evaluacionInherente}
              onUpdate={(data) => {
                setWizardData((prev) => ({
                  ...prev,
                  evaluacionInherente: data
                }));
              }}
            />
          </Box>
        );

      case 3:
        return (
          <Box>
            <Alert severity="warning" sx={{ mb: 3 }}>
              <Typography variant="body2" sx={{ fontWeight: 600 }}>
                ⚠️ Es obligatorio seleccionar al menos un control antes de continuar. 
                Puedes elegir controles de la base de datos, sugerencias ISO 27001/27002/27005, o agregar uno manualmente.
              </Typography>
            </Alert>
            
            <Typography variant="h6" className="font-poppins" sx={{ color: '#1E3A8A', mb: 2 }}>
              Selecciona los controles que mitigarán el riesgo
            </Typography>
            
            <Grid container spacing={3}>
              {/* Columna izquierda - Controles de BD y Manual */}
              <Grid item xs={12} md={6}>
                <Card className="card" sx={{ height: '100%' }}>
                  <CardContent sx={{ p: 3 }}>
                    <Box sx={{ display: 'flex', justifyContent: 'space-between', alignItems: 'center', mb: 2 }}>
                      <Typography variant="h6" className="font-poppins" sx={{ color: '#1E3A8A' }}>
                        Controles de la Base de Datos
                      </Typography>
                      <Button
                        size="small"
                        variant="outlined"
                        startIcon={<AddIcon />}
                        onClick={() => setMostrarInputManual(!mostrarInputManual)}
                        sx={{ borderColor: '#1E3A8A', color: '#1E3A8A' }}
                      >
                        Agregar Manual
                      </Button>
                    </Box>
                    
                    {/* Input para agregar control manual */}
                    {mostrarInputManual && (
                      <Box sx={{ mb: 2, p: 2, backgroundColor: '#F9FAFB', borderRadius: 2 }}>
                        <TextField
                          fullWidth
                          size="small"
                          label="Nombre del control"
                          value={nuevoControlManual}
                          onChange={(e) => setNuevoControlManual(e.target.value)}
                          placeholder="Ej: Control de acceso basado en roles"
                          InputProps={{
                            endAdornment: (
                              <InputAdornment position="end">
                                <IconButton
                                  size="small"
                                  onClick={() => {
                                    if (nuevoControlManual.trim()) {
                                      const seleccionados = [...wizardData.controles.seleccionados, nuevoControlManual.trim()];
                                      setWizardData({
                                        ...wizardData,
                                        controles: { ...wizardData.controles, seleccionados }
                                      });
                                      setNuevoControlManual('');
                                      setMostrarInputManual(false);
                                      toast.success('Control agregado');
                                    }
                                  }}
                                  disabled={!nuevoControlManual.trim()}
                                >
                                  <AddIcon />
                                </IconButton>
                              </InputAdornment>
                            )
                          }}
                        />
                      </Box>
                    )}

                    {controlesBD && controlesBD.length > 0 ? (
                      <Box sx={{ maxHeight: '400px', overflowY: 'auto' }}>
                        <FormGroup>
                          {controlesBD.map((control: any) => (
                            <FormControlLabel
                              key={`control-bd-${control.id}`}
                              control={
                                <Checkbox
                                  checked={wizardData.controles.seleccionados.includes(control.nombre)}
                                  onChange={(e) => {
                                    const seleccionados = e.target.checked
                                      ? [...wizardData.controles.seleccionados, control.nombre]
                                      : wizardData.controles.seleccionados.filter(c => c !== control.nombre);
                                    setWizardData({
                                      ...wizardData,
                                      controles: { ...wizardData.controles, seleccionados }
                                    });
                                  }}
                                  sx={{
                                    color: '#1E3A8A',
                                    '&.Mui-checked': {
                                      color: '#1E3A8A',
                                    },
                                  }}
                                />
                              }
                              label={
                                <Box>
                                  <Typography className="font-roboto" sx={{ color: '#374151', fontWeight: 500 }}>
                                    {control.nombre}
                                  </Typography>
                                  {control.descripcion && (
                                    <Typography variant="caption" className="font-roboto" sx={{ color: '#6B7280', display: 'block' }}>
                                      {control.descripcion.substring(0, 80)}...
                                    </Typography>
                                  )}
                                  {control.categoria && (
                                    <Chip label={control.categoria} size="small" sx={{ mt: 0.5, fontSize: '0.65rem' }} />
                                  )}
                                </Box>
                              }
                            />
                          ))}
                        </FormGroup>
                      </Box>
                    ) : (
                      <Alert severity="info" sx={{ mt: 2 }}>
                        No hay controles disponibles en la base de datos. Usa las sugerencias ISO o agrega controles manualmente.
                      </Alert>
                    )}
                  </CardContent>
                </Card>
              </Grid>

              {/* Columna derecha - Sugerencias ISO y Predictivas */}
              <Grid item xs={12} md={6}>
                <Stack spacing={2}>
                  {/* Sugerencias ISO */}
                  <ISOSuggestions
                    amenaza={wizardData.newRiesgo.amenaza}
                    vulnerabilidad={wizardData.newRiesgo.vulnerabilidad}
                    onSuggestionSelect={(suggestion) => {
                      const seleccionados = wizardData.controles.seleccionados.includes(suggestion.nombre)
                        ? wizardData.controles.seleccionados.filter(c => c !== suggestion.nombre)
                        : [...wizardData.controles.seleccionados, suggestion.nombre];
                      
                      setWizardData({
                        ...wizardData,
                        controles: { 
                          ...wizardData.controles, 
                          seleccionados,
                          eficacia: suggestion.eficacia === 'Crítica' ? 'Muy Alta' : 
                                   suggestion.eficacia === 'Alta' ? 'Alta' : 
                                   suggestion.eficacia === 'Media' ? 'Media' : 'Baja'
                        }
                      });
                    }}
                  />
                  
                  {/* Sugerencias Predictivas */}
                  {wizardData.selectedActivo && (
                    <ControlSuggestions
                      assetType={wizardData.selectedActivo.tipo || wizardData.selectedActivo.Tipo_Activo || 'Hardware'}
                      threatType={wizardData.newRiesgo.amenaza}
                      vulnerabilityType={wizardData.newRiesgo.vulnerabilidad}
                      selectedControls={wizardData.controles.seleccionados}
                      onControlSelect={(control) => {
                        const nombreControl = control.titulo || control.nombre;
                        const seleccionados = wizardData.controles.seleccionados.includes(nombreControl)
                          ? wizardData.controles.seleccionados.filter(c => c !== nombreControl)
                          : [...wizardData.controles.seleccionados, nombreControl];
                        
                        setWizardData({
                          ...wizardData,
                          controles: { 
                            ...wizardData.controles, 
                            seleccionados,
                            eficacia: control.eficacia ? 
                              (control.eficacia >= 80 ? 'Muy Alta' : 
                               control.eficacia >= 60 ? 'Alta' : 
                               control.eficacia >= 40 ? 'Media' : 'Baja') : 
                              wizardData.controles.eficacia
                          }
                        });
                      }}
                    />
                  )}
                </Stack>
              </Grid>
            </Grid>

            {/* Sección de eficacia y controles seleccionados mejorada */}
            <Grid container spacing={3} sx={{ mt: 2 }}>
              <Grid item xs={12} md={4}>
                <Card className="card" sx={{ height: '100%' }}>
                  <CardContent sx={{ p: 3 }}>
                    <Box display="flex" alignItems="center" mb={2}>
                      <TrendingUpIcon sx={{ color: '#1E3A8A', mr: 1 }} />
                      <Typography variant="h6" className="font-poppins" sx={{ color: '#1E3A8A' }}>
                        Eficacia de los Controles
                      </Typography>
                    </Box>
                    <FormControl fullWidth>
                      <InputLabel>Nivel de Eficacia</InputLabel>
                      <Select
                        value={wizardData.controles.eficacia}
                        onChange={(e) => setWizardData({
                          ...wizardData,
                          controles: { ...wizardData.controles, eficacia: e.target.value }
                        })}
                        label="Nivel de Eficacia"
                        sx={{ borderRadius: '12px' }}
                      >
                        <MenuItem value="Muy Baja">Muy Baja (0-20%)</MenuItem>
                        <MenuItem value="Baja">Baja (21-40%)</MenuItem>
                        <MenuItem value="Media">Media (41-60%)</MenuItem>
                        <MenuItem value="Alta">Alta (61-80%)</MenuItem>
                        <MenuItem value="Muy Alta">Muy Alta (81-100%)</MenuItem>
                      </Select>
                    </FormControl>
                  </CardContent>
                </Card>
              </Grid>
              
              <Grid item xs={12} md={8}>
                <Card className="card" sx={{ 
                  background: 'linear-gradient(135deg, #F8FAFC 0%, #F1F5F9 100%)',
                  border: '2px solid #E2E8F0',
                  height: '100%'
                }}>
                  <CardContent sx={{ p: 3 }}>
                    <Typography variant="h6" className="font-poppins" sx={{ color: '#1E3A8A', mb: 2 }}>
                      Controles Seleccionados
                    </Typography>
                    <Box sx={{ 
                      display: 'flex',
                      flexWrap: 'wrap',
                      gap: 1.5,
                      minHeight: '60px',
                      alignItems: 'center'
                    }}>
                      {wizardData.controles.seleccionados.length === 0 ? (
                        <Alert severity="warning" sx={{ width: '100%' }}>
                          <Typography variant="body2" sx={{ fontWeight: 600 }}>
                            ⚠️ Es obligatorio seleccionar al menos un control antes de continuar
                          </Typography>
                          <Typography variant="caption" sx={{ display: 'block', mt: 0.5 }}>
                            Selecciona controles de la base de datos, sugerencias ISO 27001/27002/27005, o agrega uno manualmente
                          </Typography>
                        </Alert>
                      ) : (
                        wizardData.controles.seleccionados.map((control, controlIndex) => (
                          <Chip
                            key={`selected-control-chip-${control}-${controlIndex}`}
                            label={control}
                            color="primary"
                            sx={{ 
                              backgroundColor: '#1E3A8A',
                              color: 'white',
                              fontWeight: 500,
                              '&:hover': {
                                backgroundColor: '#1E40AF'
                              }
                            }}
                            onDelete={() => {
                              const seleccionados = wizardData.controles.seleccionados.filter(c => c !== control);
                              setWizardData({
                                ...wizardData,
                                controles: { ...wizardData.controles, seleccionados }
                              });
                            }}
                          />
                        ))
                      )}
                    </Box>
                  </CardContent>
                </Card>
              </Grid>
            </Grid>

            {/* Justificación mejorada con sugerencias */}
            <Card className="card" sx={{ mt: 3 }}>
              <CardContent sx={{ p: 3 }}>
                <Typography variant="h6" className="font-poppins" sx={{ color: '#1E3A8A', mb: 2 }}>
                  Justificación de la Eficacia
                </Typography>
                
                {/* Sugerencias de justificación */}
                {wizardData.controles.seleccionados.length > 0 && (
                  <Box sx={{ mb: 3 }}>
                    <JustificationSuggestions
                      riskType={wizardData.newRiesgo.amenaza}
                      controls={wizardData.controles.seleccionados}
                      onJustificationSelect={(justification) => {
                        setWizardData((prev) => ({
                          ...prev,
                          controles: { 
                            ...prev.controles, 
                            justificacion: prev.controles.justificacion 
                              ? `${prev.controles.justificacion}\n\n${justification}`
                              : justification
                          }
                        }));
                      }}
                    />
                  </Box>
                )}
                
                <TextField
                  fullWidth
                  multiline
                  rows={4}
                  label="Explica por qué los controles seleccionados son efectivos para mitigar este riesgo"
                  placeholder="Describe cómo los controles seleccionados reducen la probabilidad o impacto del riesgo identificado..."
                  value={wizardData.controles.justificacion || ''}
                  onChange={(e) => {
                    const newValue = e.target.value;
                    setWizardData((prev) => ({
                      ...prev,
                      controles: { ...prev.controles, justificacion: newValue }
                    }));
                  }}
                  sx={{ 
                    borderRadius: '12px',
                    '& .MuiOutlinedInput-root': {
                      '&:hover fieldset': {
                        borderColor: '#1E3A8A',
                      },
                      '&.Mui-focused fieldset': {
                        borderColor: '#1E3A8A',
                      },
                    },
                  }}
                />
              </CardContent>
            </Card>
          </Box>
        );

      case 4:
        return (
          <Box>
            <Typography variant="h6" className="font-poppins" sx={{ color: '#1E3A8A', mb: 2 }}>
              Evalúa nuevamente la probabilidad e impacto del riesgo
            </Typography>
            
            <Grid container spacing={3}>
              {/* Evaluación Inherente */}
              <Grid item xs={12} md={6}>
                <Card className="card" sx={{ 
                  background: 'linear-gradient(135deg, #FEF3C7 0%, #FDE68A 100%)',
                  border: '2px solid #F59E0B'
                }}>
                  <CardContent sx={{ p: 3 }}>
                    <Typography variant="h6" className="font-poppins" sx={{ color: '#1E3A8A', mb: 2, textAlign: 'center' }}>
                      Riesgo Inherente
                    </Typography>
                    <Box sx={{ textAlign: 'center', mb: 2 }}>
                      <Typography variant="body2" className="font-roboto" sx={{ color: '#6B7280', mb: 1 }}>
                        Probabilidad: {wizardData.evaluacionInherente.probabilidad || 'No definida'}
                      </Typography>
                      <Typography variant="body2" className="font-roboto" sx={{ color: '#6B7280', mb: 2 }}>
                        Impacto: {wizardData.evaluacionInherente.impacto || 'No definido'}
                      </Typography>
                      <Box sx={{ 
                        display: 'inline-flex',
                        alignItems: 'center',
                        gap: 1,
                        p: 1.5,
                        borderRadius: '8px',
                        backgroundColor: '#FFFFFF',
                        boxShadow: '0 2px 8px rgba(0, 0, 0, 0.1)'
                      }}>
                        <AssessmentIcon sx={{ 
                          fontSize: 24, 
                          color: getRiskColor(wizardData.evaluacionInherente.nivelRiesgo) 
                        }} />
                        <Typography 
                          variant="h6" 
                          className="font-poppins" 
                          sx={{ 
                            color: getRiskColor(wizardData.evaluacionInherente.nivelRiesgo),
                            fontWeight: 600
                          }}
                        >
                          {wizardData.evaluacionInherente.nivelRiesgo || 'Medio'}
                        </Typography>
                      </Box>
                    </Box>
                  </CardContent>
                </Card>
              </Grid>

              {/* Evaluación Residual */}
              <Grid item xs={12} md={6}>
                <Card className="card" sx={{ 
                  background: 'linear-gradient(135deg, #DBEAFE 0%, #BFDBFE 100%)',
                  border: '2px solid #3B82F6'
                }}>
                  <CardContent sx={{ p: 3 }}>
                    <Typography variant="h6" className="font-poppins" sx={{ color: '#1E3A8A', mb: 2, textAlign: 'center' }}>
                      Riesgo Residual
                    </Typography>
                    <Stack spacing={2}>
                      <FormControl fullWidth>
                        <InputLabel>Probabilidad Residual</InputLabel>
                        <Select
                          value={wizardData.evaluacionResidual.probabilidad}
                        onChange={(e) => {
                            const probabilidad = e.target.value;
                            const impacto = wizardData.evaluacionResidual.impacto;
                            const nivelRiesgo = calculateRiskLevel(probabilidad, impacto);
                            setWizardData({
                              ...wizardData,
                              evaluacionResidual: {
                                ...wizardData.evaluacionResidual,
                                probabilidad,
                                nivelRiesgo
                              }
                            });
                          }}
                          label="Probabilidad Residual"
                          sx={{ borderRadius: '12px' }}
                        >
                          <MenuItem value="Improbable">Improbable</MenuItem>
                          <MenuItem value="Posible">Posible</MenuItem>
                          <MenuItem value="Ocasional">Ocasional</MenuItem>
                          <MenuItem value="Probable">Probable</MenuItem>
                          <MenuItem value="Frecuente">Frecuente</MenuItem>
                        </Select>
                      </FormControl>
                      
                      <FormControl fullWidth>
                        <InputLabel>Impacto Residual</InputLabel>
                        <Select
                          value={wizardData.evaluacionResidual.impacto}
                  onChange={(e) => {
                            const impacto = e.target.value;
                            const probabilidad = wizardData.evaluacionResidual.probabilidad;
                            const nivelRiesgo = calculateRiskLevel(probabilidad, impacto);
                            setWizardData({
                              ...wizardData,
                              evaluacionResidual: {
                                ...wizardData.evaluacionResidual,
                                impacto,
                                nivelRiesgo
                              }
                            });
                          }}
                          label="Impacto Residual"
                          sx={{ borderRadius: '12px' }}
                        >
                          <MenuItem value="Insignificante">Insignificante</MenuItem>
                          <MenuItem value="Menor">Menor</MenuItem>
                          <MenuItem value="Moderado">Moderado</MenuItem>
                          <MenuItem value="Mayor">Mayor</MenuItem>
                          <MenuItem value="Catastrófico">Catastrófico</MenuItem>
                        </Select>
                      </FormControl>
                    </Stack>
                    
                    <Box sx={{ textAlign: 'center', mt: 2 }}>
                      <Box sx={{ 
                        display: 'inline-flex',
                        alignItems: 'center',
                        gap: 1,
                        p: 1.5,
                        borderRadius: '8px',
                        backgroundColor: '#FFFFFF',
                        boxShadow: '0 2px 8px rgba(0, 0, 0, 0.1)'
                      }}>
                        <AssessmentIcon sx={{ 
                          fontSize: 24, 
                          color: getRiskColor(wizardData.evaluacionResidual.nivelRiesgo) 
                        }} />
                        <Typography 
                          variant="h6" 
                          className="font-poppins" 
                          sx={{ 
                            color: getRiskColor(wizardData.evaluacionResidual.nivelRiesgo),
                            fontWeight: 600
                          }}
                        >
                          {wizardData.evaluacionResidual.nivelRiesgo || 'Medio'}
                        </Typography>
                      </Box>
                    </Box>
                  </CardContent>
                </Card>
              </Grid>
            </Grid>

            {/* Comparación Visual */}
            <Card className="card" sx={{ mt: 3 }}>
              <CardContent sx={{ p: 3 }}>
                <Typography variant="h6" className="font-poppins" sx={{ color: '#1E3A8A', mb: 2, textAlign: 'center' }}>
                  Comparación de Riesgos
                </Typography>
                <Grid container spacing={2}>
                  <Grid item xs={6}>
                    <Box sx={{ textAlign: 'center' }}>
                      <Typography variant="body2" className="font-roboto" sx={{ color: '#6B7280', mb: 1 }}>
                        Inherente
                      </Typography>
                      <Chip
                        label={wizardData.evaluacionInherente.nivelRiesgo || 'Medio'}
                        sx={{
                          backgroundColor: getRiskColor(wizardData.evaluacionInherente.nivelRiesgo),
                          color: '#FFFFFF',
                          fontWeight: 600,
                          fontSize: '0.875rem'
                        }}
                      />
                    </Box>
                  </Grid>
                  <Grid item xs={6}>
                    <Box sx={{ textAlign: 'center' }}>
                      <Typography variant="body2" className="font-roboto" sx={{ color: '#6B7280', mb: 1 }}>
                        Residual
                      </Typography>
                      <Chip
                        label={wizardData.evaluacionResidual.nivelRiesgo || 'Medio'}
                        sx={{
                          backgroundColor: getRiskColor(wizardData.evaluacionResidual.nivelRiesgo),
                          color: '#FFFFFF',
                          fontWeight: 600,
                          fontSize: '0.875rem'
                        }}
                      />
                    </Box>
                  </Grid>
                </Grid>
              </CardContent>
            </Card>

            <Card className="card" sx={{ mt: 3 }}>
              <CardContent sx={{ p: 3 }}>
                <TextField
                  fullWidth
                  multiline
                  rows={3}
                  label="Justificación de la Evaluación Residual"
                  value={wizardData.evaluacionResidual.justificacion || ''}
                  onChange={(e) => {
                    const newValue = e.target.value;
                    setWizardData((prev) => ({
                      ...prev,
                      evaluacionResidual: { ...prev.evaluacionResidual, justificacion: newValue }
                    }));
                  }}
                  sx={{ borderRadius: '12px' }}
                />
              </CardContent>
            </Card>

            {/* Sugerencias de Riesgo Residual */}
            {wizardData.controles.seleccionados.length > 0 && (
              <Box sx={{ mt: 3 }}>
                <ResidualRiskSuggestions
                  inherentRisk={{
                    probabilidad: wizardData.evaluacionInherente.probabilidad || 'Media',
                    impacto: wizardData.evaluacionInherente.impacto || 'Medio',
                    nivel: wizardData.evaluacionInherente.nivelRiesgo || 'MEDIUM'
                  }}
                  selectedControls={wizardData.controles.seleccionados}
                  onSuggestionSelect={(suggestion) => {
                    setWizardData({
                      ...wizardData,
                      evaluacionResidual: {
                        ...wizardData.evaluacionResidual,
                        probabilidad: suggestion.probabilidad,
                        impacto: suggestion.impacto,
                        nivelRiesgo: suggestion.nivel,
                        justificacion: suggestion.justificacion
                      }
                    });
                  }}
                />
              </Box>
            )}
          </Box>
        );

      case 5:
        return (
          <Box>
            <Typography variant="h6" className="font-poppins" sx={{ color: '#1E3A8A', mb: 2 }}>
              Selecciona la opción de tratamiento para el riesgo
            </Typography>
            
            <Card className="card" sx={{ mb: 3 }}>
              <CardContent sx={{ p: 3 }}>
                <Typography variant="subtitle1" className="font-poppins" sx={{ color: '#1E3A8A', mb: 2 }}>
                  Opciones de Tratamiento
                </Typography>
                <Grid container spacing={2}>
                  {[
                    { 
                      value: 'Aceptar', 
                      label: 'Aceptar el Riesgo', 
                      description: 'Aceptar el riesgo residual y continuar con las operaciones',
                      color: '#10B981',
                      bgColor: '#ECFDF5'
                    },
                    { 
                      value: 'Transferir', 
                      label: 'Transferir el Riesgo', 
                      description: 'Transferir el riesgo a un tercero (seguros, outsourcing)',
                      color: '#3B82F6',
                      bgColor: '#EFF6FF'
                    },
                    { 
                      value: 'Mitigar', 
                      label: 'Mitigar el Riesgo', 
                      description: 'Implementar controles adicionales para reducir el riesgo',
                      color: '#F59E0B',
                      bgColor: '#FFFBEB'
                    },
                    { 
                      value: 'Evitar', 
                      label: 'Evitar el Riesgo', 
                      description: 'Eliminar la actividad o proceso que genera el riesgo',
                      color: '#EF4444',
                      bgColor: '#FEF2F2'
                    }
                  ].map((opcion, opcionIndex) => (
                    <Grid item xs={12} sm={6} key={`tratamiento-opcion-${opcion.value}-${opcionIndex}`}>
                      <Card
                        className="card"
                        sx={{
                          cursor: 'pointer',
                          border: wizardData.tratamiento.opcion === opcion.value ? `2px solid ${opcion.color}` : '1px solid #E5E7EB',
                          backgroundColor: wizardData.tratamiento.opcion === opcion.value ? opcion.bgColor : '#FFFFFF',
                          '&:hover': {
                            transform: 'translateY(-2px)',
                            boxShadow: '0 8px 25px rgba(0, 0, 0, 0.1)',
                          },
                          transition: 'all 0.25s ease'
                        }}
                        onClick={() => setWizardData({
                          ...wizardData,
                          tratamiento: { ...wizardData.tratamiento, opcion: opcion.value }
                        })}
                      >
                        <CardContent sx={{ p: 3 }}>
                          <Typography variant="h6" className="font-poppins" sx={{ color: opcion.color, fontWeight: 600, mb: 1 }}>
                            {opcion.label}
                          </Typography>
                          <Typography variant="body2" className="font-roboto" sx={{ color: '#6B7280' }}>
                            {opcion.description}
                          </Typography>
                        </CardContent>
                      </Card>
                    </Grid>
                  ))}
                </Grid>
              </CardContent>
            </Card>

            {wizardData.tratamiento.opcion && (
              <Card className="card">
                <CardContent sx={{ p: 3 }}>
                  <Typography variant="subtitle1" className="font-poppins" sx={{ color: '#1E3A8A', mb: 2 }}>
                    Detalles del Tratamiento
                  </Typography>
                  <Grid container spacing={2}>
                    <Grid item xs={12} md={6}>
                      <TextField
                        fullWidth
                        label="Responsable"
                        value={wizardData.tratamiento.responsable}
                        onChange={(e) => setWizardData({
                          ...wizardData,
                          tratamiento: { ...wizardData.tratamiento, responsable: e.target.value }
                        })}
                        sx={{ borderRadius: '12px' }}
                      />
                    </Grid>
                    <Grid item xs={12} md={6}>
                      <CurrencyInput
                        fullWidth
                        label="Presupuesto Estimado"
                        value={wizardData.tratamiento.presupuesto}
                        onChange={(value) => setWizardData({
                          ...wizardData,
                          tratamiento: { ...wizardData.tratamiento, presupuesto: value }
                        })}
                        sx={{ borderRadius: '12px' }}
                      />
                    </Grid>
                    <Grid item xs={12}>
                      <DateRangeInput
                        startDate={wizardData.tratamiento.fechaInicio ? new Date(wizardData.tratamiento.fechaInicio) : null}
                        endDate={wizardData.tratamiento.fechaFin ? new Date(wizardData.tratamiento.fechaFin) : null}
                        onStartDateChange={(date) => setWizardData({
                          ...wizardData,
                          tratamiento: { 
                            ...wizardData.tratamiento, 
                            fechaInicio: date ? date.toISOString().split('T')[0] : '' 
                          }
                        })}
                        onEndDateChange={(date) => setWizardData({
                          ...wizardData,
                          tratamiento: { 
                            ...wizardData.tratamiento, 
                            fechaFin: date ? date.toISOString().split('T')[0] : '' 
                          }
                        })}
                        startLabel="Fecha de Inicio"
                        endLabel="Fecha de Finalización"
                      />
                    </Grid>
                  </Grid>
                </CardContent>
              </Card>
            )}
          </Box>
        );

      case 6:
        return (
          <Box>
            <Typography variant="h6" className="font-poppins" sx={{ color: '#1E3A8A', mb: 2 }}>
              Crea un plan de acción concreto para el tratamiento del riesgo
            </Typography>
            
            <EditableActionPlan
              actionItems={wizardData.planAccion.acciones}
              onActionItemsChange={(items) => setWizardData({
                ...wizardData,
                planAccion: { ...wizardData.planAccion, acciones: items }
              })}
            />
          </Box>
        );

      case 7:
        return (
          <Box>
            <Typography variant="h6" className="font-poppins" sx={{ color: '#1E3A8A', mb: 2 }}>
              Resumen final y recomendaciones de la evaluación de riesgos
            </Typography>
            
            {/* Resumen del Activo */}
            <Card className="card" sx={{ mb: 3 }}>
              <CardContent sx={{ p: 3 }}>
                <Typography variant="h6" className="font-poppins" sx={{ color: '#1E3A8A', mb: 2 }}>
                  Activo Evaluado
                </Typography>
                {wizardData.selectedActivo ? (
                  <EvaluationAvatar
                    activo={wizardData.selectedActivo}
                    progreso={getEvaluacionEstado(wizardData.selectedActivo).porcentaje}
                    estado={getEvaluacionEstado(wizardData.selectedActivo).estado}
                    showDetails={true}
                  />
                ) : (
                  <Typography variant="body2" className="font-roboto" sx={{ color: '#6B7280' }}>
                    No se ha seleccionado un activo
                  </Typography>
                )}
              </CardContent>
            </Card>

            {/* Resumen del Riesgo */}
            <Grid container spacing={3} sx={{ mb: 3 }}>
              <Grid item xs={12} md={6}>
                <Card className="card">
                  <CardContent sx={{ p: 3 }}>
                    <Typography variant="h6" className="font-poppins" sx={{ color: '#1E3A8A', mb: 2 }}>
                      Riesgo Identificado
                    </Typography>
                    <Box sx={{ mb: 2 }}>
                      <Typography variant="body2" className="font-roboto" sx={{ color: '#6B7280', mb: 1 }}>
                        <strong>Amenaza:</strong> {wizardData.newRiesgo.amenaza || 'No definida'}
                      </Typography>
                      <Typography variant="body2" className="font-roboto" sx={{ color: '#6B7280', mb: 1 }}>
                        <strong>Vulnerabilidad:</strong> {wizardData.newRiesgo.vulnerabilidad || 'No definida'}
                      </Typography>
                      <Typography variant="body2" className="font-roboto" sx={{ color: '#6B7280' }}>
                        <strong>Descripción:</strong> {wizardData.newRiesgo.descripcion || 'No definida'}
                      </Typography>
                    </Box>
                  </CardContent>
                </Card>
              </Grid>

              <Grid item xs={12} md={6}>
                <Card className="card">
                  <CardContent sx={{ p: 3 }}>
                    <Typography variant="h6" className="font-poppins" sx={{ color: '#1E3A8A', mb: 2 }}>
                      Evaluación de Riesgo
                    </Typography>
                    <Grid container spacing={2}>
                      <Grid item xs={6}>
                        <Box sx={{ textAlign: 'center' }}>
                          <Typography variant="body2" className="font-roboto" sx={{ color: '#6B7280', mb: 1 }}>
                            Inherente
                          </Typography>
                          <Chip
                            label={wizardData.evaluacionInherente.nivelRiesgo || 'Medio'}
                            sx={{
                              backgroundColor: getRiskColor(wizardData.evaluacionInherente.nivelRiesgo),
                              color: '#FFFFFF',
                              fontWeight: 600
                            }}
                          />
                        </Box>
                      </Grid>
                      <Grid item xs={6}>
                        <Box sx={{ textAlign: 'center' }}>
                          <Typography variant="body2" className="font-roboto" sx={{ color: '#6B7280', mb: 1 }}>
                            Residual
                          </Typography>
                          <Chip
                            label={wizardData.evaluacionResidual.nivelRiesgo || 'Medio'}
                            sx={{
                              backgroundColor: getRiskColor(wizardData.evaluacionResidual.nivelRiesgo),
                              color: '#FFFFFF',
                              fontWeight: 600
                            }}
                          />
                        </Box>
                      </Grid>
                    </Grid>
                  </CardContent>
                </Card>
              </Grid>
            </Grid>

            {/* Controles y Tratamiento */}
            <Grid container spacing={3} sx={{ mb: 3 }}>
              <Grid item xs={12} md={6}>
                <Card className="card">
                  <CardContent sx={{ p: 3 }}>
                    <Typography variant="h6" className="font-poppins" sx={{ color: '#1E3A8A', mb: 2 }}>
                      Controles Implementados
                    </Typography>
                    <Box sx={{ mb: 2 }}>
                      <Typography variant="body2" className="font-roboto" sx={{ color: '#6B7280', mb: 1 }}>
                        <strong>Controles:</strong> {wizardData.controles.seleccionados.length} seleccionados
                      </Typography>
                      <Typography variant="body2" className="font-roboto" sx={{ color: '#6B7280', mb: 1 }}>
                        <strong>Eficacia:</strong> {wizardData.controles.eficacia || 'No definida'}
                      </Typography>
                    </Box>
                    <Box sx={{ display: 'flex', flexWrap: 'wrap', gap: 1 }}>
                      {wizardData.controles.seleccionados.map((control, controlIndex) => (
                        <Chip
                          key={`summary-control-chip-${control}-${controlIndex}`}
                          label={control}
                          size="small"
                          sx={{
                            backgroundColor: '#1E3A8A',
                            color: '#FFFFFF',
                            fontWeight: 500
                          }}
                        />
                      ))}
                    </Box>
                  </CardContent>
                </Card>
              </Grid>

              <Grid item xs={12} md={6}>
                <Card className="card">
                  <CardContent sx={{ p: 3 }}>
                    <Typography variant="h6" className="font-poppins" sx={{ color: '#1E3A8A', mb: 2 }}>
                      Tratamiento Seleccionado
                    </Typography>
                    <Box sx={{ mb: 2 }}>
                      <Typography variant="body2" className="font-roboto" sx={{ color: '#6B7280', mb: 1 }}>
                        <strong>Opción:</strong> {wizardData.tratamiento.opcion || 'No seleccionada'}
                      </Typography>
                      <Typography variant="body2" className="font-roboto" sx={{ color: '#6B7280', mb: 1 }}>
                        <strong>Responsable:</strong> {wizardData.tratamiento.responsable || 'No asignado'}
                      </Typography>
                      <Typography variant="body2" className="font-roboto" sx={{ color: '#6B7280', mb: 1 }}>
                        <strong>Presupuesto:</strong> ${wizardData.tratamiento.presupuesto || '0'}
                      </Typography>
                      <Typography variant="body2" className="font-roboto" sx={{ color: '#6B7280' }}>
                        <strong>Período:</strong> {wizardData.tratamiento.fechaInicio} - {wizardData.tratamiento.fechaFin}
                      </Typography>
                    </Box>
                  </CardContent>
                </Card>
              </Grid>
            </Grid>

            {/* Plan de Acción */}
            <Card className="card" sx={{ mb: 3 }}>
              <CardContent sx={{ p: 3 }}>
                <Typography variant="h6" className="font-poppins" sx={{ color: '#1E3A8A', mb: 2 }}>
                  Plan de Acción
                </Typography>
                {wizardData.planAccion.acciones.length > 0 ? (
                  <Box>
                    <Typography variant="body2" className="font-roboto" sx={{ color: '#6B7280', mb: 2 }}>
                      <strong>Total de acciones:</strong> {wizardData.planAccion.acciones.length}
                    </Typography>
                    <List>
                      {wizardData.planAccion.acciones.map((accion, accionIndex) => (
                        <ListItem key={accion.id || `accion-${accionIndex}-${accion.descripcion}`} sx={{ px: 0 }}>
                          <ListItemText
                            primary={
                              <Typography variant="body1" className="font-roboto" sx={{ color: '#374151', fontWeight: 500 }}>
                                {accion.descripcion}
                              </Typography>
                            }
                            secondary={
                              <Typography variant="body2" className="font-roboto" sx={{ color: '#6B7280' }}>
                                {accion.responsable} • {accion.estado}
                              </Typography>
                            }
                          />
                        </ListItem>
                      ))}
                    </List>
                  </Box>
                ) : (
                  <Typography variant="body2" className="font-roboto" sx={{ color: '#6B7280' }}>
                    No hay acciones definidas en el plan
                  </Typography>
                )}
              </CardContent>
            </Card>

            {/* Recomendaciones */}
            <Card className="card" sx={{ mb: 3 }}>
              <CardContent sx={{ p: 3 }}>
                <Typography variant="h6" className="font-poppins" sx={{ color: '#1E3A8A', mb: 2 }}>
                  Recomendaciones Automáticas
                </Typography>
                <Box sx={{ display: 'flex', alignItems: 'center', gap: 2, mb: 2 }}>
                  <InfoIcon sx={{ color: '#3B82F6' }} />
                  <Typography variant="body1" className="font-roboto" sx={{ color: '#374151' }}>
                    Revisar periódicamente la efectividad de los controles implementados
                  </Typography>
                </Box>
                <Box sx={{ display: 'flex', alignItems: 'center', gap: 2, mb: 2 }}>
                  <WarningIcon sx={{ color: '#F59E0B' }} />
                  <Typography variant="body1" className="font-roboto" sx={{ color: '#374151' }}>
                    Monitorear el progreso de las acciones del plan de tratamiento
                  </Typography>
                </Box>
                <Box sx={{ display: 'flex', alignItems: 'center', gap: 2 }}>
                  <CheckCircleIcon sx={{ color: '#10B981' }} />
                  <Typography variant="body1" className="font-roboto" sx={{ color: '#374151' }}>
                    Actualizar la evaluación de riesgo cada 6 meses o cuando cambien las condiciones
                  </Typography>
                </Box>
              </CardContent>
            </Card>

            {/* Botones de Acción */}
            <Card className="card">
              <CardContent sx={{ p: 3 }}>
                <Typography variant="h6" className="font-poppins" sx={{ color: '#1E3A8A', mb: 2 }}>
                  Exportar Resultados
                </Typography>
                <Box sx={{ display: 'flex', gap: 2, flexWrap: 'wrap' }}>
                  <Button
                    variant="outlined"
                    startIcon={<DownloadIcon />}
                    className="btn btn-secondary"
                    onClick={exportToPDF}
                    disabled={isExportando}
                    sx={{
                      borderRadius: '12px',
                      px: 3,
                      py: 1.5,
                      textTransform: 'none',
                      fontWeight: 500
                    }}
                  >
                    {isExportando ? 'Exportando...' : 'Exportar a PDF'}
                  </Button>
                  <Button
                    variant="outlined"
                    startIcon={<DownloadIcon />}
                    className="btn btn-secondary"
                    onClick={exportToExcel}
                    disabled={isExportando}
                    sx={{
                      borderRadius: '12px',
                      px: 3,
                      py: 1.5,
                      textTransform: 'none',
                      fontWeight: 500
                    }}
                  >
                    {isExportando ? 'Exportando...' : 'Exportar a Excel'}
                  </Button>
                  <Button
                    variant="contained"
                    startIcon={<SaveIcon />}
                    className="btn btn-primary"
                    onClick={guardarEvaluacion}
                    disabled={isExportando}
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
                      transition: 'all 0.25s cubic-bezier(0.4, 0, 0.2, 1)'
                    }}
                  >
                    {isExportando ? 'Guardando...' : 'Guardar Evaluación'}
                  </Button>
                </Box>
              </CardContent>
            </Card>

            {/* Mensaje de Confirmación */}
            {isEvaluacionCompletada && (
              <Card className="card" sx={{ mb: 3, border: '2px solid #10B981' }}>
                <CardContent sx={{ p: 3, textAlign: 'center' }}>
                  <CheckCircleIcon sx={{ fontSize: 64, color: '#10B981', mb: 2 }} />
                  <Typography variant="h5" className="font-poppins" sx={{ color: '#10B981', fontWeight: 600, mb: 1 }}>
                    ¡Riesgo Evaluado Exitosamente!
                  </Typography>
                  <Typography variant="body1" className="font-roboto" sx={{ color: '#6B7280', mb: 3 }}>
                    La evaluación de riesgo ha sido completada y guardada en el sistema.
                  </Typography>
                  
                  {/* Opciones al finalizar */}
                  <Box sx={{ display: 'flex', gap: 2, justifyContent: 'center', flexWrap: 'wrap' }}>
                    <Button
                      variant="contained"
                      startIcon={<AddIcon />}
                    onClick={() => {
                        setWizardData({
                          selectedActivo: null,
                          newRiesgo: { amenaza: '', vulnerabilidad: '', descripcion: '', tipoRiesgo: '' },
                          evaluacionInherente: { probabilidad: '', impacto: '', nivelRiesgo: '', justificacion: '' },
                          controlesExistentes: { controles: [], eficacia: '', justificacion: '' },
                          evaluacionResidual: { probabilidad: '', impacto: '', nivelRiesgo: '', justificacion: '' },
                          tratamiento: { opcion: '', responsable: '', fechaInicio: '', fechaFin: '', presupuesto: '' },
                          planAccion: { acciones: [] }
                        });
                        setActiveStep(0);
                        setIsEvaluacionCompletada(false);
                      }}
                      sx={{
                        backgroundColor: '#1E3A8A',
                        '&:hover': { backgroundColor: '#1E40AF' },
                        borderRadius: '12px',
                        px: 3,
                        py: 1.5,
                        textTransform: 'none',
                        fontWeight: 500
                      }}
                    >
                      Evaluar Nuevo Activo
                    </Button>
                    
                    <Button
                      variant="outlined"
                      startIcon={<InfoIcon />}
                      onClick={() => {
                        // Aquí podrías abrir un modal con el resumen detallado
                        console.log('Mostrar resumen detallado');
                      }}
                      sx={{
                        borderColor: '#1E3A8A',
                        color: '#1E3A8A',
                        '&:hover': { 
                          borderColor: '#1E40AF',
                          backgroundColor: '#F8FAFC'
                        },
                        borderRadius: '12px',
                        px: 3,
                        py: 1.5,
                        textTransform: 'none',
                        fontWeight: 500
                      }}
                    >
                      Ver Resumen Detallado
                    </Button>
                    
                    <Button
                      variant="outlined"
                      startIcon={<ArrowBackIcon />}
                      onClick={() => {
                        setActiveStep(0);
                        setIsEvaluacionCompletada(false);
                      }}
                      sx={{
                        borderColor: '#6B7280',
                        color: '#6B7280',
                        '&:hover': { 
                          borderColor: '#4B5563',
                          backgroundColor: '#F9FAFB'
                        },
                        borderRadius: '12px',
                        px: 3,
                        py: 1.5,
                        textTransform: 'none',
                        fontWeight: 500
                      }}
                    >
                      Volver al Inicio
                    </Button>
                  </Box>
                </CardContent>
              </Card>
            )}
          </Box>
        );

      default:
        return (
          <Box sx={{ textAlign: 'center', py: 4 }}>
            <Typography variant="h6" className="font-poppins" sx={{ color: '#1E3A8A', mb: 2 }}>
              Paso {step + 1}: {steps[step]}
            </Typography>
            <Typography variant="body1" className="font-roboto" sx={{ color: '#6B7280' }}>
              Contenido en desarrollo...
            </Typography>
          </Box>
        );
    }
  };

  return (
    <Box>
        {/* Header */}
      <Box sx={{ mb: 4 }}>
        <Box sx={{ display: 'flex', alignItems: 'center', gap: 2, mb: 2 }}>
          <Typography variant="h4" className="font-poppins" sx={{ color: '#1E3A8A', fontWeight: 600 }}>
            Evaluación de Riesgos
          </Typography>
          {wizardData.selectedActivo && (
            <Chip
              label={`Activo: ${wizardData.selectedActivo.Nombre || wizardData.selectedActivo.nombre || 'Sin nombre'}`}
              sx={{
                backgroundColor: '#1E3A8A',
                color: 'white',
                fontWeight: 500,
                fontSize: '0.875rem',
                height: '32px'
              }}
            />
          )}
        </Box>
        <Typography variant="body1" className="font-roboto" sx={{ color: '#6B7280' }}>
          {wizardData.selectedActivo 
            ? `Evaluando activo: ${wizardData.selectedActivo.Nombre || wizardData.selectedActivo.nombre || 'Sin nombre'} - ${wizardData.selectedActivo.Tipo_Activo || wizardData.selectedActivo.tipo || 'Sin tipo'}`
            : 'Wizard paso a paso para la evaluación integral de riesgos en activos de información'
          }
        </Typography>
      </Box>

      {/* Progress Stepper */}
      <Card className="card" sx={{ mb: 4 }}>
        <CardContent sx={{ p: 3 }}>
          <Box sx={{ display: 'flex', alignItems: 'center', justifyContent: 'space-between', mb: 2 }}>
            <Typography variant="h6" className="font-poppins" sx={{ color: '#1E3A8A' }}>
              Progreso: {Math.round(((activeStep + 1) / steps.length) * 100)}% - Paso {activeStep + 1} de {steps.length}
            </Typography>
            <Chip
              label={`${activeStep + 1}/${steps.length}`}
              sx={{
                backgroundColor: '#1E3A8A',
                color: '#FFFFFF',
                fontWeight: 600
              }}
            />
          </Box>
          
          <Box id="wizard-content">
          <Stepper activeStep={activeStep} alternativeLabel>
            {steps.map((label, index) => {
              const stepColor = getStepColor(index);
              const isEvaluationStep = [2, 3, 5].includes(index); // Identificación de Riesgo, Evaluación Inherente, Evaluación Residual
              
              return (
                <Step key={`step-${index}-${label}`}>
                  <StepLabel
                    sx={{
                      '& .MuiStepLabel-label': {
                        fontFamily: "'Roboto', sans-serif",
                        fontSize: '0.875rem',
                        color: stepColor,
                        fontWeight: isEvaluationStep ? 600 : 400
                      },
                      '& .MuiStepIcon-root': {
                        color: stepColor,
                        '&.Mui-active': {
                          color: stepColor
                        },
                        '&.Mui-completed': {
                          color: stepColor
                        }
                      }
                    }}
                  >
                    {label}
                    {isEvaluationStep && wizardData.selectedActivo && (
                      <Box sx={{ mt: 0.5 }}>
                        <Chip
                          label={
                            getEvaluacionEstado(wizardData.selectedActivo).estado === 'completa' ? 'Completa' :
                            getEvaluacionEstado(wizardData.selectedActivo).estado === 'parcial' ? `${getEvaluacionEstado(wizardData.selectedActivo).porcentaje}%` :
                            'Pendiente'
                          }
                          size="small"
                          sx={{
                            backgroundColor: `${stepColor}20`,
                            color: stepColor,
                            fontWeight: 500,
                            fontSize: '0.75rem',
                            height: 20
                          }}
                        />
                      </Box>
                    )}
                  </StepLabel>
                </Step>
              );
            })}
          </Stepper>
          </Box>
        </CardContent>
      </Card>

      {/* Step Content */}
      <Card className="card">
        <CardContent sx={{ p: 4 }}>
          {renderStepContent(activeStep)}
        </CardContent>
      </Card>

        {/* Navigation */}
      <Box sx={{ display: 'flex', justifyContent: 'space-between', mt: 4 }}>
        <Button
          variant="outlined"
          startIcon={<ArrowBackIcon />}
          onClick={handleBack}
          disabled={activeStep === 0}
          className="btn btn-secondary"
          sx={{
            borderRadius: '12px',
            px: 4,
            py: 1.5,
            textTransform: 'none',
            fontWeight: 500
          }}
        >
              Anterior
        </Button>
        
        <Button
          variant="contained"
          endIcon={<ArrowForwardIcon />}
          onClick={activeStep === steps.length - 1 ? finalizarEvaluacion : handleNext}
          disabled={activeStep === steps.length - 1 && !isEvaluacionCompletada}
          className="btn btn-primary"
          sx={{
            background: 'linear-gradient(135deg, #1E3A8A 0%, #3B82F6 100%)',
            color: '#FFFFFF',
            borderRadius: '12px',
            px: 4,
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
          {activeStep === steps.length - 1 ? 'Finalizar' : 'Siguiente'}
        </Button>
      </Box>

      {/* Dialog para agregar acciones */}
      <Dialog open={openAccionDialog} onClose={() => setOpenAccionDialog(false)} maxWidth="md" fullWidth>
        <DialogTitle className="font-poppins" sx={{ color: '#1E3A8A' }}>
          Agregar Acción al Plan
        </DialogTitle>
        <DialogContent>
          <Stack spacing={2} sx={{ mt: 1 }}>
            <TextField
              fullWidth
              label="Descripción de la Acción"
              value={newAccion.descripcion}
              onChange={(e) => setNewAccion({ ...newAccion, descripcion: e.target.value })}
              sx={{ borderRadius: '12px' }}
            />
            <Grid container spacing={2}>
              <Grid item xs={6}>
                <TextField
                  fullWidth
                  label="Responsable"
                  value={newAccion.responsable}
                  onChange={(e) => setNewAccion({ ...newAccion, responsable: e.target.value })}
                  sx={{ borderRadius: '12px' }}
                />
              </Grid>
              <Grid item xs={6}>
                <FormControl fullWidth>
                  <InputLabel>Estado</InputLabel>
                  <Select
                    value={newAccion.estado}
                    onChange={(e) => setNewAccion({ ...newAccion, estado: e.target.value })}
                    label="Estado"
                    sx={{ borderRadius: '12px' }}
                  >
                    <MenuItem value="Pendiente">Pendiente</MenuItem>
                    <MenuItem value="En Progreso">En Progreso</MenuItem>
                    <MenuItem value="Completado">Completado</MenuItem>
                    <MenuItem value="Cancelado">Cancelado</MenuItem>
                  </Select>
                </FormControl>
              </Grid>
            </Grid>
            <Grid container spacing={2}>
              <Grid item xs={6}>
                <TextField
                  fullWidth
                  type="date"
                  label="Fecha de Inicio"
                  value={newAccion.fechaInicio}
                  onChange={(e) => setNewAccion({ ...newAccion, fechaInicio: e.target.value })}
                  InputLabelProps={{ shrink: true }}
                  sx={{ borderRadius: '12px' }}
                />
              </Grid>
              <Grid item xs={6}>
                <TextField
                  fullWidth
                  type="date"
                  label="Fecha de Fin"
                  value={newAccion.fechaFin}
                  onChange={(e) => setNewAccion({ ...newAccion, fechaFin: e.target.value })}
                  InputLabelProps={{ shrink: true }}
                  sx={{ borderRadius: '12px' }}
                />
              </Grid>
            </Grid>
            <TextField
              fullWidth
              multiline
              rows={2}
              label="Comentarios"
              value={newAccion.comentarios}
              onChange={(e) => setNewAccion({ ...newAccion, comentarios: e.target.value })}
              sx={{ borderRadius: '12px' }}
            />
            
            {/* Gestión de documentos */}
            <Box sx={{ mt: 3 }}>
              <DocumentManager
                accionId={newAccion.id || 'temp'}
                documentos={newAccion.documentos}
                onDocumentosChange={(documentos) => setNewAccion({ ...newAccion, documentos })}
              />
            </Box>
          </Stack>
        </DialogContent>
        <DialogActions>
          <Button onClick={() => setOpenAccionDialog(false)}>Cancelar</Button>
          <Button onClick={addAccion} variant="contained">Agregar</Button>
        </DialogActions>
      </Dialog>

      {/* Snackbars para mensajes */}
      <Snackbar
        open={showSuccessMessage}
        autoHideDuration={6000}
        onClose={() => setShowSuccessMessage(false)}
        anchorOrigin={{ vertical: 'top', horizontal: 'center' }}
      >
        <Alert 
          onClose={() => setShowSuccessMessage(false)} 
          severity="success" 
          sx={{ width: '100%' }}
        >
          ¡Evaluación completada exitosamente!
        </Alert>
      </Snackbar>

      <Snackbar
        open={showExportMessage}
        autoHideDuration={4000}
        onClose={() => setShowExportMessage(false)}
        anchorOrigin={{ vertical: 'bottom', horizontal: 'right' }}
      >
        <Alert 
          onClose={() => setShowExportMessage(false)} 
          severity="info" 
          sx={{ width: '100%' }}
        >
          {exportMessage}
        </Alert>
      </Snackbar>

      {/* Diálogo para crear activo */}
      <Dialog open={openDialog} onClose={handleCloseDialog} maxWidth="lg" fullWidth>
        <DialogTitle sx={{ 
          backgroundColor: '#1E3A8A', 
          color: 'white',
          display: 'flex',
          alignItems: 'center',
          gap: 2,
          pb: 3,
          pt: 3,
          px: 3
        }}>
          <SecurityIcon />
          <Box>
            <Typography variant="h6" className="font-poppins">
              Crear Nuevo Activo
            </Typography>
            <Typography variant="body2" sx={{ opacity: 0.9 }}>
              Agrega un nuevo activo al inventario
            </Typography>
          </Box>
        </DialogTitle>
        <DialogContent sx={{ pt: 6, px: 4, pb: 4, mt: 3 }}>
          <Grid container spacing={4}>
            <Grid item xs={12} md={6}>
              <TextField
                fullWidth
                label="Nombre del Activo *"
                value={formData.nombre}
                onChange={(e) => setFormData({ ...formData, nombre: e.target.value })}
                className="input"
              />
            </Grid>
            <Grid item xs={12} md={6}>
              <FormControl fullWidth required>
                <InputLabel id="wizard-tipo-activo-label" sx={{ mt: 0.5 }}>Tipo de Activo *</InputLabel>
                <Select
                  labelId="wizard-tipo-activo-label"
                  value={formData.tipo}
                  onChange={(e) => setFormData({ ...formData, tipo: e.target.value })}
                  label="Tipo de Activo *"
                  sx={{ borderRadius: '12px', minWidth: '200px' }}
                  MenuProps={{
                    PaperProps: {
                      style: {
                        maxHeight: 300,
                      },
                    },
                  }}
                >
                  <MenuItem value="Hardware">Hardware</MenuItem>
                  <MenuItem value="Sistema de Información">Sistema de Información</MenuItem>
                  <MenuItem value="Software">Software</MenuItem>
                  <MenuItem value="Infraestructura">Infraestructura</MenuItem>
                  <MenuItem value="Datos">Datos</MenuItem>
                  <MenuItem value="Personal">Personal</MenuItem>
                </Select>
              </FormControl>
            </Grid>
            <Grid item xs={12}>
              <TextField
                fullWidth
                label="Descripción del Activo"
                multiline
                rows={3}
                value={formData.descripcion}
                onChange={(e) => setFormData({ ...formData, descripcion: e.target.value })}
                className="input"
              />
            </Grid>
            <Grid item xs={12} md={6}>
              <FormControl fullWidth>
                <InputLabel id="wizard-estado-activo-label" sx={{ mt: 0.5 }}>Estado del Activo</InputLabel>
                <Select
                  labelId="wizard-estado-activo-label"
                  value={formData.estado}
                  onChange={(e) => setFormData({ ...formData, estado: e.target.value })}
                  label="Estado del Activo"
                  sx={{ borderRadius: '12px', minWidth: '200px' }}
                  MenuProps={{
                    PaperProps: {
                      style: {
                        maxHeight: 300,
                      },
                    },
                  }}
                >
                  <MenuItem value="Planificado">Planificado</MenuItem>
                  <MenuItem value="En desarrollo">En desarrollo</MenuItem>
                  <MenuItem value="En produccion">En producción</MenuItem>
                  <MenuItem value="Mantenimiento">Mantenimiento</MenuItem>
                </Select>
              </FormControl>
            </Grid>
            <Grid item xs={12} md={6}>
              <FormControl fullWidth>
                <InputLabel id="wizard-criticidad-label" sx={{ mt: 0.5 }}>Nivel de Criticidad</InputLabel>
                <Select
                  labelId="wizard-criticidad-label"
                  value={formData.criticidad}
                  onChange={(e) => setFormData({ ...formData, criticidad: e.target.value })}
                  label="Nivel de Criticidad"
                  sx={{ borderRadius: '12px', minWidth: '200px' }}
                  MenuProps={{
                    PaperProps: {
                      style: {
                        maxHeight: 300,
                      },
                    },
                  }}
                >
                  <MenuItem value="Bajo">Bajo</MenuItem>
                  <MenuItem value="Medio">Medio</MenuItem>
                  <MenuItem value="Alto">Alto</MenuItem>
                  <MenuItem value="Crítico">Crítico</MenuItem>
                </Select>
              </FormControl>
            </Grid>
          </Grid>
        </DialogContent>
        <DialogActions sx={{ p: 3, gap: 2 }}>
          <Button 
            onClick={handleCloseDialog}
            variant="outlined"
            sx={{ borderRadius: '8px' }}
          >
            Cancelar
          </Button>
          <Button 
            onClick={handleCreateActivo}
            variant="contained"
            sx={{ 
              borderRadius: '8px',
              backgroundColor: '#1E3A8A',
              '&:hover': {
                backgroundColor: '#1E40AF',
              }
            }}
          >
            Crear Activo
          </Button>
        </DialogActions>
      </Dialog>

      {/* Diálogo para crear nuevo riesgo */}
      <Dialog 
        open={openRiesgoDialog} 
        onClose={handleCloseRiesgoDialog} 
        maxWidth="md" 
        fullWidth
        PaperProps={{
          sx: {
            borderRadius: '16px',
            boxShadow: '0 10px 40px rgba(0,0,0,0.15)'
          }
        }}
      >
        {/* Encabezado separado */}
        <Box sx={{ 
          backgroundColor: '#1E3A8A', 
          color: 'white',
          p: 3,
          borderTopLeftRadius: '16px',
          borderTopRightRadius: '16px'
        }}>
          <Box sx={{ display: 'flex', alignItems: 'center', gap: 2, mb: 1 }}>
            <WarningIcon sx={{ fontSize: 28 }} />
            <Typography variant="h5" className="font-poppins" sx={{ fontWeight: 600 }}>
              Crear Nuevo Riesgo
            </Typography>
          </Box>
          <Typography variant="body2" sx={{ opacity: 0.9, ml: 5 }}>
            Define un nuevo riesgo específico para este activo
          </Typography>
        </Box>

        {/* Contenido del formulario */}
        <DialogContent sx={{ p: 0 }}>
          <Box sx={{ p: 4, pt: 3 }}>
            <Grid container spacing={3}>
              <Grid item xs={12}>
                <TextField
                  fullWidth
                  label="Nombre del Riesgo *"
                  value={riesgoFormData.nombre}
                  onChange={(e) => setRiesgoFormData({ ...riesgoFormData, nombre: e.target.value })}
                  sx={{
                    '& .MuiOutlinedInput-root': {
                      borderRadius: '12px',
                      backgroundColor: '#F9FAFB',
                      '& fieldset': {
                        borderColor: '#E5E7EB',
                        borderWidth: '2px'
                      },
                      '&:hover fieldset': {
                        borderColor: '#1E3A8A',
                      },
                      '&.Mui-focused fieldset': {
                        borderColor: '#1E3A8A',
                        borderWidth: '2px'
                      }
                    },
                    '& .MuiInputLabel-root.Mui-focused': {
                      color: '#1E3A8A'
                    }
                  }}
                  placeholder="Ej: Pérdida de datos por acceso no autorizado"
                />
              </Grid>
              
              <Grid item xs={12} md={6}>
                <FormControl fullWidth>
                  <InputLabel sx={{ 
                    '&.Mui-focused': { color: '#1E3A8A' }
                  }}>Amenaza *</InputLabel>
                  <Select
                    value={riesgoFormData.amenaza}
                    onChange={(e) => setRiesgoFormData({ ...riesgoFormData, amenaza: e.target.value })}
                    label="Amenaza *"
                    sx={{
                      borderRadius: '12px',
                      backgroundColor: '#F9FAFB',
                      '& .MuiOutlinedInput-notchedOutline': {
                        borderColor: '#E5E7EB',
                        borderWidth: '2px'
                      },
                      '&:hover .MuiOutlinedInput-notchedOutline': {
                        borderColor: '#1E3A8A'
                      },
                      '&.Mui-focused .MuiOutlinedInput-notchedOutline': {
                        borderColor: '#1E3A8A',
                        borderWidth: '2px'
                      }
                    }}
                  >
                    <MenuItem value="Malware">Malware</MenuItem>
                    <MenuItem value="Ataques de Phishing">Ataques de Phishing</MenuItem>
                    <MenuItem value="Acceso No Autorizado">Acceso No Autorizado</MenuItem>
                    <MenuItem value="Pérdida de Datos">Pérdida de Datos</MenuItem>
                    <MenuItem value="Interrupción del Servicio">Interrupción del Servicio</MenuItem>
                    <MenuItem value="Acceso Físico No Controlado">Acceso Físico No Controlado</MenuItem>
                    <MenuItem value="Ingeniería Social">Ingeniería Social</MenuItem>
                    <MenuItem value="Ataques DDoS">Ataques DDoS</MenuItem>
                  </Select>
                </FormControl>
              </Grid>
              
              <Grid item xs={12} md={6}>
                <FormControl fullWidth>
                  <InputLabel sx={{ 
                    '&.Mui-focused': { color: '#1E3A8A' }
                  }}>Vulnerabilidad *</InputLabel>
                  <Select
                    value={riesgoFormData.vulnerabilidad}
                    onChange={(e) => setRiesgoFormData({ ...riesgoFormData, vulnerabilidad: e.target.value })}
                    label="Vulnerabilidad *"
                    sx={{
                      borderRadius: '12px',
                      backgroundColor: '#F9FAFB',
                      '& .MuiOutlinedInput-notchedOutline': {
                        borderColor: '#E5E7EB',
                        borderWidth: '2px'
                      },
                      '&:hover .MuiOutlinedInput-notchedOutline': {
                        borderColor: '#1E3A8A'
                      },
                      '&.Mui-focused .MuiOutlinedInput-notchedOutline': {
                        borderColor: '#1E3A8A',
                        borderWidth: '2px'
                      }
                    }}
                  >
                    <MenuItem value="Configuración Insegura">Configuración Insegura</MenuItem>
                    <MenuItem value="Software Desactualizado">Software Desactualizado</MenuItem>
                    <MenuItem value="Falta de Autenticación">Falta de Autenticación</MenuItem>
                    <MenuItem value="Acceso Físico No Controlado">Acceso Físico No Controlado</MenuItem>
                    <MenuItem value="Falta de Respaldo">Falta de Respaldo</MenuItem>
                    <MenuItem value="Contraseñas Débiles">Contraseñas Débiles</MenuItem>
                    <MenuItem value="Falta de Cifrado">Falta de Cifrado</MenuItem>
                    <MenuItem value="Ausencia de Monitoreo">Ausencia de Monitoreo</MenuItem>
                  </Select>
                </FormControl>
              </Grid>
              
              <Grid item xs={12}>
                <TextField
                  fullWidth
                  label="Descripción del Riesgo"
                  multiline
                  rows={5}
                  placeholder="Describe detalladamente el riesgo identificado, sus causas, consecuencias y contexto..."
                  value={riesgoFormData.descripcion}
                  onChange={(e) => setRiesgoFormData({ ...riesgoFormData, descripcion: e.target.value })}
                  sx={{
                    '& .MuiOutlinedInput-root': {
                      borderRadius: '12px',
                      backgroundColor: '#F9FAFB',
                      '& fieldset': {
                        borderColor: '#E5E7EB',
                        borderWidth: '2px'
                      },
                      '&:hover fieldset': {
                        borderColor: '#1E3A8A',
                      },
                      '&.Mui-focused fieldset': {
                        borderColor: '#1E3A8A',
                        borderWidth: '2px'
                      }
                    },
                    '& .MuiInputLabel-root.Mui-focused': {
                      color: '#1E3A8A'
                    }
                  }}
                />
              </Grid>
            </Grid>
          </Box>
        </DialogContent>

        {/* Acciones separadas */}
        <Divider />
        <DialogActions sx={{ p: 3, gap: 2, backgroundColor: '#F9FAFB' }}>
          <Button 
            onClick={handleCloseRiesgoDialog}
            variant="outlined"
            sx={{ 
              borderRadius: '10px',
              px: 3,
              py: 1.5,
              borderColor: '#D1D5DB',
              color: '#374151',
              textTransform: 'none',
              fontWeight: 500,
              '&:hover': {
                borderColor: '#9CA3AF',
                backgroundColor: '#F3F4F6'
              }
            }}
          >
            Cancelar
          </Button>
          <Button 
            onClick={handleCreateRiesgo}
            variant="contained"
            disabled={!riesgoFormData.nombre || !riesgoFormData.amenaza || !riesgoFormData.vulnerabilidad}
            sx={{ 
              borderRadius: '10px',
              px: 4,
              py: 1.5,
              backgroundColor: '#1E3A8A',
              textTransform: 'none',
              fontWeight: 600,
              boxShadow: '0 4px 12px rgba(30, 58, 138, 0.3)',
              '&:hover': {
                backgroundColor: '#1E40AF',
                boxShadow: '0 6px 16px rgba(30, 58, 138, 0.4)'
              },
              '&:disabled': {
                backgroundColor: '#9CA3AF',
                color: '#FFFFFF'
              }
            }}
          >
            Crear Riesgo
          </Button>
        </DialogActions>
      </Dialog>

      {/* Ficha de detalles del activo */}
      <ActivoDetailCard
        open={openDetailDialog}
        onClose={() => setOpenDetailDialog(false)}
        activo={selectedActivoDetail}
        onEdit={() => {
          setOpenDetailDialog(false);
          setOpenDialog(true);
        }}
        onEvaluate={() => {
          setOpenDetailDialog(false);
          // El activo ya está seleccionado, solo necesitamos continuar con la evaluación
          if (wizardData.selectedActivo) {
            setActiveStep(1); // Ir al siguiente paso (Identificación de Riesgo)
          }
        }}
      />

      {/* Modal de resumen de evaluación */}
      <Dialog 
        open={openSummaryDialog} 
        onClose={() => setOpenSummaryDialog(false)} 
        maxWidth="md" 
        fullWidth
        PaperProps={{
          sx: { borderRadius: '16px' }
        }}
      >
        <DialogTitle className="font-poppins" sx={{ color: '#1E3A8A', pb: 1 }}>
          <Box sx={{ display: 'flex', alignItems: 'center', gap: 2 }}>
            <CheckCircleIcon sx={{ color: '#10B981', fontSize: 28 }} />
            <Box>
              <Typography variant="h6" className="font-poppins">
                Resumen de Evaluación Completada
              </Typography>
              <Typography variant="body2" className="font-roboto" sx={{ color: '#6B7280' }}>
                {selectedActivoDetail?.Nombre || selectedActivoDetail?.nombre || 'Activo'}
              </Typography>
            </Box>
          </Box>
        </DialogTitle>
        
        <DialogContent sx={{ pt: 2 }}>
          {selectedActivoDetail && (() => {
            const evaluacionEstado = getEvaluacionEstado(selectedActivoDetail);
            const evaluacion = evaluacionEstado.evaluacion;
            
            if (!evaluacion) return null;
            
            return (
              <Box sx={{ maxHeight: '60vh', overflowY: 'auto' }}>
                {/* Información del activo */}
                <Card sx={{ mb: 3, border: '1px solid #E5E7EB' }}>
                  <CardContent>
                    <Typography variant="h6" className="font-poppins" sx={{ color: '#1E3A8A', mb: 2 }}>
                      Información del Activo
                    </Typography>
                    <Grid container spacing={2}>
                      <Grid item xs={12} sm={6}>
                        <Typography variant="body2" className="font-roboto" sx={{ color: '#6B7280' }}>
                          <strong>Nombre:</strong> {selectedActivoDetail?.Nombre || selectedActivoDetail?.nombre || 'N/A'}
                        </Typography>
                      </Grid>
                      <Grid item xs={12} sm={6}>
                        <Typography variant="body2" className="font-roboto" sx={{ color: '#6B7280' }}>
                          <strong>Tipo:</strong> {selectedActivoDetail?.Tipo_Activo || selectedActivoDetail?.tipo || 'N/A'}
                        </Typography>
                      </Grid>
                      <Grid item xs={12} sm={6}>
                        <Typography variant="body2" className="font-roboto" sx={{ color: '#6B7280' }}>
                          <strong>Criticidad:</strong> {selectedActivoDetail?.nivel_criticidad_negocio || 'N/A'}
                        </Typography>
                      </Grid>
                      <Grid item xs={12} sm={6}>
                        <Typography variant="body2" className="font-roboto" sx={{ color: '#6B7280' }}>
                          <strong>Fecha de Evaluación:</strong> {
                            evaluacion?.fechaCompletada 
                              ? new Date(evaluacion.fechaCompletada).toLocaleDateString()
                              : new Date().toLocaleDateString()
                          }
                        </Typography>
                      </Grid>
                    </Grid>
                  </CardContent>
                </Card>

                {/* Información del riesgo */}
                {evaluacion.evaluacion?.newRiesgo?.amenaza && (
                  <Card sx={{ mb: 3, border: '1px solid #E5E7EB' }}>
                    <CardContent>
                      <Typography variant="h6" className="font-poppins" sx={{ color: '#1E3A8A', mb: 2 }}>
                        Información del Riesgo
                      </Typography>
                      <Typography variant="body2" className="font-roboto" sx={{ color: '#6B7280', mb: 1 }}>
                        <strong>Amenaza:</strong> {evaluacion.evaluacion?.newRiesgo.amenaza}
                      </Typography>
                      <Typography variant="body2" className="font-roboto" sx={{ color: '#6B7280', mb: 1 }}>
                        <strong>Vulnerabilidad:</strong> {evaluacion.evaluacion?.newRiesgo.vulnerabilidad}
                      </Typography>
                      <Typography variant="body2" className="font-roboto" sx={{ color: '#6B7280' }}>
                        <strong>Descripción:</strong> {evaluacion.evaluacion?.newRiesgo.descripcion}
                      </Typography>
                    </CardContent>
                  </Card>
                )}

                {/* Evaluación Inherente */}
                {evaluacion.evaluacion?.evaluacionInherente.probabilidad && (
                  <Card sx={{ mb: 3, border: '1px solid #E5E7EB' }}>
                    <CardContent>
                      <Typography variant="h6" className="font-poppins" sx={{ color: '#1E3A8A', mb: 2 }}>
                        Evaluación Inherente
                      </Typography>
                      <Grid container spacing={2}>
                        <Grid item xs={12} sm={6}>
                          <Typography variant="body2" className="font-roboto" sx={{ color: '#6B7280' }}>
                            <strong>Probabilidad:</strong> {evaluacion.evaluacion?.evaluacionInherente.probabilidad}
                          </Typography>
                        </Grid>
                        <Grid item xs={12} sm={6}>
                          <Typography variant="body2" className="font-roboto" sx={{ color: '#6B7280' }}>
                            <strong>Impacto:</strong> {evaluacion.evaluacion?.evaluacionInherente.impacto}
                          </Typography>
                        </Grid>
                        <Grid item xs={12}>
                          <Typography variant="body2" className="font-roboto" sx={{ color: '#6B7280', mb: 1 }}>
                            <strong>Nivel de Riesgo:</strong> 
                            <Chip 
                              label={evaluacion.evaluacion?.evaluacionInherente.nivelRiesgo} 
                              size="small" 
                              sx={{ ml: 1, backgroundColor: '#FEF3C7', color: '#D97706' }}
                            />
                          </Typography>
                        </Grid>
                        <Grid item xs={12}>
                          <Typography variant="body2" className="font-roboto" sx={{ color: '#6B7280' }}>
                            <strong>Justificación:</strong> {evaluacion.evaluacion?.evaluacionInherente.justificacion}
                          </Typography>
                        </Grid>
                      </Grid>
                    </CardContent>
                  </Card>
                )}

                {/* Evaluación Residual */}
                {evaluacion.evaluacion?.evaluacionResidual.probabilidad && (
                  <Card sx={{ mb: 3, border: '1px solid #E5E7EB' }}>
                    <CardContent>
                      <Typography variant="h6" className="font-poppins" sx={{ color: '#1E3A8A', mb: 2 }}>
                        Evaluación Residual
                      </Typography>
                      <Grid container spacing={2}>
                        <Grid item xs={12} sm={6}>
                          <Typography variant="body2" className="font-roboto" sx={{ color: '#6B7280' }}>
                            <strong>Probabilidad:</strong> {evaluacion.evaluacion?.evaluacionResidual.probabilidad}
                          </Typography>
                        </Grid>
                        <Grid item xs={12} sm={6}>
                          <Typography variant="body2" className="font-roboto" sx={{ color: '#6B7280' }}>
                            <strong>Impacto:</strong> {evaluacion.evaluacion?.evaluacionResidual.impacto}
                          </Typography>
                        </Grid>
                        <Grid item xs={12}>
                          <Typography variant="body2" className="font-roboto" sx={{ color: '#6B7280', mb: 1 }}>
                            <strong>Nivel de Riesgo:</strong> 
                            <Chip 
                              label={evaluacion.evaluacion?.evaluacionResidual.nivelRiesgo} 
                              size="small" 
                              sx={{ ml: 1, backgroundColor: '#DBEAFE', color: '#2563EB' }}
                            />
                          </Typography>
                        </Grid>
                        <Grid item xs={12}>
                          <Typography variant="body2" className="font-roboto" sx={{ color: '#6B7280' }}>
                            <strong>Justificación:</strong> {evaluacion.evaluacion?.evaluacionResidual.justificacion}
                          </Typography>
                        </Grid>
                      </Grid>
                    </CardContent>
                  </Card>
                )}

                {/* Opciones de Tratamiento */}
                {evaluacion.evaluacion?.tratamiento.opcion && (
                  <Card sx={{ mb: 3, border: '1px solid #E5E7EB' }}>
                    <CardContent>
                      <Typography variant="h6" className="font-poppins" sx={{ color: '#1E3A8A', mb: 2 }}>
                        Opciones de Tratamiento
                      </Typography>
                      <Grid container spacing={2}>
                        <Grid item xs={12}>
                          <Typography variant="body2" className="font-roboto" sx={{ color: '#6B7280', mb: 1 }}>
                            <strong>Opción:</strong> {evaluacion.evaluacion?.tratamiento.opcion}
                          </Typography>
                        </Grid>
                        <Grid item xs={12} sm={6}>
                          <Typography variant="body2" className="font-roboto" sx={{ color: '#6B7280' }}>
                            <strong>Responsable:</strong> {evaluacion.evaluacion?.tratamiento.responsable}
                          </Typography>
                        </Grid>
                        <Grid item xs={12} sm={6}>
                          <Typography variant="body2" className="font-roboto" sx={{ color: '#6B7280' }}>
                            <strong>Presupuesto:</strong> {evaluacion.evaluacion?.tratamiento.presupuesto}
                          </Typography>
                        </Grid>
                        <Grid item xs={12} sm={6}>
                          <Typography variant="body2" className="font-roboto" sx={{ color: '#6B7280' }}>
                            <strong>Fecha Inicio:</strong> {evaluacion.evaluacion?.tratamiento.fechaInicio}
                          </Typography>
                        </Grid>
                        <Grid item xs={12} sm={6}>
                          <Typography variant="body2" className="font-roboto" sx={{ color: '#6B7280' }}>
                            <strong>Fecha Fin:</strong> {evaluacion.evaluacion?.tratamiento.fechaFin}
                          </Typography>
                        </Grid>
                      </Grid>
                    </CardContent>
                  </Card>
                )}

                {/* Plan de Acción con Documentos */}
                {evaluacion.evaluacion?.planAccion.acciones.length > 0 && (
                  <Card sx={{ mb: 3, border: '1px solid #E5E7EB' }}>
                    <CardContent>
                      <Typography variant="h6" className="font-poppins" sx={{ color: '#1E3A8A', mb: 2 }}>
                        Plan de Acción
                      </Typography>
                      {evaluacion.evaluacion?.planAccion.acciones.map((accion, index) => (
                        <Box key={accion.id || `accion-${index}-${accion.descripcion}`} sx={{ mb: 3, p: 2, border: '1px solid #F3F4F6', borderRadius: '8px' }}>
                          <Box sx={{ display: 'flex', justifyContent: 'space-between', alignItems: 'flex-start', mb: 2 }}>
                            <Typography variant="subtitle1" className="font-poppins" sx={{ color: '#1E3A8A', fontWeight: 600 }}>
                              Acción {index + 1}: {accion.descripcion}
                            </Typography>
                            <Chip
                              label={accion.estado}
                              size="small"
                              sx={{
                                backgroundColor: accion.estado === 'Completado' ? '#D1FAE5' :
                                               accion.estado === 'En Progreso' ? '#DBEAFE' :
                                               accion.estado === 'Pendiente' ? '#FEF3C7' : '#FEE2E2',
                                color: accion.estado === 'Completado' ? '#059669' :
                                       accion.estado === 'En Progreso' ? '#2563EB' :
                                       accion.estado === 'Pendiente' ? '#D97706' : '#DC2626',
                                fontWeight: 500
                              }}
                            />
                          </Box>
                          
                          <Grid container spacing={2} sx={{ mb: 2 }}>
                            <Grid item xs={12} sm={6}>
                              <Typography variant="body2" className="font-roboto" sx={{ color: '#6B7280' }}>
                                <strong>Responsable:</strong> {accion.responsable}
                              </Typography>
                            </Grid>
                            <Grid item xs={12} sm={6}>
                              <Typography variant="body2" className="font-roboto" sx={{ color: '#6B7280' }}>
                                <strong>Período:</strong> {accion.fechaInicio} - {accion.fechaFin}
                              </Typography>
                            </Grid>
                            {accion.comentarios && (
                              <Grid item xs={12}>
                                <Typography variant="body2" className="font-roboto" sx={{ color: '#6B7280' }}>
                                  <strong>Comentarios:</strong> {accion.comentarios}
                                </Typography>
                              </Grid>
                            )}
                          </Grid>

                          {/* Documentos de la acción */}
                          {accion.documentos && accion.documentos.length > 0 && (
                            <Box sx={{ mt: 2 }}>
                              <Typography variant="subtitle2" className="font-poppins" sx={{ color: '#1E3A8A', mb: 1 }}>
                                Documentos de Evidencia ({accion.documentos.length})
                              </Typography>
                              <List dense sx={{ bgcolor: '#F9FAFB', borderRadius: '4px', p: 1 }}>
                                {accion.documentos.map((documento, docIndex) => (
                                  <ListItem key={documento.id || `doc-${docIndex}-${documento.nombre}`} sx={{ py: 0.5 }}>
                                    <Box sx={{ display: 'flex', alignItems: 'center', mr: 2 }}>
                                      {documento.tipo.includes('pdf') ? <PdfIcon sx={{ color: '#DC2626', fontSize: 20 }} /> :
                                       documento.tipo.includes('word') ? <WordIcon sx={{ color: '#2563EB', fontSize: 20 }} /> :
                                       documento.tipo.includes('excel') ? <ExcelIcon sx={{ color: '#059669', fontSize: 20 }} /> :
                                       documento.tipo.includes('image') ? <ImageIcon sx={{ color: '#7C3AED', fontSize: 20 }} /> :
                                       <FileIcon sx={{ color: '#6B7280', fontSize: 20 }} />}
                                    </Box>
                                    <ListItemText
                                      primary={
                                        <Typography variant="body2" className="font-roboto" sx={{ fontWeight: 500 }}>
                                          {documento.nombre}
                                        </Typography>
                                      }
                                      secondary={
                                        <Typography variant="caption" className="font-roboto" sx={{ color: '#6B7280' }}>
                                          {documentosService.formatearTamaño(documento.tamaño)} • 
                                          {new Date(documento.fechaSubida).toLocaleDateString()}
                                          {documento.descripcion && ` • ${documento.descripcion}`}
                                        </Typography>
                                      }
                                    />
                                    <Box>
                                      <IconButton
                                        size="small"
                                        onClick={() => {
                                          // Abrir en nueva ventana para visualizar
                                          window.open(documento.url, '_blank');
                                        }}
                                        sx={{ color: '#1E3A8A', mr: 0.5 }}
                                        title="Ver documento"
                                      >
                                        <VisibilityIcon />
                                      </IconButton>
                                      <IconButton
                                        size="small"
                                        onClick={() => {
                                          const link = document.createElement('a');
                                          link.href = documento.url;
                                          link.download = documento.nombre;
                                          document.body.appendChild(link);
                                          link.click();
                                          document.body.removeChild(link);
                                        }}
                                        sx={{ color: '#1E3A8A' }}
                                        title="Descargar documento"
                                      >
                                        <DownloadIcon />
                                      </IconButton>
                                    </Box>
                                  </ListItem>
                                ))}
                              </List>
                            </Box>
                          )}
                        </Box>
                      ))}
                    </CardContent>
                  </Card>
                )}
              </Box>
            );
          })()}
        </DialogContent>
        
        <DialogActions sx={{ p: 3, gap: 2 }}>
          <Button 
            onClick={() => setOpenSummaryDialog(false)}
            variant="outlined"
            sx={{ borderRadius: '8px' }}
          >
            Cerrar
          </Button>
          <Button 
            onClick={() => {
              if (selectedActivoDetail) {
                const evaluacionEstado = getEvaluacionEstado(selectedActivoDetail);
                if (evaluacionEstado.evaluacion) {
                  exportarResumenPDF(evaluacionEstado.evaluacion, selectedActivoDetail);
                }
              }
            }}
            variant="contained"
            startIcon={<DownloadIcon />}
            disabled={isExportando}
            sx={{ 
              borderRadius: '8px',
              backgroundColor: '#10B981',
              '&:hover': {
                backgroundColor: '#059669',
              }
            }}
          >
            {isExportando ? 'Exportando...' : 'Exportar PDF'}
          </Button>
        </DialogActions>
      </Dialog>
    </Box>
  );
};

export default RiskAssessmentWizard;
