import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:voting/core/bloc_providers.dart';
import 'package:voting/core/repository_providers.dart';
import 'package:voting/screens/home_screen.dart';
import 'package:voting/utils/constants.dart';

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    const buttonStyle =
        ButtonStyle(padding: MaterialStatePropertyAll(EdgeInsets.all(18)));

    const elevatedButtonTheme = ElevatedButtonThemeData(style: buttonStyle);
    const outlinedButtonTheme = OutlinedButtonThemeData(style: buttonStyle);
    const textButtonTheme = TextButtonThemeData(style: buttonStyle);

    return RepositoryProviders(
      child: BlocProviders(
        child: MaterialApp(
          title: Constants.appTitle,
          debugShowCheckedModeBanner: false,
          localizationsDelegates: const [
            GlobalMaterialLocalizations.delegate,
            GlobalWidgetsLocalizations.delegate,
            GlobalCupertinoLocalizations.delegate,
          ],
          supportedLocales: const [Locale('pt', 'BR')],
          theme: ThemeData(
            fontFamily: 'Poppins',
            brightness: Brightness.light,
            primarySwatch: Colors.green,
            textButtonTheme: textButtonTheme,
            elevatedButtonTheme: elevatedButtonTheme,
            outlinedButtonTheme: outlinedButtonTheme,
          ),
          routes: {
            HomeScreen.route: (context) => const HomeScreen(),
          },
        ),
      ),
    );
  }
}
