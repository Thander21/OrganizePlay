import 'package:flutter/material.dart';
import 'videos.dart'; // Corrected import statement

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _loadPage();
  }

  Future<void> _loadPage() async {
    await Future.delayed(const Duration(seconds: 3)); // Simulate loading
    setState(() {
      _isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: _isLoading
          ? const Center(child: CircularProgressIndicator())
          : const VideosPage(),
    );
  }
}
