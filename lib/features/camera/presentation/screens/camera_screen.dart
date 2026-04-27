import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:provider/provider.dart';
import '../../../../core/theme/theme_provider.dart';
import '../camera_provider.dart';

class CameraScreen extends StatefulWidget {
  const CameraScreen({super.key});

  @override
  State<CameraScreen> createState() => _CameraScreenState();
}

class _CameraScreenState extends State<CameraScreen> {
  bool _permissionGranted = false;

  @override
  void initState() {
    super.initState();
    _requestPermissionAndInit();
  }

  Future<void> _requestPermissionAndInit() async {
    final status = await Permission.camera.request();
    if (status.isGranted) {
      setState(() => _permissionGranted = true);
      if (mounted) {
        await context.read<CameraProvider>().initCamera();
      }
    } else {
      setState(() => _permissionGranted = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    final themeProvider = context.watch<ThemeProvider>();
    final cameraProvider = context.watch<CameraProvider>();

    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        title: const Text('Cámara'),
        backgroundColor: Colors.black,
        foregroundColor: Colors.white,
        actions: [
          IconButton(
            icon: Icon(
                themeProvider.isDarkMode ? Icons.light_mode : Icons.dark_mode),
            onPressed: () => themeProvider.toggleDarkMode(),
          ),
          PopupMenuButton<AppThemeMode>(
            icon: const Icon(Icons.palette),
            onSelected: (mode) => themeProvider.setTheme(mode),
            itemBuilder: (_) => [
              PopupMenuItem(
                value: AppThemeMode.guinda,
                child: Row(children: [
                  Container(
                      width: 16,
                      height: 16,
                      decoration: const BoxDecoration(
                          color: Color(0xFF6D1130), shape: BoxShape.circle)),
                  const SizedBox(width: 8),
                  const Text('Guinda — IPN'),
                ]),
              ),
              PopupMenuItem(
                value: AppThemeMode.azul,
                child: Row(children: [
                  Container(
                      width: 16,
                      height: 16,
                      decoration: const BoxDecoration(
                          color: Color(0xFF003B8E), shape: BoxShape.circle)),
                  const SizedBox(width: 8),
                  const Text('Azul — ESCOM'),
                ]),
              ),
            ],
          ),
        ],
      ),
      body: _buildBody(cameraProvider),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: _buildCaptureButton(cameraProvider),
    );
  }

  Widget _buildBody(CameraProvider provider) {
    if (!_permissionGranted) {
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(Icons.camera_alt, size: 80, color: Colors.white54),
            const SizedBox(height: 16),
            const Text('Permiso de cámara requerido',
                style: TextStyle(color: Colors.white, fontSize: 18)),
            const SizedBox(height: 8),
            ElevatedButton(
              onPressed: _requestPermissionAndInit,
              child: const Text('Conceder permiso'),
            ),
          ],
        ),
      );
    }

    if (provider.errorMessage != null) {
      return Center(
        child: Text(provider.errorMessage!,
            style: const TextStyle(color: Colors.red)),
      );
    }

    if (!provider.isInitialized) {
      return const Center(
        child: CircularProgressIndicator(color: Colors.white),
      );
    }

    return Stack(
      children: [
        // Vista previa de la cámara ocupando toda la pantalla
        Positioned.fill(
          child: CameraPreview(provider.controller!),
        ),

        // Botón para cambiar cámara (arriba a la derecha)
        if (provider.hasMultipleCameras)
          Positioned(
            top: 16,
            right: 16,
            child: CircleAvatar(
              backgroundColor: Colors.black45,
              child: IconButton(
                icon:
                    const Icon(Icons.flip_camera_android, color: Colors.white),
                onPressed: () => provider.switchCamera(),
              ),
            ),
          ),

        // Indicador de captura
        if (provider.isCapturing)
          Container(
            color: Colors.white24,
            child: const Center(
              child: CircularProgressIndicator(color: Colors.white),
            ),
          ),
      ],
    );
  }

  Widget? _buildCaptureButton(CameraProvider provider) {
    if (!_permissionGranted || !provider.isInitialized) return null;

    return GestureDetector(
      onTap: () async {
        final photo = await provider.takePicture();
        if (photo != null && mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text('Foto guardada en la galería'),
              duration: Duration(seconds: 2),
              backgroundColor: Colors.green,
            ),
          );
        }
      },
      child: Container(
        width: 72,
        height: 72,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          border: Border.all(color: Colors.white, width: 4),
          color: Colors.white24,
        ),
        child: const Icon(Icons.camera, color: Colors.white, size: 36),
      ),
    );
  }
}
