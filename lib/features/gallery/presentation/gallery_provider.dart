import 'dart:io';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:audioplayers/audioplayers.dart';
import '../../camera/domain/photo_model.dart';
import '../../recorder/domain/recording_model.dart';

class GalleryProvider extends ChangeNotifier {
  final AudioPlayer _audioPlayer = AudioPlayer();

  List<PhotoModel> _photos = [];
  List<RecordingModel> _recordings = [];
  bool _isPlaying = false;
  String? _currentPlayingId;
  Duration _playPosition = Duration.zero;
  Duration _playDuration = Duration.zero;

  List<PhotoModel> get photos => _photos;
  List<RecordingModel> get recordings => _recordings;
  bool get isPlaying => _isPlaying;
  String? get currentPlayingId => _currentPlayingId;
  Duration get playPosition => _playPosition;
  Duration get playDuration => _playDuration;

  GalleryProvider() {
    _setupAudioListeners();
  }

  void _setupAudioListeners() {
    _audioPlayer.onPlayerStateChanged.listen((state) {
      _isPlaying = state == PlayerState.playing;
      if (state == PlayerState.completed) {
        _currentPlayingId = null;
        _playPosition = Duration.zero;
      }
      notifyListeners();
    });

    _audioPlayer.onPositionChanged.listen((position) {
      _playPosition = position;
      notifyListeners();
    });

    _audioPlayer.onDurationChanged.listen((duration) {
      _playDuration = duration;
      notifyListeners();
    });
  }

  // Carga todas las fotos y grabaciones desde Hive
  void loadAll() {
    final photoBox = Hive.box<PhotoModel>('photos');
    final recordingBox = Hive.box<RecordingModel>('recordings');

    _photos = photoBox.values.toList()
      ..sort((a, b) => b.createdAt.compareTo(a.createdAt));

    _recordings = recordingBox.values.toList()
      ..sort((a, b) => b.createdAt.compareTo(a.createdAt));

    notifyListeners();
  }

  // Eliminar foto
  Future<void> deletePhoto(PhotoModel photo) async {
    try {
      final file = File(photo.filePath);
      if (await file.exists()) await file.delete();
      await photo.delete();
      loadAll();
    } catch (e) {
      debugPrint('Error al eliminar foto: $e');
    }
  }

  // Eliminar grabación
  Future<void> deleteRecording(RecordingModel recording) async {
    try {
      if (_currentPlayingId == recording.id) {
        await _audioPlayer.stop();
        _currentPlayingId = null;
      }
      final file = File(recording.filePath);
      if (await file.exists()) await file.delete();
      await recording.delete();
      loadAll();
    } catch (e) {
      debugPrint('Error al eliminar grabación: $e');
    }
  }

  // Reproducir o pausar grabación
  Future<void> togglePlayRecording(RecordingModel recording) async {
    if (_currentPlayingId == recording.id && _isPlaying) {
      await _audioPlayer.pause();
      return;
    }

    if (_currentPlayingId != recording.id) {
      await _audioPlayer.stop();
      _currentPlayingId = recording.id;
      _playPosition = Duration.zero;
    }

    await _audioPlayer.play(DeviceFileSource(recording.filePath));
  }

  // Buscar posición en la grabación
  Future<void> seekTo(Duration position) async {
    await _audioPlayer.seek(position);
  }

  String formatDuration(Duration d) {
    final minutes = d.inMinutes.remainder(60).toString().padLeft(2, '0');
    final seconds = d.inSeconds.remainder(60).toString().padLeft(2, '0');
    return '$minutes:$seconds';
  }

  @override
  void dispose() {
    _audioPlayer.dispose();
    super.dispose();
  }
}
