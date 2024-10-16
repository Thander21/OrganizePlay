import 'dart:io';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:path/path.dart' as path;

class VideosPage extends StatefulWidget {
  const VideosPage({Key? key}) : super(key: key); // Added Key? parameter

  @override
  State<VideosPage> createState() => _VideosPageState();
}

class _VideosPageState extends State<VideosPage> {
  List<String> _videoFiles = [];
  String? _selectedDirectory;

  Future<void> _pickDirectory() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles(type: FileType.any); // Changed to pickFiles
    if (result != null) {
      setState(() {
        _selectedDirectory = result.files.single.path;
        _videoFiles = [];
        _scanForVideos();
      });
    } else {
      // User canceled the picker
    }
  }

  Future<void> _scanForVideos() async {
    if (_selectedDirectory == null) return;
    final directory = Directory(_selectedDirectory!);
    try {
      await for (final FileSystemEntity entity in directory.list(recursive: true)) {
        if (entity is File) {
          final extension = path.extension(entity.path).toLowerCase();
          if (extension == '.mp4' || extension == '.mov' || extension == '.avi' || extension == '.mkv' || extension == '.wmv' || extension == '.webm') {
            setState(() {
              _videoFiles.add(entity.path);
            });
          }
        }
      }
    } catch (e) {
      print('Error scanning directory: $e');
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Error accessing directory')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Videos')),
      body: Column(
        children: [
          ElevatedButton(
            onPressed: _pickDirectory,
            child: const Text('Select Directory'),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: _videoFiles.length,
              itemBuilder: (context, index) {
                return ListTile(
                  title: Text(_videoFiles[index]),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
