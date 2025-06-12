# Implementacion de Planificacion Round Robin
from rich.console import Console
from rich.table import Table
from rich.panel import Panel
from rich import print as rprint
from rich.text import Text
from rich.style import Style

console = Console()


# Funcion para encontrar el tiempo de espera para todos los procesos
def encontrarTiempoEspera(procesos, n, tiempo_rafaga, tiempo_espera, quantum):
    tiempo_rafaga_restante = [0] * n
    orden_ejecucion = []  # Lista para almacenar el orden de ejecución

    # Copiar el tiempo de rafaga en tiempo_rafaga_restante[]
    for i in range(n):
        tiempo_rafaga_restante[i] = tiempo_rafaga[i]
    tiempo_actual = 0  # Tiempo actual

    # Mantener recorriendo los procesos en forma round robin hasta que todos esten completados
    while 1:
        completado = True

        # Recorrer todos los procesos uno por uno repetidamente
        for i in range(n):

            # Si el tiempo de rafaga de un proceso es mayor que 0, entonces necesita ser procesado
            if tiempo_rafaga_restante[i] > 0:
                completado = False  # Hay un proceso pendiente
                orden_ejecucion.append(
                    i + 1
                )  # Agregar el proceso al orden de ejecución

                if tiempo_rafaga_restante[i] > quantum:

                    # Aumentar el valor del tiempo actual, muestra cuanto tiempo ha sido procesado un proceso
                    tiempo_actual += quantum

                    # Disminuir el tiempo de rafaga del proceso actual por el quantum
                    tiempo_rafaga_restante[i] -= quantum

                # Si el tiempo de rafaga es menor o igual al quantum. Ultimo ciclo para este proceso
                else:

                    # Aumentar el valor del tiempo actual
                    tiempo_actual = tiempo_actual + tiempo_rafaga_restante[i]

                    # El tiempo de espera es el tiempo actual menos
                    # el tiempo usado por este proceso
                    tiempo_espera[i] = tiempo_actual - tiempo_rafaga[i]

                    # Como el proceso se ha ejecutado completamente hacer su tiempo de rafaga restante = 0
                    tiempo_rafaga_restante[i] = 0

        # Si todos los procesos estan completados
        if completado == True:
            break

    return orden_ejecucion


# Funcion para calcular el tiempo de retorno
def encontrarTiempoRetorno(procesos, n, tiempo_rafaga, tiempo_espera, tiempo_retorno):
    # Calculando el tiempo de retorno
    for i in range(n):
        tiempo_retorno[i] = tiempo_rafaga[i] + tiempo_espera[i]


def crearDiagramaGantt(orden_ejecucion, tiempo_rafaga, quantum):
    # Crear un diccionario para rastrear el tiempo de inicio y fin de cada proceso
    tiempo_inicio = {}
    tiempo_fin = {}
    tiempo_actual = 0
    tiempo_rafaga_restante = tiempo_rafaga.copy()

    # Calcular tiempos de inicio y fin para cada ejecución de proceso
    for proceso in orden_ejecucion:
        if proceso not in tiempo_inicio:
            tiempo_inicio[proceso] = []
            tiempo_fin[proceso] = []

        tiempo_inicio[proceso].append(tiempo_actual)
        tiempo_ejecucion = min(quantum, tiempo_rafaga_restante[proceso - 1])
        tiempo_actual += tiempo_ejecucion
        tiempo_rafaga_restante[proceso - 1] -= tiempo_ejecucion
        tiempo_fin[proceso].append(tiempo_actual)

    # Crear la línea de tiempo
    tiempo_total = tiempo_actual
    escala = 2  # Cada carácter representa 0.5 unidades de tiempo

    # Imprimir la línea de tiempo superior
    timeline = "  0"
    n_s = 3
    for i in range(1, tiempo_total + 1):
        if i == 10:
            n_s -= 1
        if i % 2 == 0:
            timeline += str(i)
        else:
            timeline += " " * n_s

    # Imprimir la línea de tiempo con marcas
    timeline_marks = "  |"
    for i in range(1, tiempo_total + 1):
        if i % 2 == 0:
            timeline_marks += "|"
        else:
            timeline_marks += "___"

    # Colores para los procesos
    colores = ["red", "green", "blue", "yellow", "magenta", "cyan"]

    # Arreglo para almacenar las líneas del diagrama
    lineas_diagrama = []
    lineas_diagrama.append(timeline)
    lineas_diagrama.append(timeline_marks)

    # Imprimir cada proceso
    for proceso in sorted(tiempo_inicio.keys()):
        linea = f"P{proceso} "
        tiempo_actual = 0

        # Crear la representación visual del proceso
        for i in range(len(tiempo_inicio[proceso])):
            inicio = tiempo_inicio[proceso][i]
            fin = tiempo_fin[proceso][i]

            # Agregar espacios hasta el inicio
            while tiempo_actual < inicio:
                linea += " "
                tiempo_actual += 0.5

            # Agregar el bloque de ejecución
            duracion = fin - inicio
            color = colores[(proceso - 1) % len(colores)]
            bloque = "█" * int(duracion * escala)
            linea += f"[{color}]{bloque}[/{color}]"
            tiempo_actual = fin

        lineas_diagrama.append(linea)

    # Crear el contenido del panel
    contenido_panel = "\n".join(lineas_diagrama)

    # Mostrar el diagrama en un panel
    console.print(
        Panel(
            contenido_panel,
            title="Diagrama de Gantt",
            border_style="cyan",
            expand=False,
        )
    )


