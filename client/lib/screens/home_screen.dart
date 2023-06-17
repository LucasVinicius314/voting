import 'package:flutter/material.dart';
import 'package:voting/utils/constants.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  static const route = '/';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text(Constants.appTitle)),
      body: const Card(
        margin: EdgeInsets.symmetric(horizontal: 16),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.zero),
        child: Padding(
          padding: EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Text(
                'Do tempor deserunt sint ex esse enim enim minim. Elit culpa sit dolore consectetur mollit incididunt adipisicing commodo enim veniam qui. Magna amet non tempor aliqua nulla in consectetur minim qui aute. Voluptate occaecat exercitation veniam eiusmod. Quis pariatur et id consectetur minim amet excepteur laboris voluptate incididunt est. Lorem aute veniam irure proident nulla aliquip culpa nisi consequat. Dolor deserunt ex nulla voluptate quis pariatur consectetur et ad laboris cupidatat culpa culpa.',
              ),
            ],
          ),
        ),
      ),
    );
  }
}
