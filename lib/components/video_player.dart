import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';

class VideoItem extends StatefulWidget {
  final String videoUrl;
  final String title;

  const VideoItem({super.key, required this.videoUrl, required this.title});

  @override
  State<VideoItem> createState() => _VideoItemState();
}

class _VideoItemState extends State<VideoItem> {
  late VideoPlayerController _controller;
  bool isLiked = false;
  bool isSaved = false;
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _initializeVideo();
  }

  Future<void> _initializeVideo() async {
    try {
      _controller = VideoPlayerController.networkUrl(Uri.parse(widget.videoUrl));
      await _controller.initialize();
      _controller.setLooping(true);
      await _controller.play();
      setState(() {
        _isLoading = false;
      });
    } catch (e) {
      print("❌ Video initialization error: $e");
      setState(() {
        _isLoading = false;
      });
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void toggleLike() {
    setState(() {
      isLiked = !isLiked;
    });
  }

  void toggleSave() {
    setState(() {
      isSaved = !isSaved;
    });
  }

  void downloadVideo() {
    ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text("Download started...")));
    // TODO: Use dio or flutter_downloader to handle actual download
  }

  @override
  Widget build(BuildContext context) {
    if (_isLoading) {
      return const Center(child: CircularProgressIndicator());
    }

    if (!_controller.value.isInitialized) {
      return const Center(child: Text("⚠️ Failed to load video"));
    }

    return Stack(
      children: [
        SizedBox.expand(
          child: FittedBox(
            fit: BoxFit.cover,
            child: SizedBox(
              width: _controller.value.size.width,
              height: _controller.value.size.height,
              child: VideoPlayer(_controller),
            ),
          ),
        ),
        Positioned(
          bottom: 100,
          right: 20,
          child: Column(
            children: [
              IconButton(
                icon: Icon(
                  isLiked ? Icons.favorite : Icons.favorite_border,
                  color: isLiked ? Colors.red : Colors.white,
                  size: 32,
                ),
                onPressed: toggleLike,
              ),
              const SizedBox(height: 12),
              IconButton(
                icon: Icon(
                  isSaved ? Icons.bookmark : Icons.bookmark_border,
                  color: isSaved ? Colors.yellow : Colors.white,
                  size: 32,
                ),
                onPressed: toggleSave,
              ),
              const SizedBox(height: 12),
              IconButton(
                icon: const Icon(Icons.download_rounded, color: Colors.white, size: 32),
                onPressed: downloadVideo,
              ),
            ],
          ),
        ),
        Positioned(
          bottom: 20,
          left: 16,
          right: 100, // So it doesn't overlap action buttons
          child: Text(
            widget.title,
            style: const TextStyle(
              color: Colors.white,
              fontSize: 16,
              fontWeight: FontWeight.w500,
              shadows: [Shadow(offset: Offset(0, 1), blurRadius: 3, color: Colors.black54)],
            ),
          ),
        ),
      ],
    );
  }
}
