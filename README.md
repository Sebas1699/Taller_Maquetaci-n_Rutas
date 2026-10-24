# taller_maquetacion

Aplicación Flutter para una interfaz de autenticación con flujo de login, registro, recuperación de contraseña, verificación por código, nueva contraseña y pantalla de inicio.

## Requisitos

Este proyecto está configurado con:

- Flutter SDK: 3.13.1 o compatible
- Dart SDK: 3.13.1
- Sistema operativo: Windows (aunque el código es multiplataforma)
- Editor recomendado: VS Code con Flutter extension
- Dispositivo o emulador Android/iOS disponible para ejecución

## Instalación de Flutter

1. Instala Flutter siguiendo la documentación oficial:
   https://docs.flutter.dev/get-started/install
2. Verifica la instalación:

```bash
flutter --version
flutter doctor
```

Si aparece algún problema con Android SDK, emuladores o licencias, corrígelo antes de continuar.

## Clonar y preparar el proyecto

```bash
git clone <https://github.com/Sebas1699/Taller_Maquetaci-n_Rutas.git>
cd taller_maquetacion
flutter pub get
```

## Ejecutar la app

Con un emulador o dispositivo conectado:

```bash
flutter run
```

Si deseas abrir una vista específica del proyecto o elegir un dispositivo:

```bash
flutter devices
flutter run -d <device-id>
```

## Ejecutar pruebas

```bash
flutter test
```

## Validación del proyecto

Este proyecto ya incluye el asset necesario para el fondo:

- `assets/images/fondo_pantalla.jpeg`

Y está registrado en `pubspec.yaml` para que Flutter lo pueda cargar correctamente.

## Estructura principal

```text
lib/
├── components/
├── models/
├── routes/
├── screens/
├── main.dart
assets/
└── images/
    └── fondo_pantalla.jpeg
```

## Flujo de la aplicación

1. Login
2. Registro
3. Recuperar contraseña
4. Código de verificación
5. Nueva contraseña
6. Home / bienvenida

## Solución rápida de errores comunes

### Error: asset no encontrado
Si aparece un error como:

```text
Unable to load asset: "assets/images/fondo_pantalla.jpeg"
```

Verifica que el archivo exista en la ruta correcta y que en `pubspec.yaml` esté registrado así:

```yaml
flutter:
  uses-material-design: true
  assets:
    - assets/images/fondo_pantalla.jpeg
```

Luego ejecuta:

```bash
flutter pub get
flutter run
```

### Error: Flutter no está instalado o no está en PATH
Ejecuta:

```bash
flutter --version
```

Si no funciona, revisa la instalación del SDK y reinicia la terminal o VS Code.

## Información útil

El proyecto usa una estructura simple de Flutter con rutas y pantallas separadas, ideal para practicar maquetación y flujo de navegación en aplicaciones móviles.
