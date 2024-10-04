import 'package:flutter/material.dart';

class UserEditScreen extends StatefulWidget {
  final Map<String, String> user;

  const UserEditScreen({Key? key, required this.user}) : super(key: key);

  @override
  _UserEditScreenState createState() => _UserEditScreenState();
}

class _UserEditScreenState extends State<UserEditScreen> {
  final _formKey = GlobalKey<FormState>();
  TextEditingController _titleController = TextEditingController();
  TextEditingController _descController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _titleController.text = widget.user['title'] ?? '';
    _descController.text = widget.user['desc'] ?? '';
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Profil Düzenle: ${widget.user['title']}'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              TextFormField(
                controller: _titleController,
                decoration: InputDecoration(labelText: 'Başlık'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Başlık boş bırakılamaz';
                  }
                  return null;
                },
              ),
              TextFormField(
                controller: _descController,
                decoration: InputDecoration(labelText: 'Açıklama'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Açıklama boş bırakılamaz';
                  }
                  return null;
                },
              ),
              SizedBox(height: 20.0),
              ElevatedButton(
                onPressed: () {
                  if (_formKey.currentState?.validate() ?? false) {
                    // Burada profil güncelleme işlemlerini yapabilirsiniz.
                    // Örneğin, setState kullanarak itemList'deki veriyi güncelleyebilirsiniz.
                    // Bu örnekte sadece konsola yazdıralım.
                    print(
                        'Profil Güncellendi: ${_titleController.text}, ${_descController.text}');
                    Navigator.of(context).pop();
                  }
                },
                child: Text('Kaydet'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
