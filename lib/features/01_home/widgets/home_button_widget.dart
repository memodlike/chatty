import 'package:flutter/material.dart';

import '../../../app/constants.dart';

class HomeButtonWidget extends StatefulWidget {
  final String textData;
  final IconData iconData;
  final VoidCallback? onTap;

  const HomeButtonWidget({
    Key? key,
    required this.textData,
    this.onTap,
    required this.iconData,
  }) : super(key: key);

  @override
  _HomeButtonWidgetState createState() => _HomeButtonWidgetState();
}

class _HomeButtonWidgetState extends State<HomeButtonWidget> {
  bool _isPressed = false;

  void _onTapDown(TapDownDetails details) {
    setState(() {
      _isPressed = true;
    });
  }

  void _onTapUp(TapUpDetails details) {
    setState(() {
      _isPressed = false;
    });
    widget.onTap?.call();
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      highlightColor: Colors.transparent,
      splashColor: Colors.transparent,
      onTapDown: _onTapDown,
      onTapUp: _onTapUp,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 100),
        transform: _isPressed
            ? Matrix4.translationValues(0, 4, 0)
            : Matrix4.translationValues(0, 0, 0),
        height: 110,
        width: double.infinity,
        alignment: Alignment.centerLeft,
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
        decoration: BoxDecoration(
          color: Color(0xFF280666),
          borderRadius: BorderRadius.circular(210),
          boxShadow: _isPressed ? [] : Constants.glowBoxShadow,
        ),
        child: Row(
          children: [
            Icon(
              widget.iconData,
              size: 50,
            ),
            const SizedBox(
              width: 10,
            ),
            Text(
              widget.textData,
              style: const TextStyle(
                  color: Colors.white,
                  fontSize: 18,
                  fontWeight: FontWeight.w600),
            ),
          ],
        ),
      ),
    );
  }
}

// class HomeButtonWidget extends StatelessWidget {
//   final String textData;
//   final IconData iconData;
//   final VoidCallback? onTap;
//   const HomeButtonWidget(
//       {Key? key, required this.textData, this.onTap, required this.iconData})
//       : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     return InkWell(
//       onTap: onTap,
//       highlightColor: Colors.transparent,
//       splashColor: Colors.transparent,
//       child: Container(
//         height: 110,
//         width: double.infinity,
//         alignment: Alignment.centerLeft,
//         padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
//         decoration: BoxDecoration(
//           color: Color(0xFF280666),
//           borderRadius: BorderRadius.circular(210),
//           boxShadow: Constants.glowBoxShadow,
//         ),
//         child: Row(
//           children: [
//             Icon(
//               iconData,
//               size: 50,
//             ),
//             const SizedBox(
//               width: 10,
//             ),
//             Text(
//               textData,
//               style: const TextStyle(
//                   color: Colors.white,
//                   fontSize: 18,
//                   fontWeight: FontWeight.w600),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }
