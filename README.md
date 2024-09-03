# chat_app

A new Flutter project.

## Getting Started

Configuración de Firebase
Para utilizar Firebase en este proyecto, es necesario configurar Firebase siguiendo estos pasos:

1. Crear un proyecto de Firebase
  -1.1. Accede a la consola de Firebase.
  -1.2. Haz clic en "Agregar proyecto" y sigue las instrucciones para crear un nuevo proyecto de Firebase:
      + Ingresa un nombre para tu proyecto.
      + Decide si deseas habilitar Google Analytics para tu proyecto.
2. Agregar Firebase a la aplicación
  -2.1. Instala las herramientas de Firebase en tu máquina:
  ```
  npm install -g firebase-tools
  ```
  -2.2. Inicia sesión en Firebase desde la terminal:
  ```
  firebase login
  ```
  -2.3. Configura Firebase para tu aplicación Flutter:
  ```
  flutterfire configure
  ```
  Durante la configuración:
    + Elige el proyecto que creaste en Firebase.
    + Selecciona Android como plataforma.
    + Para el package name, utiliza el namespace de tu aplicación.
    
3. Configurar Authentication en Firebase
  -3.1. En el panel de control de Firebase, navega a Authentication.
  -3.2. Haz clic en "Comenzar" y activa el método de autenticación por Correo electrónico y contraseña.

4. Configurar Cloud Firestore en Firebase
  -4.1. En el panel de control de Firebase, navega a Cloud Firestore.
  -4.2. Haz clic en "Crear base de datos" y selecciona el modo de producción o prueba según tus necesidades.
  -4.3. Cambia las reglas de Firestore para permitir el acceso de lectura y escritura (solo para desarrollo):
  Cambia las reglas false a true para pruebas iniciales. Nota: No olvides configurar reglas más estrictas para producción.

5. Video tutorial
  -Para una guía visual detallada de estos pasos, consulta el siguiente video: Configuración de Firebase.
  https://youtu.be/KGpmUqhtrkI?si=f9V8Svmyrh2mpDSY
