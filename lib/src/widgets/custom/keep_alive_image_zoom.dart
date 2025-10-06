import 'package:flutter/material.dart';
import 'package:widget_zoom_pro/widget_zoom_pro.dart';

class KeepAliveImageZoom extends StatefulWidget {

  final String heroAnimationTag;
  final ImageProvider imageProvider;
  final Widget? errorWidget;
  final double? width;
  final double? height;
  final BoxFit fit;
  final Alignment alignment;

  const KeepAliveImageZoom({
    super.key,
    required this.heroAnimationTag,
    required this.imageProvider,
    this.errorWidget,
    this.width,
    this.height,
    this.fit = BoxFit.cover,
    this.alignment = Alignment.center,
  });

  @override
  State<KeepAliveImageZoom> createState() => _KeepAliveImageZoomState();
}

class _KeepAliveImageZoomState extends State<KeepAliveImageZoom> with AutomaticKeepAliveClientMixin {

  late bool _didFailed = false;

  @override
  Widget build(BuildContext context) {
    super.build(context);

    if (_didFailed) {
      return Image.asset(
        'assets/placeholder.png',
        package: 'dash_chat_custom',
        fit: BoxFit.cover
      );
    }

    return WidgetZoomPro(
      hoverCursor: SystemMouseCursors.click,
      enableEmbeddedView: false,
      heroAnimationTag: widget.heroAnimationTag,
      closeFullScreenImageOnEscape: true,
      zoomWidget: Image(
        image: widget.imageProvider,
        width: widget.width,
        height: widget.height,
        fit: widget.fit,
        alignment: widget.alignment,
        errorBuilder: (_, __, ___) {
          if (!_didFailed) {
            WidgetsBinding.instance.addPostFrameCallback((_) {
              if (mounted) {
                setState(() {
                  _didFailed = true;
                });
              }
            });
          }
          return widget.errorWidget ?? Image.asset(
            'assets/placeholder.png',
            package: 'dash_chat_custom',
            fit: BoxFit.cover
          );
        },
        // errorBuilder: (_, __, ___) => widget.errorWidget ?? Image.asset(
        //     'assets/placeholder.png',
        //     package: 'dash_chat_custom',
        //     fit: BoxFit.cover
        // ),
        loadingBuilder: (_, Widget child, ImageChunkEvent? loadingProgress) {
          if (loadingProgress == null) {
            return child;
          }
          return Stack(
            alignment: Alignment.center,
            children: [
              Container(
                height: widget.height,
                width: widget.width,
                color: Colors.black12,
              ),
              const CircularProgressIndicator(strokeWidth: 6),
            ],
          );
        },
      ),
      // imageErrorBuilder: (_, __, ___) {
      //   return const Icon(Icons.error, color: Colors.redAccent);
      // }
    );
  }

  @override
  bool get wantKeepAlive => true;
}