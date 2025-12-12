                                                 Sistema de Gestión de Biblioteca 
 <img width="1366" height="768" alt="image" src="https://github.com/user-attachments/assets/8b96bdef-f72e-4e69-9b96-dc8f2961582a" />
 <img width="1366" height="768" alt="image" src="https://github.com/user-attachments/assets/1783ee0e-708a-4892-bdd2-466ee04823ca" />
<img width="1366" height="768" alt="image" src="https://github.com/user-attachments/assets/be8c4432-d617-4af6-97d0-62e3faabf806" />

Tabla de Contenidos:

Descripción

Características

Screenshots

Tecnologías

Requisitos Previos

Instalación

Uso

Estructura del Proyecto

Estado del Desarrollo

Contribuir

Licencia

Contacto


                                                                      Descripción 
Sistema de Gestión de Biblioteca es una aplicación móvil desarrollada en Flutter que facilita la administración y gestión de recursos bibliotecarios. La aplicación permite a los usuarios y administradores gestionar de manera eficiente el préstamo de libros, la reserva de espacios de estudio (cubículos) y el uso de computadoras.

                                                                ¿Qué hace esta aplicación?
Gestión de Libros: Catálogo completo con información detallada de cada libro, disponibilidad en tiempo real y sistema de préstamos

Reserva de Cubículos: Sistema de reservas para espacios de estudio individuales o grupales

Gestión de Computadoras: Control de asignación y uso de computadoras de la biblioteca

Sistema de Reportes: Generación de reportes detallados sobre el uso de recursos

Portal de Usuario: Visualización personalizada de todas las reservas y préstamos activos

                                                                        ¿Por qué es útil?
Este proyecto resuelve la necesidad de digitalizar y optimizar los procesos de gestión bibliotecaria, eliminando el uso de papel y reduciendo los tiempos de espera. Permite a los usuarios reservar recursos desde cualquier lugar y a los administradores tener un control centralizado de todos los recursos.

¿Para quién esta pensado?
Estudiantes: Para reservar espacios de estudio y préstamos de libros

Bibliotecarios: Para gestionar recursos y generar reportes

Administradores: Para supervisar el uso general y tomar decisiones basadas en datos

                                                                           Características
Catálogo de Libros:
Búsqueda y filtrado de libros

Información detallada (autor, ISBN, categoría, disponibilidad)

Sistema de préstamos con fechas de devolución


Gestión de Cubículos:
Visualización de disponibilidad en tiempo real

Reserva por fecha y horario

Diferentes capacidades (individual, grupal)


Administración de Computadoras:
Asignación de equipos disponibles

Control de tiempo de uso

Estado de cada equipo


Sistema de Reportes:
Reportes de préstamos de libros

Estadísticas de uso de cubículos

Reportes de uso de computadoras

Exportación de datos


Portal Personal:
Vista consolidada de todas tus reservas

Historial de préstamos

Notificaciones de vencimiento


Módulo de Estadísticas:
Dashboard visual (En desarrollo)

Métricas de uso de recursos

Tendencias y análisis


                                                                                Screenshots
Pantalla Principal / Home

Vista principal de la aplicación mostrando el dashboard con acceso rápido a libros, cubículos y computadoras

<img width="746" height="1600" alt="image" src="https://github.com/user-attachments/assets/325621ba-d072-44aa-8351-503c52f554cb" />
                  



  Catálogo de Libros
  
  Catálogo completo de libros con información de disponibilidad,categorías y opciones de búsqueda
  
  <img width="746" height="1600" alt="image" src="https://github.com/user-attachments/assets/5a1b6283-067d-45c1-9465-955e2041f77c" />
 


  Reserva de Cubículos
 
  Sistema de reserva de cubículos con calendario y disponibilidad en tiempo real
  
  <img width="747" height="1600" alt="image" src="https://github.com/user-attachments/assets/f0c80e8d-e429-4c52-b854-970d57066a15" />


  
  Gestión de Computadoras
 
  Vista personal donde el usuario puede consultar todas sus reservas activas y su historial
  
  <img width="750" height="1599" alt="image" src="https://github.com/user-attachments/assets/b10d7531-3644-4300-9b63-bc2a236af04b" />

  
Sistema de Reportes

Módulo de generación de reportes con diferentes opciones de filtrado y exportación

<img width="744" height="1600" alt="image" src="https://github.com/user-attachments/assets/2a075223-81f9-4784-b72f-b577d3d61028" />




                                                                      Tecnologías
  Framework y Lenguaje
                                                    
  Flutter 3.x - Framework de UI multiplataforma de Google
                                                    
  Dart 3.x - Lenguaje de programación optimizado para UI
                                                    
                                                                Almacenamiento de Datos
                                                    
  JSON - Almacenamiento local de datos en formato JSON
                                                    
  dart:convert - Codificación y decodificación de JSON
                                                         
                                                          
                                                          Paquetes de Flutter Utilizados
  yamldependencies:
                                                                  
  flutter: sdk: flutter
                                                                  
  # Gestión de estado:
  
  provider: ^6.0.0
                                                                  
  # Almacenamiento local:
  
  path_provider: ^2.0.0
                                                                  
  shared_preferences: ^2.0.0
                                                                  
   # UI y diseño:
  
   google_fonts: ^5.0.0
                                                                  
  flutter_svg: ^2.0.0
                                                                  
  # Utilidades:
  
  intl: ^0.18.0

                                                                            Requisitos Previos
Antes de comenzar, asegúrate de tener instalado:

Flutter SDK (versión 3.0 o superior)

Guía de instalación de Flutter

Dart SDK (incluido con Flutter)

Android Studio o Visual Studio Code

Con los plugins de Flutter y Dart instalados

Git

Emulador Android o dispositivo físico para testing

Para iOS: Xcode (solo en macOS)

                                                                            Verificar instalación
flutter doctor

Este comando verificará que todo esté configurado correctamente.

                                                                               Instalación
1. Clonar el repositorio

git clone https://github.com/pmoraila23-lgtm/biblioteca_app.git

cd biblioteca_app

2. Instalar dependencias

flutter pub get

3. Configurar datos iniciales (Opcional)
   
El proyecto incluye archivos JSON de ejemplo en la carpeta assets/data/:

libros.json - Catálogo inicial de libros

cubiculos.json - Configuración de cubículos

computadoras.json - Inventario de computadoras

Puedes modificar estos archivos para personalizar los datos iniciales.

4. Ejecutar la aplicación
# En modo debug

flutter run

# O específicamente en un dispositivo

flutter run -d <device_id>

# Para listar dispositivos disponibles

flutter devices

5. Compilar para producción

# Android (APK)

flutter build apk --release

                                                                                    Uso

                            Para Usuarios

Explorar el Catálogo de Libros:

Navega por el catálogo desde la pantalla principal

Usa la búsqueda para encontrar libros específicos

Selecciona un libro para ver detalles y solicitar préstamo


                        Reservar un Cubículo:

Accede a la sección de cubículos

Selecciona fecha y horario deseado

Confirma la reserva

                      Solicitar una Computadora:

Ve a la sección de computadoras

Selecciona una computadora disponible

Indica el tiempo estimado de uso

                            Ver tus Reservas:

Accede a "Mis Reservas" desde el menú

Revisa todas tus reservas activas

Consulta el historial

                            Para Administradores

Generar Reportes:

Accede al módulo de reportes

Selecciona el tipo de reporte deseado

Aplica filtros por fecha o categoría

Exporta los datos

                              Gestionar Recursos:

Agrega nuevos libros al catálogo

Administra disponibilidad de cubículos

Controla el estado de las computadoras



