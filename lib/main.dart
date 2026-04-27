import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:hive_flutter/hive_flutter.dart';

import 'core/theme/theme_provider.dart';
import 'features/camera/domain/photo_model.dart';
import 'features/recorder/domain/recording_model.dart';
import 'features/camera/presentation/screens/camera_screen.dart';
import 'features/recorder/presentation/screens/recorder_screen.dart';
import 'features/gallery/presentation/screens/gallery_screen.dart';
import 'features/camera/presentation/camera_provider.dart';
import 'features/recorder/presentation/recorder_provider.dart';

Future<void> main() async {
  // Necesario antes de llamar cualquier código nativo
  WidgetsFlutterBinding.ensureInitialized();

  // Inicializar base de datos local Hive
  await Hive.initFlutter();

  // Registrar adaptadores ANTES de abrir cualquier caja
  Hive.registerAdapter(PhotoModelAdapter());
  Hive.registerAdapter(RecordingModelAdapter());

  // Abrir las cajas (equivalente a tablas en una base de datos)
  await Hive.openBox<PhotoModel>('photos');
  await Hive.openBox<RecordingModel>('recordings');

  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => ThemeProvider()),
        ChangeNotifierProvider(create: (_) => CameraProvider()),
        ChangeNotifierProvider(create: (_) => RecorderProvider()),
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    // Consumer escucha cambios en ThemeProvider y reconstruye
    // el MaterialApp completo cuando el tema cambia
    return Consumer<ThemeProvider>(
      builder: (context, themeProvider, _) {
        return MaterialApp(
          title: 'Práctica 3 - ESCOM IPN',
          debugShowCheckedModeBanner: false,
          theme: themeProvider.themeData,
          home: const MainNavigation(),
        );
      },
    );
  }
}

// Widget de navegación principal con barra inferior
class MainNavigation extends StatefulWidget {
  const MainNavigation({super.key});

  @override
  State<MainNavigation> createState() => _MainNavigationState();
}

class _MainNavigationState extends State<MainNavigation> {
  int _currentIndex = 0;

  // Las tres pantallas principales de la app
  final List<Widget> _screens = const [
    CameraScreen(),
    RecorderScreen(),
    GalleryScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _screens[_currentIndex],
      bottomNavigationBar: NavigationBar(
        selectedIndex: _currentIndex,
        onDestinationSelected: (index) {
          setState(() => _currentIndex = index);
        },
        destinations: const [
          NavigationDestination(
            icon: Icon(Icons.camera_alt_outlined),
            selectedIcon: Icon(Icons.camera_alt),
            label: 'Cámara',
          ),
          NavigationDestination(
            icon: Icon(Icons.mic_outlined),
            selectedIcon: Icon(Icons.mic),
            label: 'Grabador',
          ),
          NavigationDestination(
            icon: Icon(Icons.photo_library_outlined),
            selectedIcon: Icon(Icons.photo_library),
            label: 'Galería',
          ),
        ],
      ),
    );
  }
}
