**1. MAPA DE NAVEGACIÓN**

* Inicio → lista de películas → detalle
  
El usuario se encuentra en la pantalla de inicio al abrir la aplicación, después el usuario selecciona la opción de ver más dentro de la sección de películas, la aplicación le lleva a la página de películas donde se encuentran todas las películas disponibles ordenadas de la mas a la menos reciente. Por último, el usuario selecciona el banner de una película lo que le llevará a los detalles de la misma.

* Inicio → búsqueda → resultados → detalle
  
El usuario se encuentra en la pantalla de inicio al abrir la aplicación, después el usuario selecciona la barra de basqueda superior y busca la película que desea encontrar y presionar el botón de buscar, después la aplicación le mostrará los resultados que coinciden con su búsqueda. Por último, el usuario selecciona el banner de una película lo que le llevará a los detalles de la misma.

* Inicio → favoritos → película guardada → detall
  
El usuario se encuentra en la pantalla de inicio al abrir la aplicación, después el usuario selecciona la opción de ver más dentro de la sección de películas favoritas, la aplicación le lleva a la página de películas favoritas donde se encuentran todas las películas que el usuario ha marcado como favoritas al seleccionar el icono de corazón en el banner de cada película dentro de la aplicación. Por último, el usuario selecciona el banner de una película lo que le llevará a los detalles de la misma.

---
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

---
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

---
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

---
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

---
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

---
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

---
**3. ORGANIZACIÓN DEL ESTADO**

El estado de MovieMap se organizará según las pantallas que necesitan utilizar cada dato y el tiempo durante el cual debe conservarse. Se distinguirá entre estado local, propio de una pantalla, y estado compartido, utilizado por varias pantallas.

Se aplicará el principio **Single Source of Truth**, manteniendo una única fuente de verdad para cada dato compartido. Así se evitará que una película aparezca como favorita en una pantalla y como no favorita en otra.

---

**PELÍCULAS MÁS RECIENTES**

DÓNDE VIVIRÁN:

- En un modelo compartido observable (clase), utilizando `@Observable`.
- La pantalla de inicio y la pantalla de últimas películas consultarán la misma instancia del modelo.

JUSTIFICACIÓN:

- Inicio mostrará una selección de las películas más recientes y la pantalla de últimas películas utilizará el catálogo cargado.
- Compartir esta información evitará mantener colecciones independientes que puedan mostrar datos distintos.

---

**PELÍCULAS FAVORITAS**

DÓNDE VIVIRÁN:

- En el modelo compartido observable.
- La colección estará disponible para inicio, últimas películas, coincidencias de búsqueda y detalles.

JUSTIFICACIÓN:

- El usuario podrá agregar o quitar favoritos desde diferentes pantallas.
- Todas las pantallas deberán reflejar los cambios en la colección y en los íconos de corazón.
- Las vistas consultarán una misma fuente de verdad para determinar si una película está marcada como favorita.

---

**TEXTO DE BÚSQUEDA**

DÓNDE VIVIRÁ:

- En un estado local con `@State` dentro de la pantalla que contiene el buscador.
- Si el buscador es un componente separado, podrá editar ese texto mediante `@Binding`.

JUSTIFICACIÓN:

- El texto representa una entrada temporal que el usuario puede modificar antes de buscar.
- Al ejecutar la búsqueda, se enviará la consulta a la pantalla de coincidencias.

---

**CONSULTA ENVIADA Y RESULTADOS DE BÚSQUEDA**

DÓNDE VIVIRÁN:

- La consulta se recibirá como dato de entrada en la pantalla de coincidencias.
- Los resultados se mantendrán en el estado de esa pantalla.

JUSTIFICACIÓN:

- La consulta permitirá identificar qué información debe solicitarse a la API y mostrarse en el encabezado.
- La consulta y sus resultados deberán conservarse al abrir un detalle y regresar, mientras la pantalla de coincidencias permanezca en el recorrido de navegación.

---

**TEXTO PARA BUSCAR EN FAVORITOS**

DÓNDE VIVIRÁ:

- En un estado local con `@State` dentro de la pantalla de películas favoritas.

JUSTIFICACIÓN:

- La búsqueda solo modificará qué películas favoritas se muestran.
- Filtrar la lista no eliminará películas ni modificará la colección compartida de favoritos.

---

**IDENTIFICADOR DE LA PELÍCULA SELECCIONADA**

DÓNDE VIVIRÁ:

- Se pasará como dato de navegación a la pantalla de detalles.

JUSTIFICACIÓN:

- Permitirá identificar qué película debe mostrarse o consultarse en la API.
- No será necesario enviar todo el catálogo ni mantener una selección global utilizada por todas las pantallas.

---

**INFORMACIÓN ADICIONAL DEL DETALLE**

DÓNDE VIVIRÁ:

- En el estado de la pantalla de detalles de película.

JUSTIFICACIÓN:

- La sinopsis, el reparto y los demás datos consultados corresponden a la película que se está mostrando.
- El estado de favorito se consultará en el modelo compartido para mantenerlo coordinado con las otras pantallas.

---

**ESTADO DE CARGA Y ERROR**

DÓNDE VIVIRÁ:

- Junto a los datos de cada consulta.
- El catálogo mantendrá su estado de carga en el modelo compartido; las búsquedas y los detalles lo mantendrán en sus respectivas pantallas.

JUSTIFICACIÓN:

