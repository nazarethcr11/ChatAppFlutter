# Chat App (Flutter and Firebase)

## Descripción del Proyecto
Este proyecto es una aplicación que proporciona una plataforma de comunicación con las siguientes funcionalidades clave:

### **Themes**
La aplicación soporta dos temas visuales para mejorar la experiencia del usuario:
- Modo Claro: Un tema con colores brillantes y claros, ideal para ambientes bien iluminados.
- Modo Oscuro: Un tema con colores oscuros, diseñado para ambientes con poca luz o para usuarios que prefieren interfaces con menos brillo.
### **Autenticación**
La seguridad y privacidad de los usuarios son primordiales. La aplicación incluye las siguientes opciones de autenticación:
- Inicio de sesión con correo electrónico: Permite a los usuarios ingresar con su dirección de correo electrónico y contraseña.
- Registro con correo electrónico: Los nuevos usuarios pueden crear una cuenta proporcionando un correo electrónico y una contraseña.
### **Funcionalidad de Chat**
Para facilitar la comunicación, la aplicación incluye funcionalidades de chat en tiempo real:

- Enviar mensajes: Los usuarios pueden enviar mensajes instantáneamente a otros usuarios en la plataforma.
- Recibir mensajes: Los usuarios reciben mensajes de otros usuarios en tiempo real.
### **Cuenta de Usuario**
La aplicación ofrece varias herramientas para gestionar y personalizar la experiencia del usuario:

- Bloquear y reportar usuarios: Los usuarios pueden bloquear o reportar a otros usuarios en caso de comportamientos inapropiados.
- Eliminar cuenta: Los usuarios tienen la opción de eliminar su cuenta de forma permanente si así lo desean.
### **Mejoras Futuras**
Para mejorar la funcionalidad y experiencia del usuario, se están considerando las siguientes características:

- Notificaciones: Implementar notificaciones push para alertar a los usuarios sobre nuevos mensajes o eventos importantes.
- Estado de mensajes no leídos: Mostrar el estado de los mensajes no leídos para mantener a los usuarios informados sobre la actividad en sus chats.


## Getting Started
### **Video tutorial**
- Para una guía visual detallada de los pasos de configuración del proyecto, consulta el siguiente video: https://youtu.be/KGpmUqhtrkI?si=f9V8Svmyrh2mpDSY

### **Obtencion de Dependencias**
```
  flutter pub get
```

### **Configuración de Firebase**

Para utilizar Firebase en este proyecto, es necesario configurar Firebase siguiendo estos pasos:

1. Crear un proyecto de Firebase
- 1.1. Accede a la consola de Firebase.
- 1.2. Haz clic en "Agregar proyecto" y sigue las instrucciones para crear un nuevo proyecto de Firebase:
    + Ingresa un nombre para tu proyecto.
    + Decide si deseas habilitar Google Analytics para tu proyecto.
2. Agregar Firebase a la aplicación
- 2.1. Instala las herramientas de Firebase en tu máquina:
  ```
  npm install -g firebase-tools
  ```
- 2.2. Inicia sesión en Firebase desde la terminal:
  ```
  firebase login
  ```
- 2.3. Configura Firebase para tu aplicación Flutter:
  ```
  flutterfire configure
  ```
> [!NOTE]
> Durante la configuración:
> - Elige el proyecto que creaste en Firebase.
> - Selecciona Android como plataforma.
> - Para el package name, utiliza el namespace de tu aplicación.

3. Configurar Authentication en Firebase
- 3.1. En el panel de control de Firebase, navega a Authentication.
- 3.2. Haz clic en "Comenzar" y activa el método de autenticación por Correo electrónico y contraseña.

4. Configurar Cloud Firestore en Firebase
- 4.1. En el panel de control de Firebase, navega a Cloud Firestore.
- 4.2. Haz clic en "Crear base de datos" y selecciona el modo de producción o prueba según tus necesidades.
- 4.3. Cambia las reglas de Firestore para permitir el acceso de lectura y escritura (solo para desarrollo): Cambia las reglas false a true para pruebas iniciales.
> [!TIP]
> No olvides configurar reglas más estrictas para producción.