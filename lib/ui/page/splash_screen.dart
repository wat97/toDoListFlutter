import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todolist/providers/splash_provider.dart';
import 'package:todolist/ui/page/home_page.dart';
import 'package:todolist/core/services/update_service.dart';

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
    splashProv.addListener(() async {
      if (splashProv.isReady) {
        // Check for Play Store updates on Android before navigating.
        if (!mounted) return;
        await checkAndPromptUpdate(context);
        if (!mounted) return;
        Navigator.of(context).pushReplacement(
          MaterialPageRoute(builder: (_) => const HomePage()),
        );
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF1976D2),
      body: LayoutBuilder(
        builder: (context, constraints) {
          final isWide = constraints.maxWidth > 700;
          return Center(
            child: Container(
              constraints: const BoxConstraints(maxWidth: 420),
              padding: isWide
                  ? const EdgeInsets.symmetric(vertical: 48, horizontal: 32)
                  : const EdgeInsets.symmetric(vertical: 32, horizontal: 16),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(32),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.10),
                    blurRadius: 32,
                    offset: const Offset(0, 12),
                  ),
                ],
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  // App icon
                  Container(
                    width: 96,
                    height: 96,
                    decoration: const BoxDecoration(
                      borderRadius: BorderRadius.all(Radius.circular(24)),
                      color: Color(0xFF90CAF9),
                    ),
                    child: const Padding(
                      padding: EdgeInsets.all(16.0),
                      child: Image(
                        image: AssetImage('assets/app_icon.png'),
                        fit: BoxFit.contain,
                      ),
                    ),
                  ),
                  const SizedBox(height: 24),
                  const Text(
                    'Wat Do',
                    style: TextStyle(
                      fontSize: 44,
                      fontWeight: FontWeight.bold,
                      color: Color(0xFF1976D2),
                      letterSpacing: 2,
                      shadows: [
                        Shadow(
                          blurRadius: 8,
                          color: Colors.black12,
                          offset: Offset(2, 4),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 12),
                  const Text(
                    'Wat To Do',
                    style: TextStyle(
                      fontSize: 18,
                      color: Color(0xFF1976D2),
                      fontWeight: FontWeight.w500,
                      letterSpacing: 1.2,
                    ),
                  ),
                  const SizedBox(height: 32),
                  // Optionally, add a loading indicator
                  const CircularProgressIndicator(
                    valueColor:
                        AlwaysStoppedAnimation<Color>(Color(0xFF1976D2)),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