# Funcion para calcular el tiempo promedio de espera y tiempo de retorno
def encontrarTiempoPromedio(procesos, n, tiempo_rafaga, quantum):
    tiempo_espera = [0] * n
    tiempo_retorno = [0] * n

    # Funcion para encontrar el tiempo de espera de todos los procesos
    orden_ejecucion = encontrarTiempoEspera(
        procesos, n, tiempo_rafaga, tiempo_espera, quantum
    )

    # Funcion para encontrar el tiempo de retorno para todos los procesos
    encontrarTiempoRetorno(procesos, n, tiempo_rafaga, tiempo_espera, tiempo_retorno)

    print()
    # Crear tabla para mostrar los resultados
    table = Table(
        title="Resumen de Ejecución",
        show_header=True,
        header_style="bold magenta",
    )
    table.add_column("Proceso", style="cyan")
    table.add_column("Tiempo Rafaga", justify="right", style="green")
    table.add_column("Tiempo Espera", justify="right", style="yellow")
    table.add_column("Tiempo Finalización", justify="right", style="blue")

    tiempo_espera_total = 0
    tiempo_retorno_total = 0
    for i in range(n):
        tiempo_espera_total = tiempo_espera_total + tiempo_espera[i]
        tiempo_retorno_total = tiempo_retorno_total + tiempo_retorno[i]
        table.add_row(
            str(i + 1),
            str(tiempo_rafaga[i]),
            str(tiempo_espera[i]),
            str(tiempo_retorno[i]),
        )

    # Mostrar la tabla
    console.print(table)

    # Mostrar tiempos promedio en un panel
    console.print(
        Panel(
            f"[green]Tiempo promedio de espera:[/green] {tiempo_espera_total/n:.2f}\n"
            f"[blue]Tiempo promedio de retorno:[/blue] {tiempo_retorno_total/n:.2f}",
            title="Estadísticas",
            border_style="yellow",
        )
    )

    # Mostrar el orden de ejecución
    secuencia = " → ".join(map(str, orden_ejecucion))
    console.print(
        Panel(
            f"[cyan]Secuencia de ejecución:[/cyan]\n{secuencia}\n\n"
            f"[yellow]Cantidad total de cambios de contexto:[/yellow] {len(orden_ejecucion)}",
            title="Orden de Ejecución",
            border_style="green",
        )
    )

    # Mostrar el diagrama de Gantt
    lineas_diagrama = crearDiagramaGantt(orden_ejecucion, tiempo_rafaga, quantum)


# Codigo principal
if __name__ == "__main__":

    # IDs de los procesos
    # proc = [1, 2, 3, 4, 5]

    # Tiempo de rafaga de todos los procesos
    # tiempo_rafaga = [8, 10, 6, 4, 2]

    n = int(input("Ingrese el numero de procesos: "))
    proc = list(range(1, n + 1))
    tiempo_rafaga = []
    for i in range(n):
        tiempo = int(input(f"Ingrese el tiempo de rafaga para el proceso {i+1}: "))
        tiempo_rafaga.append(tiempo)

    # Quantum de tiempo
    quantum = 2
    encontrarTiempoPromedio(proc, len(proc), tiempo_rafaga, quantum)
