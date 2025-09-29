# Blueprint de la Aplicación "Ser Interior"

## Visión General

"Ser Interior" es una aplicación de bienestar integral diseñada para conectar a las personas con profesionales del crecimiento personal. La plataforma ofrece una variedad de herramientas y servicios, desde la búsqueda de terapeutas hasta contenido exclusivo, para apoyar a los usuarios en su camino hacia el autoconocimiento y el equilibrio.

## Diseño y Características Implementadas

### Versión Inicial

#### Estilo y Diseño

*   **Paleta de Colores:** Se utiliza una paleta suave y acogedora, con un degradado de rosa a lavanda en la sección principal y un fondo blanco limpio para el contenido. Los colores de acento incluyen un rosa vibrante, azul y morado para los elementos interactivos y los íconos.
*   **Tipografía:** Se emplea una tipografía moderna y legible para garantizar una buena experiencia de usuario.
*   **Iconografía:** Se utilizan íconos de Material Design para representar visualmente cada característica.

#### Características

*   **Pantalla de Inicio (`lib/inicio.dart`):**
    *   **Sección de Bienvenida:** Un mensaje de bienvenida con un degradado de fondo, un título llamativo ("Conecta con tu Ser Interior") y botones de acción para "Encontrar Terapeuta" y "Reservar Espacio".
    *   **Sección "Todo lo que necesitas":** Una sección que presenta las principales características de la aplicación a través de tarjetas informativas.
*   **Componente de Tarjeta de Característica (`lib/tarjetas.dart`):**
    *   Un widget reutilizable (`FeatureCard`) que muestra un ícono, un título y un subtítulo.
    *   Las tarjetas implementadas son:
        *   Terapeutas Profesionales
        *   Reserva Espacios
        *   Chat Seguro
        *   Podcast Exclusivo
        *   Blog de Bienestar
        *   Tienda Espiritual

## Plan de Cambios Actual

*   **Tarea:** Visualización de la interfaz de usuario.
*   **Pasos:**
    1.  Formatear el código fuente (`dart format .`).
    2.  Analizar el código en busca de errores y advertencias (`flutter analyze`).
    3.  Corregir una advertencia de `withOpacity` obsoleto en `lib/tarjetas.dart`.
    4.  Verificar que no haya más problemas con `flutter analyze`.
    5.  Confirmar que la vista previa se ha actualizado con los cambios.
