# -*- coding: utf-8 -*-
# -----------------------------------------------------------------------------
# SIMULADOR DE PLANIFICACIÓN POR PRIORIDAD (PREEMPTIVE Y NON-PREEMPTIVE)
#
# Cómo funciona (Modo Preemptive - por defecto):
# 1. El tiempo avanza unidad por unidad.
# 2. En cada instante, se revisa si ha llegado un nuevo proceso.
# 3. El planificador SIEMPRE elige al proceso con la prioridad más alta
#    (número más bajo) de la cola de listos.
# 4. Si un nuevo proceso llega con una prioridad MÁS ALTA que el que está
#    en ejecución, el proceso actual es INTERRUMPIDO (preempted) y
#    devuelto a la cola de listos.
#
# Cómo ejecutar:
#   - Modo Preemptive (por defecto): python PP.py
#   - Modo Non-Preemptive:         python PP.py --non-preemptive
#
# Requisitos:
#   - Python 3.7+
#   - Instalar la librería 'rich': pip install rich
# -----------------------------------------------------------------------------

import sys
import argparse  # Módulo para manejar argumentos de línea de comandos

# Importamos las herramientas de la librería 'rich'
from rich.console import Console
from rich.table import Table
from rich.panel import Panel
from rich.prompt import Prompt


# Clase para representar un Proceso
class Process:
    def __init__(self, name, arrival, burst, priority):
        self.name = name
        self.arrival_time = int(arrival)
        self.burst_time = int(burst)
        self.priority = int(priority)

        # Atributos para la simulación
        self.remaining_burst = int(burst)
        self.start_time = -1  # -1 indica que aún no ha comenzado
        self.finish_time = 0
        self.wait_time = 0
        self.turnaround_time = 0

    def __repr__(self):
        return (
            f"Process(name={self.name}, arrival={self.arrival_time}, "
            f"burst={self.burst_time}, priority={self.priority})"
        )


def get_process_data():
    """Solicita al usuario los datos de 4 procesos y realiza validaciones."""
    console = Console()
    processes = []

    while True:
        processes.clear()
        console.print(
            "[bold cyan]Por favor, introduce los datos de 4 procesos.[/bold cyan]"
        )
        console.print("Nota: Prioridad '1' es la más alta.")

        for i in range(4):
            console.print(f"\n--- Proceso {i+1} ---")
            name = f"P{i+1}"

            # Bucle de validacion para cada entrada numerica
            while True:
                try:
                    arrival = int(Prompt.ask(f"[P{i+1}] Instante de llegada"))
                    burst = int(Prompt.ask(f"[P{i+1}] Tiempo de ejecución"))
                    priority = int(Prompt.ask(f"[P{i+1}] Prioridad"))
                    if arrival < 0 or burst <= 0 or priority <= 0:
                        console.print(
                            "[bold red]Error: Los valores deben ser positivos (ráfaga y prioridad > 0).[/bold red]"
                        )
                        continue
                    break
                except ValueError:
                    console.print(
                        "[bold red]Error: Por favor, introduce solo números enteros.[/bold red]"
                    )

            processes.append(Process(name, arrival, burst, priority))

        # Validacion final: al menos un proceso con prioridad >= 3
        low_priority_exists = any(p.priority >= 3 for p in processes)
        if not low_priority_exists:
            console.print(
                "[bold red]\nError de validación: Debe haber al menos un proceso con prioridad baja (>= 3).[/bold red]"
            )
            console.print("Por favor, introduce los datos de nuevo.\n")
        else:
            break

    return processes


