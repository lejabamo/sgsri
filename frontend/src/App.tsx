import React from "react";
import { BrowserRouter as Router, Routes, Route, Navigate } from "react-router-dom";
import { ThemeProvider, createTheme } from "@mui/material/styles";
import { CssBaseline } from "@mui/material";
import { QueryClient, QueryClientProvider } from "@tanstack/react-query";
import { Toaster } from "react-hot-toast";

import { AuthProvider, useAuth } from "./contexts/AuthContext";
import Layout from "./components/common/Layout";
import Login from "./components/auth/Login";
import Dashboard from "./pages/dashboard/Dashboard";
import Activos from "./pages/activos/Activos";
import Usuarios from "./pages/usuarios/Usuarios";
import Riesgos from "./pages/riesgos/Riesgos";
import Reportes from "./pages/reportes/Reportes";
import RiskAssessmentWizard from "./pages/wizard/RiskAssessmentWizard";

const theme = createTheme({
  palette: {
    primary: {
      main: "#2F3E46",
    },
    secondary: {
      main: "#84A98C",
    },
    background: {
      default: "#F6F7F8",
      paper: "#FFFFFF",
    },
    text: {
      primary: "#2F3E46",
      secondary: "#666666",
    },
  },
  typography: {
    fontFamily: "'Roboto', 'Helvetica', 'Arial', sans-serif",
    h1: {
      fontFamily: "'Poppins', sans-serif",
      fontWeight: 600,
    },
    h2: {
      fontFamily: "'Poppins', sans-serif",
      fontWeight: 600,
    },
    h3: {
      fontFamily: "'Poppins', sans-serif",
      fontWeight: 600,
    },
    h4: {
      fontFamily: "'Poppins', sans-serif",
      fontWeight: 600,
    },
    h5: {
      fontFamily: "'Poppins', sans-serif",
      fontWeight: 500,
    },
    h6: {
      fontFamily: "'Poppins', sans-serif",
      fontWeight: 500,
    },
    button: {
      fontFamily: "'Poppins', sans-serif",
      fontWeight: 500,
      textTransform: 'none',
    },
  },
  shape: {
    borderRadius: 8,
  },
  components: {
    MuiButton: {
      styleOverrides: {
        root: {
          borderRadius: 8,
          padding: '10px 24px',
          fontSize: '0.95rem',
          fontWeight: 500,
          boxShadow: '0 2px 8px rgba(47, 62, 70, 0.15)',
          transition: 'all 0.2s ease-in-out',
          '&:hover': {
            transform: 'translateY(-1px)',
            boxShadow: '0 4px 16px rgba(47, 62, 70, 0.25)',
          },
          '&:active': {
            transform: 'translateY(0)',
          },
        },
        contained: {
          backgroundColor: '#2F3E46',
          color: '#F6F7F8',
          '&:hover': {
            backgroundColor: '#1a2529',
          },
        },
        outlined: {
          borderColor: '#84A98C',
          color: '#52796F',
          '&:hover': {
            borderColor: '#52796F',
            backgroundColor: 'rgba(132, 169, 140, 0.04)',
          },
        },
      },
    },
    MuiCard: {
      styleOverrides: {
        root: {
          borderRadius: 12,
          boxShadow: '0 4px 20px rgba(47, 62, 70, 0.08)',
          border: '1px solid rgba(47, 62, 70, 0.06)',
          transition: 'all 0.2s ease-in-out',
          '&:hover': {
            boxShadow: '0 8px 32px rgba(47, 62, 70, 0.12)',
            transform: 'translateY(-2px)',
          },
        },
      },
    },
    MuiTextField: {
      styleOverrides: {
        root: {
          '& .MuiOutlinedInput-root': {
            borderRadius: 8,
            transition: 'all 0.2s ease-in-out',
            '&:hover fieldset': {
              borderColor: '#84A98C',
            },
            '&.Mui-focused fieldset': {
              borderColor: '#52796F',
            },
          },
        },
      },
    },
    MuiPaper: {
      styleOverrides: {
        root: {
          borderRadius: 12,
          boxShadow: '0 2px 12px rgba(47, 62, 70, 0.06)',
        },
      },
    },
  },
});

const queryClient = new QueryClient();

const ProtectedRoute: React.FC<{ children: React.ReactNode }> = ({ children }) => {
  const { isAuthenticated, isLoading } = useAuth();

  if (isLoading) {
    return <div>Cargando...</div>;
  }

  return isAuthenticated ? <Layout>{children}</Layout> : <Navigate to="/login" />;
};

const App: React.FC = () => {
  return (
    <QueryClientProvider client={queryClient}>
      <ThemeProvider theme={theme}>
        <CssBaseline />
        <AuthProvider>
          <Router>
            <Routes>
              <Route path="/login" element={<Login />} />
              <Route
                path="/dashboard"
                element={
                  <ProtectedRoute>
                    <Dashboard />
                  </ProtectedRoute>
                }
              />
              <Route
                path="/activos"
                element={
                  <ProtectedRoute>
                    <Activos />
                  </ProtectedRoute>
                }
              />
              <Route
                path="/usuarios"
                element={
                  <ProtectedRoute>
                    <Usuarios />
                  </ProtectedRoute>
                }
              />
              <Route
                path="/riesgos"
                element={
                  <ProtectedRoute>
                    <Riesgos />
                  </ProtectedRoute>
                }
              />
              <Route
                path="/reportes"
                element={
                  <ProtectedRoute>
                    <Reportes />
                  </ProtectedRoute>
                }
              />
              <Route
                path="/wizard"
                element={
                  <ProtectedRoute>
                    <RiskAssessmentWizard />
                  </ProtectedRoute>
                }
              />
              <Route path="/" element={<Navigate to="/dashboard" />} />
            </Routes>
          </Router>
        </AuthProvider>
        <Toaster position="top-right" />
      </ThemeProvider>
    </QueryClientProvider>
  );
};

export default App;
