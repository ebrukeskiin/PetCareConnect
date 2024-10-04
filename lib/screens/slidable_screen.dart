import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:pet_care_connect/screens/chat_screen.dart';
import 'package:pet_care_connect/screens/create_profile_screen.dart';
import 'package:pet_care_connect/screens/discover_screen.dart';
import 'package:pet_care_connect/screens/user_details_screen.dart';

class SlidableScreen extends StatefulWidget {
  const SlidableScreen({Key? key}) : super(key: key);

  @override
  State<SlidableScreen> createState() => _SlidableScreenState();
}

class _SlidableScreenState extends State<SlidableScreen> {
  final itemList = [
    {
      'image': 'assets/images/BurcuCan.jpg',
      'title': 'Burcu Can',
      'desc':
          "Hello! I am Burcu,\nan animal caregiver known\n for my deep love \nand care for animals.",
    },
    {
      'image': 'assets/images/GizemAkdoğan.jpeg',
      'title': 'Gizem Akdoğan',
      'desc':
          'Hi Everyone :) I am Gizem.\n I offer a unique approach\nto animal care with a\nflexible working approach\n and excellent communication\n skills.',
    },
    {
      'image': 'assets/images/AliBerk.jpg',
      'title': 'Ali Berk',
      'desc':
          'Hello! I am Ali.\n With my training and \nsense of responsibility\n in animal care, I am here to\n provide reliable care to\n your animal friends.',
    }
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Profiles"),
        actions: [
          InkWell(
            onTap: () {
              _navigateToDiscover(); // Discover ekranına yönlendirme
            },
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Center(
                child: Text(
                  'Discover',
                  style: TextStyle(fontSize: 16.0),
                ),
              ),
            ),
          ),
          IconButton(
            icon: Icon(Icons.person_add),
            onPressed: () {
              _navigateToCreateProfile();
            },
          ),
        ],
      ),
      body: (itemList.isEmpty)
          ? SizedBox(
              height: double.infinity,
              width: double.infinity,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: const [
                  Icon(
                    Icons.hourglass_empty_rounded,
                    color: Colors.grey,
                    size: 60.0,
                  ),
                  SizedBox(height: 10.0),
                  Text(
                    'Öğe bulunamadı...',
                    style: TextStyle(fontSize: 24.0, color: Colors.grey),
                  )
                ],
              ),
            )
          : ListView.builder(
              itemCount: itemList.length,
              itemBuilder: (context, index) {
                final item = itemList[index];
                return Padding(
                  padding: (index == 0)
                      ? const EdgeInsets.symmetric(vertical: 20.0)
                      : const EdgeInsets.only(bottom: 20.0),
                  child: Slidable(
                    key: Key('$item'),
                    startActionPane: ActionPane(
                      motion: const ScrollMotion(),
                      children: [
                        SlidableAction(
                          onPressed: (context) {
                            _navigateToProfile(item);
                          },
                          backgroundColor: Colors.blue,
                          icon: Icons.person,
                          label: 'View Profile',
                        ),
                      ],
                    ),
                    endActionPane: ActionPane(
                      motion: const ScrollMotion(),
                      children: [
                        SlidableAction(
                          onPressed: (context) {
                            _navigateToChat(item);
                          },
                          backgroundColor: Colors.green,
                          icon: Icons.message,
                          label: 'Send Message',
                        ),
                      ],
                    ),
                    child: Container(
                      margin: const EdgeInsets.symmetric(horizontal: 20.0),
                      padding: const EdgeInsets.all(10.0),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10.0),
                        color: Colors.white,
                        boxShadow: [
                          BoxShadow(
                              blurRadius: 1.0,
                              spreadRadius: 1.0,
                              color: Colors.grey[400]!),
                        ],
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          ClipRRect(
                            borderRadius: BorderRadius.circular(10.0),
                            child: Image.asset(
                              item['image']!,
                              width: 100.0,
                              height: 100.0,
                              fit: BoxFit.cover,
                            ),
                          ),
                          const SizedBox(width: 10.0),
                          Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                item['title']!,
                                style: const TextStyle(
                                  fontSize: 18.0,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              const SizedBox(height: 10.0),
                              Text(
                                item['desc']!,
                                style: const TextStyle(
                                  fontSize: 14.0,
                                  color: Colors.grey,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                );
              },
            ),
    );
  }

  void _navigateToProfile(Map<String, String> item) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => UserDetailScreen(user: item),
      ),
    );
  }

  void _navigateToChat(Map<String, String> item) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => ChatScreen(user: item),
      ),
    );
  }

  void _navigateToCreateProfile() {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => CreateProfileScreen(),
      ),
    );
  }

  void _navigateToDiscover() {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => DiscoverScreen(), // DiscoverScreen'a yönlendirme
      ),
    );
  }
}
