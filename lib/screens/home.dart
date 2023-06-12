import 'package:flutter/material.dart';
import 'package:voting/utils/constants.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text(Constants.appTitle)),
      body: Card(
        margin: EdgeInsets.symmetric(
          vertical: 0,
          horizontal: 8,
        ),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.zero),
      ),
    );
  }
}
