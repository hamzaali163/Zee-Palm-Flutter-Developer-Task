import 'package:assesment_project/components/video_player.dart';
import 'package:assesment_project/providers/homevm.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Consumer<Homevm>(
      builder: (context, vm, child) => Scaffold(
        backgroundColor: Colors.white,
        body: StreamBuilder<QuerySnapshot>(
          stream: FirebaseFirestore.instance.collection('videos').orderBy('timestamp', descending: true).snapshots(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(child: CircularProgressIndicator());
            }
            final videos = snapshot.data?.docs ?? [];

            if (videos.isEmpty) {
              return const Center(
                child: Text("No videos found", style: TextStyle(color: Colors.white)),
              );
            }
            if (snapshot.hasError) {
              return const Center(child: Text("Something went wrong..."));
            }

            return PageView.builder(
              scrollDirection: Axis.vertical,
              itemCount: videos.length,
              itemBuilder: (context, index) {
                final videoUrl = videos[index]['url'];
                //   return VideoItem(videoUrl: videoUrl);
                return VideoItem(title: videos[index]['video title'], videoUrl: videoUrl);
              },
            );
          },
        ),
      ),
    );
  }
}


// floatingActionButton: FloatingActionButton(
//           child: const Icon(Icons.add),
//           onPressed: () {
//             vm.pickAndUploadVideo(context);
//           },
//         ),