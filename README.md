# Speed Rivals — Neon Circuit

Speed Rivals es un videojuego de carreras arcade en 2D para dos jugadores. Cada persona entra desde su propio navegador o dispositivo, participa en una carrera compartida y compara la distancia recorrida.

## Cómo probar la versión publicada

1. Abre [Speed Rivals](https://proyecto12-kohl.vercel.app/) desde el dominio de producción.
2. Crea una cuenta o inicia sesión con correo y contraseña.
3. Escribe el nombre que se mostrará en la carrera y entra a la pista.
4. Abre el mismo enlace en otro navegador o dispositivo e inicia sesión con la segunda cuenta.
5. Espera a que ambos jugadores estén conectados y comience la carrera compartida.
6. Mantén `↑` o `W` para acelerar y usa `←` / `→` o `A` / `D` para dirigir el auto. En pantalla táctil, utiliza los controles que aparecen en pantalla.
7. La carrera dura 2 minutos y 30 segundos. Un choque devuelve el auto afectado al inicio, pero no reinicia el cronómetro ni la distancia acumulada.
8. Al terminar, revisa el resultado y el historial de la cuenta. La carrera espera a que se pulse **Jugar otra vez** antes de iniciar otra.

## Cómo está construido

- **HTML y CSS:** estructura de la pantalla, controles, panel de resultados y adaptación a distintos tamaños de pantalla.
- **JavaScript:** movimiento de los autos, obstáculos, colisiones, cronómetro, puntajes y eventos de los controles. Esta lógica se ejecuta en el navegador.
- **Vercel:** publica la aplicación desde el repositorio de GitHub.
- **Supabase Auth:** registra e identifica las cuentas mediante correo y contraseña.
- **Supabase Realtime:** comparte el estado de los jugadores para sincronizar la carrera entre navegadores.
- **Supabase Database:** conserva los resultados en `public.race_results`. Cada fila incluye ganador, distancia total, distancia del jugador, nombres, fecha, identificador de carrera y `user_id` de la cuenta que guardó el resultado.
- **Historial personal:** la aplicación filtra los resultados por `user_id`, de modo que cada cuenta consulta su propio historial.
- **Ranking compartido:** un disparador actualiza `public.race_leaderboard` cuando se guarda un resultado. El ranking público muestra ganador, distancia y fecha.

## Datos y seguridad

La tabla `race_results` tiene Row Level Security activado. Las políticas actuales permiten que una cuenta autenticada consulte e inserte únicamente filas asociadas a su propio `user_id`. La tabla `race_leaderboard` permite consultas públicas del ranking, sin exponer el historial individual completo.

En el navegador sólo se utiliza la URL del proyecto y la clave publicable de Supabase. Nunca incluyas una clave secreta o `service_role` en el código público ni en GitHub.

## Publicación y código fuente

- Aplicación: https://proyecto12-kohl.vercel.app/
- Repositorio: https://github.com/Jhonn16ax/proyecto12

Vercel publica los cambios de la rama `main`. Para la entrega y la demostración, abre el enlace de producción antes de presentarlo y comprueba el acceso con las dos cuentas de prueba.

## Estructura de Supabase

El archivo `supabase.sql` documenta las tablas `race_results` y `race_leaderboard`, las políticas de acceso por cuenta y el disparador que mantiene el ranking. Es una referencia del esquema actual; antes de ejecutarlo en otra base, revisa que no sobrescriba datos o políticas que ya necesites.
