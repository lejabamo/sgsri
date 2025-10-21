import React, { useState } from 'react';
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
} from '@mui/icons-material';
import jsPDF from 'jspdf';
import html2canvas from 'html2canvas';
import * as XLSX from 'xlsx';
import { saveAs } from 'file-saver';
import { useQuery } from '@tanstack/react-query';
import { activosService } from '../../services/activos';
import RiskMatrix from '../../components/common/RiskMatrix';
import InherentEvaluationStep from '../../components/wizard/InherentEvaluationStep';
import ActivoDetailCard from '../../components/activos/ActivoDetailCard';
import DocumentManager from '../../components/common/DocumentManager';
import type { DocumentoAdjunto, AccionPlan } from '../../services/documentos';
import { documentosService } from '../../services/documentos';
import '../../styles/design-system.css';

interface WizardData {
  selectedActivo: any;
  newRiesgo: {
    amenaza: string;
    vulnerabilidad: string;
    descripcion: string;
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
  const [activeStep, setActiveStep] = useState(0);
  const [wizardData, setWizardData] = useState<WizardData>({
    selectedActivo: null,
    newRiesgo: { amenaza: '', vulnerabilidad: '', descripcion: '' },
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
  const [riesgoFormData, setRiesgoFormData] = useState({
    nombre: '',
    amenaza: '',
    vulnerabilidad: '',
    descripcion: '',
  });
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
  const [evaluacionesCompletadas, setEvaluacionesCompletadas] = useState<{[key: string]: any}>({
    // Evaluación de ejemplo para EFINANCIERA-5
    2: {
      activo: {
        id: 2,
        ID_Activo: 2,
        Nombre: 'EFINANCIERA-5',
        Tipo_Activo: 'Aplicación',
        estado: 'Activo',
        nivel_criticidad_negocio: 'Crítica'
      },
      evaluacion: {
        selectedActivo: {
          id: 2,
          ID_Activo: 2,
          Nombre: 'EFINANCIERA-5',
          Tipo_Activo: 'Aplicación',
          estado: 'Activo',
          nivel_criticidad_negocio: 'Crítica'
        },
        newRiesgo: {
          amenaza: 'Acceso no autorizado a datos financieros',
          vulnerabilidad: 'Falta de autenticación multifactor',
          descripcion: 'Riesgo de acceso no autorizado a información financiera crítica debido a la ausencia de autenticación multifactor en el sistema EFINANCIERA-5'
        },
        evaluacionInherente: {
          probabilidad: 'Probable',
          impacto: 'Mayor',
          nivelRiesgo: 'Alto',
          justificacion: 'La probabilidad es alta debido a la exposición del sistema a internet y el impacto es mayor por la naturaleza crítica de los datos financieros'
        },
        controles: {
          seleccionados: ['Autenticación multifactor', 'Cifrado de datos', 'Monitoreo de accesos'],
          eficacia: 'Alta',
          justificacion: 'Los controles implementados reducen significativamente el riesgo de acceso no autorizado'
        },
        evaluacionResidual: {
          probabilidad: 'Ocasional',
          impacto: 'Moderado',
          nivelRiesgo: 'Medio',
          justificacion: 'Con los controles implementados, el riesgo residual se reduce considerablemente'
        },
        tratamiento: {
          opcion: 'Mitigar',
          responsable: 'Equipo de Seguridad TI',
          fechaInicio: '2024-01-15',
          fechaFin: '2024-03-15',
          presupuesto: '$15,000'
        },
        planAccion: {
          acciones: [
            {
              id: '1',
              descripcion: 'Implementar autenticación multifactor',
              responsable: 'Equipo de Seguridad TI',
              fechaInicio: '2024-01-15',
              fechaFin: '2024-02-15',
              estado: 'Completado',
              comentarios: 'Implementación exitosa',
              documentos: [
                {
                  id: 'doc1',
                  nombre: 'Manual_Implementacion_MFA.pdf',
                  tipo: 'application/pdf',
                  tamaño: 2048576,
                  url: '#',
                  fechaSubida: '2024-01-20T10:30:00Z',
                  descripcion: 'Manual técnico de implementación'
                },
                {
                  id: 'doc2',
                  nombre: 'Evidencia_Configuracion.xlsx',
                  tipo: 'application/vnd.openxmlformats-officedocument.spreadsheetml.sheet',
                  tamaño: 512000,
                  url: '#',
                  fechaSubida: '2024-01-22T14:15:00Z',
                  descripcion: 'Configuraciones aplicadas'
                }
              ]
            },
            {
              id: '2',
              descripcion: 'Configurar monitoreo de accesos',
              responsable: 'Equipo de Seguridad TI',
              fechaInicio: '2024-02-01',
              fechaFin: '2024-03-01',
              estado: 'En Progreso',
              comentarios: 'En proceso de configuración',
              documentos: [
                {
                  id: 'doc3',
                  nombre: 'Plan_Monitoreo.docx',
                  tipo: 'application/vnd.openxmlformats-officedocument.wordprocessingml.document',
                  tamaño: 1024000,
                  url: '#',
                  fechaSubida: '2024-02-05T09:00:00Z',
                  descripcion: 'Plan detallado de monitoreo'
                }
              ]
            }
          ]
        }
      },
      fechaCompletada: '2024-01-10T10:30:00Z',
      completada: true
    }
  });
  const [exportMessage, setExportMessage] = useState('');

  const { data: activos = [] } = useQuery({
    queryKey: ['activos'],
    queryFn: async () => {
      try {
        const { activosService } = await import('../../services/backend');
        return await activosService.getAll();
      } catch (error) {
        console.error('Error fetching activos:', error);
        // Datos de fallback con estados de evaluación
        return [
          { 
            id: 1, 
            ID_Activo: 1,
            Nombre: 'Servidor Web Principal', 
            Tipo_Activo: 'Infraestructura', 
            estado: 'Activo', 
            nivel_criticidad_negocio: 'Alta',
            evaluacion_completa: true,
            porcentaje_evaluacion: 100
          },
          { 
            id: 2, 
            ID_Activo: 2,
            Nombre: 'EFINANCIERA-5', 
            Tipo_Activo: 'Aplicación', 
            estado: 'Activo', 
            nivel_criticidad_negocio: 'Crítica',
            evaluacion_completa: false,
            porcentaje_evaluacion: 65
          },
          { 
            id: 3, 
            ID_Activo: 3,
            Nombre: 'Firewall Corporativo', 
            Tipo_Activo: 'Seguridad', 
            estado: 'Activo', 
            nivel_criticidad_negocio: 'Alta',
            evaluacion_completa: false,
            porcentaje_evaluacion: 0
          },
          { 
            id: 4, 
            ID_Activo: 4,
            Nombre: 'Sistema de Backup', 
            Tipo_Activo: 'Infraestructura', 
            estado: 'Activo', 
            nivel_criticidad_negocio: 'Medio',
            evaluacion_completa: false,
            porcentaje_evaluacion: 30
          },
          { 
            id: 5, 
            ID_Activo: 5,
            Nombre: 'Servidor de Correo', 
            Tipo_Activo: 'Aplicación', 
            estado: 'Activo', 
            nivel_criticidad_negocio: 'Medio',
            evaluacion_completa: true,
            porcentaje_evaluacion: 100
          }
        ];
      }
    }
  });

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
    
    // Si no está evaluado o está parcialmente evaluado, continuar con el flujo normal
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
      const { activosService } = await import('../../services/backend');
      const nuevoActivo = await activosService.create(formData);
      
      // Actualizar la lista de activos
      window.location.reload(); // Recargar para mostrar el nuevo activo
      
      handleCloseDialog();
    } catch (error) {
      console.error('Error al crear activo:', error);
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
        ['Activo Seleccionado:', wizardData.activoSeleccionado?.nombre || 'No seleccionado'],
        ['Tipo de Activo:', wizardData.activoSeleccionado?.tipo || 'No especificado'],
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
      if (wizardData.controles.selected.length > 0) {
        const controlesData = [
          ['Controles Seleccionados', 'Eficacia', 'Justificación'],
          ...wizardData.controles.selected.map(control => [
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
      // Aquí se haría la llamada al backend para guardar
      // Por ahora simulamos el guardado
      await new Promise(resolve => setTimeout(resolve, 1000));
      
      // Guardar la evaluación en el estado local
      const activoId = wizardData.selectedActivo?.ID_Activo || wizardData.selectedActivo?.id;
      if (activoId) {
        setEvaluacionesCompletadas(prev => ({
          ...prev,
          [activoId]: {
            activo: wizardData.selectedActivo,
            evaluacion: wizardData,
            fechaCompletada: new Date().toISOString(),
            completada: true
          }
        }));
      }
      
      setIsEvaluacionCompletada(true);
      setShowSuccessMessage(true);
      setExportMessage('Evaluación guardada exitosamente');
      setShowExportMessage(true);
    } catch (error) {
      console.error('Error al guardar:', error);
      setExportMessage('Error al guardar la evaluación');
      setShowExportMessage(true);
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
  const exportarResumenPDF = async (evaluacion: any) => {
    setIsExportando(true);
    try {
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
      pdf.text(`Nombre: ${evaluacion.activo.Nombre || evaluacion.activo.nombre || 'N/A'}`, 20, yPosition);
      yPosition += 8;
      pdf.text(`Tipo: ${evaluacion.activo.Tipo_Activo || evaluacion.activo.tipo || 'N/A'}`, 20, yPosition);
      yPosition += 8;
      pdf.text(`Criticidad: ${evaluacion.activo.nivel_criticidad_negocio || 'N/A'}`, 20, yPosition);
      yPosition += 15;

      // Información del riesgo
      if (evaluacion.evaluacion.newRiesgo.amenaza) {
        pdf.setFontSize(14);
        pdf.setFont('helvetica', 'bold');
        pdf.text('Información del Riesgo:', 20, yPosition);
        yPosition += 10;
        
        pdf.setFontSize(12);
        pdf.setFont('helvetica', 'normal');
        pdf.text(`Amenaza: ${evaluacion.evaluacion.newRiesgo.amenaza}`, 20, yPosition);
        yPosition += 8;
        pdf.text(`Vulnerabilidad: ${evaluacion.evaluacion.newRiesgo.vulnerabilidad}`, 20, yPosition);
        yPosition += 8;
        pdf.text(`Descripción: ${evaluacion.evaluacion.newRiesgo.descripcion}`, 20, yPosition);
        yPosition += 15;
      }

      // Evaluación Inherente
      if (evaluacion.evaluacion.evaluacionInherente.probabilidad) {
        pdf.setFontSize(14);
        pdf.setFont('helvetica', 'bold');
        pdf.text('Evaluación Inherente:', 20, yPosition);
        yPosition += 10;
        
        pdf.setFontSize(12);
        pdf.setFont('helvetica', 'normal');
        pdf.text(`Probabilidad: ${evaluacion.evaluacion.evaluacionInherente.probabilidad}`, 20, yPosition);
        yPosition += 8;
        pdf.text(`Impacto: ${evaluacion.evaluacion.evaluacionInherente.impacto}`, 20, yPosition);
        yPosition += 8;
        pdf.text(`Nivel de Riesgo: ${evaluacion.evaluacion.evaluacionInherente.nivelRiesgo}`, 20, yPosition);
        yPosition += 8;
        pdf.text(`Justificación: ${evaluacion.evaluacion.evaluacionInherente.justificacion}`, 20, yPosition);
        yPosition += 15;
      }

      // Evaluación Residual
      if (evaluacion.evaluacion.evaluacionResidual.probabilidad) {
        pdf.setFontSize(14);
        pdf.setFont('helvetica', 'bold');
        pdf.text('Evaluación Residual:', 20, yPosition);
        yPosition += 10;
        
        pdf.setFontSize(12);
        pdf.setFont('helvetica', 'normal');
        pdf.text(`Probabilidad: ${evaluacion.evaluacion.evaluacionResidual.probabilidad}`, 20, yPosition);
        yPosition += 8;
        pdf.text(`Impacto: ${evaluacion.evaluacion.evaluacionResidual.impacto}`, 20, yPosition);
        yPosition += 8;
        pdf.text(`Nivel de Riesgo: ${evaluacion.evaluacion.evaluacionResidual.nivelRiesgo}`, 20, yPosition);
        yPosition += 8;
        pdf.text(`Justificación: ${evaluacion.evaluacion.evaluacionResidual.justificacion}`, 20, yPosition);
        yPosition += 15;
      }

      // Opciones de Tratamiento
      if (evaluacion.evaluacion.tratamiento.opcion) {
        pdf.setFontSize(14);
        pdf.setFont('helvetica', 'bold');
        pdf.text('Opciones de Tratamiento:', 20, yPosition);
        yPosition += 10;
        
        pdf.setFontSize(12);
        pdf.setFont('helvetica', 'normal');
        pdf.text(`Opción: ${evaluacion.evaluacion.tratamiento.opcion}`, 20, yPosition);
        yPosition += 8;
        pdf.text(`Responsable: ${evaluacion.evaluacion.tratamiento.responsable}`, 20, yPosition);
        yPosition += 8;
        pdf.text(`Fecha Inicio: ${evaluacion.evaluacion.tratamiento.fechaInicio}`, 20, yPosition);
        yPosition += 8;
        pdf.text(`Fecha Fin: ${evaluacion.evaluacion.tratamiento.fechaFin}`, 20, yPosition);
        yPosition += 8;
        pdf.text(`Presupuesto: ${evaluacion.evaluacion.tratamiento.presupuesto}`, 20, yPosition);
        yPosition += 15;
      }

      // Fecha de evaluación
      pdf.setFontSize(10);
      pdf.setFont('helvetica', 'normal');
      pdf.text(`Fecha de evaluación: ${new Date(evaluacion.fechaCompletada).toLocaleDateString()}`, 20, pageHeight - 20);

      // Guardar el PDF
      pdf.save(`evaluacion-riesgo-${evaluacion.activo.Nombre || evaluacion.activo.nombre || 'activo'}.pdf`);
      
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
    
    // Si hay una evaluación guardada para este activo
    if (evaluacionGuardada) {
      return { 
        estado: 'completa', 
        porcentaje: 100, 
        color: '#10B981',
        evaluacion: evaluacionGuardada
      };
    }
    
    // Verificar si hay datos parciales en el wizard actual
    if (wizardData.selectedActivo?.ID_Activo === activoId) {
      let porcentajeParcial = 0;
      
      // Calcular progreso basado en los pasos completados
      if (wizardData.newRiesgo.amenaza && wizardData.newRiesgo.vulnerabilidad) {
        porcentajeParcial += 20; // Identificación de riesgo
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
      
      if (porcentajeParcial > 0) {
        return { 
          estado: 'parcial', 
          porcentaje: porcentajeParcial, 
          color: '#F59E0B' 
        };
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
                  return (
                    <Box component="li" {...props} sx={{ py: 1.5, px: 2 }}>
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
              {filteredActivos.map((activo) => {
                const evaluacionEstado = getEvaluacionEstado(activo);
                return (
                  <Grid item xs={12} sm={6} md={4} key={activo.ID_Activo}>
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
            <Typography variant="h6" className="font-poppins" sx={{ color: '#1E3A8A', mb: 2 }}>
              Identifica el riesgo a evaluar
            </Typography>
            
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
                        return (
                          <Box component="li" {...props} sx={{ py: 1.5, px: 2 }}>
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
            <Card className="card" sx={{ mt: 3 }}>
              <CardContent sx={{ p: 4 }}>
                <Typography variant="h6" className="font-poppins" sx={{ color: '#1E3A8A', mb: 3 }}>
                  Detalles del Riesgo
                </Typography>
                <Grid container spacing={3}>
                  <Grid item xs={12} md={6}>
                    <FormControl fullWidth>
                      <InputLabel>Amenaza</InputLabel>
                      <Select
                        value={wizardData.newRiesgo.amenaza}
                        onChange={(e) => setWizardData({
                          ...wizardData,
                          newRiesgo: { ...wizardData.newRiesgo, amenaza: e.target.value }
                        })}
                        label="Amenaza"
                        sx={{ borderRadius: '12px' }}
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
                      <InputLabel>Vulnerabilidad</InputLabel>
                      <Select
                        value={wizardData.newRiesgo.vulnerabilidad}
                        onChange={(e) => setWizardData({
                          ...wizardData,
                          newRiesgo: { ...wizardData.newRiesgo, vulnerabilidad: e.target.value }
                        })}
                        label="Vulnerabilidad"
                        sx={{ borderRadius: '12px' }}
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
          </Box>
        );

      case 2:
        return (
          <InherentEvaluationStep
            data={wizardData.evaluacionInherente}
            onUpdate={(data) => setWizardData({
              ...wizardData,
              evaluacionInherente: data
            })}
          />
        );

      case 3:
        return (
          <Box>
            <Typography variant="h6" className="font-poppins" sx={{ color: '#1E3A8A', mb: 2 }}>
              Selecciona los controles que mitigarán el riesgo
            </Typography>
            
            <Card className="card" sx={{ mb: 3 }}>
              <CardContent sx={{ p: 3 }}>
                <Typography variant="subtitle1" className="font-poppins" sx={{ color: '#1E3A8A', mb: 2 }}>
                  Controles Disponibles
                </Typography>
                <FormGroup>
                  {[
                    'Firewall',
                    'Antivirus',
                    'Monitoreo de Red',
                    'Copia de Seguridad',
                    'Seguridad en la Nube',
                    'Autenticación Multifactor',
                    'Encriptación de Datos',
                    'Control de Acceso Físico',
                    'Auditoría de Seguridad',
                    'Capacitación en Seguridad'
                  ].map((control) => (
                    <FormControlLabel
                      key={control}
                      control={
                        <Checkbox
                          checked={wizardData.controles.seleccionados.includes(control)}
                          onChange={(e) => {
                            const seleccionados = e.target.checked
                              ? [...wizardData.controles.seleccionados, control]
                              : wizardData.controles.seleccionados.filter(c => c !== control);
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
                        <Typography className="font-roboto" sx={{ color: '#374151' }}>
                          {control}
                        </Typography>
                      }
                    />
                  ))}
                </FormGroup>
              </CardContent>
            </Card>

            <Grid container spacing={3}>
              <Grid item xs={12} md={6}>
                <Card className="card">
                  <CardContent sx={{ p: 3 }}>
                    <Typography variant="subtitle1" className="font-poppins" sx={{ color: '#1E3A8A', mb: 2 }}>
                      Eficacia de los Controles
                    </Typography>
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
              
              <Grid item xs={12} md={6}>
                <Card className="card" sx={{ 
                  background: 'linear-gradient(135deg, #F9FAFB 0%, #F3F4F6 100%)',
                  border: '2px solid #E5E7EB'
                }}>
                  <CardContent sx={{ p: 3, textAlign: 'center' }}>
                    <Typography variant="h6" className="font-poppins" sx={{ color: '#1E3A8A', mb: 2 }}>
                      Controles Seleccionados
                    </Typography>
                    <Box sx={{ 
                      display: 'flex',
                      flexWrap: 'wrap',
                      gap: 1,
                      justifyContent: 'center'
                    }}>
                      {wizardData.controles.seleccionados.length > 0 ? (
                        wizardData.controles.seleccionados.map((control) => (
                          <Chip
                            key={control}
                            label={control}
                            size="small"
                            sx={{
                              backgroundColor: '#1E3A8A',
                              color: '#FFFFFF',
                              fontWeight: 500
                            }}
                          />
                        ))
                      ) : (
                        <Typography variant="body2" className="font-roboto" sx={{ color: '#6B7280' }}>
                          No hay controles seleccionados
                        </Typography>
                      )}
                    </Box>
                  </CardContent>
                </Card>
              </Grid>
            </Grid>

            <Card className="card" sx={{ mt: 3 }}>
              <CardContent sx={{ p: 3 }}>
                <TextField
                  fullWidth
                  multiline
                  rows={3}
                  label="Justificación de la Eficacia"
                  value={wizardData.controles.justificacion}
                  onChange={(e) => setWizardData({
                    ...wizardData,
                    controles: { ...wizardData.controles, justificacion: e.target.value }
                  })}
                  sx={{ borderRadius: '12px' }}
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
                          <MenuItem value="Muy Baja">Muy Baja</MenuItem>
                          <MenuItem value="Baja">Baja</MenuItem>
                          <MenuItem value="Media">Media</MenuItem>
                          <MenuItem value="Alta">Alta</MenuItem>
                          <MenuItem value="Muy Alta">Muy Alta</MenuItem>
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
                          <MenuItem value="Muy Bajo">Muy Bajo</MenuItem>
                          <MenuItem value="Bajo">Bajo</MenuItem>
                          <MenuItem value="Medio">Medio</MenuItem>
                          <MenuItem value="Alto">Alto</MenuItem>
                          <MenuItem value="Muy Alto">Muy Alto</MenuItem>
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
                  value={wizardData.evaluacionResidual.justificacion}
                  onChange={(e) => setWizardData({
                    ...wizardData,
                    evaluacionResidual: { ...wizardData.evaluacionResidual, justificacion: e.target.value }
                  })}
                  sx={{ borderRadius: '12px' }}
                />
              </CardContent>
            </Card>
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
                  ].map((opcion) => (
                    <Grid item xs={12} sm={6} key={opcion.value}>
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
                      <TextField
                        fullWidth
                        label="Presupuesto Estimado"
                        value={wizardData.tratamiento.presupuesto}
                        onChange={(e) => setWizardData({
                          ...wizardData,
                          tratamiento: { ...wizardData.tratamiento, presupuesto: e.target.value }
                        })}
                        sx={{ borderRadius: '12px' }}
                        InputProps={{
                          startAdornment: (
                            <InputAdornment position="start">
                              <Typography sx={{ color: '#6B7280' }}>$</Typography>
                            </InputAdornment>
                          ),
                        }}
                      />
                    </Grid>
                    <Grid item xs={12} md={6}>
                      <TextField
                        fullWidth
                        type="date"
                        label="Fecha de Inicio"
                        value={wizardData.tratamiento.fechaInicio}
                        onChange={(e) => setWizardData({
                          ...wizardData,
                          tratamiento: { ...wizardData.tratamiento, fechaInicio: e.target.value }
                        })}
                        InputLabelProps={{ shrink: true }}
                        sx={{ borderRadius: '12px' }}
                      />
                    </Grid>
                    <Grid item xs={12} md={6}>
                      <TextField
                        fullWidth
                  type="date"
                        label="Fecha de Finalización"
                        value={wizardData.tratamiento.fechaFin}
                        onChange={(e) => setWizardData({
                          ...wizardData,
                          tratamiento: { ...wizardData.tratamiento, fechaFin: e.target.value }
                        })}
                        InputLabelProps={{ shrink: true }}
                        sx={{ borderRadius: '12px' }}
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
            
            <Card className="card" sx={{ mb: 3 }}>
              <CardContent sx={{ p: 3 }}>
                <Box sx={{ display: 'flex', justifyContent: 'space-between', alignItems: 'center', mb: 2 }}>
                  <Typography variant="subtitle1" className="font-poppins" sx={{ color: '#1E3A8A' }}>
                    Acciones del Plan
                  </Typography>
                  <Button
                    variant="contained"
                    startIcon={<AddIcon />}
                    onClick={() => setOpenAccionDialog(true)}
                    className="btn btn-primary"
                    sx={{
                      background: 'linear-gradient(135deg, #1E3A8A 0%, #3B82F6 100%)',
                      color: '#FFFFFF',
                      borderRadius: '12px',
                      px: 3,
                      py: 1,
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
                    Agregar Acción
                  </Button>
                </Box>

                {wizardData.planAccion.acciones.length > 0 ? (
                  <List>
                    {wizardData.planAccion.acciones.map((accion) => (
                      <ListItem
                        key={accion.id}
                        sx={{
                          border: '1px solid #E5E7EB',
                          borderRadius: '12px',
                          mb: 2,
                          backgroundColor: '#FFFFFF',
                          '&:hover': {
                            boxShadow: '0 4px 12px rgba(0, 0, 0, 0.1)',
                          },
                          transition: 'all 0.2s ease'
                        }}
                      >
                        <ListItemText
                          primary={
                            <Typography variant="h6" className="font-poppins" sx={{ color: '#1E3A8A', fontWeight: 600 }}>
                              {accion.descripcion}
                            </Typography>
                          }
                          secondary={
                            <Box sx={{ mt: 1 }}>
                              <Typography variant="body2" className="font-roboto" sx={{ color: '#6B7280', mb: 1 }}>
                                <strong>Responsable:</strong> {accion.responsable}
                              </Typography>
                              <Typography variant="body2" className="font-roboto" sx={{ color: '#6B7280', mb: 1 }}>
                                <strong>Período:</strong> {accion.fechaInicio} - {accion.fechaFin}
                              </Typography>
                              <Box sx={{ display: 'flex', alignItems: 'center', gap: 1, mb: 1 }}>
                                <Typography variant="body2" className="font-roboto" sx={{ color: '#6B7280' }}>
                                  <strong>Estado:</strong>
                                </Typography>
                                <Chip
                                  label={accion.estado}
                                  size="small"
                                  sx={{
                                    backgroundColor: getEstadoColor(accion.estado),
                                    color: '#FFFFFF',
                                    fontWeight: 500,
                                    fontSize: '0.75rem'
                                  }}
                                />
                              </Box>
                              {accion.comentarios && (
                                <Typography variant="body2" className="font-roboto" sx={{ color: '#6B7280' }}>
                                  <strong>Comentarios:</strong> {accion.comentarios}
                                </Typography>
                              )}
                            </Box>
                          }
                        />
                        <ListItemSecondaryAction>
                          <IconButton
                            edge="end"
                            onClick={() => deleteAccion(accion.id)}
                            sx={{ color: '#EF4444' }}
                          >
                            <DeleteIcon />
                          </IconButton>
                        </ListItemSecondaryAction>
                      </ListItem>
                    ))}
                  </List>
                ) : (
                  <Box sx={{ textAlign: 'center', py: 4 }}>
                    <AssignmentIcon sx={{ fontSize: 64, color: '#D1D5DB', mb: 2 }} />
                    <Typography variant="h6" className="font-poppins" sx={{ color: '#6B7280', mb: 1 }}>
                      No hay acciones definidas
                    </Typography>
                    <Typography variant="body2" className="font-roboto" sx={{ color: '#9CA3AF' }}>
                      Haz clic en "Agregar Acción" para crear el primer elemento del plan
                    </Typography>
                  </Box>
                )}
              </CardContent>
            </Card>
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
                  <Box sx={{ display: 'flex', alignItems: 'center', gap: 2 }}>
                    <Avatar sx={{ 
                      background: 'linear-gradient(135deg, #1E3A8A 0%, #3B82F6 100%)',
                      color: '#FFFFFF'
                    }}>
                      <SecurityIcon />
                    </Avatar>
                    <Box>
                      <Typography variant="h6" className="font-poppins" sx={{ color: '#1E3A8A', fontWeight: 600 }}>
                        {wizardData.selectedActivo.Nombre}
                      </Typography>
                      <Typography variant="body2" className="font-roboto" sx={{ color: '#6B7280' }}>
                        {wizardData.selectedActivo.Tipo_Activo} • Criticidad: {wizardData.selectedActivo.nivel_criticidad_negocio}
                      </Typography>
                    </Box>
                  </Box>
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
                      {wizardData.controles.seleccionados.map((control) => (
                        <Chip
                          key={control}
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
                      {wizardData.planAccion.acciones.map((accion) => (
                        <ListItem key={accion.id} sx={{ px: 0 }}>
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
                          newRiesgo: { amenaza: '', vulnerabilidad: '', descripcion: '' },
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
                <Step key={label}>
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
      <Dialog open={openDialog} onClose={handleCloseDialog} maxWidth="md" fullWidth>
        <DialogTitle sx={{ 
          backgroundColor: '#1E3A8A', 
          color: 'white',
          display: 'flex',
          alignItems: 'center',
          gap: 2
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
        <DialogContent sx={{ p: 4 }}>
          <Grid container spacing={3}>
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
              <FormControl fullWidth>
                <InputLabel>Tipo de Activo *</InputLabel>
                <Select
                  value={formData.tipo}
                  onChange={(e) => setFormData({ ...formData, tipo: e.target.value })}
                  label="Tipo de Activo *"
                >
                  <MenuItem value="Hardware">Hardware</MenuItem>
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
                <InputLabel>Estado del Activo</InputLabel>
                <Select
                  value={formData.estado}
                  onChange={(e) => setFormData({ ...formData, estado: e.target.value })}
                  label="Estado del Activo"
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
                <InputLabel>Nivel de Criticidad</InputLabel>
                <Select
                  value={formData.criticidad}
                  onChange={(e) => setFormData({ ...formData, criticidad: e.target.value })}
                  label="Nivel de Criticidad"
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
      <Dialog open={openRiesgoDialog} onClose={handleCloseRiesgoDialog} maxWidth="md" fullWidth>
        <DialogTitle sx={{ 
          backgroundColor: '#1E3A8A', 
          color: 'white',
          display: 'flex',
          alignItems: 'center',
          gap: 2
        }}>
          <WarningIcon />
          <Box>
            <Typography variant="h6" className="font-poppins">
              Crear Nuevo Riesgo
            </Typography>
            <Typography variant="body2" sx={{ opacity: 0.9 }}>
              Define un nuevo riesgo específico para este activo
            </Typography>
          </Box>
        </DialogTitle>
        <DialogContent sx={{ p: 4 }}>
          <Grid container spacing={3}>
            <Grid item xs={12}>
              <TextField
                fullWidth
                label="Nombre del Riesgo *"
                value={riesgoFormData.nombre}
                onChange={(e) => setRiesgoFormData({ ...riesgoFormData, nombre: e.target.value })}
                className="input"
              />
            </Grid>
            <Grid item xs={12} md={6}>
              <FormControl fullWidth>
                <InputLabel>Amenaza *</InputLabel>
                <Select
                  value={riesgoFormData.amenaza}
                  onChange={(e) => setRiesgoFormData({ ...riesgoFormData, amenaza: e.target.value })}
                  label="Amenaza *"
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
                <InputLabel>Vulnerabilidad *</InputLabel>
                <Select
                  value={riesgoFormData.vulnerabilidad}
                  onChange={(e) => setRiesgoFormData({ ...riesgoFormData, vulnerabilidad: e.target.value })}
                  label="Vulnerabilidad *"
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
                rows={4}
                placeholder="Describe detalladamente el riesgo identificado..."
                value={riesgoFormData.descripcion}
                onChange={(e) => setRiesgoFormData({ ...riesgoFormData, descripcion: e.target.value })}
                className="input"
              />
            </Grid>
          </Grid>
        </DialogContent>
        <DialogActions sx={{ p: 3, gap: 2 }}>
          <Button 
            onClick={handleCloseRiesgoDialog}
            variant="outlined"
            sx={{ borderRadius: '8px' }}
          >
            Cancelar
          </Button>
          <Button 
            onClick={handleCreateRiesgo}
            variant="contained"
            disabled={!riesgoFormData.nombre || !riesgoFormData.amenaza || !riesgoFormData.vulnerabilidad}
            sx={{ 
              borderRadius: '8px',
              backgroundColor: '#1E3A8A',
              '&:hover': {
                backgroundColor: '#1E40AF',
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
                          <strong>Nombre:</strong> {evaluacion.activo.Nombre || evaluacion.activo.nombre || 'N/A'}
                        </Typography>
                      </Grid>
                      <Grid item xs={12} sm={6}>
                        <Typography variant="body2" className="font-roboto" sx={{ color: '#6B7280' }}>
                          <strong>Tipo:</strong> {evaluacion.activo.Tipo_Activo || evaluacion.activo.tipo || 'N/A'}
                        </Typography>
                      </Grid>
                      <Grid item xs={12} sm={6}>
                        <Typography variant="body2" className="font-roboto" sx={{ color: '#6B7280' }}>
                          <strong>Criticidad:</strong> {evaluacion.activo.nivel_criticidad_negocio || 'N/A'}
                        </Typography>
                      </Grid>
                      <Grid item xs={12} sm={6}>
                        <Typography variant="body2" className="font-roboto" sx={{ color: '#6B7280' }}>
                          <strong>Fecha de Evaluación:</strong> {new Date(evaluacion.fechaCompletada).toLocaleDateString()}
                        </Typography>
                      </Grid>
                    </Grid>
                  </CardContent>
                </Card>

                {/* Información del riesgo */}
                {evaluacion.evaluacion.newRiesgo.amenaza && (
                  <Card sx={{ mb: 3, border: '1px solid #E5E7EB' }}>
                    <CardContent>
                      <Typography variant="h6" className="font-poppins" sx={{ color: '#1E3A8A', mb: 2 }}>
                        Información del Riesgo
                      </Typography>
                      <Typography variant="body2" className="font-roboto" sx={{ color: '#6B7280', mb: 1 }}>
                        <strong>Amenaza:</strong> {evaluacion.evaluacion.newRiesgo.amenaza}
                      </Typography>
                      <Typography variant="body2" className="font-roboto" sx={{ color: '#6B7280', mb: 1 }}>
                        <strong>Vulnerabilidad:</strong> {evaluacion.evaluacion.newRiesgo.vulnerabilidad}
                      </Typography>
                      <Typography variant="body2" className="font-roboto" sx={{ color: '#6B7280' }}>
                        <strong>Descripción:</strong> {evaluacion.evaluacion.newRiesgo.descripcion}
                      </Typography>
                    </CardContent>
                  </Card>
                )}

                {/* Evaluación Inherente */}
                {evaluacion.evaluacion.evaluacionInherente.probabilidad && (
                  <Card sx={{ mb: 3, border: '1px solid #E5E7EB' }}>
                    <CardContent>
                      <Typography variant="h6" className="font-poppins" sx={{ color: '#1E3A8A', mb: 2 }}>
                        Evaluación Inherente
                      </Typography>
                      <Grid container spacing={2}>
                        <Grid item xs={12} sm={6}>
                          <Typography variant="body2" className="font-roboto" sx={{ color: '#6B7280' }}>
                            <strong>Probabilidad:</strong> {evaluacion.evaluacion.evaluacionInherente.probabilidad}
                          </Typography>
                        </Grid>
                        <Grid item xs={12} sm={6}>
                          <Typography variant="body2" className="font-roboto" sx={{ color: '#6B7280' }}>
                            <strong>Impacto:</strong> {evaluacion.evaluacion.evaluacionInherente.impacto}
                          </Typography>
                        </Grid>
                        <Grid item xs={12}>
                          <Typography variant="body2" className="font-roboto" sx={{ color: '#6B7280', mb: 1 }}>
                            <strong>Nivel de Riesgo:</strong> 
                            <Chip 
                              label={evaluacion.evaluacion.evaluacionInherente.nivelRiesgo} 
                              size="small" 
                              sx={{ ml: 1, backgroundColor: '#FEF3C7', color: '#D97706' }}
                            />
                          </Typography>
                        </Grid>
                        <Grid item xs={12}>
                          <Typography variant="body2" className="font-roboto" sx={{ color: '#6B7280' }}>
                            <strong>Justificación:</strong> {evaluacion.evaluacion.evaluacionInherente.justificacion}
                          </Typography>
                        </Grid>
                      </Grid>
                    </CardContent>
                  </Card>
                )}

                {/* Evaluación Residual */}
                {evaluacion.evaluacion.evaluacionResidual.probabilidad && (
                  <Card sx={{ mb: 3, border: '1px solid #E5E7EB' }}>
                    <CardContent>
                      <Typography variant="h6" className="font-poppins" sx={{ color: '#1E3A8A', mb: 2 }}>
                        Evaluación Residual
                      </Typography>
                      <Grid container spacing={2}>
                        <Grid item xs={12} sm={6}>
                          <Typography variant="body2" className="font-roboto" sx={{ color: '#6B7280' }}>
                            <strong>Probabilidad:</strong> {evaluacion.evaluacion.evaluacionResidual.probabilidad}
                          </Typography>
                        </Grid>
                        <Grid item xs={12} sm={6}>
                          <Typography variant="body2" className="font-roboto" sx={{ color: '#6B7280' }}>
                            <strong>Impacto:</strong> {evaluacion.evaluacion.evaluacionResidual.impacto}
                          </Typography>
                        </Grid>
                        <Grid item xs={12}>
                          <Typography variant="body2" className="font-roboto" sx={{ color: '#6B7280', mb: 1 }}>
                            <strong>Nivel de Riesgo:</strong> 
                            <Chip 
                              label={evaluacion.evaluacion.evaluacionResidual.nivelRiesgo} 
                              size="small" 
                              sx={{ ml: 1, backgroundColor: '#DBEAFE', color: '#2563EB' }}
                            />
                          </Typography>
                        </Grid>
                        <Grid item xs={12}>
                          <Typography variant="body2" className="font-roboto" sx={{ color: '#6B7280' }}>
                            <strong>Justificación:</strong> {evaluacion.evaluacion.evaluacionResidual.justificacion}
                          </Typography>
                        </Grid>
                      </Grid>
                    </CardContent>
                  </Card>
                )}

                {/* Opciones de Tratamiento */}
                {evaluacion.evaluacion.tratamiento.opcion && (
                  <Card sx={{ mb: 3, border: '1px solid #E5E7EB' }}>
                    <CardContent>
                      <Typography variant="h6" className="font-poppins" sx={{ color: '#1E3A8A', mb: 2 }}>
                        Opciones de Tratamiento
                      </Typography>
                      <Grid container spacing={2}>
                        <Grid item xs={12}>
                          <Typography variant="body2" className="font-roboto" sx={{ color: '#6B7280', mb: 1 }}>
                            <strong>Opción:</strong> {evaluacion.evaluacion.tratamiento.opcion}
                          </Typography>
                        </Grid>
                        <Grid item xs={12} sm={6}>
                          <Typography variant="body2" className="font-roboto" sx={{ color: '#6B7280' }}>
                            <strong>Responsable:</strong> {evaluacion.evaluacion.tratamiento.responsable}
                          </Typography>
                        </Grid>
                        <Grid item xs={12} sm={6}>
                          <Typography variant="body2" className="font-roboto" sx={{ color: '#6B7280' }}>
                            <strong>Presupuesto:</strong> {evaluacion.evaluacion.tratamiento.presupuesto}
                          </Typography>
                        </Grid>
                        <Grid item xs={12} sm={6}>
                          <Typography variant="body2" className="font-roboto" sx={{ color: '#6B7280' }}>
                            <strong>Fecha Inicio:</strong> {evaluacion.evaluacion.tratamiento.fechaInicio}
                          </Typography>
                        </Grid>
                        <Grid item xs={12} sm={6}>
                          <Typography variant="body2" className="font-roboto" sx={{ color: '#6B7280' }}>
                            <strong>Fecha Fin:</strong> {evaluacion.evaluacion.tratamiento.fechaFin}
                          </Typography>
                        </Grid>
                      </Grid>
                    </CardContent>
                  </Card>
                )}

                {/* Plan de Acción con Documentos */}
                {evaluacion.evaluacion.planAccion.acciones.length > 0 && (
                  <Card sx={{ mb: 3, border: '1px solid #E5E7EB' }}>
                    <CardContent>
                      <Typography variant="h6" className="font-poppins" sx={{ color: '#1E3A8A', mb: 2 }}>
                        Plan de Acción
                      </Typography>
                      {evaluacion.evaluacion.planAccion.acciones.map((accion, index) => (
                        <Box key={accion.id} sx={{ mb: 3, p: 2, border: '1px solid #F3F4F6', borderRadius: '8px' }}>
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
                                {accion.documentos.map((documento) => (
                                  <ListItem key={documento.id} sx={{ py: 0.5 }}>
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
                                    >
                                      <DownloadIcon />
                                    </IconButton>
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
                  exportarResumenPDF(evaluacionEstado.evaluacion);
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
