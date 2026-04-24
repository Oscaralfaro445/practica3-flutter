import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../../core/theme/theme_provider.dart';

class CameraScreen extends StatelessWidget {
  const CameraScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final themeProvider = context.watch<ThemeProvider>();

    return Scaffold(
      appBar: AppBar(
        title: const Text('Cámara'),
        actions: [
          // Botón para alternar claro/oscuro
          IconButton(
            icon: Icon(
                themeProvider.isDarkMode ? Icons.light_mode : Icons.dark_mode),
            onPressed: () => themeProvider.toggleDarkMode(),
            tooltip: 'Cambiar modo',
          ),
          // Menú para cambiar entre Guinda y Azul
          PopupMenuButton<AppThemeMode>(
            icon: const Icon(Icons.palette),
            tooltip: 'Cambiar tema',
            onSelected: (mode) => themeProvider.setTheme(mode),
            itemBuilder: (_) => [
              PopupMenuItem(
                value: AppThemeMode.guinda,
                child: Row(children: [
                  Container(
                      width: 16,
                      height: 16,
                      decoration: const BoxDecoration(
                        color: Color(0xFF6D1130),
                        shape: BoxShape.circle,
                      )),
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
                        color: Color(0xFF003B8E),
                        shape: BoxShape.circle,
                      )),
                  const SizedBox(width: 8),
                  const Text('Azul — ESCOM'),
                ]),
              ),
            ],
          ),
        ],
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.camera_alt,
                size: 80, color: Theme.of(context).colorScheme.primary),
            const SizedBox(height: 16),
            Text('Tema activo: ${themeProvider.themeName}',
                style: Theme.of(context).textTheme.titleMedium),
            const SizedBox(height: 8),
            const Text('Modo: usa los íconos del AppBar para cambiar',
                style: TextStyle(color: Colors.grey)),
          ],
        ),
      ),
    );
  }
}
