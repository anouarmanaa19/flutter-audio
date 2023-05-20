// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:flutter_application_1/song_list_screen.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:just_audio/just_audio.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Initialize the audio player and local notifications plugin
  AudioPlayer audioPlayer = AudioPlayer();
  FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
      FlutterLocalNotificationsPlugin();
  var initializationSettingsAndroid = AndroidInitializationSettings('app_icon');
  var initializationSettings =
      InitializationSettings(android: initializationSettingsAndroid);
  await flutterLocalNotificationsPlugin.initialize(initializationSettings);

  runApp(MyApp(audioPlayer, flutterLocalNotificationsPlugin));
}

class MyApp extends StatelessWidget {
  final AudioPlayer audioPlayer;
  final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin;

  MyApp(this.audioPlayer, this.flutterLocalNotificationsPlugin);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Song Player App',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: SongListScreen(),
    );
  }
}
