// import 'package:flutter/material.dart';
//
// class KeepAliveImage extends StatefulWidget {
//   final ImageProvider imageProvider;
//   final Widget? errorWidget;
//   final double? width;
//   final double? height;
//   final BoxFit fit;
//   final Alignment alignment;
//
//   const KeepAliveImage({
//     super.key,
//     required this.imageProvider,
//     this.errorWidget,
//     this.width,
//     this.height,
//     this.fit = BoxFit.cover,
//     this.alignment = Alignment.center,
//   });
//
//   @override
//   State<KeepAliveImage> createState() => _KeepAliveImageState();
// }
//
// class _KeepAliveImageState extends State<KeepAliveImage> with AutomaticKeepAliveClientMixin {
//   @override
//   Widget build(BuildContext context) {
//     super.build(context);
//
//     return Image(
//       image: widget.imageProvider,
//       width: widget.width,
//       height: widget.height,
//       fit: widget.fit,
//       alignment: widget.alignment,
//       errorBuilder: (_, __, ___) => widget.errorWidget ?? Image.asset(
//           'assets/placeholder.png',
//           package: 'dash_chat_custom',
//           fit: BoxFit.cover
//         ),
//         loadingBuilder: (_, Widget child, ImageChunkEvent? loadingProgress) {
//           if (loadingProgress == null) {
//             return child;
//           }
//           return Stack(
//             alignment: Alignment.center,
//             children: [
//               Container(
//                 height: widget.height,
//                 width: widget.width,
//                 color: Colors.black12,
//               ),
//               const CircularProgressIndicator(strokeWidth: 6),
//             ],
//           );
//         }
//     );
//   }
//
//   @override
//   bool get wantKeepAlive => true;
// }