// part of '../../../dash_chat_custom.dart';
//
// class FullVideoBetterPlayerPage extends StatefulWidget {
//   final String videoUrl;
//
//   const FullVideoBetterPlayerPage({
//     super.key,
//     required this.videoUrl
//   });
//
//   @override
//   State<FullVideoBetterPlayerPage> createState() => _FullVideoBetterPlayerPageState();
// }
//
// class _FullVideoBetterPlayerPageState extends State<FullVideoBetterPlayerPage> {
//   late BetterPlayerController _betterPlayerController;
//
//   @override
//   void initState() {
//     super.initState();
//
//     BetterPlayerDataSource dataSource = BetterPlayerDataSource(
//       BetterPlayerDataSourceType.network,
//       widget.videoUrl,
//       cacheConfiguration: const BetterPlayerCacheConfiguration(
//         useCache: true,
//         maxCacheSize: 200 * 1024 * 1024, // 200 MB
//         maxCacheFileSize: 50 * 1024 * 1024, // 50 MB por archivo
//       ),
//       bufferingConfiguration: const BetterPlayerBufferingConfiguration(
//         minBufferMs: 2000,
//         maxBufferMs: 5000,
//         bufferForPlaybackMs: 1000,
//         bufferForPlaybackAfterRebufferMs: 2000,
//       ),
//     );
//
//     _betterPlayerController = BetterPlayerController(
//       const BetterPlayerConfiguration(
//         aspectRatio: 9 / 16, // Default, luego se ajusta automáticamente
//         fit: BoxFit.contain,
//         autoPlay: true,
//         looping: false,
//         controlsConfiguration: BetterPlayerControlsConfiguration(
//           enablePlaybackSpeed: false,
//           enableSubtitles: false,
//           enableAudioTracks: false,
//           enableMute: true,
//           enableFullscreen: false,
//           enableOverflowMenu: false,
//           enablePlayPause: true,
//           enableQualities: false,
//           enableSkips: true,
//           controlsHideTime: Duration(milliseconds: 100),
//           progressBarPlayedColor: Colors.red,
//           progressBarHandleColor: Colors.white,
//           progressBarBackgroundColor: Colors.black54,
//           progressBarBufferedColor: Colors.grey,
//         ),
//         deviceOrientationsOnFullScreen: [DeviceOrientation.portraitUp],
//         autoDetectFullscreenDeviceOrientation: true,
//         allowedScreenSleep: false,
//         fullScreenByDefault: false,
//       ),
//       betterPlayerDataSource: dataSource,
//     );
//
//     // Ajustar el aspectRatio al real cuando se obtenga metadata
//     // _betterPlayerController.addEventsListener((event) {
//     //   if (event.betterPlayerEventType == BetterPlayerEventType.initialized) {
//     //     final double aspectRatio =
//     //         _betterPlayerController.videoPlayerController?.value.aspectRatio ?? 16 / 9;
//     //     _betterPlayerController.setOverriddenAspectRatio(aspectRatio);
//     //     setState(() {}); // Redibujar si quieres que tome efecto inmediato
//     //   }
//     // });
//   }
//
//   @override
//   void dispose() {
//     _betterPlayerController.dispose();
//     super.dispose();
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: Colors.black,
//       appBar: AppBar(
//         backgroundColor: Colors.black,
//         foregroundColor: Colors.white,
//       ),
//       body: Center(
//         child: Hero(
//           tag: widget.videoUrl,
//           child: AspectRatio(
//             aspectRatio: 9 / 16,
//             child: BetterPlayer(controller: _betterPlayerController),
//           ),
//         ),
//       ),
//     );
//   }
// }