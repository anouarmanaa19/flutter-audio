import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_application_1/url_input_screen.dart';
import 'package:path_provider/path_provider.dart';

import 'database_helper.dart';
import 'song_details_screen.dart'; // Import the SongDetailsScreen

Future<List<String>> loadSongsFromLocalStorage() async {
  try {
    final directory = await getApplicationDocumentsDirectory();
    final files = Directory(directory.path).listSync();
    List<String> songPaths = [];
    for (var file in files) {
      if (file is File && file.path.endsWith('.mp3')) {
        songPaths.add(file.path);
      }
    }
    return songPaths;
  } catch (e) {
    print('Error loading songs: $e');
    return [];
  }
}

class SongListScreen extends StatefulWidget {
  @override
  _SongListScreenState createState() => _SongListScreenState();
}

class _SongListScreenState extends State<SongListScreen> {
  List<bool> isFavoriteList = List.generate(5, (_) => false);
  List<String> songList = [];

  @override
  void initState() {
    super.initState();
    loadSongs();
  }

  Future<void> loadSongs() async {
    final songs = await loadSongsFromLocalStorage();
    setState(() {
      songList = songs;
    });
  } // Replace 5 with the actual number of songs

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Song List'),
        ),
        body: ListView.builder(
          itemCount: 5, // Replace with the actual number of songs
          itemBuilder: (context, index) {
            return ListTile(
              title: Text('Song $index'),
              trailing: IconButton(
                icon: Icon(
                  isFavoriteList[index]
                      ? Icons.favorite
                      : Icons.favorite_border,
                ),
                onPressed: () async {
                  setState(() {
                    isFavoriteList[index] = !isFavoriteList[index];
                  });

                  if (isFavoriteList[index]) {
                    final songName = 'Song $index';
                    await DatabaseHelper.instance.insertSong(songName);
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text('Song added to favorites')),
                    );
                  }
                },
                color: Colors
                    .grey, // Change the color of the heart icon when it is not tapped
              ),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) =>
                        SongDetailsScreen(songName: 'Song $index'),
                  ),
                );
              },
            );
          },
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => UrlInputScreen(),
              ),
            );
          },
          child: Icon(Icons.add),
        ));
  }
}
