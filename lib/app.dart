import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:nextask/pages/introScreen.dart';
import 'package:nextask/theme/themeProvider.dart';
import 'package:provider/provider.dart';

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: context.watch<ThemeProvider>().getTheme(),
      home: Introscreen(),
    );
  }
}