def run_priority_simulation(processes, is_preemptive):
    """
    Ejecuta la simulación del algoritmo de planificación por prioridad.
    Puede operar en modo preemptivo o no preemptivo.
    """
    # Ordenamos la lista original para tener una referencia consistente
    processes.sort(key=lambda p: p.name)

    completed_processes = []
    gantt_chart_data = []  # Almacenará tuplas (nombre, inicio, fin)
    current_time = 0
    num_processes = len(processes)

    while len(completed_processes) < num_processes:
        # Filtramos los procesos que ya han llegado y no han terminado
        ready_queue = [
            p
            for p in processes
            if p.arrival_time <= current_time and p.remaining_burst > 0
        ]

        if not ready_queue:
            # Si no hay procesos listos, la CPU está ociosa. Avanzamos el tiempo al próximo arribo.
            next_arrival_time = min(
                p.arrival_time for p in processes if p.remaining_burst > 0
            )
            if current_time < next_arrival_time:
                gantt_chart_data.append(("Ocioso", current_time, next_arrival_time))
                current_time = next_arrival_time
            continue

        # CRITERIO DE SELECCIÓN: Prioridad y luego FCFS
        ready_queue.sort(key=lambda p: (p.priority, p.arrival_time))
        process_to_run = ready_queue[0]

        if process_to_run.start_time == -1:
            process_to_run.start_time = current_time

        if is_preemptive:
            # MODO PREEMPTIVO: Se ejecuta por 1 unidad de tiempo
            gantt_chart_data.append(
                (process_to_run.name, current_time, current_time + 1)
            )
            process_to_run.remaining_burst -= 1
            current_time += 1

            if process_to_run.remaining_burst == 0:
                process_to_run.finish_time = current_time
                completed_processes.append(process_to_run)
        else:
            # MODO NO PREEMPTIVO: Se ejecuta hasta el final
            execution_time = process_to_run.burst_time
            gantt_chart_data.append(
                (process_to_run.name, current_time, current_time + execution_time)
            )
            process_to_run.finish_time = current_time + execution_time
            process_to_run.remaining_burst = 0  # El proceso se completa
            current_time = process_to_run.finish_time
            completed_processes.append(process_to_run)

    # Calculamos métricas finales para todos los procesos
    for p in processes:
        p.turnaround_time = p.finish_time - p.arrival_time
        p.wait_time = p.turnaround_time - p.burst_time

    return processes, gantt_chart_data


def merge_gantt_blocks(gantt_data):
    """
    Combina bloques consecutivos del mismo proceso en el diagrama de Gantt.
    Ej: [('P1', 0, 1), ('P1', 1, 2)] -> [('P1', 0, 2)]
    """
    if not gantt_data:
        return []

    merged = []
    current_name, start_time, _ = gantt_data[0]

    for i in range(1, len(gantt_data)):
        next_name, _, next_end_time = gantt_data[i]
        if next_name == current_name:
            # Bloque del mismo proceso, continuamos
            continue
        else:
            # Cambio de proceso, guardamos el bloque anterior
            end_time = gantt_data[i - 1][2]
            merged.append((current_name, start_time, end_time))
            current_name, start_time, _ = gantt_data[i]

    # Añadir el último bloque
    end_time = gantt_data[-1][2]
    merged.append((current_name, start_time, end_time))

    return merged


def create_gantt_chart(gantt_data, all_processes):
    """
    Crea y muestra un diagrama de Gantt visualmente mejorado.
    """
    console = Console()

    # Colores para los procesos
    colors = ["cyan", "magenta", "green", "yellow", "blue", "red"]
    process_colors = {
        p.name: colors[i % len(colors)] for i, p in enumerate(all_processes)
    }
    process_colors["Ocioso"] = "white"

    # Preparar el contenido del panel del diagrama
    gantt_lines = []

    # Crear la línea de tiempo superior
    total_time = gantt_data[-1][2] if gantt_data else 0
    timeline = "     0"
    for t in range(1, total_time + 1):
        timeline += f" {t:<2}" if t % 2 == 0 or t == total_time else "   "
    gantt_lines.append(f"[bold]{timeline}[/bold]")

    # Crear la barra de ejecución por proceso
    process_names = sorted([p.name for p in all_processes])
    for name in process_names:
        line = f"[bold {process_colors[name]}]{name: >3}[/] |"
        current_time = 0

        # Buscar los bloques de ejecución para este proceso
        for p_name, start, end in gantt_data:
            if p_name == name:
                # Espacio antes del bloque
                line += " " * (start - current_time) * 3
                # Bloque de ejecución
                duration = end - start
                line += f"[{process_colors[name]}]{'█' * duration * 3}[/]"
                current_time = end
        gantt_lines.append(line)

    panel_content = "\n".join(gantt_lines)
    console.print(
        Panel(
            panel_content,
            title="[bold]Diagrama de Gantt[/bold]",
            border_style="green",
            expand=False,
        )
    )


