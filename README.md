# MovieMap
Proyecto para la materia: DESARROLLO DE APLICACIONES PARA DISPOSITIVOS IOS - Grupo: 1796 - Sem 27-1

**Integrantes**

Equipo 6
* Balseira Vázquez Aurora (1)
* Mercado Chanes Gael Emilio (2)

**Opción del proyecto**

* Opción A - Aplicación de películas con TMDB

## Descripción

MovieMap busca facilitar la consulta de información de películas y la organización de los títulos que el usuario desea conservar. Su propósito es reunir en una misma aplicación la exploración de estrenos recientes, la búsqueda de películas y el acceso a sus detalles, junto con una colección de favoritos que permanezca disponible después de cerrar la app.

## Funcionalidades implementadas

- Consulta de películas recientes de TMDB, con hasta 20 tarjetas en el carrusel de inicio.
- Búsqueda de títulos en el catálogo remoto, con la primera página de coincidencias.
- Consulta del detalle por ID: portada, año de estreno, clasificación disponible para México, categorías, dirección, calificación, sinopsis y reparto.
- Agregado y eliminación de favoritos desde las tarjetas y el detalle, con guardado local entre ejecuciones y comprobación de duplicados por ID.
- Carrusel de hasta 20 favoritos en inicio y pantalla completa de favoritos en dos columnas, con desplazamiento vertical continuo y filtro local por título.
- Pantalla completa de recientes en dos columnas, con controles para consultar las páginas de TMDB dentro del máximo accesible.
- Tarjetas con diseño compartido, portada en proporción 2:3 y espacio reservado para título, año y corazón.
- Búsqueda de una imagen alternativa cuando la portada principal falta o falla, y mensajes de información no disponible en los campos correspondientes.
- Indicadores de carga, mensajes de error y navegación entre inicio, listados, resultados y detalle.

## Tecnologías utilizadas

- **Swift:** lenguaje de programación.
- **SwiftUI:** construcción de pantallas, componentes y navegación.
- **Observation:** seguimiento del estado observable de los ViewModels.
- **SwiftData:** persistencia local de favoritos.
- **Foundation:** solicitudes HTTP con `URLSession`, construcción de URLs y decodificación JSON.
- **Swift Concurrency:** operaciones asíncronas con `async/await` y `Task`.
- **TMDB API v3:** fuente externa de información e imágenes de películas.
- **Swift Testing:** pruebas de lógica; el proyecto también incluye un target de pruebas de interfaz con XCTest.
- **Xcode y Simulator:** edición, compilación, depuración y ejecución de la app.
- **Git y GitHub:** control de versiones y colaboración.

## Explicación de los flujos

* Inicio → lista de películas → detalle

El usuario se encuentra en la pantalla de inicio al abrir la aplicación, después el usuario selecciona la opción de ver más dentro de la sección de películas, la aplicación le lleva a la página de películas donde se encuentran todas las películas disponibles ordenadas de la mas a la menos reciente. Por último, el usuario selecciona el banner de una película lo que le llevará a los detalles de la misma 

* Inicio → búsqueda → resultados → detalle

El usuario se encuentra en la pantalla de inicio al abrir la aplicación, después el usuario selecciona la barra de basqueda superior y busca la película que desea encontrar y presionar el botón de buscar, después la aplicación le mostrará los resultados que coinciden con su búsqueda. Por último, el usuario selecciona el banner de una película lo que le llevará a los detalles de la misma 

* Inicio → favoritos → película guardada → detalle

El usuario se encuentra en la pantalla de inicio al abrir la aplicación, después el usuario selecciona la opción de ver más dentro de la sección de películas favoritas, la aplicación le lleva a la página de películas favoritas donde se encuentran todas las películas que el usuario ha marcado como favoritas al seleccionar el icono de corazón en el banner de cada película dentro de la aplicación. Por último, el usuario selecciona el banner de una película lo que le llevará a los detalles de la misma


## Wireframes y Componentes en las pantallas

### Inicio sin películas favoritas

<img width="30%%" height="30%" alt="01_Inicio_Sin_Favoritas" src="https://github.com/user-attachments/assets/1dfe48cb-b125-4f7c-95fa-74a0350683d0" />

