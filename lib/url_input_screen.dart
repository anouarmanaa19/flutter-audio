import 'package:http/http.dart' as http;
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';

class UrlInputScreen extends StatefulWidget {
  @override
  _UrlInputScreenState createState() => _UrlInputScreenState();
}

class _UrlInputScreenState extends State<UrlInputScreen> {
  TextEditingController urlController = TextEditingController();
  List<String> songList = [];

  Future<void> downloadSong(String url) async {
    try {
      // Send an HTTP GET request to download the MP3 sound
      var response = await http.get(Uri.parse(url));

      // Get the file name from the URL
      var fileName = url.split('/').last;

      // Get the directory for storing the downloaded songs
      var directory = await getApplicationDocumentsDirectory();

      // Create the file path
      var filePath = '${directory.path}/$fileName';

      // Write the downloaded content to the file
      File file = File(filePath);
      await file.writeAsBytes(response.bodyBytes);

      // Add the downloaded song to the list
      setState(() {
        // Assuming you have a list of songs, you can add the downloaded song to it
        songList.add(filePath);
      });
    } catch (e) {
      // Handle any errors that occur during the download
      print('Error downloading song: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Enter URL'),
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextField(
              controller: urlController,
              decoration: InputDecoration(
                labelText: 'Enter URL',
              ),
            ),
            SizedBox(height: 16.0),
            ElevatedButton(
              onPressed: () {
                // Handle the download logic
                String url = urlController.text;
                downloadSong(url);
              },
              child: Text('Download'),
            ),
          ],
        ),
      ),
    );
  }
}
