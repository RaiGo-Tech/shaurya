import 'package:flutter/material.dart';

import 'core/theme/app_theme.dart';
import 'features/auth/login_page.dart';

void main() => runApp(const ShauryaApp());

class ShauryaApp extends StatefulWidget {
  const ShauryaApp({super.key});

  @override
  State<ShauryaApp> createState() => _ShauryaAppState();
}

class _ShauryaAppState extends State<ShauryaApp> {
  ThemeMode _themeMode = ThemeMode.light;

  void _setDarkMode(bool dark) =>
      setState(() => _themeMode = dark ? ThemeMode.dark : ThemeMode.light);

  @override
  Widget build(BuildContext context) => MaterialApp(
    debugShowCheckedModeBanner: false,
    title: 'Shaurya — National Learning',
    theme: AppTheme.light(),
    darkTheme: AppTheme.dark(),
    themeMode: _themeMode,
    home: LoginPage(onDarkModeChanged: _setDarkMode),
  );
}
