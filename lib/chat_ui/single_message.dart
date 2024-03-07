import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../app_components/app_data.dart';
import 'package:animated_text_kit/animated_text_kit.dart';

class SingleMessage extends StatelessWidget {
  final String message;
  final String type;
  final bool shouldAnimate;
  final Function callBack;

  const SingleMessage(
      {super.key,
      required this.message,
      required this.type,
      required this.shouldAnimate,
      required this.callBack});

  @override
  Widget build(BuildContext context) {
    String displayMessage = message.startsWith('You: ')
        ? message.substring(4)
        : message.trim(); 
    return Row(
      mainAxisAlignment: message.startsWith('You:')
          ? MainAxisAlignment.end
          : MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        Container(
          padding: const EdgeInsets.all(10),
          margin: const EdgeInsets.all(7),
          constraints: BoxConstraints(
              maxWidth: MediaQuery.of(context).size.width / 1.35),
          decoration: BoxDecoration(
              gradient: message.startsWith('You:')
                  ? gradColor
                  : const LinearGradient(colors: [
                      Color.fromARGB(255, 26, 71, 86),
                      Color.fromARGB(255, 30, 56, 65)
                    ]),
              borderRadius: BorderRadius.circular(12)),
          child: Column(
            crossAxisAlignment: message.startsWith('You:')
                ? CrossAxisAlignment.end
                : CrossAxisAlignment.start,
            children: [
              Container(
                constraints: const BoxConstraints(maxWidth: 320),
                child: type == 'Chat' &&
                        !message.startsWith('You: ') &&
                        shouldAnimate
                    ? AnimatedTextKit(
                        onFinished: () => callBack(),
                        isRepeatingAnimation: false,
                        animatedTexts: [
                            TyperAnimatedText(
                              displayMessage,
                              textStyle: chatTextStyle(18.0),
                            )
                          ])
                    : !message.startsWith('You: ') && !shouldAnimate
                        ? chatText(displayMessage, 18.0)
                        : message.startsWith('You: ')
                            ? chatText(displayMessage, 18.0)
                            : ClipRRect(
                                borderRadius: BorderRadius.circular(10),
                                child: Image.network(message)),
              ),
            ],
          ),
        ),
        if (!message.startsWith('You:'))
          IconButton(
            icon: const Icon(Icons.copy, color: Colors.white),
            onPressed: () {
              Clipboard.setData(ClipboardData(text: displayMessage));
              ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('Copied to clipboard')));
            },
          ),
      ],
    );
  }
}
