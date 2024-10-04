import 'package:flutter/material.dart';

class DiscoverScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Discover"),
      ),
      body: ListView.builder(
        itemCount: discoverPosts.length,
        itemBuilder: (context, index) {
          return DiscoverCard(post: discoverPosts[index]);
        },
      ),
    );
  }
}

class DiscoverCard extends StatefulWidget {
  final DiscoverPost post;

  const DiscoverCard({Key? key, required this.post}) : super(key: key);

  @override
  _DiscoverCardState createState() => _DiscoverCardState();
}

class _DiscoverCardState extends State<DiscoverCard> {
  bool isLiked = false;

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 3.0,
      margin: const EdgeInsets.symmetric(vertical: 8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Post Resmi
          GestureDetector(
            onTap: () {
              _toggleLike();
            },
            child: Stack(
              alignment: Alignment.center,
              children: [
                Image.asset(
                  widget.post.imagePath,
                  fit: BoxFit.cover,
                  width: double.infinity,
                  height: 300.0,
                ),
                isLiked
                    ? AnimatedOpacity(
                        opacity: 1.0,
                        duration: Duration(milliseconds: 500),
                        child:
                            Icon(Icons.favorite, color: Colors.red, size: 50.0),
                      )
                    : Container(),
              ],
            ),
          ),
          // Beğeni ve Diğer Bilgiler
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                // Beğeni Iconu ve Sayısı
                Row(
                  children: [
                    InkWell(
                      onTap: () {
                        _toggleLike();
                      },
                      child: Row(
                        children: [
                          Icon(Icons.favorite,
                              color: isLiked ? Colors.red : Colors.grey),
                          SizedBox(width: 4.0),
                          Text(
                            widget.post.likes.toString(),
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                // Diğer ikonlar veya bilgiler buraya eklenebilir
              ],
            ),
          ),
          // Yorum Yapma ve Beğeni Iconları
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                // Yorum Yapma ve Beğeni Iconları
                Row(
                  children: [
                    Icon(Icons.favorite_outline),
                    SizedBox(width: 8.0),
                    Text("Like"),
                  ],
                ),
                Row(
                  children: [
                    Icon(Icons.chat_bubble_outline),
                    SizedBox(width: 8.0),
                    Text("Comment"),
                  ],
                ),
                // Diğer ikonlar buraya eklenebilir
              ],
            ),
          ),
        ],
      ),
    );
  }

  void _toggleLike() {
    setState(() {
      isLiked = true;
      widget.post.likes++;
    });

    // Beliren kalbin kaybolması için bir süre sonra durumu sıfırlayın
    Future.delayed(Duration(seconds: 1), () {
      setState(() {
        isLiked = false;
      });
    });
  }

  void _likePost() {
    setState(() {
      // Beğeni sayısını artır
      widget.post.likes++;
    });
  }
}

class DiscoverPost {
  final String imagePath;
  int likes;

  DiscoverPost({required this.imagePath, required this.likes});
}

// Örnek DiscoverPost listesi
List<DiscoverPost> discoverPosts = [
  DiscoverPost(imagePath: 'assets/images/keşfet1.jpg', likes: 150),
  DiscoverPost(imagePath: 'assets/images/keşfet2.avif', likes: 200),
  DiscoverPost(imagePath: 'assets/images/keşfet3.jpg', likes: 78)
  // Diğer postlar buraya eklenebilir
];
