import 'dart:io';
import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:path_provider/path_provider.dart';
import 'package:uuid/uuid.dart';
import '../domain/photo_model.dart';

class CameraProvider extends ChangeNotifier {
  CameraController? _controller;
  List<CameraDescription> _cameras = [];
  bool _isInitialized = false;
  bool _isCapturing = false;
  String? _errorMessage;
  int _currentCameraIndex = 0;

  CameraController? get controller => _controller;
  bool get isInitialized => _isInitialized;
  bool get isCapturing => _isCapturing;
  String? get errorMessage => _errorMessage;
  bool get hasMultipleCameras => _cameras.length > 1;

  // Inicializa la cámara — llámalo desde initState de la pantalla
  Future<void> initCamera() async {
    try {
      _cameras = await availableCameras();
      if (_cameras.isEmpty) {
        _errorMessage = 'No se encontró ninguna cámara en el dispositivo';
        notifyListeners();
        return;
      }
      await _startCamera(_cameras[_currentCameraIndex]);
    } catch (e) {
      _errorMessage = 'Error al inicializar la cámara: $e';
      notifyListeners();
    }
  }

  Future<void> _startCamera(CameraDescription camera) async {
    _isInitialized = false;
    notifyListeners();

    _controller = CameraController(
      camera,
      ResolutionPreset.high,
      enableAudio: false,
    );

    try {
      await _controller!.initialize();
      _isInitialized = true;
      _errorMessage = null;
    } catch (e) {
      _errorMessage = 'Error al iniciar la cámara: $e';
    }
    notifyListeners();
  }

  // Alterna entre cámara frontal y trasera
  Future<void> switchCamera() async {
    if (_cameras.length < 2) return;
    _currentCameraIndex = (_currentCameraIndex + 1) % _cameras.length;
    await _controller?.dispose();
    await _startCamera(_cameras[_currentCameraIndex]);
  }

  // Captura una foto y la guarda en Hive
  Future<PhotoModel?> takePicture() async {
    if (!_isInitialized || _isCapturing) return null;

    _isCapturing = true;
    notifyListeners();

    try {
      final XFile file = await _controller!.takePicture();

      // Copiar a directorio permanente de la app
      final Directory appDir = await getApplicationDocumentsDirectory();
      final String photosDir = '${appDir.path}/photos';
      await Directory(photosDir).create(recursive: true);

      final String id = const Uuid().v4();
      final String permanentPath = '$photosDir/$id.jpg';
      await File(file.path).copy(permanentPath);

      // Guardar metadata en Hive
      final photo = PhotoModel(
        id: id,
        filePath: permanentPath,
        createdAt: DateTime.now(),
      );

      final box = Hive.box<PhotoModel>('photos');
      await box.put(id, photo);

      return photo;
    } catch (e) {
      _errorMessage = 'Error al capturar foto: $e';
      return null;
    } finally {
      _isCapturing = false;
      notifyListeners();
    }
  }

  // Liberar recursos cuando la pantalla se cierra
  @override
  void dispose() {
    _controller?.dispose();
    super.dispose();
  }
}
