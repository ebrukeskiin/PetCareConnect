import 'package:flutter/material.dart';
import 'package:pet_care_connect/screens/user_details_calendar.dart';

class UserDetailScreen extends StatefulWidget {
  final Map<String, dynamic> user;

  UserDetailScreen({required this.user});

  @override
  _UserDetailScreenState createState() => _UserDetailScreenState();
}

class _UserDetailScreenState extends State<UserDetailScreen> {
  List<String> comments = [
    'Çok güleryüzlü ve neşeli birisi.Güvenle emanet ettik kızımızı.',
    'Gerçekten gözümüz arkamızda kalmıyor :)',
    'İlk defa tanıştık ama memnun kaldım.',
  ];

  TextEditingController commentController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Profile: ${widget.user['title']}'),
      ),
      body: Container(
        color: Color.fromARGB(255, 196, 244, 238),
        child: SingleChildScrollView(
          child: Column(
            children: [
              _buildUserProfile(),
              _buildCalendarButton(),
              _buildCommentsSection(),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildUserProfile() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        SizedBox(height: 20.0),
        CircleAvatar(
          radius: 80.0,
          backgroundImage: AssetImage(widget.user['image']!),
        ),
        SizedBox(height: 20.0),
        Text(
          widget.user['title']!,
          style: TextStyle(
            fontSize: 28.0,
            fontWeight: FontWeight.bold,
          ),
        ),
        SizedBox(height: 10.0),
        Text(
          widget.user['desc']!,
          style: TextStyle(fontSize: 18.0, color: Colors.grey),
        ),
        SizedBox(height: 10.0),
        _buildUserRating(),
      ],
    );
  }

  Widget _buildUserRating() {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.star, color: Colors.yellow, size: 24.0),
            Text(
              '4.5',
              style: TextStyle(fontSize: 18.0),
            ),
          ],
        ),
        SizedBox(height: 8.0),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.location_on, color: Colors.blue, size: 16.0),
            Text(
              'Eskişehir',
              style: TextStyle(fontSize: 14.0, color: Colors.grey),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildCalendarButton() {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: ElevatedButton(
        onPressed: () {
          _openCalendar(context);
        },
        child: Text('View Appointments'),
      ),
    );
  }

  Widget _buildCommentsSection() {
    return Container(
      color: Colors.white,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Text(
              'User Comments',
              style: TextStyle(fontSize: 24.0, fontWeight: FontWeight.bold),
            ),
          ),
          _buildCommentInput(),
          _buildCommentList(),
        ],
      ),
    );
  }

  Widget _buildCommentInput() {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Row(
        children: [
          Expanded(
            child: TextField(
              controller: commentController,
              decoration: InputDecoration(
                hintText: 'Add your comment here',
                border: OutlineInputBorder(
                  borderRadius:
                      BorderRadius.circular(20.0), // Border radius'u artırıldı
                ),
              ),
            ),
          ),
          SizedBox(width: 16.0),
          ElevatedButton(
            onPressed: () {
              _addComment(commentController.text);
            },
            child: Text('Add Comment'),
          ),
        ],
      ),
    );
  }

  Widget _buildCommentList() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        ...comments.map((comment) => _buildCommentBox(comment)),
      ],
    );
  }

  Widget _buildCommentBox(String comment) {
    return Container(
      margin: const EdgeInsets.all(8.0),
      padding: const EdgeInsets.all(16.0),
      width: double.infinity,
      decoration: BoxDecoration(
        border: Border.all(color: Colors.pink),
        borderRadius: BorderRadius.circular(20.0),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('ekeski10'),
          SizedBox(height: 8.0),
          Text(comment),
        ],
      ),
    );
  }

  void _addComment(String newComment) {
    setState(() {
      comments.insert(0, newComment);
      commentController.clear();
    });
  }

  void _openCalendar(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) {
        return UserDetailCalendarScreen();
      },
    );
  }
}
