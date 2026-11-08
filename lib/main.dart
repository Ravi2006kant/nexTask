import 'package:flutter/material.dart';
import 'package:nextask/taskProvider.dart';
import 'package:nextask/theme/themeProvider.dart';
import 'package:provider/provider.dart';
import 'app.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => ThemeProvider()),
        ChangeNotifierProvider(create: (_) => TaskProvider()),
      ],
      child: const App(),
    ),
  );
}
