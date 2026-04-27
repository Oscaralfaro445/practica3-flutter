import 'dart:io';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import '../../../../features/camera/domain/photo_model.dart';
import '../../../../features/recorder/domain/recording_model.dart';
import '../gallery_provider.dart';

class GalleryScreen extends StatefulWidget {
  const GalleryScreen({super.key});

  @override
  State<GalleryScreen> createState() => _GalleryScreenState();
}

class _GalleryScreenState extends State<GalleryScreen>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
    // Cargar datos cada vez que se entra a la pantalla
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<GalleryProvider>().loadAll();
    });
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Galería'),
        bottom: TabBar(
          controller: _tabController,
          tabs: const [
            Tab(icon: Icon(Icons.photo), text: 'Fotos'),
            Tab(icon: Icon(Icons.mic), text: 'Grabaciones'),
          ],
        ),
      ),
      body: TabBarView(
        controller: _tabController,
        children: const [
          _PhotosTab(),
          _RecordingsTab(),
        ],
      ),
    );
  }
}

// ── Tab de fotos ─────────────────────────────────────────────
class _PhotosTab extends StatelessWidget {
  const _PhotosTab();

  @override
  Widget build(BuildContext context) {
    final provider = context.watch<GalleryProvider>();
    final photos = provider.photos;

    if (photos.isEmpty) {
      return const Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.photo_library_outlined, size: 80, color: Colors.grey),
            SizedBox(height: 16),
            Text('No hay fotos todavía',
                style: TextStyle(fontSize: 18, color: Colors.grey)),
            SizedBox(height: 8),
            Text('Toma una foto desde la pestaña Cámara',
                style: TextStyle(color: Colors.grey)),
          ],
        ),
      );
    }

    return GridView.builder(
      padding: const EdgeInsets.all(4),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 3,
        crossAxisSpacing: 4,
        mainAxisSpacing: 4,
      ),
      itemCount: photos.length,
      itemBuilder: (context, index) {
        return _PhotoTile(photo: photos[index]);
      },
    );
  }
}

class _PhotoTile extends StatelessWidget {
  final PhotoModel photo;
  const _PhotoTile({required this.photo});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => _showPhotoDetail(context),
      onLongPress: () => _confirmDelete(context),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(4),
        child: Image.file(
          File(photo.filePath),
          fit: BoxFit.cover,
          errorBuilder: (_, __, ___) => Container(
            color: Colors.grey[300],
            child: const Icon(Icons.broken_image, color: Colors.grey),
          ),
        ),
      ),
    );
  }

  void _showPhotoDetail(BuildContext context) {
    Navigator.of(context).push(MaterialPageRoute(
      builder: (_) => _PhotoDetailScreen(photo: photo),
    ));
  }

  void _confirmDelete(BuildContext context) {
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        title: const Text('Eliminar foto'),
        content: const Text('¿Estás seguro de que quieres eliminar esta foto?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(ctx),
            child: const Text('Cancelar'),
          ),
          TextButton(
            onPressed: () {
              context.read<GalleryProvider>().deletePhoto(photo);
              Navigator.pop(ctx);
            },
            style: TextButton.styleFrom(foregroundColor: Colors.red),
            child: const Text('Eliminar'),
          ),
        ],
      ),
    );
  }
}

// ── Pantalla de detalle de foto ──────────────────────────────
class _PhotoDetailScreen extends StatelessWidget {
  final PhotoModel photo;
  const _PhotoDetailScreen({required this.photo});

  @override
  Widget build(BuildContext context) {
    final dateStr = DateFormat('dd/MM/yyyy HH:mm').format(photo.createdAt);

    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.black,
        foregroundColor: Colors.white,
        title: Text(dateStr, style: const TextStyle(fontSize: 14)),
        actions: [
          IconButton(
            icon: const Icon(Icons.delete, color: Colors.red),
            onPressed: () {
              context.read<GalleryProvider>().deletePhoto(photo);
              Navigator.pop(context);
            },
          ),
        ],
      ),
      body: Center(
        child: InteractiveViewer(
          child: Image.file(File(photo.filePath)),
        ),
      ),
    );
  }
}

