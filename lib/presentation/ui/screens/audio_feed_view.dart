// import 'dart:convert';
// import 'package:http/http.dart' as http;

// import 'package:flutter/material.dart';

// import '../../../audio/audio_container.dart';

// class AudioFeedView extends StatelessWidget {
//   AudioFeedView({Key? key}) : super(key: key);

//   ValueNotifier<String> audioLock = ValueNotifier('');

//   final String cloudFunctionUrl =
//       "https://us-central1-audio-feed-328918.cloudfunctions.net/list-drive-files";

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: const Center(
//           child: Text('Audio Feed'),
//         ),
//       ),
//       body: Center(
//         child: AudioContainer(
//           audioTitle: 'title',
//           audioId: "id",
//           audioLock: audioLock,
//         ),
//       ),
//     );
//   }
// }
