part of '../../../dash_chat_custom.dart';

/// @nodoc
class MediaContainer extends StatelessWidget {
  const MediaContainer({
    required this.maxWidth,
    required this.maxHeight,
    required this.message,
    this.messageOptions = const MessageOptions(),
    this.previousMessage,
    this.nextMessage,
    this.isOwnMessage = false,
    this.isPreviousSameAuthor = false,
    this.isNextSameAuthor = false,
    this.isAfterDateSeparator = false,
    this.isBeforeDateSeparator = false,
    Key? key,
  }) : super(key: key);

  /// The Chat media max width (default is full width)
  final double maxWidth;

  /// The Chat media max height (default is full height)
  final double maxHeight;
  
  /// Message that contains the media to show
  final ChatMessage message;

  /// Options to customize the behaviour and design of the messages
  final MessageOptions messageOptions;

  /// Previous message in the list
  final ChatMessage? previousMessage;

  /// Next message in the list
  final ChatMessage? nextMessage;

  /// If the message is from the current user
  final bool isOwnMessage;

  /// If the previous message is from the same author as the current one
  final bool isPreviousSameAuthor;

  /// If the next message is from the same author as the current one
  final bool isNextSameAuthor;

  /// If the message is preceded by a date separator
  final bool isAfterDateSeparator;

  /// If the message is before by a date separator
  final bool isBeforeDateSeparator;

  Widget _getMediaLoading({
    required ChatMedia media, Key? key
  }) {
    return Container(
      key: key,
      child: messageOptions.mediaUploadingBuilder != null
        ? messageOptions.mediaUploadingBuilder!(media, maxWidth, maxHeight)
        : const CircularProgressIndicator(color: Colors.green),
    );
  }

