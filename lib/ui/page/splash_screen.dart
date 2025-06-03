import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todolist/providers/splash_provider.dart';
import 'package:todolist/ui/page/home_page.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    final splashProv = Provider.of<SplashProvider>(context, listen: false);
    splashProv.initialize();
    splashProv.addListener(() {
      if (splashProv.isReady) {
        Navigator.of(context).pushReplacement(
          MaterialPageRoute(builder: (_) => const HomePage()),
        );
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [Color(0xFF90CAF9), Color(0xFF1976D2)],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: const [
              Text(
                'Wat Do',
                style: TextStyle(
                  fontSize: 48,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                  letterSpacing: 2,
                  shadows: [
                    Shadow(
                      blurRadius: 12,
                      color: Colors.black26,
                      offset: Offset(2, 4),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 16),
              Text(
                'Wat To Do',
                style: TextStyle(
                  fontSize: 18,
                  color: Colors.white70,
                  fontWeight: FontWeight.w500,
                  letterSpacing: 1.2,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
