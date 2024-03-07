import 'package:ai_chatbot/chat_ui/chat_ui.dart';
import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:flutter/material.dart';
import 'app_components/app_data.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(primarySwatch: mainColor),
      debugShowCheckedModeBanner: false,
      home: const HomePage(),
    );
  }
}

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    deviceHeight = MediaQuery.of(context).size.height;
    deviceWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: bgColor,
      body: SingleChildScrollView(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(height: deviceHeight! / 14),
              GradContainer(
                height: 6,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                            padding: const EdgeInsets.only(top: 15, right: 20),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.end,
                              children: [
                                AnimatedTextKit(
                                  isRepeatingAnimation: true,
                                  repeatForever: true,
                                  animatedTexts: [
                                    TyperAnimatedText(
                                      'Xero Bot',
                                      textStyle: const TextStyle(
                                          color: Colors.white,
                                          fontSize: 30,
                                          fontWeight: FontWeight.bold),
                                    ),
                                  ],
                                ),
                                AnimatedTextKit(
                                  isRepeatingAnimation: true,
                                  repeatForever: true,
                                  animatedTexts: [
                                    TyperAnimatedText(
                                      'by Mahadie',
                                      textStyle: const TextStyle(
                                          color: Colors.white,
                                          fontSize: 20,
                                          fontWeight: FontWeight.bold),
                                    ),
                                  ],
                                ),
                              ],
                            )),
                      ],
                    ),
                    const SizedBox(height: 32),
                    /*IconButton(
                        onPressed: () {
                          showDialog(
                            context: context,
                            builder: (BuildContext context) {
                              return AlertDialog(
                                insetPadding: const EdgeInsets.symmetric(
                                    horizontal: 50, vertical: 200),
                                contentPadding: const EdgeInsets.all(10),
                                title: const Center(child: Text("Xero Bot")),
                                content: const Center(
                                    child: Text(
                                  "Developed by\n Mahadie\n mahadie02@gmail.com",
                                  textAlign: TextAlign.center,
                                )),
                                actions: [
                                  TextButton(
                                    child: const Text("OK"),
                                    onPressed: () {
                                      Navigator.of(context).pop();
                                    },
                                  ),
                                ],
                              );
                            },
                          );
                        },
                        icon: const Icon(
                          Icons.info_outline,
                          color: Colors.white,
                        ))*/
                  ],
                ),
              ),
              SizedBox(height: deviceHeight! / 1.7),
              /*const SizedBox(
                height: 200,
                width: 200,
                child: Center(
                  child: rive.RiveAnimation.asset(
                    "assets/rive/hero_bot.riv",
                    artboard: "LadScape",
                    animations: [
                      "butterfly",
                      "Water",
                    ],
                    fit: BoxFit.cover,
                  ),
                ),
              ),*/
              elevButton(context, Icons.chat, 'Chat', 'Chat'),
              const SizedBox(height: 20),
              elevButton(context, Icons.image, 'Generate Image', 'Image'),
            ],
          ),
        ),
      ),
    );
  }
}

Widget elevButton(context, icon, text, type) {
  return Padding(
    padding: const EdgeInsets.symmetric(horizontal: 15),
    child: GestureDetector(
      onTap: () => Navigator.push(
          context, MaterialPageRoute(builder: (context) => ChatScreen(type))),
      child: Container(
        height: deviceHeight! / 17.5,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(15), gradient: gradColor),
        width: deviceWidth,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 10),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                icon,
                color: Colors.white,
              ),
              const SizedBox(width: 10),
              chatText(text, 20.0)
            ],
          ),
        ),
      ),
    ),
  );
}
