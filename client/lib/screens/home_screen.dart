import 'package:flutter/material.dart';
import 'package:voting/screens/results_screen.dart';
import 'package:voting/screens/vote_screen.dart';
import 'package:voting/utils/constants.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  static const route = '/';

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
                    'Olá!',
                    style: Theme.of(context).textTheme.titleLarge,
                  ),
                  const SizedBox(height: 16),
                  RichText(
                    text: TextSpan(
                      style: Theme.of(context).textTheme.bodyMedium,
                      children: const [
                        TextSpan(text: 'Seja bem-vindo(a) ao '),
                        TextSpan(
                          text: Constants.appTitle,
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                        TextSpan(text: '.'),
                      ],
                    ),
                  ),
                  const SizedBox(height: 16),
                  const Text('Para continuar, escolha uma das opções abaixo:'),
                ],
              ),
            ),
          ),
          const SizedBox(height: 32),
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Expanded(
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.blue,
                  ),
                  onPressed: () async {
                    await Navigator.of(context).pushNamed(ResultsScreen.route);
                  },
                  child: const Text('CONFERIR RESULTADOS'),
                ),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: ElevatedButton(
                  onPressed: () async {
                    await Navigator.of(context).pushNamed(VoteScreen.route);
                  },
                  child: const Text('VOTAR'),
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
