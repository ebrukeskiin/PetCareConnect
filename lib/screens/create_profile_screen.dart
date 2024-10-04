import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';

class CreateProfileScreen extends StatefulWidget {
  const CreateProfileScreen({Key? key}) : super(key: key);

  @override
  _CreateProfileScreenState createState() => _CreateProfileScreenState();
}

class _CreateProfileScreenState extends State<CreateProfileScreen> {
  TextEditingController _firstNameController = TextEditingController();
  TextEditingController _lastNameController = TextEditingController();
  TextEditingController _descriptionController = TextEditingController();
  File? _selectedImage;

  List<Map<String, dynamic>> profileList = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Create Profile'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            _buildImagePicker(),
            const SizedBox(height: 20.0),
            _buildTextField(_firstNameController, 'Name', 'John'),
            const SizedBox(height: 20.0),
            _buildTextField(_lastNameController, 'Surname', 'Doe'),
            const SizedBox(height: 20.0),
            _buildTextField(
                _descriptionController, 'About me', 'Add a description...'),
            const SizedBox(height: 20.0),
            ElevatedButton(
              onPressed: () {
                _saveProfile();
              },
              child: Text('Save'),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildImagePicker() {
    return InkWell(
      onTap: () {
        _pickImage();
      },
      child: Container(
        width: 120,
        height: 120,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: Colors.blue,
        ),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: _selectedImage == null
              ? Icon(
                  Icons.add_a_photo,
                  color: Colors.white,
                  size: 40.0,
                )
              : CircleAvatar(
                  radius: 40.0,
                  backgroundImage: FileImage(_selectedImage!),
                ),
        ),
      ),
    );
  }

  Widget _buildTextField(
      TextEditingController controller, String label, String hint) {
    return TextFormField(
      controller: controller,
      style: TextStyle(fontSize: 16),
      decoration: InputDecoration(
        labelText: label,
        hintText: hint,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
        ),
        contentPadding: EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      ),
    );
  }

  Future<void> _pickImage() async {
    final ImagePicker _picker = ImagePicker();
    final XFile? image = await _picker.pickImage(source: ImageSource.gallery);

    if (image != null) {
      setState(() {
        _selectedImage = File(image.path);
      });
    }
  }

  void _saveProfile() {
    final Map<String, dynamic> profile = {
      'firstName': _firstNameController.text,
      'lastName': _lastNameController.text,
      'description': _descriptionController.text,
      'imagePath': _selectedImage != null ? _selectedImage!.path : null,
    };

    setState(() {
      profileList.add(profile);
    });
  }
}
