**1. MAPA DE NAVEGACIÓN**

* Inicio → lista de películas → detalle
  
El usuario se encuentra en la pantalla de inicio al abrir la aplicación, después el usuario selecciona la opción de ver más dentro de la sección de películas, la aplicación le lleva a la página de películas donde se encuentran todas las películas disponibles ordenadas de la mas a la menos reciente. Por último, el usuario selecciona el banner de una película lo que le llevará a los detalles de la misma.

* Inicio → búsqueda → resultados → detalle
  
El usuario se encuentra en la pantalla de inicio al abrir la aplicación, después el usuario selecciona la barra de basqueda superior y busca la película que desea encontrar y presionar el botón de buscar, después la aplicación le mostrará los resultados que coinciden con su búsqueda. Por último, el usuario selecciona el banner de una película lo que le llevará a los detalles de la misma.

* Inicio → favoritos → película guardada → detall
  
El usuario se encuentra en la pantalla de inicio al abrir la aplicación, después el usuario selecciona la opción de ver más dentro de la sección de películas favoritas, la aplicación le lleva a la página de películas favoritas donde se encuentran todas las películas que el usuario ha marcado como favoritas al seleccionar el icono de corazón en el banner de cada película dentro de la aplicación. Por último, el usuario selecciona el banner de una película lo que le llevará a los detalles de la misma.

**2. INFORMACIÓN POR PANTALLA**

======================================================================

INICIO SIN PELÍCULAS FAVORITAS

======================================================================

MUESTRA:
- La barra de navegación superior, logotipo, descripción y barra de búsqueda.
- La sección "Últimas Películas" con su carrusel de tarjetas y el botón "Ver más".
- La sección "Películas Favoritas" mostrando un texto de estado vacío: "Aún no tienes películas favoritas guardadas..." en lugar de tarjetas.

RECIBE:
- Texto y comandos de búsqueda en la barra superior.
- Clics en los botones "Ver más" y clics en las películas o corazones de la sección "Últimas Películas".

MODIFICA:
- El mensaje de estado vacío desaparecerá y se modificará la interfaz para mostrar tarjetas si el usuario comienza a marcar películas como favoritas.

CONSERVA:
- La disposición general de la pantalla de inicio y la navegación.
- El historial de "Últimas Películas" disponibles en la base de datos de la app.

======================================================================

INICIO CON PELÍCULAS FAVORITAS

======================================================================

MUESTRA:
- La barra de navegación superior permanente (inicio y menú).
- El logotipo y la descripción de la aplicación.
- La barra de búsqueda principal con el texto de ayuda "Buscar una película...".
- Dos secciones categorizadas: "Últimas Películas" y "Películas Favoritas", ambas con un botón "Ver más".
- Carrusel de tarjetas de películas para ambas categorías.

RECIBE:
- Ingreso de texto en la barra de búsqueda y clics en el botón "Buscar".
- Comandos de deslizamiento (scroll horizontal) en el carrusel de películas.
- Clics en los botones "Ver más" para expandir las listas.
- Clics en los íconos de corazón para actualizar preferencias.

MODIFICA:
- El estado individual de cada película al interactuar con el ícono de corazón.
- La vista general de la aplicación si el usuario realiza una búsqueda o hace clic en "Ver más".

CONSERVA:
- Los datos de las preferencias del usuario, manteniendo visibles las películas que previamente marcó como favoritas en su respectiva sección.
- Los elementos globales de navegación.

======================================================================

ÚLTIMAS PELÍCULAS

======================================================================

MUESTRA:
- La interfaz superior estándar (menú de navegación, logotipo, descripción).
- La barra de búsqueda con el texto "Buscar una película...".
- El encabezado "Últimas Películas".
- Una cuadrícula vertical completa que despliega el catálogo de los lanzamientos más recientes, mostrando la portada, el título y el ícono de corazón para cada uno.

