import serial
import socket
import time
import matplotlib.pyplot as plt
import matplotlib.animation as animation
import pandas as pd
from datetime import datetime

# Configuración del puerto serial y UDP
SERIAL_PORT = "COM3"
BAUD_RATE = 9600
UDP_HOST = "127.0.0.1"
UDP_PORT = 12345

# Inicializar listas para datos
times = []
voltages = []
currents = []
powers = []

# Tiempo inicial
start_time = time.time()

# Inicializar la conexión serial
try:
    ser = serial.Serial(SERIAL_PORT, BAUD_RATE, timeout=1)
    print(f"✅ Conectado al ESP32 en {SERIAL_PORT} a {BAUD_RATE} baudios")
except Exception as e:
    print(f"❌ Error al conectar con ESP32: {e}")
    exit()

# Crear socket UDP
sock = socket.socket(socket.AF_INET, socket.SOCK_DGRAM)

# Configurar gráficos
fig, axs = plt.subplots(3, 1, figsize=(8, 10))

# Función para guardar datos en Excel
def save_to_excel():
    # Crear un DataFrame con los datos
    data = {
        'Tiempo (s)': times,
        'Voltaje (V)': voltages,
        'Corriente (A)': currents,
        'Potencia (W)': powers
    }
    df = pd.DataFrame(data)
    
    # Obtener la fecha y hora actual
    now = datetime.now()
    timestamp = now.strftime("%Y-%m-%d_%H-%M-%S")
    
    # Nombre del archivo Excel
    filename = f"datos_{timestamp}.xlsx"
    
    # Guardar el DataFrame en un archivo Excel
    df.to_excel(filename, index=False)
    print(f"📊 Datos guardados en {filename}")

def update_graph(i):
    if ser.in_waiting > 0:
        raw_data = ser.readline().decode("utf-8").strip()
        print(f"📥 Datos crudos recibidos del ESP32: {raw_data}")

        clean_data = raw_data.replace("|", "").strip()
        values = clean_data.split()

        if len(values) >= 3:
            try:
                voltaje = float(values[0])
                corriente = float(values[1])
                potencia = voltaje * corriente  # P = V * I
                tiempo_actual = time.time() - start_time

                # Guardar datos
                times.append(tiempo_actual)
                voltages.append(voltaje)
                currents.append(corriente)
                powers.append(potencia)

                # Enviar datos a Godot por UDP
                formatted_data = f"{voltaje},{corriente},{potencia}"
                sock.sendto(formatted_data.encode(), (UDP_HOST, UDP_PORT))

                # Limitar tamaño de listas para evitar consumo excesivo de memoria
                max_points = 100
                if len(times) > max_points:
                    times.pop(0)
                    voltages.pop(0)
                    currents.pop(0)
                    powers.pop(0)

                # Actualizar gráficos
                axs[0].cla()
                axs[0].plot(times, voltages, label="Voltaje (V)", color="b")
                axs[0].set_title("Voltaje vs Tiempo")
                axs[0].set_ylabel("Voltaje (V)")
                axs[0].legend()

                axs[1].cla()
                axs[1].plot(times, currents, label="Corriente (A)", color="g")
                axs[1].set_title("Corriente vs Tiempo")
                axs[1].set_ylabel("Corriente (A)")
                axs[1].legend()

                axs[2].cla()
                axs[2].plot(times, powers, label="Potencia (W)", color="r")
                axs[2].set_title("Voltaje x Corriente (Potencia)")
                axs[2].set_xlabel("Tiempo (s)")
                axs[2].set_ylabel("Potencia (W)")
                axs[2].legend()

            except ValueError:
                print("Error: Datos no numéricos recibidos")

# Iniciar animación
ani = animation.FuncAnimation(fig, update_graph, interval=500)

plt.tight_layout()
plt.show()

# Guardar datos en Excel al cerrar el programa
save_to_excel()

# Cerrar conexiones al salir
ser.close()
sock.close()
print("🔌 Conexiones cerradas.")
