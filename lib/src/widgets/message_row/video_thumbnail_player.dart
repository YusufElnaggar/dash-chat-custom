part of '../../../dash_chat_custom.dart';

class VideoThumbnailPlayer extends StatelessWidget {

  final String videoUrl;
  final String? thumbnailUrl;
  final String? fileName;
  final double? height;
  final double? width;
  final Map<String, String>? headers;

  const VideoThumbnailPlayer({
    super.key,
    required this.videoUrl,
    this.thumbnailUrl,
    this.fileName,
    this.height,
    this.width,
    this.headers
  });

  Widget _getThumbnail() {
    final Widget imageWidget = thumbnailUrl != null
        ? CachedNetworkImage(imageUrl: thumbnailUrl!, fit: BoxFit.cover, httpHeaders: headers)
        : Image.asset('assets/video_placeholder.png', package: 'dash_chat_custom', fit: BoxFit.cover,
    );

    return Stack(
      fit: StackFit.expand,
      children: [
        imageWidget,
        Container(
          color: Colors.black.withOpacity(0.3), // Máscara oscura encima
        ),
      ],
    );
  }

  void _openFullVideoPlayer(BuildContext context) {
    if (kIsWeb) {
      Navigator.push(context, MaterialPageRoute(
        builder: (_) => FullVideoChewiePlayer(videoUrl: videoUrl, fileName: fileName),
      ));
    }
    else {
      Navigator.push(context, MaterialPageRoute(
        builder: (_) => FullVideoChewiePlayer(videoUrl: videoUrl, fileName: fileName),
        // builder: (_) => FullVideoBetterPlayerPage(videoUrl: videoUrl),
      ));
    }
  }

  @override
  Widget build(BuildContext context) {
    return ZoomTapContent(
      onTap: () => _openFullVideoPlayer(context),
      child: Hero(
        tag: videoUrl,
        child: ClipRRect(
          borderRadius: BorderRadius.circular(12),
          child: Stack(
            children: [
              SizedBox(
                width: width,
                height: height,
                child: _getThumbnail(),
              ),
              const Center(
                child: Icon(
                  Icons.play_arrow,
                  color: Colors.white,
                  size: 50,
                ),
              ),
              if (fileName != null)
                Positioned(
                  bottom: 6,
                  left: 8,
                  right: 8,
                  child: Container(
                    padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 4),
                    decoration: BoxDecoration(
                      color: Colors.black54,
                      borderRadius: BorderRadius.circular(6),
                    ),
                    child: Text(
                      fileName!.length > 30 ? '${fileName!.substring(0, 30)}…' : fileName!,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 8,
                      ),
                    ),
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }
}