part of '../../../dash_chat_custom.dart';

class FullVideoChewiePlayer extends StatefulWidget {

  final String videoUrl;
  final String? fileName;
  final bool canPlay;

  const FullVideoChewiePlayer({
    super.key,
    required this.videoUrl,
    this.fileName,
    this.canPlay = true,
  });

  @override
  State<FullVideoChewiePlayer> createState() => _FullVideoChewiePlayerState();
}

class _FullVideoChewiePlayerState extends State<FullVideoChewiePlayer> {
  late VideoPlayerController _videoController;
  ChewieController? _chewieController;

  @override
  void initState() {
    super.initState();
    _videoController = VideoPlayerController.networkUrl(Uri.parse(widget.videoUrl))
      ..initialize().then((_) {
        if (!mounted) {
          return;
        }

        if (widget.canPlay) {
          _chewieController = ChewieController(
            videoPlayerController: _videoController,
            pauseOnBackgroundTap: true,
            autoPlay: true,
            looping: false,
            allowFullScreen: false,
            fullScreenByDefault: false,
            allowMuting: true,
            showOptions: false,
            showControls: true,
            showControlsOnInitialize: false,
            allowPlaybackSpeedChanging: false,
            allowedScreenSleep: false,
            hideControlsTimer: const Duration(milliseconds: 1000),
            materialProgressColors: ChewieProgressColors(
              playedColor: Colors.red,
              handleColor: Colors.white,
              backgroundColor: Colors.black54,
              bufferedColor: Colors.grey,
            ),
          );
        }
        setState(() {});
      });
  }

  @override
  void dispose() {
    _videoController.dispose();
    _chewieController?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final Widget chewiePlayer = _videoController.value.isInitialized
        ? (widget.canPlay && _chewieController != null
          ? Chewie(controller: _chewieController!)
          : AspectRatio(
            aspectRatio: _videoController.value.aspectRatio,
            child: vp.VideoPlayer(_videoController),
          ))
        : const CircularProgressIndicator(strokeWidth: 6);

    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        title: widget.fileName != null
          ? Text(widget.fileName!, overflow: TextOverflow.ellipsis, style: const TextStyle(fontSize: 12))
          : null,
        backgroundColor: Colors.black,
        foregroundColor: Colors.white,
      ),
      body: KeyboardListener(
        autofocus: true,
        focusNode: FocusNode(),
        onKeyEvent: (KeyEvent event) {
          if (event is KeyDownEvent && event.logicalKey == LogicalKeyboardKey.escape) {
            Navigator.of(context).pop();
          }
        },
        child: Center(
          child: Hero(
            tag: widget.videoUrl,
            child: chewiePlayer
          ),
        ),
      ),
    );
  }

}