* Texto de título de la aplicación (Text to speech)
* Texto de descripción de la aplicación (Text to speech) 
* Barra de búsqueda
* Texto: Buscar una película... (Text to speech)
* Botón de búsqueda (Text to speech)
* Texto: Últimas películas (Text to speech)
* Botón de ver más películas (Text to speech)
* Carrusel de portadas de películas y su título con su botón para añadir/quitar de favoritos (Text to speech)
* Texto: Películas favoritas (Text to speech)
* Botón de ver más películas favoritas (Text to speech)
* Texto: Aún no tienes películas favoritas guardadas... (Text to speech)

### Inicio con películas favoritas

<img width="30%" height="30%" alt="02_Inicio_Con_Favoritas" src="https://github.com/user-attachments/assets/91ea58e6-1070-441a-8de1-7f8e0b9ae366" />

* Texto de título de la aplicación (Text to speech)
* Texto de descripción de la aplicación (Text to speech)
* Barra de búsqueda
* Texto: Buscar una película... (Text to speech)
* Botón de búsqueda (Text to speech)
* Texto: Últimas películas (Text to speech)
* Botón de ver más películas (Text to speech)
* Carrusel de portadas de películas recientes y su título con su botón para añadir/quitar de favoritos (Text to speech)
* Texto: Películas favoritas (Text to speech)
* Botón de ver más películas favoritas (Text to speech)
* Carrusel de portadas de películas favoritas y su título con su botón para añadir/quitar de favoritos (Text to speech)

### Últimas películas

<img width="30%" height="30%" alt="03_Ultimas_Peliculas" src="https://github.com/user-attachments/assets/274d3d12-e079-49c6-9120-11da44e08fb0" />

* Botón de inicio (Text to speech)
* Texto de título de la aplicación (Text to speech)
* Texto de descripción de la aplicación (Text to speech)
* Barra de búsqueda
* Texto: Buscar una película... (Text to speech)
* Botón de búsqueda (Text to speech)
* Texto: Últimas películas (Text to speech)
* Lista de películas coincidentes con el texto de búsqueda y su título con su botón para añadir/quitar de favoritos (Text to speech)

### Películas favoritas

<img width="30%" height="30%" alt="04_Mis_Favoritas" src="https://github.com/user-attachments/assets/865f6ec0-89f7-46e2-b2b3-8857c1c9a561" />

* Botón de inicio (Text to speech)
* Texto de título de la aplicación (Text to speech)
* Texto de descripción de la aplicación (Text to speech)
* Barra de búsqueda
* Texto: Buscar en películas favoritas...  (Text to speech)
* Botón de búsqueda (Text to speech)
* Texto: Películas favoritas (Text to speech)
* Lista de películas favoritas y su título con su botón para quitar de favoritos (Text to speech)

### Coincidencias de búsqueda

<img width="30%" height="30%" alt="05_Coincidencias_De_Busqueda" src="https://github.com/user-attachments/assets/0fde873d-a12a-4aef-ac74-a25f8cf358b8" />

* Botón de inicio (Text to speech)
* Texto de título de la aplicación (Text to speech)
* Texto de descripción de la aplicación (Text to speech)
* Barra de búsqueda 
* Texto introducido para generar una búsqueda (Text to speech)  
* Botón de búsqueda (Text to speech)
* Texto: Coincidencias con [texto de búsqueda] (Text to speech)
* Lista de películas coincidentes con el texto de búsqueda y su título con su botón para añadir/quitar de favoritos (Text to speech)

### Detalles de película

<img width="30%" height="30%" alt="06_Detalles_De_Pelicula" src="https://github.com/user-attachments/assets/30964b97-e38d-4040-b4a1-ad4847a5514b" />

* Botón de inicio (Text to speech)
* Botón para añadir/quitar de favoritos (Text to speech)
* Título de la película (Text to speech)
* Portada de la película 
* Texto de fecha de publicación de la película (Text to speech)
* Texto de clasificación de la película (Text to speech)
* Texto de categoría(s) de la película (Text to speech)
* Texto de duración de la película
* Botones de calificación
* Texto de director(es) de la película (Text to speech)
* Texto: Sinopsis (Text to speech)
* Texto de sinopsis de la película (Text to speech)
* Texto: Reparto principal (Text to speech)
* Carrusel de imágenes de miembros del reparto principal junto con su nombre y rol dentro de la película (Text to speech)

