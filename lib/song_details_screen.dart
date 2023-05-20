import 'package:flutter/material.dart';
import 'package:just_audio/just_audio.dart';

class SongDetailsScreen extends StatefulWidget {
  final String songName; // Pass the song name as an argument

  SongDetailsScreen({required this.songName});

  @override
  _SongDetailsScreenState createState() => _SongDetailsScreenState();
}

class _SongDetailsScreenState extends State<SongDetailsScreen> {
  AudioPlayer audioPlayer = AudioPlayer();

  @override
  void dispose() {
    audioPlayer.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Song Details'),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.music_note,
            size: 100,
          ),
          SizedBox(height: 16),
          Text(
            widget.songName,
            style: TextStyle(fontSize: 20),
          ),
          SizedBox(height: 16),
          CircularProgressIndicator(),
          SizedBox(height: 16),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              IconButton(
                icon: Icon(Icons.play_arrow),
                onPressed: () {
                  // Play song
                },
              ),
              IconButton(
                icon: Icon(Icons.pause),
                onPressed: () {
                  // Pause song
                },
              ),
              IconButton(
                icon: Icon(Icons.skip_previous),
                onPressed: () {
                  // Play previous song
                },
              ),
              IconButton(
                icon: Icon(Icons.skip_next),
                onPressed: () {
                  // Play next song
                },
              ),
            ],
          ),
        ],
      ),
    );
  }
}