- Cada consulta puede encontrarse en una situación diferente.
- La aplicación deberá distinguir entre una operación en curso, una respuesta exitosa y un error.
- Una búsqueda sin coincidencias se mostrará como un resultado vacío, no como un error de conexión.

---

**ESTADO DEL MENÚ DE NAVEGACIÓN**

DÓNDE VIVIRÁ:

- En un estado local con `@State` en la vista que administra el menú.

JUSTIFICACIÓN:

- Indicar si el menú está abierto o cerrado es un cambio temporal de presentación.
- Este estado no necesita formar parte del modelo que contiene las películas y los favoritos.

---

**4. ESTRATEGIA DE NAVEGACIÓN**

La aplicación utilizará `NavigationStack` para organizar el recorrido entre inicio, listas, coincidencias y detalles. Este mecanismo permitirá avanzar hacia una pantalla y regresar a la anterior mediante los controles de navegación del sistema.

Se utilizarán `NavigationLink` para iniciar la navegación desde elementos seleccionables, como los botones “Ver más” y las portadas de las películas. Además, `navigationDestination` relacionará los datos de navegación con sus pantallas de destino.

Los destinos podrán representarse mediante un `enum` con casos para últimas películas, películas favoritas, resultados de búsqueda y detalles de una película. Los casos de búsqueda y detalles incluirán, respectivamente, el texto consultado y el identificador de la película seleccionada. 

---

**FLUJO INICIO → LISTA DE PELÍCULAS → DETALLE**

RECORRIDO:

- Al abrir la aplicación, el usuario encontrará la pantalla de inicio con una selección de películas recientes.
- Al seleccionar “Ver más” en la sección “Últimas Películas”, accederá a la pantalla del catálogo cargado.
- Las películas se mostrarán ordenadas de la más reciente a la menos reciente según su fecha de estreno.
- Al seleccionar la portada o el título de una película, se abrirá su pantalla de detalles.

MECANISMOS:

- `NavigationStack` administrará el recorrido y permitirá regresar.
- Un `NavigationLink` abrirá la pantalla de últimas películas.
- Otro `NavigationLink` permitirá seleccionar una película.
- `navigationDestination` determinará la pantalla correspondiente al destino seleccionado.

INFORMACIÓN QUE SE ENVÍA:

- El identificador de la película seleccionada.
- La pantalla de detalles utilizará ese ID para mostrar o solicitar la información correspondiente.

AL REGRESAR:

- El usuario volverá a la lista desde la que seleccionó la película.
- El catálogo cargado seguirá disponible en el modelo compartido.
- Los cambios realizados en favoritos se reflejarán en los corazones de las tarjetas.

---

**FLUJO INICIO → BÚSQUEDA → RESULTADOS → DETALLE**

RECORRIDO:

- El usuario escribirá el nombre de una película en el buscador.
- Al pulsar “Buscar”, se comprobará que la consulta no esté vacía ni contenga únicamente espacios.
- Si la consulta es válida, se abrirá la pantalla de coincidencias y se solicitarán los resultados a la API.
- La pantalla mostrará el estado de carga, las películas encontradas, un mensaje sin resultados o un error, según corresponda.
- Al seleccionar una película, se abrirá su pantalla de detalles.

MECANISMOS:

- `@State` mantendrá el texto escrito en el buscador.
- Si el buscador es un componente separado, `@Binding` permitirá modificar el texto de la vista que lo contiene.
- El botón “Buscar” iniciará la navegación hacia coincidencias después de validar la consulta.
- `NavigationStack` y `navigationDestination` organizarán los destinos.
- Un `NavigationLink` permitirá abrir el detalle desde cada resultado.

INFORMACIÓN QUE SE ENVÍA:

- El texto consultado se enviará a la pantalla de coincidencias.
- El identificador de la película seleccionada se enviará a la pantalla de detalles.

AL REGRESAR:

- Se conservarán la consulta y los resultados mientras la pantalla de coincidencias permanezca en la pila de navegación.
- Los cambios en favoritos se mostrarán en las tarjetas correspondientes.

---

**FLUJO INICIO → FAVORITOS → PELÍCULA GUARDADA → DETALLE**

RECORRIDO:

- El usuario seleccionará “Ver más” en la sección “Películas Favoritas”.
- La aplicación abrirá la pantalla que muestra la colección compartida de favoritos.
- El usuario podrá buscar dentro de esa colección sin modificar los favoritos originales.
- Al seleccionar una película guardada, se abrirá su pantalla de detalles.
- Seleccionar una película guardada será una acción dentro de la lista; no requerirá una pantalla intermedia adicional.

MECANISMOS:

- Un `NavigationLink` abrirá la pantalla de películas favoritas.
- La pantalla consultará el modelo compartido observable.
- `@State` mantendrá el texto utilizado para filtrar los favoritos.
- Un `NavigationLink` permitirá abrir el detalle de la película seleccionada.
- `navigationDestination` utilizará el mismo destino de detalle disponible desde el catálogo y las coincidencias.

INFORMACIÓN QUE SE ENVÍA:

- El identificador de la película seleccionada.
- No será necesario enviar una copia de la colección de favoritos, porque las pantallas consultarán el mismo modelo compartido.

AL REGRESAR:

- La lista reflejará cualquier cambio realizado en los favoritos desde el detalle.
- Si una película fue desmarcada, dejará de aparecer en la colección.
- Si la colección queda vacía, la interfaz mostrará el mensaje correspondiente.
- Los favoritos se conservarán en memoria durante el uso de la aplicación; su conservación después de cerrarla requerirá un mecanismo de persistencia.
