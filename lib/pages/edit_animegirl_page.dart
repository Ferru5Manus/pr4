import 'package:flutter/material.dart';
import 'package:file_picker/file_picker.dart';
import 'dart:io';
import '../model/animegirl.dart';

class EditAnimeGirlPage extends StatefulWidget {
  final AnimeGirl? animeGirl;
  final Function(AnimeGirl) onSave;

  const EditAnimeGirlPage({super.key, this.animeGirl, required this.onSave});

  @override
  _EditAnimeGirlPageState createState() => _EditAnimeGirlPageState();
}

class _EditAnimeGirlPageState extends State<EditAnimeGirlPage> {
  late TextEditingController _nameController;
  late TextEditingController _descriptionController;
  late TextEditingController _imagePathController;

  File? _selectedImage;

  @override
  void initState() {
    super.initState();
    _nameController = TextEditingController(text: widget.animeGirl?.name ?? '');
    _descriptionController = TextEditingController(text: widget.animeGirl?.description ?? '');
    _imagePathController = TextEditingController(text: widget.animeGirl?.imagePath ?? '');
  }

  @override
  void dispose() {
    _nameController.dispose();
    _descriptionController.dispose();
    _imagePathController.dispose();
    super.dispose();
  }

  Future<void> _pickImage() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles(type: FileType.image);

    if (result != null) {
      setState(() {
        _selectedImage = File(result.files.single.path!);
        _imagePathController.text = _selectedImage!.path;
      });
    }
  }

  void _save() {
    final id = widget.animeGirl?.id ?? DateTime.now().millisecondsSinceEpoch.toString();
    final AnimeGirl animeGirl = AnimeGirl(
      id: id,
      name: _nameController.text,
      description: _descriptionController.text,
      imagePath: _imagePathController.text,
      isAsset: _selectedImage == null, // Если изображение не выбрано, значит это ассет
    );
    widget.onSave(animeGirl);
    Navigator.of(context).pop();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black54,
        title: const Text('Add/Edit Anime Girl'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          children: [
            TextField(
              controller: _nameController,
              decoration: const InputDecoration(labelText: 'Name'),
            ),
            const SizedBox(height: 10),
            TextField(
              controller: _descriptionController,
              decoration: const InputDecoration(labelText: 'Description'),
            ),
            const SizedBox(height: 10),
            TextField(
              controller: _imagePathController,
              decoration: const InputDecoration(labelText: 'Image Path'),
            ),
            const SizedBox(height: 10),
            ElevatedButton(
              onPressed: _pickImage,
              child: const Text('Pick Image'),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: _save,
              child: const Text('Save'),
            ),
          ],
        ),
      ),
    );
  }
}
