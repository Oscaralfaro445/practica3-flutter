import 'package:flutter/material.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:provider/provider.dart';
import '../recorder_provider.dart';

class RecorderScreen extends StatefulWidget {
  const RecorderScreen({super.key});

  @override
  State<RecorderScreen> createState() => _RecorderScreenState();
}

class _RecorderScreenState extends State<RecorderScreen> {
  bool _permissionGranted = false;

  @override
  void initState() {
    super.initState();
    _requestPermissionAndInit();
  }

  Future<void> _requestPermissionAndInit() async {
    final status = await Permission.microphone.request();
    if (status.isGranted) {
      setState(() => _permissionGranted = true);
      if (mounted) {
        await context.read<RecorderProvider>().init();
      }
    } else {
      setState(() => _permissionGranted = false);
    }
  }

  String _formatDuration(Duration d) {
    final minutes = d.inMinutes.remainder(60).toString().padLeft(2, '0');
    final seconds = d.inSeconds.remainder(60).toString().padLeft(2, '0');
    return '$minutes:$seconds';
  }

  @override
  Widget build(BuildContext context) {
    final provider = context.watch<RecorderProvider>();
    final colorScheme = Theme.of(context).colorScheme;

    return Scaffold(
      appBar: AppBar(title: const Text('Grabador de audio')),
      body: !_permissionGranted
          ? Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Icon(Icons.mic_off, size: 80, color: Colors.grey),
                  const SizedBox(height: 16),
                  const Text('Permiso de micrófono requerido',
                      style: TextStyle(fontSize: 18)),
                  const SizedBox(height: 8),
                  ElevatedButton(
                    onPressed: _requestPermissionAndInit,
                    child: const Text('Conceder permiso'),
                  ),
                ],
              ),
            )
          : Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                // Indicador visual de grabación
                AnimatedContainer(
                  duration: const Duration(milliseconds: 300),
                  width: provider.isRecording ? 140 : 120,
                  height: provider.isRecording ? 140 : 120,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: provider.isRecording
                        ? colorScheme.primary.withOpacity(0.15)
                        : Colors.grey.withOpacity(0.1),
                    border: Border.all(
                      color: provider.isRecording
                          ? colorScheme.primary
                          : Colors.grey,
                      width: 3,
                    ),
                  ),
                  child: Icon(
                    provider.isRecording ? Icons.mic : Icons.mic_none,
                    size: 60,
                    color: provider.isRecording
                        ? colorScheme.primary
                        : Colors.grey,
                  ),
                ),

                const SizedBox(height: 32),

                // Contador de tiempo
                Text(
                  _formatDuration(provider.recordingDuration),
                  style: Theme.of(context).textTheme.displayMedium?.copyWith(
                        fontWeight: FontWeight.bold,
                        color: provider.isRecording
                            ? colorScheme.primary
                            : Colors.grey,
                      ),
                ),

                const SizedBox(height: 8),
                Text(
                  provider.isRecording ? 'Grabando...' : 'Listo para grabar',
                  style: TextStyle(
                    color: provider.isRecording
                        ? colorScheme.primary
                        : Colors.grey,
                  ),
                ),

                const SizedBox(height: 48),

                // Botón principal de grabar/detener
                ElevatedButton.icon(
                  onPressed: () async {
                    if (provider.isRecording) {
                      final recording = await provider.stopRecording();
                      if (recording != null && mounted) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content:
                                Text('Grabación guardada: ${recording.title}'),
                            backgroundColor: Colors.green,
                          ),
                        );
                      }
                    } else {
                      await provider.startRecording();
                    }
                  },
                  icon: Icon(provider.isRecording
                      ? Icons.stop
                      : Icons.fiber_manual_record),
                  label: Text(
                      provider.isRecording ? 'Detener' : 'Iniciar grabación'),
                  style: ElevatedButton.styleFrom(
                    backgroundColor:
                        provider.isRecording ? Colors.red : colorScheme.primary,
                    foregroundColor: Colors.white,
                    padding: const EdgeInsets.symmetric(
                        horizontal: 32, vertical: 16),
                    textStyle: const TextStyle(fontSize: 18),
                  ),
                ),

                if (provider.errorMessage != null) ...[
                  const SizedBox(height: 16),
                  Text(provider.errorMessage!,
                      style: const TextStyle(color: Colors.red)),
                ],
              ],
            ),
    );
  }
}
