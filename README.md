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

# 📖 Documentación del Proyecto: The Ring Private

## 1. ¿Qué es la app y de qué va?
**The Ring Private** es una aplicación móvil exclusiva diseñada para la gestión integral de acceso, comunicación y experiencia de usuario de un club privado. Su objetivo principal es digitalizar y asegurar el ecosistema del club, sustituyendo los carnets físicos tradicionales por un sistema de acceso dinámico y cifrado, al mismo tiempo que centraliza las notificaciones y el soporte en tiempo real para los usuarios.

## 2. ¿Para quién está dirigida?
La plataforma está diseñada para dos perfiles principales:
* **Socios / Miembros VIP:** Usuarios que han adquirido una membresía en el club. Utilizan la app para identificarse en puerta, leer las normativas, recibir notificaciones de eventos y contactar con el staff.
* **Staff y Personal de Seguridad:** Aunque la app principal es para el socio, el personal de seguridad interactúa con ella validando visual o digitalmente los códigos de acceso generados.

## 3. ¿Quién la desarrolló?
El diseño, la arquitectura de software y el desarrollo completo de la aplicación han sido llevados a cabo por **Mauricio Javier Pérez Gavilanes**.

## 4. ¿Cómo funciona? (Resumen de Flujo)
El funcionamiento de la app es directo y seguro:
1.  **Autenticación:** Al abrir la aplicación, el usuario debe identificarse mediante DNI o Correo y contraseña contra una base de datos segura.
2.  **Dashboard:** Una vez dentro, la pantalla principal (**Home**) actúa como un panel de control donde el usuario visualiza notificaciones y accede a su perfil.
3.  **Acciones Críticas:** Desde la Home, el usuario puede realizar las dos funciones principales: generar su pase de acceso inmediato o solicitar soporte técnico mediante el botón flotante.

## 5. Funciones Relevantes ("Funciones Tochas")
El software ha sido desarrollado utilizando **Flutter (Dart)** para el frontend móvil y **Firebase (Google)** para la autenticación y base de datos en la nube.

* **Sistema de Acceso Seguro Dinámico (QR):** Para evitar suplantaciones de identidad y el uso de capturas de pantalla, la app genera un código QR único vinculado al ID del usuario. Este código cuenta con un temporizador de seguridad que se destruye y **regenera automáticamente cada 60 segundos**.
* **Motor de Físicas Personalizado (Aura Repelente):** El botón de soporte (WhatsApp) es un elemento flotante que el usuario puede arrastrar libremente por toda la pantalla (optimizado mediante GPU). Incluye un algoritmo matemático (`math.atan2`) que detecta la cercanía con el botón principal del QR y lo **repele magnéticamente**, garantizando que los elementos vitales de la interfaz nunca se solapen.
* **UI Reactiva en Tiempo Real (Estado Global):** Mediante el uso de `ValueNotifier`, la aplicación permite cambiar el idioma (Inglés/Español) y el tema de apariencia (Modo Claro/Oscuro) de forma instantánea. No requiere pantallas de carga ni reiniciar la app para aplicar los cambios.
* **Autenticación Inteligente:** El sistema de Login detecta automáticamente si el usuario ingresa un correo electrónico o un DNI, mapeando el DNI a su registro interno correspondiente en Firebase de forma transparente para el usuario.

## 6. Casos de Uso (Estructura para Diagramas)

### Caso de Uso 1: Validación en Puerta (Control de Acceso)
* **Actor:** Socio VIP.
* **Flujo:** El socio llega al club → Abre la app → Pulsa el botón central (QR) → El sistema genera un token temporal → Se muestra el código con cuenta atrás de 60s → El personal de seguridad valida el código → Acceso concedido.

### Caso de Uso 2: Asistencia Inmediata (Soporte)
* **Actor:** Socio VIP.
* **Flujo:** El socio requiere asistencia → Localiza el icono flotante de WhatsApp → Lo pulsa → El sistema inyecta un mensaje predefinido → Se abre la app nativa de WhatsApp redirigiendo al contacto oficial de la empresa.

### Caso de Uso 3: Autenticación de Usuario (Login)
* **Actor:** Socio.
* **Flujo:** El usuario introduce credenciales (DNI/Password) → La app cifra los datos → Firebase valida el token → El sistema carga el perfil y redirige a la Home.

## 7. Versiones y Especificaciones de Hardware/Software
Para un rendimiento óptimo de las animaciones y la conexión en tiempo real:

* **Versión Actual:** `1.0.0+1`
* **Requisitos Android:** Android 6.0 (API 23) o superior. Recomendado dispositivos de 64 bits (ARM64).
* **Requisitos iOS:** iOS 12.0 o superior (iPhone 6s en adelante).
* **Hardware Común:** * Conexión a Internet activa (4G/5G/Wi-Fi).
   * Pantalla táctil capacitiva.
   * Cámara funcional (para futuras implementaciones de foto de perfil).

