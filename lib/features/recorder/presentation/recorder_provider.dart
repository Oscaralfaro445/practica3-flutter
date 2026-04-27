import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_sound/flutter_sound.dart';
import 'package:hive/hive.dart';
import 'package:path_provider/path_provider.dart';
import 'package:uuid/uuid.dart';
import '../domain/recording_model.dart';

class RecorderProvider extends ChangeNotifier {
  final FlutterSoundRecorder _recorder = FlutterSoundRecorder();
  final FlutterSoundPlayer _player = FlutterSoundPlayer();

  bool _isRecorderReady = false;
  bool _isRecording = false;
  bool _isPlaying = false;
  Duration _recordingDuration = Duration.zero;
  String? _currentRecordingPath;
  String? _errorMessage;

  bool get isRecording => _isRecording;
  bool get isPlaying => _isPlaying;
  bool get isRecorderReady => _isRecorderReady;
  Duration get recordingDuration => _recordingDuration;
  String? get errorMessage => _errorMessage;

  Future<void> init() async {
    try {
      await _recorder.openRecorder();
      await _player.openPlayer();
      _isRecorderReady = true;

      // Actualizar duración cada segundo mientras graba
      _recorder.onProgress!.listen((e) {
        _recordingDuration = e.duration;
        notifyListeners();
      });
      await _recorder.setSubscriptionDuration(const Duration(seconds: 1));
    } catch (e) {
      _errorMessage = 'Error al inicializar grabador: $e';
    }
    notifyListeners();
  }

  Future<void> startRecording() async {
    if (!_isRecorderReady) return;

    try {
      final Directory appDir = await getApplicationDocumentsDirectory();
      final String recordingsDir = '${appDir.path}/recordings';
      await Directory(recordingsDir).create(recursive: true);

      final String id = const Uuid().v4();
      _currentRecordingPath = '$recordingsDir/$id.aac';
      _recordingDuration = Duration.zero;

      await _recorder.startRecorder(
        toFile: _currentRecordingPath,
        codec: Codec.aacADTS,
      );

      _isRecording = true;
      _errorMessage = null;
    } catch (e) {
      _errorMessage = 'Error al iniciar grabación: $e';
    }
    notifyListeners();
  }

  Future<RecordingModel?> stopRecording() async {
    if (!_isRecording) return null;

    try {
      await _recorder.stopRecorder();
      _isRecording = false;

      if (_currentRecordingPath == null) return null;

      final recording = RecordingModel(
        id: const Uuid().v4(),
        filePath: _currentRecordingPath!,
        createdAt: DateTime.now(),
        durationSeconds: _recordingDuration.inSeconds,
        title: 'Grabación ${DateTime.now().toString().substring(0, 16)}',
      );

      final box = Hive.box<RecordingModel>('recordings');
      await box.put(recording.id, recording);

      notifyListeners();
      return recording;
    } catch (e) {
      _errorMessage = 'Error al detener grabación: $e';
      notifyListeners();
      return null;
    }
  }

  Future<void> playRecording(String filePath) async {
    if (_isPlaying) {
      await _player.stopPlayer();
      _isPlaying = false;
      notifyListeners();
      return;
    }

    try {
      await _player.startPlayer(
        fromURI: filePath,
        codec: Codec.aacADTS,
        whenFinished: () {
          _isPlaying = false;
          notifyListeners();
        },
      );
      _isPlaying = true;
    } catch (e) {
      _errorMessage = 'Error al reproducir: $e';
    }
    notifyListeners();
  }

  @override
  void dispose() {
    _recorder.closeRecorder();
    _player.closePlayer();
    super.dispose();
  }
}
