import 'dart:io';

import 'package:flutter/material.dart';
import 'package:google_mlkit_text_recognition/google_mlkit_text_recognition.dart';
import 'package:image_picker/image_picker.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(home: TextExtractScreen());
  }
}

class TextExtractScreen extends StatefulWidget {
  const TextExtractScreen({super.key});

  @override
  State<TextExtractScreen> createState() => _TextExtractScreenState();
}

class _TextExtractScreenState extends State<TextExtractScreen> {
  File? _imageFile;
  String? _pickedText;
  bool _loading = false;

  Future<void> _pickImageAndExtract() async {
    final picker = ImagePicker();
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);
    // use ImageSource.camera if you want the camera instead

    if (pickedFile == null) return;

    setState(() {
      _imageFile = File(pickedFile.path);
      _loading = true;
      _pickedText = null;
    });

    final lines = await _extractLines(pickedFile.path);

    setState(() => _loading = false);

    if (lines.isEmpty) {
      if (!mounted) return;
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(const SnackBar(content: Text('No text found in image')));
      return;
    }

    if (!mounted) return;
    final selected = await _showTextPickerDialog(lines);

    if (selected != null) {
      setState(() => _pickedText = selected);
    }
  }

  Future<List<String>> _extractLines(String imagePath) async {
    final inputImage = InputImage.fromFilePath(imagePath);
    final recognizer = TextRecognizer(script: TextRecognitionScript.latin);

    final result = await recognizer.processImage(inputImage);
    recognizer.close();

    List<String> lines = [];
    for (var block in result.blocks) {
      for (var line in block.lines) {
        lines.add(line.text);
      }
    }
    return lines;
  }

  Future<String?> _showTextPickerDialog(List<String> lines) {
    return showDialog<String>(
      context: context,
      builder: (context) => SimpleDialog(
        title: const Text('Select text'),
        children: lines.map((text) {
          return SimpleDialogOption(
            onPressed: () => Navigator.pop(context, text),
            child: Text(text),
          );
        }).toList(),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Extract Text from Image')),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            ElevatedButton(
              onPressed: _loading ? null : _pickImageAndExtract,
              child: Text(
                _loading ? 'Processing...' : 'Pick Image & Extract Text',
              ),
            ),
            const SizedBox(height: 16),
            if (_imageFile != null) Image.file(_imageFile!, height: 200),
            const SizedBox(height: 16),
            if (_pickedText != null)
              Card(
                child: Padding(
                  padding: const EdgeInsets.all(12),
                  child: Text(
                    'Picked text:\n$_pickedText',
                    style: const TextStyle(fontSize: 16),
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }
}

// this is just testing project which are using for devops testing

// but you can also use webhook for this