RECIBE:
- Texto de búsqueda y clics en el botón "Buscar".
- Clics en el ícono de corazón de cada tarjeta.
- Selección de películas para navegar a la tarjeta de detalles.

MODIFICA:
- El estado individual de cada película (favorita o no favorita) según la interacción con el ícono del corazón.
- La pantalla actual si el usuario ejecuta una nueva búsqueda, cambiando a la vista de "Coincidencias".

CONSERVA:
- El orden cronológico o de sistema del listado completo de "Últimas Películas".
- Los elementos persistentes de identidad de la marca (logotipo) y controles de navegación.

======================================================================

PELÍCULAS FAVORITAS

======================================================================

MUESTRA:
- La barra superior de navegación constante.
- El logotipo de "MovieMap" y la descripción.
- Una barra de búsqueda especializada con el texto "Buscar en Películas Favoritas...".
- El título de sección "Películas Favoritas" acompañado de un ícono de corazón oscuro.
- Una cuadrícula vertical extendida que muestra todas las películas que el usuario ha guardado.

RECIBE:
- Términos de búsqueda específicos para filtrar únicamente la lista de favoritos.
- Clics en el botón "Buscar".
- Clics en los corazones rellenos de las tarjetas (para desmarcar) o en las portadas (para ver detalles).

MODIFICA:
- La lista de resultados mostrados si el usuario realiza una búsqueda local.
- La cuadrícula de películas, eliminando tarjetas si el usuario hace clic en el corazón para quitarlas de sus favoritos.

CONSERVA:
- El estado relleno (favorito) de todos los íconos de corazón al cargar la pantalla.
- La barra de navegación y el formato estándar de las tarjetas.

======================================================================

COINCIDENCIAS DE BÚSQUEDA

======================================================================

MUESTRA:
- La barra de navegación superior con el ícono de inicio y el menú desplegable.
- El logotipo "MovieMap" y la descripción de la app.
- Una barra de búsqueda que contiene el texto ingresado por el usuario.
- Un título que indica "Coincidencias con [texto introducido]".
- Una cuadrícula vertical de tarjetas de películas, cada una mostrando una portada, un título y un ícono de corazón (algunos vacíos y otros rellenos).

RECIBE:
- Cadenas de texto que el usuario teclea en la barra de búsqueda.
- El comando de clic en el botón "Buscar".
- Selecciones táctiles o clics sobre las tarjetas de películas para ver sus detalles.
- Clics sobre los íconos de corazón para marcar o desmarcar favorito.

MODIFICA:
- El estado del ícono del corazón en cada tarjeta (de vacío a relleno o viceversa) cuando el usuario interactúa con él.
- La cuadrícula de resultados, mostrando únicamente las películas que coinciden con el término de búsqueda ingresado.

CONSERVA:
- El término de búsqueda introducido dentro de la barra de texto.
- La barra de navegación superior y el diseño estructurado de las tarjetas.

======================================================================

DETALLES DE PELÍCULA

======================================================================

MUESTRA:
- La barra de navegación superior global.
- Un ícono de corazón grande junto al "Título de la Película".
- La portada de la película en un tamaño mayor.
- Metadatos detallados: Fecha de Publicación, Clasificación, Categoría(s), Calificación (5 estrellas) y Director(es).
- Un bloque de texto con la "Sinopsis" de la película.
- Una sección de "Reparto Principal" con tarjetas horizontales que incluyen la silueta/foto del actor y su nombre.

RECIBE:
- Clics en el ícono del corazón principal situado junto al título.
- Comandos de deslizamiento horizontal en la lista del reparto principal.
- Interacciones táctiles o clics sobre los perfiles de los actores.

MODIFICA:
- El estado visual del corazón principal (se rellena o se vacía) para reflejar si la película está en favoritos.

CONSERVA:
- Toda la información descriptiva de la película (sinopsis, datos técnicos, actores), manteniéndola estática para su lectura.
- La navegación principal de la aplicación.
