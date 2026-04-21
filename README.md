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



HAY QUE REORGANIZAR LA INFORMACIÓN DEL README

# 📖 Documentación del Proyecto: Fidelidad Flutter (NightRewards)

## 1. ¿Qué es la app y de qué va?
**Fidelidad Flutter** es una plataforma móvil de alto rendimiento diseñada para la gamificación y fidelización de clientes en el sector del ocio nocturno. La aplicación permite a los usuarios centralizar su experiencia social: descubriendo promociones exclusivas, acumulando puntos ("Diamantes") mediante el escaneado de consumiciones reales y canjeando recompensas en una red de locales asociados (discotecas, bares y salas de eventos).

## 2. ¿Para quién está dirigida?
* **Usuarios Finales:** Clientes de ocio nocturno que buscan optimizar sus gastos y acceder a beneficios VIP (entradas, copas, reservaciones) mediante la recurrencia.
* **Establecimientos Asociados:** Negocios que necesitan una herramienta digital ágil para fidelizar a su clientela sin depender de tarjetas de cartón físicas, obteniendo una imagen de marca premium y moderna.

## 3. ¿Quién la desarrolló?
El diseño de interfaz (UI), la arquitectura de la experiencia de usuario (UX) y el desarrollo íntegro del software han sido realizados por **Mauricio Javier Pérez Gavilanes**.

## 4. ¿Cómo funciona? (Resumen de Flujo)
1.  **Exploración:** El usuario consulta el carrusel dinámico de ofertas para decidir su destino.
2.  **Consumo y Captura:** Al realizar un gasto en el local, el usuario utiliza el escáner integrado para registrar su ticket.
3.  **Cálculo de Recompensa:** El sistema procesa el gasto y asigna puntos proporcionales (ej. 1€ = 10 pts) al saldo global en tiempo real.
4.  **Canjeo:** El usuario selecciona un premio del catálogo, genera un ticket digital y lo valida con el staff del local.

## 5. Funciones Relevantes ("Funciones Tochas")
El software destaca por una implementación técnica avanzada sobre **Flutter (Dart)**:

* **Motor de Transición de Pantallas "Liquid Smooth":** Utiliza un `SmoothTransitionScaffold` propio que implementa una "sábana de fusión" blanca con opacidad variable basada en curvas sinusoidales (`math.sin`). Esto permite una navegación inmersiva a 60 FPS constantes, eliminando el impacto visual de los bordes rígidos.
* **Estado Global Reactivo:** Implementación de `ValueNotifier` y `ValueListenableBuilder` para la sincronización instantánea de puntos. Cualquier cambio en el historial se refleja automáticamente en la Home y la pantalla de Puntos sin necesidad de recargas o estados de carga.
* **Renderizado de Gradientes por GPU:** Uso de la clase `AnimacionXMLGradient` que cicla degradados lineales complejos. Al utilizar `RepaintBoundary`, la carga gráfica se delega al hardware especializado, permitiendo animaciones fluidas sin calentar el procesador.
* **Generador de Tickets Digitales:** Un motor interno que transforma los datos de la transacción en un ticket visual con estética *monospace* y cálculo automático de caducidad (ventana móvil de 180 días).

## 6. Casos de Uso

### Caso de Uso 1: Acumulación de Puntos (Escáner)
* **Actor:** Cliente.
* **Flujo:** Cliente recibe ticket → Abre cámara en la app → Escanea código → El sistema inyecta los puntos al estado global → El saldo se actualiza visualmente en todas las pantallas.

### Caso de Uso 2: Decisión de Ocio (Discovery)
* **Actor:** Cliente.
* **Flujo:** Cliente abre la app → Desliza el carrusel de ofertas → Consulta el panel de "Normas" para verificar validez → Elige el establecimiento basado en la promoción activa.

### Caso de Uso 3: Canjeo en Barra (Redemption)
* **Actor:** Cliente y Staff.
* **Flujo:** Cliente entra en "Gastar Puntos" → Elige local y premio → Confirma canje → El sistema genera un ticket digital con el logo animado del local → El staff valida visualmente y entrega el premio.

## 7. Especificaciones Técnicas
* **Versión:** 1.0.0+1
* **Arquitectura:** Clean UI con gestión de estado desacoplada.
* **Compatibilidad:**
   * **Android:** 6.0 (API 23) en adelante.
   * **iOS:** 12.0 o superior.
* **Hardware Requerido:** Cámara trasera (AF), conexión a datos/Wi-Fi y pantalla capacitiva.

