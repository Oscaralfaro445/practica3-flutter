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

# Práctica 3: Aplicaciones Nativas
**Instituto Politécnico Nacional — Escuela Superior de Cómputo**  
Ingeniería en Sistemas Computacionales / 2020  
Unidad de aprendizaje: Desarrollo de Aplicaciones Móviles Nativas

---

## Datos de los integrantes

| Campo | Valor |
|---|---|
| Nombres | Oscar Alfaro - Hugo Herrera - Amairani Cruz |
| Profesor | Hurtado Aviles Gabriel |
| Fecha de entrega | 27 de abril de 2026 |

---

## Introducción

Esta práctica tiene como objetivo desarrollar aplicaciones nativas para el ecosistema Apple e implementar una solución multiplataforma con Flutter. Se desarrollaron 4 ejercicios: instalación del entorno macOS con Docker, gestor de archivos en macOS con Swift, aplicación de cámara/micrófono en macOS con Swift, y dos aplicaciones Flutter multiplataforma (cámara/micrófono y gestor de archivos).

Todas las aplicaciones funcionan sin conexión a internet, gestionando y almacenando datos localmente en el dispositivo.

---

## Ejercicio 1: Instalacion de iOS/macOS

### 1.1 Identificación del equipo

> **Capturas** Especificaciones del equipo, pantalla de System Information.

<details>
<summary>Ver imagen</summary>

- Equipo Amairani
<img width="295" height="640" alt="image" src="https://github.com/user-attachments/assets/cda2cd87-ad6d-423c-b6f3-4a11022d68cd" />
<br />
- Equipo Hugo
<img width="595" height="245" alt="image" src="https://github.com/user-attachments/assets/e8d48d65-29ae-48d9-8046-9673b995ad3f" />
<br />
- Equipo Oscar
<img width="853" height="158" alt="image" src="https://github.com/user-attachments/assets/95ed25a7-266e-4ff5-962d-17f9511f39dc" />
<br />
</details>

> **Equipo seleccionado**

| Componente | Especificación |
|---|---|
| CPU | Core i7 Ultra |
| RAM | 16 GB |
| Almacenamiento | 477 GB |
| GPU | Intel Arc |
| Sistema operativo | Windows 11 Pro |

> **Capturas** Especificaciones del equipo, pantalla de System Information.

<details>
<summary>Ver imagen</summary>
<img width="1038" height="147" alt="image" src="https://github.com/user-attachments/assets/e44c4069-bd8c-487c-bc11-4cd07d912bb9" />
<br />
<img width="518" height="92" alt="image" src="https://github.com/user-attachments/assets/2399fcc6-3b67-4d34-ab0d-e0e0acaf415a" />
</details>

### 1.2 Instalación del entorno macOS con Docker

Pasos realizados:
1. Clonación del repositorio `github.com/gabrielhuav/MacOS-Docker`
2. Verificación de requisitos del sistema
3. Configuración de recursos (CPU cores, RAM, almacenamiento)
4. Arranque y verificación del sistema

> 📸 **Capturas:** Docker corriendo, macOS iniciado en el contenedor, acceso a internet verificado dentro del contenedor.

