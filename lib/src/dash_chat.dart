part of '../dash_chat_custom.dart';

/// {@category Entry point}
class DashChat extends StatelessWidget {
  const DashChat({
    required this.currentUser,
    required this.onSend,
    required this.messages,
    this.inputOptions = const InputOptions(),
    this.messageOptions = const MessageOptions(),
    this.messageListOptions = const MessageListOptions(),
    this.quickReplyOptions = const QuickReplyOptions(),
    this.scrollToBottomOptions = const ScrollToBottomOptions(),
    this.readOnly = false,
    this.typingUsers,
    this.maxWidth,
    this.maxHeight,
    Key? key,
  }) : super(key: key);

  /// The Chat media max width (default is full width)
  final double? maxWidth;

  /// The Chat media max height (default is full height)
  final double? maxHeight;

  /// The current user of the chat
  final ChatUser currentUser;

  /// Function to call when the user sends a message
  final void Function(ChatMessage message) onSend;

  /// List of messages visible in the chat
  final List<ChatMessage> messages;

  /// Options to customize the behaviour and design of the chat input
  final InputOptions inputOptions;

  /// Options to customize the behaviour and design of the messages
  final MessageOptions messageOptions;

  /// Options to customize the behaviour and design of the overall list of message
  final MessageListOptions messageListOptions;

  /// Options to customize the behaviour and design of the quick replies
  final QuickReplyOptions quickReplyOptions;

  /// Options to customize the behaviour and design of the scroll-to-bottom button
  final ScrollToBottomOptions scrollToBottomOptions;

  /// Option to make the chat read only, it will hide the input field
  final bool readOnly;

  /// List of users currently typing in the chat
  final List<ChatUser>? typingUsers;

  @override
  Widget build(BuildContext context) {
    double maxWidth = this.maxWidth ?? MediaQuery.of(context).size.width;
    double maxHeight = this.maxHeight ?? MediaQuery.of(context).size.height;

    return Column(
      children: <Widget>[
        Expanded(
          child: MessageList(
            maxWidth: maxWidth,
            maxHeight: maxHeight,
            currentUser: currentUser,
            messages: messages,
            messageOptions: messageOptions,
            messageListOptions: messageListOptions,
            quickReplyOptions: quickReplyOptions,
            scrollToBottomOptions: scrollToBottomOptions,
            typingUsers: typingUsers,
            readOnly: readOnly,
          ),
        ),
        if (!readOnly)
          InputToolbar(
            inputOptions: inputOptions,
            currentUser: currentUser,
            onSend: onSend,
          ),
      ],
    );
  }
}
