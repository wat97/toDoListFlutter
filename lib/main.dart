import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todolist/config/constants/app_theme.dart';
import 'package:todolist/core/di/injection.dart';
import 'package:todolist/providers/home_provider.dart';
import 'package:todolist/providers/splash_provider.dart';
import 'package:todolist/ui/page/splash_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await initDI();

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  //

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => HomeProvider()),
        ChangeNotifierProvider(create: (_) => SplashProvider()),
        // Tambahkan provider lain jika ada
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: appTheme,
        title: 'Wat Do',
        home: const SplashScreen(),
      ),
    );
  }
}
