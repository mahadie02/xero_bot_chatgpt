import 'package:flutter/material.dart';

//MaterialColor mainColor = Colors.teal;
Color bgColor = const Color(0xff021d24);
Color myColor =
    const Color.fromARGB(255, 10, 150, 168); // replace with your color

MaterialColor mainColor = MaterialColor(
  myColor.value,
  <int, Color>{
    50: myColor.withOpacity(0.1),
    100: myColor.withOpacity(0.2),
    200: myColor.withOpacity(0.3),
    300: myColor.withOpacity(0.4),
    400: myColor.withOpacity(0.5),
    500: myColor.withOpacity(0.6),
    600: myColor.withOpacity(0.7),
    700: myColor.withOpacity(0.8),
    800: myColor.withOpacity(0.9),
    900: myColor.withOpacity(1.0),
  },
);

LinearGradient gradColor = const LinearGradient(
  colors: [Color.fromARGB(255, 38, 144, 133), Color.fromARGB(255, 0, 225, 255)],
  begin: Alignment.centerLeft,
  end: Alignment.centerRight,
);

// Display Heigh & Width
double? deviceHeight;
double? deviceWidth;

// App Texts

Widget mainText(text) {
  return Text(text,
      style: const TextStyle(
          color: Colors.white, fontSize: 22, fontWeight: FontWeight.bold));
}

Widget chatText(message, size) {
  return Text(message, style: chatTextStyle(size));
}

//TextStyle
TextStyle chatTextStyle(size) {
  return TextStyle(color: Colors.white, fontSize: size);
}

//Gradient Container
class GradContainer extends StatelessWidget {
  final double height;
  final Widget? child;

  const GradContainer({
    super.key,
    required this.height,
    this.child,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 15),
      child: Container(
        height: deviceHeight! / height,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(15),
          gradient: gradColor,
        ),
        width: deviceWidth,
        child: child ?? Container(),
      ),
    );
  }
}

//Animated Rotation + Fade Transition Icons
/*
class RotFadeTranIcons extends StatefulWidget {
  final double? start;
  final double? end;
  final double? size;
  final IconData startIcon;
  final IconData endIcon;
  final Function? onTap;
  bool? isActive;
  RotFadeTranIcons({
    super.key,
    this.start,
    this.end,
    this.size,
    this.isActive,
    required this.startIcon,
    required this.endIcon,
    this.onTap,
  });

  @override
  State<RotFadeTranIcons> createState() => _RotFadeTranIconsState();
}

class _RotFadeTranIconsState extends State<RotFadeTranIcons> {
  bool isTapped = false;
  @override
  Widget build(BuildContext context) {
    isTapped = widget.isActive ?? false;
    return Container(
      height: widget.size ?? 55,
      decoration: BoxDecoration(
          gradient: const LinearGradient(colors: [Colors.teal, Colors.cyan]),
          borderRadius: BorderRadius.circular(200)),
      child: FloatingActionButton(
          backgroundColor: Colors.transparent,
          onPressed: () {
            setState(() {
              isTapped = !isTapped;
            });
          },
          //Animated Icons
          child: rotFadeICons(widget.start ?? 1.0, widget.end ?? 0.0,
              widget.startIcon, widget.endIcon, isTapped)
          /*Stack(children: [
                      animtedIcons(1.0, 0.0, Icons.mic),
                      animtedIcons(0.0, 1.0, Icons.send),
                    ]),*/
          ),
    );
  }

  Widget rotFadeICons(start, end, startIcon, endIcon, isTapped) {
    Widget animtedIcons(start, end, icon) {
      //Single animated Icons
      return AnimatedRotation(
          curve: Curves.easeInOut,
          turns: isTapped ? start * (1 / 2) : end * (-1 / 2),
          duration: const Duration(milliseconds: 300),
          child: AnimatedOpacity(
              curve: Curves.easeInOut,
              opacity: isTapped ? end : start,
              duration: const Duration(milliseconds: 300),
              child: Icon(icon)));
    }

    // Calling two Icons in stack but with  opposite valuse
    return Stack(children: [
      animtedIcons(start, end, startIcon),
      animtedIcons(end, start, endIcon),
    ]);
  }
}
*/