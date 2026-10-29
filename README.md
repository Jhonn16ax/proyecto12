# Speed Rivals — Neon Circuit

Speed Rivals es un juego de carreras arcade 2D hecho con HTML, CSS y JavaScript. Dos jugadores pueden conectarse desde navegadores o dispositivos distintos mediante Supabase Realtime. Los resultados de carrera se guardan en Supabase.

## Cómo probar la versión publicada

1. Abre el **dominio de producción corto** de Vercel, desde la sección **Settings → Domains** del proyecto. No compartas un enlace de Deployment Preview, porque puede estar protegido y pedir una cuenta de Vercel.
2. Abre ese mismo enlace en dos navegadores o dispositivos.
3. Cada jugador escribe su nombre y pulsa **Entrar a la pista**. Espera a que el rival se conecte y a que comience la salida compartida.
4. Mantén `↑` o `W` para acelerar y usa `←` / `→` o `A` / `D` para esquivar. En pantalla táctil usa los botones de dirección y aceleración.
5. La carrera dura 2 minutos y 30 segundos. Si chocas, tu coche vuelve al inicio, pero el reloj y la distancia acumulada de la carrera continúan.
6. Cuando el reloj llega a `0:00`, la partida debe mostrar el resultado y el botón **Jugar otra vez**. No debe iniciar automáticamente otra carrera.

## Supabase

El juego usa el proyecto Supabase `speed-rivals-lab4` y la tabla pública `public.race_results` para leer el ranking y guardar los resultados al terminar una carrera. La tabla guarda el ganador, la distancia, los nombres de los dos pilotos y la fecha.

Supabase Realtime usa el canal `speed-rivals-lobby` para compartir el estado de cada jugador y sincronizar la carrera. La versión del Laboratorio 4 no requiere inicio de sesión; las políticas de la tabla son de demostración y permiten consultar el ranking y añadir resultados de forma anónima, así que no deben tratarse como un sistema de puntuaciones seguro para producción.

La aplicación utiliza solo la **URL del proyecto** y la **publishable key** de Supabase en el navegador. Nunca poner una clave `sb_secret_` en el código ni en GitHub.

## Publicación

El código fuente está en el repositorio público `Jhonn16ax/proyecto12` en la rama `main`. Vercel publica los cambios cuando se despliega un nuevo commit. Para la entrega usa el dominio de producción corto que aparece en **Vercel → proyecto12 → Settings → Domains**.

- Aplicación: https://proyecto12-kohl.vercel.app/
- Repositorio: https://github.com/Jhonn16ax/proyecto12

## Evidencias para Laboratorio 4

Guardar cuatro capturas de la aplicación publicada:
1. Un resultado guardado antes de recargar.
2. El ranking o dato que sigue apareciendo después de recargar o abrir otro navegador.
3. El jugador A realizando una acción en su navegador.
4. El jugador B viendo la acción de A desde el segundo navegador.

Para Proyecto 2, las siguientes mejoras previstas son el inicio de sesión y asociar los resultados a cada usuario; primero se implementará la autenticación con Supabase y se verificará el manejo de identidad.