## Instalación y configuración desde cero

### 1. Preparar el equipo

* Utilizar una Mac con una versión de macOS compatible con Xcode.
* Instalar Xcode con un SDK que permita compilar para iOS 26.4 y un runtime (sistema iOS del simulador) de iOS 26.4 o posterior. El proyecto tiene `IPHONEOS_DEPLOYMENT_TARGET = 26.4`; este es el requisito actual del repositorio.
* Abrir Xcode por primera vez, aceptar sus condiciones y completar la instalación de componentes que solicite.
* En `Xcode > Settings > Components`, instalar el runtime de iOS si todavía no está disponible.
* Contar con Git, conexión a internet y una cuenta de TMDB para obtener un token de lectura de su API.

La aplicación usa SwiftUI, Observation y SwiftData. No requiere instalar CocoaPods ni otras bibliotecas de terceros. Tener Swift instalado en Windows o una extensión de VS Code no permite compilar ni ejecutar esta aplicación iOS; para ello se utiliza Xcode en macOS.

### 2. Clonar la versión documentada

Abrir Terminal y ubicarse en la carpeta donde se desea guardar el proyecto. Ejecutar:

```bash
git clone --branch main --single-branch https://github.com/EmilioChanes/ProyectoIOS_ABV-GEMCH.git
cd ProyectoIOS_ABV-GEMCH
git branch --show-current
```
### 3. Obtener el token de lectura de TMDB

