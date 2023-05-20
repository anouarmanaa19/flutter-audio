import 'package:flutter/material.dart';

class UrlInputScreen extends StatefulWidget {
  @override
  _UrlInputScreenState createState() => _UrlInputScreenState();
}

class _UrlInputScreenState extends State<UrlInputScreen> {
  TextEditingController urlController = TextEditingController();

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
                // Implement the logic to download the MP3 sound using the provided URL
                // and add it to the list of songs
              },
              child: Text('Download'),
            ),
          ],
        ),
      ),
    );
  }
}