<details>
<summary>Ver imagen</summary>
<img width="1241" height="355" alt="Captura de pantalla 2026-04-22 220119" src="https://github.com/user-attachments/assets/d385e23a-c63d-4586-8e39-87f62dae8dc7" />
<br />
<img width="1919" height="1079" alt="Captura de pantalla 2026-04-22 220708" src="https://github.com/user-attachments/assets/ca90e27e-936b-415c-b156-ba0de0c38c15" />
<br />
<img width="1131" height="645" alt="Captura de pantalla 2026-04-22 220955" src="https://github.com/user-attachments/assets/f69c45c3-c3ca-48f9-8aa6-a2baf148dc9e" />
<br />
<img width="1122" height="635" alt="Captura de pantalla 2026-04-22 221107" src="https://github.com/user-attachments/assets/fe5a54ac-0406-4dd5-88c5-dd5ac881f77d" />
<br />
<img width="1018" height="988" alt="Captura de pantalla 2026-04-22 221505" src="https://github.com/user-attachments/assets/98cc5338-2dd5-4a46-a55d-6f763cddfb42" />
<br />
<img width="1919" height="461" alt="Captura de pantalla 2026-04-22 221908" src="https://github.com/user-attachments/assets/82b3ed6d-f77f-4d1a-a269-52b603cb61ce" />
<br />
<img width="1919" height="390" alt="Captura de pantalla 2026-04-22 221949" src="https://github.com/user-attachments/assets/225cdf93-b331-4a95-aa22-3b29498b3109" />
<br />
<img width="1000" height="658" alt="Captura de pantalla 2026-04-22 222431" src="https://github.com/user-attachments/assets/f0cf544f-7874-49d0-97d0-34053f5a6612" />
<br />
<img width="405" height="67" alt="Captura de pantalla 2026-04-22 222543" src="https://github.com/user-attachments/assets/11381412-da18-45d8-92be-78f373988fcc" />
<br />
<img width="1052" height="898" alt="Captura de pantalla 2026-04-22 222846" src="https://github.com/user-attachments/assets/261dd82d-514d-4d7e-8804-a22ab9a85304" />
<br />
<img width="1134" height="887" alt="Captura de pantalla 2026-04-22 223425" src="https://github.com/user-attachments/assets/b74e4968-ace9-4ad7-be8c-4f819088694d" />
<br />
<img width="1911" height="1053" alt="Captura de pantalla 2026-04-22 224306" src="https://github.com/user-attachments/assets/726d670f-3919-472e-8e78-a34a9bdbb771" />
<br />
<img width="1910" height="1052" alt="Captura de pantalla 2026-04-22 224450" src="https://github.com/user-attachments/assets/bd9cd066-4492-4e95-a13e-d1d1a7e067b8" />
<br />
<img width="1913" height="1049" alt="Captura de pantalla 2026-04-22 224627" src="https://github.com/user-attachments/assets/f11fcf48-0300-425a-9325-4ff50e2276d1" />
<br />
<img width="1911" height="1049" alt="Captura de pantalla 2026-04-22 224955" src="https://github.com/user-attachments/assets/15da7be9-83ab-48fa-be58-a7a05c6ed2a6" />
<br />
<img width="1917" height="1051" alt="Captura de pantalla 2026-04-22 225056" src="https://github.com/user-attachments/assets/11dcfebb-d895-40c9-97ed-c58524867cf6" />
<br />
<img width="1914" height="1048" alt="Captura de pantalla 2026-04-22 225125" src="https://github.com/user-attachments/assets/79fc8db5-d7f5-4d83-8c97-4bdb2e6e4a92" />
<br />
<img width="1913" height="1054" alt="Captura de pantalla 2026-04-22 225252" src="https://github.com/user-attachments/assets/a735f089-b1df-4d45-b4a5-af68bc956bd6" />
<br />
<img width="908" height="738" alt="Captura de pantalla 2026-04-22 225334" src="https://github.com/user-attachments/assets/0191f4d7-103f-4a7b-94b0-aa844ddf3b23" />
<br />
<img width="1914" height="1051" alt="Captura de pantalla 2026-04-22 225528" src="https://github.com/user-attachments/assets/650dd7b7-0c35-4553-98fd-62b49e90b5e1" />
<br />
<img width="1919" height="1050" alt="Captura de pantalla 2026-04-22 231842" src="https://github.com/user-attachments/assets/77184607-2a87-47ad-a7b8-bf642b5b050c" />
<br />
<img width="1916" height="1051" alt="Captura de pantalla 2026-04-22 233832" src="https://github.com/user-attachments/assets/be7924b6-466c-46a9-a560-4b5a7e6f4635" />
<br />
<img width="1917" height="1052" alt="Captura de pantalla 2026-04-23 004611" src="https://github.com/user-attachments/assets/ee57dcf3-f329-439d-9f82-97a9d538ca07" />
</details>

