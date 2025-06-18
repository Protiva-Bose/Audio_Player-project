import 'package:flutter/material.dart';
import 'dart:ui';
import 'package:audioplayers/audioplayers.dart';

import 'music_player.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: EbookHome(),
      debugShowCheckedModeBanner: false,
    );
  }
}

class EbookHome extends StatelessWidget {
  const EbookHome({super.key});

  final List<Map<String, String>> books = const [
    {
      "title": "E01",
      "date": "5 May, 2025",
      "image": "assets/aa.jpg",
    },
    {
      "title": "E02",
      "date": "5 May, 2025",
      "image": "assets/c.jpg",
    },
    {
      "title": "E03",
      "date": "5 May, 2025",
      "image": "assets/d.jpg",
    },
    {
      "title": "E04",
      "date": "5 May, 2025",
      "image": "assets/e.jpg",
    },
    {
      "title": "E05",
      "date": "5 May, 2025",
      "image": "assets/f.jpg",
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black,
        titleSpacing: 30,
        toolbarHeight: 100,
        title: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: Text("Music Streaming", style: TextStyle(color: Colors.white)),
        ),
      ),

        backgroundColor: const Color(0xFF0D0F21),

      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 16),
              Row(
                children: [
                  const CircleAvatar(
                    backgroundImage: AssetImage("assets/a.jpg"),
                    radius: 22,
                  ),
                  const SizedBox(width: 12),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: const [
                      Text("Good Morning,", style: TextStyle(color: Colors.blue, fontSize: 14)),
                      Text("Ronald Richards", style: TextStyle(color: Colors.white, fontSize: 18)),
                    ],
                  ),
                  const Spacer(),
                  CircleAvatar(
                     backgroundColor: Colors.blueGrey,
                    child: Icon(Icons.favorite_border, color: Colors.white,),),

                ],
              ),
              const SizedBox(height: 30),
              Center(child:  Text("E-book",
                  style: TextStyle(color: Colors.white, fontSize: 24, fontWeight: FontWeight.bold)),),
              const SizedBox(height: 20),
              Expanded(
                child: GridView.builder(
                  padding: EdgeInsets.zero,
                  itemCount: books.length,
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    mainAxisSpacing: 16,
                    crossAxisSpacing: 16,
                    childAspectRatio: 0.65,
                  ),
                  itemBuilder: (context, index) {
                    final book = books[index];
                    return GestureDetector(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (_) => MusicPlayer()),
                        );
                      },
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center, // Changed here
                        children: [
                          ClipRRect(
                            borderRadius: BorderRadius.circular(16),
                            child: Image.asset(
                              book["image"]!,
                              height: 180,
                              fit: BoxFit.fill,
                            ),
                          ),
                          const SizedBox(height: 8),
                          Text(
                            book["title"]!,
                            style: const TextStyle(color: Colors.white),
                            textAlign: TextAlign.center,  // Optional: center title text
                          ),
                          Text(
                            book["date"]!,
                            style: TextStyle(color: Colors.grey.shade400, fontSize: 12),
                            textAlign: TextAlign.center,  // Optional: center date text
                          ),
                        ],
                      ),
                    );
                  },
                ),
              ),

              const SizedBox(height: 16),


              BottomNavigationBar(
                type: BottomNavigationBarType.fixed,
                backgroundColor: Colors.blueGrey,
                selectedItemColor: Colors.black,
                unselectedItemColor: Colors.white,

                items: const [
                  BottomNavigationBarItem(icon: Icon(Icons.home), label: ''),
                  BottomNavigationBarItem(icon: Icon(Icons.grid_view), label: ''),
                  BottomNavigationBarItem(icon: Icon(Icons.graphic_eq,color: Colors.blue,), label: ''),
                  BottomNavigationBarItem(icon: Icon(Icons.notifications_none), label: ''),
                  BottomNavigationBarItem(icon: Icon(Icons.person_outline), label: ''),
                ],
              )


            ],
          ),
        ),
      ),
    );
  }
}
