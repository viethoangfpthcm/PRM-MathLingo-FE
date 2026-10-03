import 'package:flutter/material.dart';
import 'core/theme/app_theme.dart';
import 'state/app_state.dart';
import 'ui/screens/home_scaffold.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const MathLingoApp());
}

class MathLingoApp extends StatefulWidget {
  const MathLingoApp({super.key});

  @override
  State<MathLingoApp> createState() => _MathLingoAppState();
}

class _MathLingoAppState extends State<MathLingoApp> {
  final AppState _appState = AppState();

  @override
  void dispose() {
    _appState.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ListenableBuilder(
      listenable: _appState,
      builder: (context, child) {
        return MaterialApp(
          title: 'MathLingo Prototype',
          debugShowCheckedModeBanner: false,
          theme: AppTheme.lightTheme,
          home: HomeScaffold(appState: _appState),
        );
      },
    );
  }
}