### 1.3 Configuración del entorno de desarrollo iOS

Pasos realizados:
1. Instalación de Xcode desde la Mac App Store
2. Configuración de simuladores de iPhone y iPad
3. Instalación de Homebrew, CocoaPods y Swift Package Manager
4. Proyecto de prueba en Swift ejecutándose en simulador

> 📸 **Capturas** Xcode instalado, simulador corriendo, proyecto de prueba ejecutándose.

---

## Ejercicio 2: Gestor de Archivos para macOS

Repositorio de referencia: [practica3-gestor-archivos](https://github.com/Oscaralfaro445/practica3-gestor-archivos)

### Descripción

Gestor de archivos nativo para macOS desarrollado con Swift y SwiftUI/AppKit. Permite explorar el sistema de archivos, visualizar archivos, gestionar favoritos y aplicar temas personalizados del IPN y ESCOM.

### Funcionalidades implementadas

- Exploración del sistema de archivos con navegación jerárquica
- Visualización de imágenes con zoom y rotación
- Visualización de archivos de texto y código
- Gestión de archivos: copiar, mover, renombrar, eliminar
- Sistema de favoritos persistente
- Historial de archivos recientes
- Temas Guinda (IPN) y Azul (ESCOM) con soporte Light/Dark Mode

### Tecnologías utilizadas

| Paquete | Versión | Propósito |
|---|---|---|
| `provider` | ^6.1.2 | Gestión de estado |
| `hive` | ^2.2.3 | Almacenamiento local |
| `path_provider` | ^2.1.3 | Rutas del sistema |
| `open_file` | ^3.3.2 | Abrir archivos externos |
| `permission_handler` | ^11.3.1 | Permisos Android/iOS |

> 📸 **Capturas** Pantalla del explorador navegando carpetas, breadcrumb en acción, visor de imágenes con zoom, favoritos con archivos marcados, recientes con historial, menú contextual con opciones, cambio de tema Guinda/Azul, modo oscuro activado.

<details>
<summary>Ver imagen</summary>
<img width="1038" height="147" alt="image" src="https://github.com/user-attachments/assets/e44c4069-bd8c-487c-bc11-4cd07d912bb9" />
<br />
<img width="518" height="92" alt="image" src="https://github.com/user-attachments/assets/2399fcc6-3b67-4d34-ab0d-e0e0acaf415a" />
<br />
</details>

### Instalación

```bash
git clone https://github.com/TuUsuario/practica3-gestor-archivos.git
cd practica3-gestor-archivos
flutter pub get
dart run build_runner build --delete-conflicting-outputs
flutter run
```

---

## Ejercicio 3: Aplicación de Cámara y Micrófono para iOS

### Descripción

Aplicación nativa para iOS desarrollada con Swift y SwiftUI, compilada desde el entorno macOS-Docker. Implementa captura de fotos con AVFoundation y grabación de audio con AVAudioRecorder.

### Funcionalidades implementadas

- Captura de fotos con vista previa en tiempo real (AVCaptureSession)
- Grabación de audio con contador de tiempo (AVAudioRecorder)
- Galería con grid de fotos y reproductor de audio
- Visor de imágenes a pantalla completa con zoom interactivo
- Reproductor de audio con barra de progreso y control de posición
- Temas Guinda (IPN) y Azul (ESCOM) con soporte claro/oscuro
- Persistencia con Core Data para metadatos

> 📸 **Capturas** Vista previa de cámara activa, botón de captura, grabador con contador de tiempo animado, galería con fotos capturadas, reproductor de audio con slider, solicitud de permisos, tema Azul ESCOM activado.

<details>
<summary>Ver imagen</summary>
<img width="1038" height="147" alt="image" src="https://github.com/user-attachments/assets/e44c4069-bd8c-487c-bc11-4cd07d912bb9" />
<br />
<img width="518" height="92" alt="image" src="https://github.com/user-attachments/assets/2399fcc6-3b67-4d34-ab0d-e0e0acaf415a" />
<br />
</details>

### Requisitos técnicos

- Lenguaje: Swift 5+
- Cámara: AVFoundation (AVCaptureSession)
- Audio: AVAudioRecorder / AVAudioPlayer
- Persistencia: Core Data
- Compilación: Xcode en entorno macOS-Docker

---

## Ejercicio 4: Desarrollo Multiplataforma con Flutter

### Descripción general

Se desarrollaron dos aplicaciones Flutter multiplataforma (iOS y Android) implementando Clean Architecture, Provider como gestor de estado, y Hive para persistencia local. Ambas apps funcionan completamente sin conexión a internet.

---

### Opción A — Gestor de Archivos Flutter

**Repositorio:** [practica3-gestor-archivos](https://github.com/Oscaralfaro445/practica3-gestor-archivos)  
**APK:** `build/app/outputs/flutter-apk/app-release.apk`

#### Arquitectura (Clean Architecture)

---

### Opción B — Cámara y Micrófono Flutter

**Repositorio:** Este mismo repositorio  
**APK:** `build/app/outputs/flutter-apk/app-release.apk`

#### Arquitectura (Clean Architecture)

#### Decisiones de arquitectura

**Provider** permite que `CameraProvider`, `RecorderProvider` y `GalleryProvider` operen de forma independiente. El `GalleryProvider` observa los cambios en las cajas de Hive y se actualiza automáticamente cuando se captura una foto o se guarda una grabación.

**Hive** almacena los metadatos de fotos (`PhotoModel`) y grabaciones (`RecordingModel`) con sus rutas en el sistema de archivos, fechas y duración. Los archivos físicos se guardan en el directorio de documentos de la app.

**flutter_sound** maneja la grabación de audio en formato AAC, compatible con Android e iOS sin configuración adicional.

> 📸 **Capturas** Vista previa de cámara en tiempo real, solicitud de permiso de cámara, captura de foto con snackbar de confirmación, pantalla del grabador con indicador animado, contador de tiempo durante grabación, galería con grid de fotos, visor de foto a pantalla completa con zoom, reproductor de audio con slider de progreso, selector de tema Guinda/Azul, modo oscuro activado.

<details>
<summary>Ver imagen</summary>
<img width="1038" height="147" alt="image" src="https://github.com/user-attachments/assets/e44c4069-bd8c-487c-bc11-4cd07d912bb9" />
<br />
<img width="518" height="92" alt="image" src="https://github.com/user-attachments/assets/2399fcc6-3b67-4d34-ab0d-e0e0acaf415a" />
<br />
</details>

---

## Pruebas realizadas

| Ejercicio | Plataforma | Resultado |
|---|---|---|
| Ejercicio 1 | macOS en Docker | ✅ |
| Ejercicio 2 | macOS (Swift) | ✅ |
| Ejercicio 3 | Simulador iOS | ✅ |
| Ejercicio 4 — Gestor | Android (Emulador Pixel 7) | ✅ |
| Ejercicio 4 — Cámara | Android (Emulador Pixel 7) | ✅ |

### Dispositivo de prueba (emulador)

| Campo | Valor |
|---|---|
| Dispositivo | Pixel 7 API 34 |
| Android | 14 |
| Resolución | 1080 x 2400 |

---

## Conclusiones

> **

---

## Bibliografía

- Flutter Team. (2024). *Flutter documentation*. https://docs.flutter.dev
- Google. (2024). *Provider package*. https://pub.dev/packages/provider
- Hive Team. (2024). *Hive documentation*. https://docs.hivedb.dev
- Apple Inc. (2024). *AVFoundation Framework*. https://developer.apple.com/av-foundation/
- Android Developers. (2024). *Manage files in shared storage*. https://developer.android.com/training/data-storage/shared
- Huav, G. (2024). *MacOS-Docker*. https://github.com/gabrielhuav/MacOS-Docker