// ── Tab de grabaciones ───────────────────────────────────────
class _RecordingsTab extends StatelessWidget {
  const _RecordingsTab();

  @override
  Widget build(BuildContext context) {
    final provider = context.watch<GalleryProvider>();
    final recordings = provider.recordings;

    if (recordings.isEmpty) {
      return const Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.mic_none, size: 80, color: Colors.grey),
            SizedBox(height: 16),
            Text('No hay grabaciones todavía',
                style: TextStyle(fontSize: 18, color: Colors.grey)),
            SizedBox(height: 8),
            Text('Graba audio desde la pestaña Grabador',
                style: TextStyle(color: Colors.grey)),
          ],
        ),
      );
    }

    return ListView.builder(
      padding: const EdgeInsets.all(8),
      itemCount: recordings.length,
      itemBuilder: (context, index) {
        return _RecordingTile(recording: recordings[index]);
      },
    );
  }
}

class _RecordingTile extends StatelessWidget {
  final RecordingModel recording;
  const _RecordingTile({required this.recording});

  @override
  Widget build(BuildContext context) {
    final provider = context.watch<GalleryProvider>();
    final isCurrentlyPlaying =
        provider.currentPlayingId == recording.id && provider.isPlaying;
    final isCurrentTrack = provider.currentPlayingId == recording.id;
    final colorScheme = Theme.of(context).colorScheme;
    final dateStr = DateFormat('dd/MM/yyyy HH:mm').format(recording.createdAt);

    return Card(
      margin: const EdgeInsets.symmetric(vertical: 4, horizontal: 4),
      child: Padding(
        padding: const EdgeInsets.all(12),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                // Botón play/pause
                CircleAvatar(
                  backgroundColor: colorScheme.primary,
                  child: IconButton(
                    icon: Icon(
                      isCurrentlyPlaying ? Icons.pause : Icons.play_arrow,
                      color: Colors.white,
                    ),
                    onPressed: () => provider.togglePlayRecording(recording),
                  ),
                ),
                const SizedBox(width: 12),

                // Título y fecha
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        recording.title ?? 'Grabación sin título',
                        style: const TextStyle(fontWeight: FontWeight.bold),
                        overflow: TextOverflow.ellipsis,
                      ),
                      Text(dateStr,
                          style: const TextStyle(
                              fontSize: 12, color: Colors.grey)),
                    ],
                  ),
                ),

                // Duración y botón eliminar
                Text(
                  provider.formatDuration(
                      Duration(seconds: recording.durationSeconds)),
                  style: const TextStyle(color: Colors.grey),
                ),
                IconButton(
                  icon: const Icon(Icons.delete_outline, color: Colors.red),
                  onPressed: () => _confirmDelete(context, provider),
                ),
              ],
            ),

            // Barra de progreso (solo si es la pista actual)
            if (isCurrentTrack) ...[
              const SizedBox(height: 8),
              SliderTheme(
                data: SliderTheme.of(context).copyWith(
                  trackHeight: 3,
                  thumbShape:
                      const RoundSliderThumbShape(enabledThumbRadius: 6),
                ),
                child: Slider(
                  value: provider.playPosition.inSeconds.toDouble(),
                  max: provider.playDuration.inSeconds > 0
                      ? provider.playDuration.inSeconds.toDouble()
                      : 1,
                  onChanged: (value) =>
                      provider.seekTo(Duration(seconds: value.toInt())),
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(provider.formatDuration(provider.playPosition),
                      style: const TextStyle(fontSize: 11, color: Colors.grey)),
                  Text(provider.formatDuration(provider.playDuration),
                      style: const TextStyle(fontSize: 11, color: Colors.grey)),
                ],
              ),
            ],
          ],
        ),
      ),
    );
  }

  void _confirmDelete(BuildContext context, GalleryProvider provider) {
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        title: const Text('Eliminar grabación'),
        content: const Text('¿Quieres eliminar esta grabación?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(ctx),
            child: const Text('Cancelar'),
          ),
          TextButton(
            onPressed: () {
              provider.deleteRecording(recording);
              Navigator.pop(ctx);
            },
            style: TextButton.styleFrom(foregroundColor: Colors.red),
            child: const Text('Eliminar'),
          ),
        ],
      ),
    );
  }
}