1. Crear una cuenta o iniciar sesión en [TMDB](https://www.themoviedb.org/).
2. Entrar a la [configuración de API de la cuenta](https://www.themoviedb.org/settings/api) y completar el registro de acceso si es necesario.
3. Copiar el valor llamado **API Read Access Token**. Se utiliza el token de lectura completo, no la clave corta de API.

La app consulta TMDB con credenciales de la aplicación. El usuario de MovieMap no tiene que iniciar sesión en TMDB dentro de la app, y los favoritos no se guardan en una cuenta de TMDB.

### 4. Abrir el proyecto en Xcode

Desde la raíz del repositorio, ejecutar:

```bash
open ProyectoiOS-ABV-GEMCH/ProyectoiOS-ABV-GEMCH.xcodeproj
```

También se puede abrir ese archivo `.xcodeproj` desde Finder. Debe abrirse el proyecto completo para que Xcode reconozca el target de la aplicación y sus pruebas.

### 5. Crear el archivo local `Secrets.swift`

El repositorio no incluye `Secrets.swift`: está excluido mediante `.gitignore`, pero el código lo necesita para compilar.

1. En el navegador de Xcode, localizar la carpeta `Services` de la aplicación.
2. Crear allí un archivo Swift llamado `Secrets.swift` y comprobar que pertenece al target de la app.
3. Pegar el siguiente contenido y reemplazar el texto de ejemplo por el token obtenido:

```swift
enum Secrets: String {
    case token = "REEMPLAZA_ESTO_CON_TU_API_READ_ACCESS_TOKEN"
}
```

La ubicación del archivo desde la raíz del repositorio debe ser:

```text
ProyectoiOS-ABV-GEMCH/ProyectoiOS-ABV-GEMCH/Services/Secrets.swift
```

No agregar `Bearer` dentro de las comillas: `TMDBService` lo añade al encabezado `Authorization`. No dejar espacios o saltos de línea dentro del token ni conservar el texto de ejemplo.

Comprobar que Git ignora el archivo:

```bash
git check-ignore -v "ProyectoiOS-ABV-GEMCH/ProyectoiOS-ABV-GEMCH/Services/Secrets.swift"
```

Debe aparecer la regla `Secrets.swift` de `.gitignore`. Cada integrante debe configurar su propia copia local y evitar publicar el token en commits, capturas o mensajes. `.gitignore` evita agregar este archivo por las operaciones habituales de Git; no elimina credenciales que ya estén en el historial ni hace que un token incluido en una app compilada sea inaccesible.

### 6. Compilar y ejecutar

1. Seleccionar el esquema de la aplicación `ProyectoiOS-ABV-GEMCH` en la barra superior de Xcode.
2. Elegir un iPhone Simulator con iOS 26.4 o posterior como destino. No seleccionar únicamente un dispositivo genérico si se quiere abrir la app.
3. Compilar con `Product > Build` o **⌘B**.
4. Ejecutar con `Product > Run` o **⌘R**.
5. Esperar a que se abra el simulador y termine la primera consulta a TMDB.

El inicio debe mostrar las películas recientes o el mensaje de carga/error correspondiente. En una instalación nueva, la sección de favoritos estará vacía. No es necesario crear manualmente la base de datos: la app configura el contenedor de SwiftData al arrancar.

Para ejecutar en un iPhone físico, además se necesita configurar la firma en `Signing & Capabilities`, seleccionar el equipo de desarrollo y usar un dispositivo compatible con el deployment target. 

La ruta principal de prueba de esta entrega es el Simulator.

### 7. Ejecutar las pruebas y comprobar la persistencia

Ejecutar `Product > Test` o **⌘U** en Xcode. Las pruebas de lógica usan Swift Testing y un almacenamiento de SwiftData en memoria, independiente de los favoritos reales de la aplicación. Cubren alternar favoritos, filtrado local de películas, títulos por destino, identificación de favoritos, filtrado de favoritos y mensajes de listas vacías. No verifican automáticamente todas las solicitudes HTTP, las portadas ni la paginación contra el servicio real.

Para comprobar el guardado entre ejecuciones:

1. Agregar una película a favoritos con su corazón.
2. Confirmar que aparece tanto en inicio como en `Películas favoritas`.
3. Cerrar la app y volver a abrirla en el mismo simulador.
4. Confirmar que la película sigue guardada.
5. Quitarla de favoritos, cerrar y abrir de nuevo, y confirmar que ya no aparece.

No desinstalar la app ni borrar el contenido del simulador durante esta comprobación, porque eso puede eliminar el almacenamiento local. 

### Problemas frecuentes de instalación

- **`Cannot find Secrets in scope`:** falta crear el archivo local, su nombre no coincide o no forma parte del target de la app.
- **`missingToken`:** el token está vacío. Un token de ejemplo o inválido puede producir un error HTTP, como `httpError(401)`.
- **No aparece un simulador compatible:** instalar un runtime adecuado en los componentes de Xcode y seleccionarlo como destino.
- **La app abre, pero no obtiene películas:** revisar el token, la conexión y el error impreso en la consola de Xcode.
- **Una película no tiene portada:** no necesariamente es un error de instalación; TMDB puede no tener ninguna imagen disponible para ese ID.

## Paso a paso para usar la app

### Inicio

1. Abrir MovieMap y esperar la carga de películas recientes.
2. Deslizar horizontalmente el carrusel de `Últimas películas` para explorar hasta 20 tarjetas.
3. Tocar la portada o el título de una tarjeta para abrir su detalle.
4. Tocar el corazón para agregar o quitar una película de favoritos.

La sección de favoritos muestra hasta 20 elementos en inicio. Este límite corresponde al carrusel, no a la cantidad de películas que se pueden guardar. Si no hay favoritos, se muestra el mensaje de colección vacía. El botón de inicio se oculta en esta pantalla.

### Ver más películas recientes

1. En `Últimas películas`, tocar `Ver más`.
2. Explorar las tarjetas organizadas en una cuadrícula de dos columnas.
3. Desplazarse al final para ver el número de página y los botones `Anterior` y `Siguiente`.
4. Tocar `Siguiente` para consultar la siguiente página de TMDB, o `Anterior` para volver a la previa.
5. Al cargar correctamente, las nuevas tarjetas reemplazan las de la página anterior y el desplazamiento vuelve al inicio de la pantalla.
6. Seleccionar una película para abrir su detalle. Al regresar a la lista, se mantiene la página cargada mientras esa pantalla siga en la navegación.

La paginación usa las páginas que devuelve TMDB con los filtros del proyecto. No divide únicamente las primeras 20 películas en páginas locales. Si una solicitud falla, se conserva la página que ya estaba visible; al fallar la carga inicial aparece `Reintentar`. No se descargan todas las páginas por adelantado.

### Buscar películas en TMDB

1. Escribir el título en la barra `Buscar una película...`.
2. Pulsar `Buscar`. El botón no permite ejecutar una consulta vacía o compuesta solo por espacios.
3. Esperar la consulta y revisar las coincidencias o el mensaje correspondiente.
4. Abrir una tarjeta para consultar su detalle o usar su corazón para guardarla.

La búsqueda general consulta `/search/movie`, por lo que no está limitada a las películas recientes. Por ahora muestra solo la primera página de coincidencias y no tiene los controles de paginación de recientes. El encabezado de resultados permite escribir otra consulta; no conserva automáticamente en su campo editable el texto del buscador anterior.

### Consultar y filtrar favoritos

1. Tocar `Ver más` en `Películas favoritas`.
2. Explorar toda la colección en una cuadrícula de dos columnas con desplazamiento vertical continuo.
3. Para filtrar, escribir en `Buscar en películas favoritas...` y pulsar `Buscar`.
4. Para volver a mostrar toda la colección, borrar el texto y pulsar `Buscar`.
5. Tocar una tarjeta para abrir el detalle o su corazón relleno para quitarla de favoritos.

Esta pantalla no tiene un límite de 20 ni paginación remota. Su búsqueda se realiza sobre los favoritos locales y no modifica la colección original. El código no impone una cantidad máxima de favoritos; la capacidad real depende del almacenamiento y los recursos del dispositivo.

### Consultar el detalle de una película

La ficha muestra el título, la portada, el año de estreno, la clasificación disponible para México, categorías, dirección, calificación sobre 10, sinopsis y nombres del reparto según los datos obtenidos de TMDB.

- La calificación es de consulta; no hay un control para asignar una calificación personal.
- Si la calificación es `0` o no llega, su propia fila muestra `Calificación: Sin calificación disponible`.
- Otros campos ausentes muestran mensajes como `Sin categoría disponible`, `Sin sinopsis disponible` o `Sin reparto disponible` en el lugar correspondiente.
- Si la portada falta o falla, se intenta obtener otra imagen del mismo ID. Si no se consigue mostrar ninguna, aparece `Sin portada disponible`.
- El reparto muestra nombres con íconos de persona, no fotografías ni fichas navegables de actores.

El detalle se consulta por ID, incluso cuando la película se abre desde favoritos y no aparece en la página actual de recientes. Los favoritos solo conservan información básica; para recuperar la ficha completa se necesita conexión.

### Regresar o volver a inicio

Usar el control de regreso de `NavigationStack` para volver a la pantalla anterior. En las pantallas secundarias, el botón con la casa permite volver directamente al inicio y vacía el recorrido de navegación. El detalle no muestra el hero ni el buscador.

## Documentación técnica

### Arquitectura

El proyecto sigue una organización MVVM, con responsabilidades repartidas en las carpetas `Models`, `Views`, `ViewModels` y `Services`.

**Models**

- `Movie.swift`: representa la película usada por la interfaz: ID, título, año, clasificación, categoría, dirección, sinopsis, reparto, calificación y ruta opcional de portada. También contiene películas de prueba y el `enum Destination`, que es `Hashable` y representa los destinos de navegación.
- `MovieFavorite.swift`: representa la información básica de un favorito: `id`, `title`, `year` y `posterPath`.
- `SavedMovie.swift`: clase marcada con `@Model` que SwiftData almacena de forma persistente.
- `TMDBMovie.swift`: contiene los tipos `Decodable` para leer las respuestas remotas y la conversión `toMovie()` al modelo de la app. No sustituye a `Movie`.

**Views**

- `ContentView`: crea el ViewModel compartido, presenta inicio, administra `NavigationStack` y conecta los destinos. Conserva el límite de 20 para cada carrusel.
- `MovieListView`: muestra recientes y favoritos en cuadrículas de dos columnas. Incluye los controles de paginación para recientes y el filtro local de favoritos; los resultados de búsqueda se muestran como lista vertical.
- `MovieDetailView`: solicita el detalle a través de su ViewModel y presenta los campos y mensajes de información ausente.
- `HeaderView`: contiene hero, buscador y botón de inicio según la pantalla.
- `MovieCardLayout` y `MovieCardMetrics`: comparten la distribución y medidas de las tarjetas; reservan dos líneas para el título y un espacio para el corazón. Los títulos largos se recortan visualmente, pero el detalle muestra el título completo.
- `MovieCardView`, `MovieFavoriteCardView` y `FavoriteButtonView`: conectan tarjetas, navegación y acciones de favoritos con el ViewModel.
- `MoviePosterView`: presenta el estado de carga, la imagen o el aviso de portada ausente. Usa `AsyncImage`; cuando necesita una alternativa, la solicita mediante el ViewModel compartido.

**ViewModels**

- `MovieViewModel`: es `@Observable`, conserva las películas del carrusel de inicio, la colección de favoritos y los estados de carga y error. Coordina las operaciones remotas y locales, y se comparte con `.environment(movieViewModel)`.
- `MovieListViewModel`: es `@Observable`, administra el destino de la lista, la página visible de recientes, el total de páginas, resultados de búsqueda, filtrado de favoritos y estados de carga/error de esa pantalla.
- `MovieDetailViewModel`: es `@Observable`, consulta la ficha por ID y mantiene su resultado, carga y error. Los IDs negativos de las películas de prueba usan sus datos locales.

**Services y punto de entrada**

- `TMDBService`: construye y ejecuta las consultas HTTP y convierte respuestas. Devuelve la información o lanza el error; no es observable ni conserva las listas de las pantallas.
- `MovieService`: recibe un `ModelContext` y realiza consultas, altas, bajas y actualizaciones de favoritos con SwiftData. Tampoco es observable.
- `Secrets.swift`: configuración local del token; no forma parte del repositorio.
- `ProyectoiOS_ABV_GEMCHApp`: crea `Schema`, `ModelConfiguration`, `ModelContainer` y `ModelContext`, y abre `ContentView`.

Una interacción sigue este recorrido: la View solicita una acción al ViewModel; el ViewModel llama al servicio correspondiente y actualiza su estado; SwiftUI refleja el cambio en la interfaz.

La colección de favoritos tiene una sola fuente de verdad compartida en `MovieViewModel`, que se vuelve a cargar desde SwiftData después de modificarla. El texto del buscador y la presentación de una pantalla son estados locales. La lista paginada tiene su propio estado para evitar que avanzar a otra página cambie el carrusel de inicio.

### Networking

Se utiliza la API v3 de **The Movie Database (TMDB)**.

Base URL:

```text
https://api.themoviedb.org/3
```

`TMDBService` usa `URLComponents` y `URLQueryItem` para formar las URLs, `URLRequest` para definir solicitudes `GET`, `URLSession.shared.data(for:)` con `async/await` para obtener datos y `JSONDecoder` para leer el JSON. La autenticación se envía en `Authorization: Bearer <token>`.

**Endpoints implementados**

- `GET /discover/movie`: obtiene recientes. Envía `language=es-MX`, `include_adult=false`, `sort_by=primary_release_date.desc`, el número de `page` y `primary_release_date.lte` con la fecha actual. `fetchLatestMovies()` pide la primera página para inicio; `fetchLatestMoviesPage(_:)` devuelve número de página, total accesible y películas para la lista completa.
- `GET /search/movie`: busca títulos con `query`, `language=es-MX`, `include_adult=false` y `page=1`.
- `GET /movie/{id}`: obtiene título, año, sinopsis, géneros, calificación y ruta de portada del detalle.
- `GET /movie/{id}/credits`: obtiene `cast` y `crew`. Se usan los nombres del reparto y los miembros cuyo `job` es `Director`.
- `GET /movie/{id}/release_dates`: obtiene las clasificaciones por país. Se busca `MX`, se descartan clasificaciones vacías y se prefiere el estreno en cines de tipo `3`; si no hay uno, se toma la primera clasificación mexicana no vacía.
- `GET /movie/{id}/images`: se consulta cuando la portada principal falta o falla. Busca primero otra ruta en `posters` y después en `backdrops`, excluyendo la ruta que ya falló. No aplica filtro de idioma en esta petición.

La imagen se descarga desde `https://image.tmdb.org/t/p/w500` seguido de la ruta recibida. Guardar `posterPath` no equivale a guardar los bytes de la imagen.

**Modelos de respuesta**

- `TMDBMovie`: decodifica `id`, `title`, `overview`, `release_date`, `poster_path`, `vote_average` y, cuando llegan, `genres`.
- `TMDBMovieResponse`: contiene `page`, `results` y `total_pages` para listados y búsqueda.
- `TMDBGenre`: representa el nombre de un género.
- `TMDBCreditsResponse`, `TMDBCastMember` y `TMDBCrewMember`: leen nombres de reparto y trabajos del equipo.
- `TMDBReleaseDatesResponse`, `TMDBCountryRelease` y `TMDBReleaseEntry`: leen país, tipo de estreno y clasificación.
- `TMDBMovieImages` y `TMDBImagePath`: tipos privados dentro de `TMDBService.swift` que leen las rutas de las imágenes alternativas.

`CodingKeys` relaciona las claves del JSON, como `poster_path`, con nombres Swift como `posterPath`. `toMovie()` convierte los datos remotos al modelo utilizado por las vistas.

**Carga y errores**

Las consultas son `async throws`. El servicio comprueba token vacío, URL, tipo de respuesta y códigos HTTP entre `200` y `299`; los errores de conexión y decodificación también se propagan al ViewModel. `TMDBError` incluye `missingToken`, `invalidURL`, `invalidResponse`, `invalidMovieID` y `httpError(Int)`.

Los ViewModels muestran mensajes de carga/error y registran detalles en consola. Las operaciones comprueban cancelación antes de aplicar resultados. El cambio de página reemplaza su colección únicamente después de una respuesta exitosa. La interfaz de listas permite reintentar la carga inicial; no existe una política general de reintentos automáticos.

### Persistencia

Se usa **SwiftData** para conservar la colección personal en el almacenamiento local de la aplicación. El modelo persistente es `SavedMovie` y almacena únicamente:

- `id`: identificador estable de TMDB.
- `title`: título de la película.
- `year`: año de estreno.
- `posterPath`: ruta opcional de la imagen que se utiliza en la tarjeta.

La configuración de la app usa `isStoredInMemoryOnly: false`. En las pruebas y la Preview se utiliza `true` para no modificar la colección real.

Al agregar un favorito, `MovieService` consulta los registros existentes y compara sus IDs para evitar duplicados. Después inserta `SavedMovie` y ejecuta `context.save()`. Para eliminarlo, localiza los registros por ID, los borra y guarda. Si el guardado falla, ejecuta `rollback()` y propaga el error.

Después de agregar o quitar una película, `MovieViewModel` vuelve a consultar los favoritos y actualiza la colección compartida. Una imagen alternativa que carga correctamente puede actualizar la ruta del favorito ya guardado.

No se persisten el catálogo completo, los resultados de búsqueda, las páginas consultadas, la sinopsis, el reparto ni la calificación. La persistencia complementa los datos remotos: permite identificar y mostrar el favorito básico, mientras el detalle completo se vuelve a solicitar por ID. No hay sincronización de favoritos con TMDB ni con otros dispositivos.

### Decisiones técnicas

- **MVVM y servicios separados:** la presentación, el estado de pantalla, las peticiones HTTP y el acceso a SwiftData tienen responsabilidades distintas. Los servicios devuelven datos o errores y no administran el estado observable de las vistas.
- **Estado compartido con Observation:** `@Observable` y `@Environment` permiten que los cambios de favoritos se reflejen en las pantallas que utilizan la misma colección.
- **Navegación por datos:** `NavigationStack`, `NavigationLink`, `navigationDestination` y `Destination: Hashable` relacionan cada selección con una pantalla. El detalle recibe un ID y datos básicos, en lugar de depender de encontrar la película en el catálogo cargado.
- **Persistencia mínima:** guardar ID, título, año y ruta de portada evita tratar los favoritos como una copia completa y permanente de la API.
- **Paginación remota:** cada página de recientes corresponde a una respuesta de TMDB con los filtros del proyecto. El total navegable se limita a `min(total_pages, 500)` por la restricción del servicio.
- **Favoritos sin límite de interfaz:** la pantalla completa usa `LazyVGrid` dentro de `ScrollView`; no aplica `.prefix(20)`. Las filas se crean conforme se necesitan, aunque la consulta actual de SwiftData sí recupera todos los favoritos en memoria.
- **Tarjetas compartidas:** una portada 2:3, dos líneas reservadas para títulos y un espacio común para corazones reducen diferencias de tamaño sin deformar las imágenes.
- **Información ausente visible:** se conserva la película aunque no tenga imagen o un campo esté vacío. La interfaz coloca un mensaje `Sin ... disponible` en ese campo. Una calificación `0` se trata como no disponible por decisión del proyecto.
- **Código y textos:** los identificadores se mantienen en inglés y la interfaz en español. La petición `es-MX` no garantiza que todos los títulos o sinopsis existan traducidos.
- **Token local ignorado por Git:** cada desarrollador configura `Secrets.swift`. Es una solución de configuración para el proyecto académico; no es un servidor intermediario ni un almacén cifrado de credenciales.

### Limitaciones conocidas

- Se requiere conexión y un token válido para cargar recientes, búsquedas, detalles e imágenes. No hay un modo offline completo; los favoritos básicos sí se conservan localmente.
- La búsqueda general solo presenta la primera página de coincidencias. La paginación está implementada únicamente para recientes.
- No se puede recorrer todo el catálogo en una sola consulta de recientes si excede el máximo de 500 páginas permitido por TMDB. El número y orden de resultados pueden cambiar cuando la base remota se actualiza.
- La app usa las fechas de estreno registradas en TMDB a nivel global; no presenta exclusivamente los estrenos en salas de México. La consulta tampoco filtra películas por popularidad ni por existencia de portada.
- Una película puede no tener imágenes, traducción, clasificación mexicana, sinopsis o reparto. La recuperación intenta una alternativa, pero no garantiza que exista o se descargue. Si se usa un fondo horizontal, puede quedar espacio libre dentro del marco vertical.
- No se muestra la duración ni la fecha completa de estreno; el modelo actual conserva el año. El reparto muestra nombres e íconos, sin fotografías, personajes ni navegación a actores.
- La calificación procede de TMDB. No hay cuentas de usuario dentro de la app, calificaciones personales ni favoritos remotos.
- `MovieService` recupera todos los favoritos para sus operaciones y no define un orden de guardado. El desplazamiento continuo no significa almacenamiento o memoria ilimitados.
- El detalle realiza varias peticiones consecutivas; un fallo de créditos o clasificaciones puede impedir mostrar la ficha completa aunque la petición básica haya respondido.
- La primera carga exitosa del inicio se conserva durante esa instancia del ViewModel. No hay un control de actualización manual del catálogo en inicio.
- Hay etiquetas de accesibilidad y controles estándar de SwiftUI, pero no se implementó un lector de texto a voz propio ni se documenta una validación completa de accesibilidad.
- Las pruebas existentes cubren lógica local, pero no garantizan el funcionamiento en vivo de TMDB, de las descargas de imágenes ni de todos los escenarios de paginación. La comprobación de cierre y reapertura se realiza manualmente.
- Los enlaces de wireframes incluidos en este README usan URLs temporales de GitHub (`private-user-images`). Pueden expirar. Para una entrega duradera, falta sustituirlos por imágenes dentro del repositorio o enlaces públicos estables.

### Documentación de consulta

- [Código de MovieMap en la rama test](https://github.com/EmilioChanes/ProyectoIOS_ABV-GEMCH/tree/test).
- [TMDB: introducción a la API](https://developer.themoviedb.org/docs/getting-started).
- [TMDB: autenticación de aplicación](https://developer.themoviedb.org/docs/authentication-application).
- [TMDB: descubrir películas](https://developer.themoviedb.org/reference/discover-movie).
- [TMDB: búsqueda de películas](https://developer.themoviedb.org/reference/search-movie).
- [TMDB: detalles](https://developer.themoviedb.org/reference/movie-details), [créditos](https://developer.themoviedb.org/reference/movie-credits), [clasificaciones](https://developer.themoviedb.org/reference/movie-release-dates) e [imágenes](https://developer.themoviedb.org/reference/movie-images).
- [TMDB: construcción de URLs de imágenes](https://developer.themoviedb.org/docs/image-basics) y [errores y límite de paginación](https://developer.themoviedb.org/docs/errors).
- [Apple: instalación de componentes de Xcode](https://developer.apple.com/documentation/xcode/downloading-and-installing-additional-xcode-components).
- [Apple: SwiftData](https://developer.apple.com/documentation/swiftdata) y [LazyVGrid](https://developer.apple.com/documentation/swiftui/lazyvgrid).