  /// Get the right media widget according to its type
  Widget _getMedia(
    BuildContext context,
    ChatMedia media,
    double? height,
    double? width,
  ) {
    final Widget loading = Container(
      width: 15,
      height: 15,
      margin: const EdgeInsets.all(10),
      child: const CircularProgressIndicator(
        strokeWidth: 6,
        color: Colors.green,
      ),
    );

    switch (media.type) {
      case MediaType.video:
        return Stack(
          alignment: AlignmentDirectional.bottomEnd,
          children: <Widget>[
            if (media.isUploading)
              _getMediaLoading(key: ValueKey('loading-${media.url}'), media: media),

            if (!media.isUploading)
              VideoThumbnailPlayer(
                key: ValueKey(media.url),
                videoUrl: media.url,
                thumbnailUrl: media.thumbnailUrl,
                fileName: media.fileName,
                width: width,
                height: height,
                headers: messageOptions.mediaHttpHeaders,
              ),

          ],
        );
      case MediaType.image:
        return Stack(
          alignment: AlignmentDirectional.bottomEnd,
          children: <Widget>[
            if (media.isUploading)
              _getMediaLoading(key: ValueKey('loading-${media.url}'), media: media),

            // if (media.isUploading)
            //   Image(
            //     height: height,
            //     width: width,
            //     fit: BoxFit.cover,
            //     alignment: isOwnMessage ? Alignment.topRight : Alignment.topLeft,
            //     image: getImageProvider(media.url, fileBytes: media.fileBytes),
            //     errorBuilder: (_, __, ___) {
            //       return Image.asset('assets/placeholder.png',
            //         package: 'dash_chat_custom',
            //         fit: BoxFit.cover
            //       );
            //     },
            //   ),

            if (!media.isUploading)
              KeepAliveImageZoom(
                key: ValueKey(media.url),
                heroAnimationTag: media.url,
                width: width,
                height: height,
                fit: BoxFit.cover,
                alignment: isOwnMessage ? Alignment.topRight : Alignment.topLeft,
                imageProvider: getImageProvider(media.url, fileBytes: media.fileBytes, headers: messageOptions.mediaHttpHeaders),
              ),
          ],
        );
      default:
        //file
        return TextContainer(
          maxWidth: maxWidth,
          maxHeight: maxHeight,
          isOwnMessage: isOwnMessage,
          messageOptions: messageOptions,
          message: message,
          messageTextBuilder: (ChatMessage m, ChatMessage? p, ChatMessage? n) {
            return Row(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.only(right: 18.0),
                  child: !media.isUploading
                      ? Icon(
                          Icons.description,
                          size: 18,
                          color: isOwnMessage
                              ? messageOptions.currentUserTextColor(context)
                              : messageOptions.textColor,
                        )
                      : loading,
                ),
                Flexible(
                  child: Text(
                    media.fileName,
                    style: TextStyle(
                      decoration: TextDecoration.underline,
                      color: isOwnMessage
                          ? messageOptions.currentUserTextColor(context)
                          : messageOptions.textColor,
                    ),
                  ),
                ),
              ],
            );
          },
        );
    }
  }

  @override
  Widget build(BuildContext context) {
    if (message.medias != null && message.medias!.isNotEmpty) {
      final List<ChatMedia> media = message.medias!;
      //Size size = MediaQuery.sizeOf(context);
      double maxWidthPerc = maxWidth * 0.8;
      double maxHeightPerc = maxHeight * 0.8;

      return Container(
        decoration: defaultMessageDecoration(
          color: isOwnMessage
              ? messageOptions.currentUserContainerColor(context)
              : messageOptions.containerColor,
          borderTopLeft:
          isPreviousSameAuthor && !isOwnMessage && !isAfterDateSeparator
              ? 0.0
              : messageOptions.borderRadius,
          borderTopRight:
          isPreviousSameAuthor && isOwnMessage && !isAfterDateSeparator
              ? 0.0
              : messageOptions.borderRadius,
          borderBottomLeft:
          !isOwnMessage && !isBeforeDateSeparator && isNextSameAuthor
              ? 0.0
              : messageOptions.borderRadius,
          borderBottomRight:
          isOwnMessage && !isBeforeDateSeparator && isNextSameAuthor
              ? 0.0
              : messageOptions.borderRadius,
        ),
        padding: messageOptions.messagePadding,
        child: Column(
          crossAxisAlignment: isOwnMessage ? CrossAxisAlignment.end : CrossAxisAlignment.start,
          children: <Widget>[
            Wrap(
              alignment: isOwnMessage ? WrapAlignment.end : WrapAlignment.start,
              children: media.map(
                (ChatMedia m) {
                  final double gallerySize = ((maxWidth * 0.6) / 2 - 5).clampMax(maxWidthPerc);
                  final bool isImage = m.type == MediaType.image;
                  return Container(
                    color: Colors.transparent,
                    margin: const EdgeInsets.only(top: 5, right: 5),
                    width: media.length > 1 && isImage ? gallerySize : null,
                    height: media.length > 1 && isImage ? gallerySize : null,
                    constraints: BoxConstraints(
                      maxHeight: (maxHeight * 0.4).clampMax(maxHeightPerc),
                      maxWidth: (maxWidth * 0.6).clampMax(maxWidthPerc),
                    ),
                    child: ZoomTapContent(
                      onTap: messageOptions.onTapMedia != null && m.type != MediaType.video
                          ? () => messageOptions.onTapMedia!(m)
                          : null,
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(8.0),
                        child: ColorFiltered(
                          colorFilter: ColorFilter.mode(
                            m.isUploading
                                ? Colors.white54
                                : Colors.white.withOpacity(
                                    0.1,
                                  ), // Because transparent is causing an issue on flutter web
                            BlendMode.srcATop,
                          ),
                          child: _getMedia(
                            context,
                            m,
                            media.length > 1 ? gallerySize : null,
                            media.length > 1 ? gallerySize : null,
                          ),
                        ),
                      ),
                    ),
                  );
                },
              ).toList(),
            ),
            if (messageOptions.showTime)
              messageOptions.messageTimeBuilder != null
                  ? messageOptions.messageTimeBuilder!(message, isOwnMessage)
                  : Padding(
                padding: messageOptions.timePadding,
                child: Text(
                  (messageOptions.timeFormat ?? intl.DateFormat('HH:mm'))
                      .format(message.createdAt),
                  style: TextStyle(
                    color: isOwnMessage
                        ? messageOptions.currentUserTimeTextColor(context)
                        : messageOptions.timeTextColor(),
                    fontSize: messageOptions.timeFontSize,
                  ),
                ),
              ),
          ],
        ),
      );
    }
    return const SizedBox();
  }
}
