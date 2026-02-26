"""
Script para obtener la IP del servidor y mostrar información de conexión
"""
import socket
import sys

def get_local_ip():
    """Obtiene la IP local del servidor"""
    try:
        # Conectar a un servidor externo para obtener la IP local
        s = socket.socket(socket.AF_INET, socket.SOCK_DGRAM)
        # No necesita conectarse realmente, solo prepara la conexión
        s.connect(("8.8.8.8", 80))
        ip = s.getsockname()[0]
        s.close()
        return ip
    except Exception:
        try:
            # Método alternativo
            hostname = socket.gethostname()
            ip = socket.gethostbyname(hostname)
            return ip
        except Exception:
            return "127.0.0.1"

def get_all_ips():
    """Obtiene todas las IPs de las interfaces de red"""
    ips = []
    try:
        hostname = socket.gethostname()
        # Obtener todas las IPs asociadas al hostname
        for addr_info in socket.getaddrinfo(hostname, None):
            ip = addr_info[4][0]
            if ip not in ips and not ip.startswith('127.'):
                ips.append(ip)
    except Exception:
        pass
    
    # Agregar IP local principal
    local_ip = get_local_ip()
    if local_ip not in ips:
        ips.insert(0, local_ip)
    
    return ips if ips else ["127.0.0.1"]

if __name__ == "__main__":
    print("=" * 60)
    print("INFORMACIÓN DE CONEXIÓN DEL SERVIDOR SGRI")
    print("=" * 60)
    print()
    
    ips = get_all_ips()
    main_ip = ips[0]
    
    print(f"IP Principal del Servidor: {main_ip}")
    print()
    
    if len(ips) > 1:
        print("Otras IPs disponibles:")
        for ip in ips[1:]:
            print(f"  - {ip}")
        print()
    
    print("URLs de acceso:")
    print(f"  Backend API: http://{main_ip}:5000")
    print(f"  Frontend (desarrollo): http://{main_ip}:5173")
    print()
    
    print("Para conectarse desde otro equipo:")
    print(f"  1. Asegúrate de que el firewall permita conexiones en los puertos 5000 y 5173")
    print(f"  2. En el otro equipo, accede a: http://{main_ip}:5173")
    print(f"  3. O configura el frontend para usar: http://{main_ip}:5000/api")
    print()
    
    print("Comandos útiles:")
    print(f"  - Verificar conexión: curl http://{main_ip}:5000/api/health")
    print()
    
    print("=" * 60)