def display_results(completed_processes, gantt_chart_data, is_preemptive):
    """Muestra los resultados de la simulación en tablas y diagrama de Gantt."""
    console = Console()
    mode = (
        "PREEMPTIVE (Apropiativo)"
        if is_preemptive
        else "NON-PREEMPTIVE (No Apropiativo)"
    )

    console.print("\n" + "=" * 120, style="bold green")
    console.print(
        f"SIMULACIÓN DE PLANIFICACIÓN POR PRIORIDAD - MODO {mode}",
        justify="center",
        style="bold green",
    )
    console.print("=" * 120, style="bold green")
    console.print()

    # Tabla de Resultados de la Planificación
    table_out = Table(
        title="[bold]RESULTADOS DE LA PLANIFICACIÓN[/bold]",
        title_style="magenta",
        header_style="bold magenta",
    )
    headers = [
        "Proceso",
        "Llegada",
        "Ejecución",
        "Prioridad",
        "Inicio",
        "Fin",
        "Espera",
        "Retorno",
    ]
    for header in headers:
        table_out.add_column(header, justify="right" if header != "Proceso" else "left")

    total_wait_time = 0
    total_turnaround_time = 0

    for p in completed_processes:
        table_out.add_row(
            p.name,
            str(p.arrival_time),
            str(p.burst_time),
            str(p.priority),
            str(p.start_time),
            str(p.finish_time),
            str(p.wait_time),
            str(p.turnaround_time),
        )
        total_wait_time += p.wait_time
        total_turnaround_time += p.turnaround_time

    console.print(table_out)

    # Calculo y visualizacion de promedios
    num_processes = len(completed_processes)
    avg_wait_time = total_wait_time / num_processes
    avg_turnaround_time = total_turnaround_time / num_processes

    console.print(
        f"\n[bold]Tiempo de Espera Promedio:[/] [yellow]{avg_wait_time:.2f}[/yellow]"
    )
    console.print(
        f"[bold]Tiempo de Retorno Promedio:[/] [yellow]{avg_turnaround_time:.2f}[/yellow]"
    )

    console.print()

    # Fusionar bloques de Gantt y mostrar el diagrama
    merged_gantt = merge_gantt_blocks(gantt_chart_data)
    create_gantt_chart(merged_gantt, completed_processes)


def main():
    """Función principal que orquesta la ejecución del simulador."""
    # Configuración de argumentos de línea de comandos
    parser = argparse.ArgumentParser(
        description="Simulador de Planificación por Prioridad."
    )
    parser.add_argument(
        "--non-preemptive",
        action="store_true",
        help="Ejecuta la simulación en modo no apropiativo. Por defecto es apropiativo.",
    )
    args = parser.parse_args()

    # El modo es preemptivo a menos que se especifique la bandera --non-preemptive
    is_preemptive = not args.non_preemptive

    # 1. Obtener datos de los procesos
    initial_processes = get_process_data()

    # 2. Ejecutar el algoritmo de planificación
    completed_processes, gantt_chart_data = run_priority_simulation(
        list(initial_processes), is_preemptive
    )

    # 3. Mostrar los resultados
    display_results(completed_processes, gantt_chart_data, is_preemptive)


if __name__ == "__main__":
    main()


# --- EJEMPLO DE EJECUCION COMENTADO ---
#
# Supongamos la siguiente entrada:
# P1: Llegada=0, Ejecucion=8, Prioridad=3
# P2: Llegada=1, Ejecucion=4, Prioridad=1 (mas alta)
# P3: Llegada=2, Ejecucion=2, Prioridad=2
# P4: Llegada=3, Ejecucion=1, Prioridad=4 (mas baja)
#
# El flujo de la simulacion seria:
#
# Tiempo = 0:
#   - Llega P1. La cola de listos es [P1].
#   - P1 es el unico, asi que se ejecuta.
#   - P1 comienza en t=0 y se ejecutara por 8 unidades (hasta t=8) porque es no apropiativo.
#
# Tiempo = 1:
#   - Llega P2. P1 sigue en ejecucion.
#
# Tiempo = 2:
#   - Llega P3. P1 sigue en ejecucion.
#
# Tiempo = 3:
#   - Llega P4. P1 sigue en ejecucion.
#
# Tiempo = 8:
#   - P1 termina.
#   - La CPU esta libre. La cola de listos contiene a [P2, P3, P4].
#   - Se ordenan por prioridad: P2 (1), P3 (2), P4 (4).
#   - Se selecciona P2 (prioridad 1).
#   - P2 comienza en t=8 y se ejecutara por 4 unidades (hasta t=12).
#
# Tiempo = 12:
#   - P2 termina.
#   - La CPU esta libre. La cola de listos contiene a [P3, P4].
#   - Se ordenan por prioridad: P3 (2), P4 (4).
#   - Se selecciona P3 (prioridad 2).
#   - P3 comienza en t=12 y se ejecutara por 2 unidades (hasta t=14).
#
# Tiempo = 14:
#   - P3 termina.
#   - La CPU esta libre. La cola de listos contiene a [P4].
#   - Se selecciona P4 (prioridad 4).
#   - P4 comienza en t=14 y se ejecutara por 1 unidad (hasta t=15).
#
# Tiempo = 15:
#   - P4 termina. Todos los procesos han sido ejecutados.
#
# El programa calculara los tiempos de espera y retorno para cada uno y los mostrara.
# Por ejemplo, para P4:
#   - Espera = Inicio - Llegada = 14 - 3 = 11
#   - Retorno = Fin - Llegada = 15 - 3 = 12
