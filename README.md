# practica3_flutter

A new Flutter project.

## Getting Started

This project is a starting point for a Flutter application.

A few resources to get you started if this is your first Flutter project:

- [Learn Flutter](https://docs.flutter.dev/get-started/learn-flutter)
- [Write your first Flutter app](https://docs.flutter.dev/get-started/codelab)
- [Flutter learning resources](https://docs.flutter.dev/reference/learning-resources)

For help getting started with Flutter development, view the
[online documentation](https://docs.flutter.dev/), which offers tutorials,
samples, guidance on mobile development, and a full API reference.

# Práctica 3 — Ejercicio 4: Flutter Multiplataforma

**ESCOM — Instituto Politécnico Nacional**  
Desarrollo de Aplicaciones Móviles Nativas

## Descripción

Aplicación multiplataforma desarrollada con Flutter que implementa
cámara fotográfica y grabación de audio, con persistencia local
y soporte para iOS y Android.

## Características

- Captura de fotos con vista previa en tiempo real
- Grabación de audio con contador de tiempo
- Galería con reproductor de audio integrado
- Dos temas: Guinda (IPN) y Azul (ESCOM)
- Modo claro y oscuro
- Almacenamiento local con Hive (sin conexión a internet)

## Arquitectura

Clean Architecture con tres capas:

- **Presentación**: Screens, Widgets, Providers
- **Dominio**: Entidades (PhotoModel, RecordingModel)
- **Datos**: Repositorios Hive, acceso a hardware

## Tecnologías

| Paquete              | Propósito             |
| -------------------- | --------------------- |
| `provider`           | Gestión de estado     |
| `camera`             | Acceso a cámara       |
| `flutter_sound`      | Grabación de audio    |
| `audioplayers`       | Reproducción de audio |
| `hive`               | Almacenamiento local  |
| `permission_handler` | Permisos Android/iOS  |

## Instalación

```bash
git clone https://github.com/TuUsuario/practica3-flutter.git
cd practica3-flutter
flutter pub get
dart run build_runner build --delete-conflicting-outputs
flutter run
```

## APK

El APK compilado se encuentra en:
`build/app/outputs/flutter-apk/app-release.apk`
