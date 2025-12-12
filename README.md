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
            <img width="746" height="1600" alt="image" src="https://github.com/user-attachments/assets/5a1b6283-067d-45c1-9465-955e2041f77c" />

                                  Catálogo completo de libros con información de disponibilidad, categorías y opciones de búsqueda


                                                                              Reserva de Cubículos
            <img width="747" height="1600" alt="image" src="https://github.com/user-attachments/assets/f0c80e8d-e429-4c52-b854-970d57066a15" />

                                              Sistema de reserva de cubículos con calendario y disponibilidad en tiempo real


                                                                            Gestión de Computadoras
            <img width="750" height="1599" alt="image" src="https://github.com/user-attachments/assets/b10d7531-3644-4300-9b63-bc2a236af04b" />

                                        Vista personal donde el usuario puede consultar todas sus reservas activas y su historial


                                                                              Sistema de Reportes
            <img width="744" height="1600" alt="image" src="https://github.com/user-attachments/assets/2a075223-81f9-4784-b72f-b577d3d61028" />

                                            Módulo de generación de reportes con diferentes opciones de filtrado y exportación


                                                                                Tecnologías
                                                    Framework y Lenguaje
                                                    
                                                    Flutter 3.x - Framework de UI multiplataforma de Google
                                                    
                                                    Dart 3.x - Lenguaje de programación optimizado para UI
                                                    
                                                    Almacenamiento de Datos
                                                    
                                                    JSON - Almacenamiento local de datos en formato JSON
                                                    
                                                    dart:convert - Codificación y decodificación de JSON
                                                         
                                                          
                                                          Paquetes de Flutter Utilizados
                                                                yamldependencies:
                                                                  
                                                                    flutter:
                                                                    sdk: flutter
                                                                  
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



