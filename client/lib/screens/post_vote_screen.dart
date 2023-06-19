import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';
import 'package:record/record.dart';
import 'package:share_plus/share_plus.dart';
import 'package:voting/utils/constants.dart';
import 'package:voting/utils/utils.dart';

class PostVoteScreen extends StatefulWidget {
  const PostVoteScreen({super.key});

  static const route = '/post-vote';

  @override
  State<PostVoteScreen> createState() => _PostVoteScreenState();
}

class _PostVoteScreenState extends State<PostVoteScreen> {
  final _record = Record();

  var _isRecording = false;
  String? _recordingPath;

  Widget _getContent(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Expanded(
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Text(
                    'Seu voto foi registrado com sucesso!',
                    style: Theme.of(context).textTheme.titleLarge,
                  ),
                  const SizedBox(height: 16),
                  const Text(
                    'Seu voto foi coletado e armazenado junto aos dados informados.',
                  ),
                  const SizedBox(height: 8),
                  const Text(
                    'Ele será utilizado para a geração de métricas, que podem ser visualizadas na tela de resultados na página inicial do aplicativo.',
                  ),
                  const SizedBox(height: 8),
                  const Text(
                    'Caso queira, você pode gravar uma mensagem de voz explicando o motivo de seu voto e compartilhá-lo em suas redes sociais.',
                  ),
                  const SizedBox(height: 64),
                  Center(
                    child: IconButton(
                      tooltip: _isRecording
                          ? 'Parar gravação'
                          : 'Gravar mensagem de voz',
                      onPressed: () async {
                        if (_isRecording) {
                          final recordingPath = await _record.stop();

                          setState(() {
                            _isRecording = false;
                            _recordingPath = recordingPath;
                          });
                        } else {
                          final hasPermission = await _record.hasPermission();

                          if (!hasPermission) {
                            if (mounted) {
                              await Utils.showDefaultDialog(
                                context: context,
                                content:
                                    'Habilite ou permita o acesso do aplicativo ao serviço microfone e tente novamente.',
                              );
                            }

                            return;
                          }

                          final directory = await getTemporaryDirectory();

                          await _record.start(
                            encoder: AudioEncoder.wav,
                            path: '${directory.path}\\note.wav',
                            bitRate: 128000,
                            samplingRate: 48000,
                          );

                          setState(() {
                            _isRecording = true;
                          });
                        }
                      },
                      icon: _isRecording
                          ? const Icon(Icons.pause_rounded, color: Colors.green)
                          : const Icon(Icons.volume_up_rounded),
                    ),
                  ),
                  const SizedBox(height: 64),
                  Center(
                    child: IconButton(
                      tooltip: 'Compartilhar gravação',
                      onPressed: _recordingPath == null || _isRecording
                          ? null
                          : () async {
                              await Share.shareXFiles(
                                [XFile(_recordingPath!)],
                                text: 'Meu voto.',
                              );
                            },
                      icon: const Icon(Icons.share_rounded),
                    ),
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(height: 32),
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Expanded(child: Container()),
              const SizedBox(width: 16),
              Expanded(
                child: ElevatedButton(
                  onPressed: () async {
                    await Navigator.of(context).maybePop();
                  },
                  child: const Text('VOLTAR'),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text(Constants.appTitle)),
      body: Align(
        alignment: Alignment.topCenter,
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 1200),
          child: Card(
            margin: const EdgeInsets.symmetric(horizontal: 16),
            shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.zero,
            ),
            child: _getContent(context),
          ),
        ),
      ),
    );
  }
}
