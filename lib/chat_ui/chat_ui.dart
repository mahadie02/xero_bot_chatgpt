import 'package:ai_chatbot/app_components/app_data.dart';
import 'package:flutter/material.dart';
import '../api/api_response.dart';
import 'single_message.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class ChatScreen extends StatefulWidget {
  final String type;
  const ChatScreen(this.type, {super.key});

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> with TickerProviderStateMixin {
  @override
  void initState() {
    super.initState();
  }

  final TextEditingController _controller = TextEditingController();
  final List<String> _messages = [];
  bool _isTyping = false;
  bool _isLoading = false;
  bool _isGenerating = false;
  bool isTalking = true;

  void _sendMessage(String message) async {
    setState(() {
      _isTyping = false;
      _messages.add(message);
    });
    _controller.clear();
    setState(() {
      _isLoading = true;
    });

    // Call ChatGPT API here to get response
    final String reply = await chatResponse(message, widget.type);
    setState(() {
      _isLoading = false;
      _messages.add(reply);
      widget.type == 'Image' ? _isGenerating = false : _isGenerating = true;
    });
  }

  callBackFunction() {
    setState(() {
      _isGenerating = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: bgColor,
      appBar: AppBar(
        automaticallyImplyLeading: false,
        flexibleSpace: Container(
          decoration: BoxDecoration(gradient: gradColor),
        ),
        leading: IconButton(
            onPressed: () => Navigator.pop(context),
            icon: const Icon(Icons.arrow_back_ios)),
        title: mainText(widget.type),
        centerTitle: true,
        actions: [
          IconButton(
              onPressed: () {
                setState(() {
                  isTalking = !isTalking;
                });
              },
              icon: isTalking
                  ? const Icon(Icons.volume_up_rounded)
                  : const Icon(Icons.volume_off_rounded))
        ],
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          Expanded(
            child: ListView.builder(
              physics: const BouncingScrollPhysics(),
              reverse: true,
              itemCount: _messages.length,
              itemBuilder: (context, index) {
                return _messages[_messages.length - 1 - index] != ''
                    ? SingleMessage(
                        message: _messages[_messages.length - 1 - index],
                        type: widget.type,
                        shouldAnimate: _messages.length - 1 - index ==
                            _messages.length - 1,
                        callBack: callBackFunction,
                      )
                    : Container();
              },
            ),
          ),
          _isLoading
              ? Row(
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: FittedBox(
                        child: Container(
                          padding: const EdgeInsets.all(10),
                          decoration: BoxDecoration(
                              gradient: gradColor,
                              borderRadius: BorderRadius.circular(15)),
                          //Three Dot Loading
                          child: const SpinKitThreeBounce(
                            color: Colors.white,
                            size: 20.0,
                          ),
                        ),
                      ),
                    ),
                  ],
                )
              : Container(),
          _isGenerating
              ? GestureDetector(
                  onTap: () {
                    setState(() {
                      _isGenerating = false;
                      _messages.add('');
                    });
                  },
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: FittedBox(
                          child: Container(
                            padding: const EdgeInsets.all(10),
                            decoration: BoxDecoration(
                                color: const Color(0xff1e3942),
                                borderRadius: BorderRadius.circular(15)),
                            child: const Row(
                              children: [
                                Icon(
                                  Icons.stop,
                                  color: Colors.white,
                                  size: 12,
                                ),
                                SizedBox(width: 3),
                                Text(
                                  'stop generating',
                                  style: TextStyle(
                                      color: Colors.white, fontSize: 12),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                )
              : Container(),

          //Text Field
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: _controller,
                    style: chatTextStyle(18.0),
                    decoration: InputDecoration(
                      suffixIcon: _isTyping
                          ? IconButton(
                              onPressed: () {
                                _controller.clear();
                                setState(() {
                                  _isTyping = !_isTyping;
                                });
                              },
                              icon: const Icon(
                                Icons.clear,
                                size: 30,
                              ))
                          : const Visibility(visible: false, child: SizedBox()),
                      suffixIconColor: const Color.fromARGB(255, 10, 150, 168),
                      focusedBorder: const OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(20)),
                        borderSide: BorderSide(
                            color: Color.fromARGB(255, 8, 152, 171),
                            width: 2.7),
                      ),
                      enabledBorder: const OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(20)),
                        borderSide:
                            BorderSide(color: Color(0xff1e3942), width: 2),
                      ),
                      hintText: 'Type a message...',
                      hintStyle: chatTextStyle(18.0),
                    ),
                    onChanged: (value) {
                      setState(() {
                        _isTyping = value.isNotEmpty;
                      });
                    },
                  ),
                ),
                const SizedBox(width: 8),
                //RotFadeTranIcons(startIcon: Icons.send, endIcon: Icons.mic),
                Container(
                  height: 55,
                  width: 55,
                  decoration: BoxDecoration(
                      gradient: gradColor,
                      borderRadius: BorderRadius.circular(200)),
                  child: GestureDetector(
                    onTap: () {
                      if (_isTyping) {
                        _sendMessage('You: ${_controller.text}');
                      } else {
                        const Tooltip(message: 'Hello');
                      }
                    },
                    child: Container(
                      decoration: const BoxDecoration(shape: BoxShape.circle),
                      //Animated Icons
                      child: Center(
                        child: rotFadeICons(
                            1.0, 0.0, Icons.mic, Icons.send, _isTyping),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget rotFadeICons(start, end, firstICon, secondIcon, icActive) {
    Widget animtedIcons(start, end, icon) {
      //Single animated Icons
      return AnimatedRotation(
          curve: Curves.easeInOut,
          turns: icActive ? start * (1 / 2) : end * (-1 / 2),
          duration: const Duration(milliseconds: 300),
          child: AnimatedOpacity(
              curve: Curves.easeInOut,
              opacity: icActive ? end : start,
              duration: const Duration(milliseconds: 300),
              child: Icon(icon)));
    }

    // Calling two Icons in stack but with  opposite valuse
    return Stack(children: [
      animtedIcons(start, end, firstICon),
      animtedIcons(end, start, secondIcon),
    ]);
  }
}
