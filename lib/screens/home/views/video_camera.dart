//   import 'package:flutter/material.dart';
//   import 'package:flutter_vlc_player/flutter_vlc_player.dart';
// import 'package:fungus_focus/screens/home/views/home_screen.dart';

//   class VideoStreamPage extends StatefulWidget {
//     const VideoStreamPage({super.key});

//     @override
//     // ignore: library_private_types_in_public_api
//     _VideoStreamPageState createState() => _VideoStreamPageState();
//   }

//   class _VideoStreamPageState extends State<VideoStreamPage> {
//     late VlcPlayerController _vlcViewController;

//     @override
//     void initState() {
//       super.initState();
//       _vlcViewController = VlcPlayerController.network(
//         'http://192.168.254.106:5000', 
//         autoPlay: true,
//       );
//     }

//     @override
//     void dispose() {
//       _vlcViewController.dispose();
//       super.dispose();
//     }

//     @override
//     Widget build(BuildContext context) {
//       return Scaffold(
//         appBar: AppBar(
//           title: const Text('Raspberry Pi Camera Stream'),
//           leading: IconButton(
//           icon: const Icon(Icons.arrow_back),
//           onPressed: () {
//             Navigator.pushReplacement(
//               context,
//               MaterialPageRoute(builder: (context) => const HomeScreen())
//             );
//           },
//         ),
//         ),
//         body: Center(
//           child: VlcPlayer(
//             controller: _vlcViewController,
//             aspectRatio: 16 / 9,
//             placeholder: const Center(child: CircularProgressIndicator()),
//           ),
//         ),
//       );
//     }
//   }


// import 'package:flutter/material.dart';
// import 'package:webview_flutter/webview_flutter.dart';
// import 'package:fungus_focus/screens/home/views/home_screen.dart';

// class VideoStreamPage extends StatefulWidget {
//   const VideoStreamPage({super.key});

//   @override
//   // ignore: library_private_types_in_public_api
//   _VideoStreamPageState createState() => _VideoStreamPageState();
// }

// class _VideoStreamPageState extends State<VideoStreamPage> {
//   late final WebViewController _webViewController;

//   @override
//   void initState() {
//     super.initState();
//     _webViewController = WebViewController()
//       ..setJavaScriptMode(JavaScriptMode.unrestricted)
//       ..loadRequest(Uri.parse('http://192.168.254.106:5000')); 
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text('Raspberry Pi Camera Stream'),
//         leading: IconButton(
//           icon: const Icon(Icons.arrow_back),
//           onPressed: () {
//             Navigator.pushReplacement(
//               context,
//               MaterialPageRoute(builder: (context) => const HomeScreen()),
//             );
//           },
//         ),
//       ),
//       body: WebViewWidget(controller: _webViewController),
//     );
//   }
// }

import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';
import 'package:fungus_focus/screens/home/views/home_screen.dart';

class VideoStreamPage extends StatefulWidget {
  const VideoStreamPage({super.key});

  @override
  _VideoStreamPageState createState() => _VideoStreamPageState();
}

class _VideoStreamPageState extends State<VideoStreamPage> {
  late final WebViewController _webViewController;
  String address1 = 'http://192.168.254.106:5000/video_feed'; // First address natin
  String address2 = 'http://192.168.254.37:5000/video_feed'; // Second address ung mali yung isa 

  @override
  void initState() {
    super.initState();
    _webViewController = WebViewController()
      ..setJavaScriptMode(JavaScriptMode.unrestricted)
      ..loadRequest(Uri.parse(address1)); // Try load yung isa 

    // Add error handling for failed loading
    _webViewController.setNavigationDelegate(
      NavigationDelegate(
        onWebResourceError: (WebResourceError error) {
          if (error.errorType == WebResourceErrorType.connect) {
            // If may error puntang address2
            _webViewController.loadRequest(Uri.parse(address2));
          }
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Raspberry Pi Camera Stream'),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(builder: (context) => const HomeScreen()),
            );
          },
        ),
      ),
      body: WebViewWidget(controller: _webViewController),
    );
  }
}
