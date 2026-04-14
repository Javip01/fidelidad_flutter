Fidelidad Flutter
Fidelidad Flutter es la solución móvil definitiva para la gestión de lealtad en el sector del ocio nocturno. Diseñada con un enfoque de alto rendimiento y una experiencia de usuario (UX) inmersiva, esta app permite a los clientes de discotecas y clubes acumular puntos, descubrir ofertas exclusivas y canjear premios mediante un sistema de escaneo ágil y seguro.

📑 Índice
Características Principales

Tecnologías Utilizadas

Manual de Usuario

Navegación y Estética

Gestión de Puntos (Diamonds)

Acumulación de Puntos (Cámara)

Canjeo de Recompensas

Configuración y Soporte

Detalles Técnicos y UX/UI Avanzada

Instalación

✨ Características Principales
Transiciones de Fusión Inmersiva: Sistema de navegación personalizado que utiliza fundidos a blanco progresivos para eliminar la rigidez de los bordes de pantalla durante el deslizamiento.

Arquitectura Zero-Lag: Implementación de técnicas de renderizado aislado que garantizan una tasa de refresco constante de 60 FPS, incluso en dispositivos de gama media.

Fidelización Gamificada: Visualización de saldo mediante gemas dinámicas y tarjetas de promociones con degradados animados inspirados en interfaces XML de alto nivel.

Sistema de Recompensas Multi-Local: Capacidad de gestionar catálogos de premios independientes para diferentes locales desde una única interfaz centralizada.

🛠 Tecnologías Utilizadas
Framework: Flutter (Dart)

Integraciones: image_picker (Para captura de QR/Tickets), Material Design 3.

Animaciones: AnimationController y Tween para el control milimétrico de la opacidad y posición.

Gestión de Memoria: Uso de RepaintBoundary para optimizar el uso de la GPU.

📖 Manual de Usuario (Cómo usar la app)
Este apartado detalla el funcionamiento de cada sección de la aplicación para garantizar que el usuario final aproveche al máximo el sistema de recompensas.

1. Navegación y Estética
   La app utiliza una barra de navegación inferior intuitiva para moverse entre las dos áreas principales: Ofertas y Ajustes.

Efecto de Transición: Al cambiar de pestaña, notarás que la pantalla actual se funde suavemente con el fondo blanco mientras la nueva aparece. Este efecto está diseñado para evitar cortes bruscos y mejorar la inmersión visual.

2. Gestión de Puntos (Diamonds)
   En la parte superior de la pantalla principal, verás tu saldo de puntos junto a un icono de diamante (ej. 1.250 pts).

Consulta rápida: El saldo se actualiza instantáneamente tras cada operación.

Acceso al historial: Al tocar el marcador de puntos, accederás a una vista detallada de tus movimientos y puntos acumulados.

3. Acumulación de Puntos (Cámara)
   El botón rojo con el icono de la cámara situado en el centro de la barra inferior es tu herramienta principal de crecimiento.

¿Cómo sumar? Pulsa el botón central para activar la cámara del terminal. Apunta al código QR que te facilite el personal del club o al que aparezca en tu ticket de consumición.

Validación: Una vez detectado, el sistema procesará la lectura y verás crecer tu saldo de diamantes en tiempo real.

4. Canjeo de Recompensas
   Bajo el carrusel de ofertas, encontrarás la sección "Gastar Puntos" con un listado de locales asociados.

Selección: Toca el logo de tu local preferido para abrir su catálogo de premios.

Canje: Selecciona la recompensa deseada (ej. "Premio Especial 1"). Se abrirá un pop-up informativo donde podrás confirmar el canje pulsando en el botón de puntos.

Uso: Muestra la confirmación al personal del local para recibir tu premio físico.

5. Configuración y Soporte
   Desde la pestaña de Ajustes, puedes gestionar tu identidad digital:

Perfil: Edita tu nombre de usuario y correo de contacto.

Centro de Ayuda: Accede a las Preguntas Frecuentes (FAQ) o contacta directamente con el soporte técnico mediante el chat con el administrador.

Seguridad: Encontrarás los términos legales y la opción de eliminar tu cuenta de forma permanente si lo deseas.

🧠 Detalles Técnicos y UX/UI Avanzada
La aplicación ha sido optimizada para ofrecer una experiencia de nivel profesional mediante:

Fusión de Pantallas mediante Sábana Blanca: Para evitar el alto coste computacional de las transparencias reales (saveLayer), la app utiliza un FadeTransition sobre contenedores de color sólido que actúan como "sábanas" visuales. Esto emula un desvanecimiento perfecto con un uso de CPU cercano al 0%.

Interruptores de Estado (SizedBox.shrink): Los halos y efectos de iluminación solo existen en el árbol de widgets mientras la animación está en curso. Al detenerse, el código destruye físicamente estos elementos para garantizar que no queden "luces fijas" o artefactos visuales sobre el contenido de las pantallas.

Repaint Boundaries: Las pantallas de Ofertas y Ajustes están envueltas en fronteras de repintado para asegurar que la GPU no trabaje de más recalculando elementos estáticos durante el movimiento de los menús.

💻 Instalación (Para Desarrolladores)
Clona este repositorio público:

Bash
git clone https://github.com/Javip01/fidelidad_flutter.git
Entra en el directorio del proyecto:

Bash
cd fidelidad_flutter
Asegúrate de tener instalado el SDK de Flutter (>=3.0.0) y ejecuta:

Bash
flutter pub get
Ejecuta la aplicación en modo release para experimentar la fluidez real de las animaciones:

Bash
flutter run --release