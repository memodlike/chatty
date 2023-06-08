import 'package:flutter/material.dart';

import '../../core/utils/assets_manager.dart';
import '../../core/utils/navigation_helper.dart';
import '../../core/utils/routes_manager.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({
    Key? key,
  }) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _rotationAnimation;
  late Animation<Color?> _colorAnimation;
  late Animation<double> _scaleAnimation;
  late Animation<double> _positionAnimation;
  bool _isComplete = false;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 2),
    );

    _rotationAnimation = Tween<double>(begin: 0, end: 1).animate(_controller)
      ..addStatusListener((status) {
        if (status == AnimationStatus.completed && !_isComplete) {
          _isComplete = true;
          _navigateToNextScreen();
        }
      });

    _colorAnimation = ColorTween(
            begin: Color.fromARGB(255, 169, 5, 5),
            end: Color.fromARGB(255, 40, 6, 102))
        .animate(_controller);

    _scaleAnimation = Tween<double>(begin: 1.0, end: 0.90).animate(_controller);

    _positionAnimation =
        Tween<double>(begin: 0, end: -0.25).animate(_controller);

    _controller.forward();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: AnimatedBuilder(
        animation: _controller,
        builder: (context, child) {
          return Container(
            color: _colorAnimation.value,
            child: Center(
              child: Transform.rotate(
                angle: _rotationAnimation.value * 2 * 3.14,
                child: Transform.scale(
                  scale: _scaleAnimation.value,
                  child: Transform.translate(
                    offset: Offset(
                        0,
                        _positionAnimation.value *
                            MediaQuery.of(context).size.height),
                    child: Hero(
                      tag: 'heroTag',
                      child: Image.asset(
                        ImageAssets.ChattyLogo,
                        fit: BoxFit.contain,
                      ),
                    ),
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  void _navigateToNextScreen() {
    Navigator.pushReplacementNamed(context, Routes.homeRoute);
  }
}

//__________________________________________________________________________
// class SplashScreen extends StatefulWidget {
//   const SplashScreen({
//     Key? key,
//   }) : super(key: key);

//   @override
//   State<SplashScreen> createState() => _SplashScreenState();
// }

// class _SplashScreenState extends State<SplashScreen>
//     with SingleTickerProviderStateMixin {
//   late AnimationController _controller;
//   late Animation<double> _rotationAnimation;
//   late Animation<Color?> _colorAnimation;
//   bool _isComplete = false;

//   @override
//   void initState() {
//     super.initState();
//     _controller = AnimationController(
//       vsync: this,
//       duration: const Duration(seconds: 2),
//     );

//     _rotationAnimation = Tween<double>(begin: 0, end: 1).animate(_controller)
//       ..addStatusListener((status) {
//         if (status == AnimationStatus.completed && !_isComplete) {
//           _isComplete = true;
//           _navigateToNextScreen();
//         }
//       });

//     _colorAnimation = ColorTween(
//             begin: Color.fromARGB(255, 54, 244, 70),
//             end: Color.fromARGB(255, 40, 6, 102))
//         .animate(_controller);

//     _controller.forward();
//   }

//   @override
//   void dispose() {
//     _controller.dispose();
//     super.dispose();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: AnimatedBuilder(
//         animation: _controller,
//         builder: (context, child) {
//           return Container(
//             color: _colorAnimation.value,
//             child: Center(
//               child: Transform.rotate(
//                 angle: _rotationAnimation.value * 2 * 3.14,
//                 child: Image.asset(
//                   ImageAssets.openAiAvatar,
//                   fit: BoxFit.contain,
//                 ),
//               ),
//             ),
//           );
//         },
//       ),
//     );
//   }

//   void _navigateToNextScreen() {
//     Navigator.pushReplacementNamed(context, Routes.homeRoute);
//   }
// }
//__________________________________________________________________________
// class SplashScreen extends StatefulWidget {
//   const SplashScreen({
//     Key? key,
//   }) : super(key: key);

//   @override
//   State<SplashScreen> createState() => _SplashScreenState();
// }

// class _SplashScreenState extends State<SplashScreen>
//     with SingleTickerProviderStateMixin {
//   late AnimationController _controller;
//   late Animation<double> _rotationAnimation;
//   late Animation<Color?> _colorAnimation;
//   bool _isComplete = false;

//   @override
//   void initState() {
//     super.initState();
//     _controller = AnimationController(
//       vsync: this,
//       duration: const Duration(seconds: 2),
//     );

//     _rotationAnimation = Tween<double>(begin: 0, end: 1).animate(_controller)
//       ..addStatusListener((status) {
//         if (status == AnimationStatus.completed && !_isComplete) {
//           _isComplete = true;
//           Navigator.pushReplacementNamed(context, Routes.homeRoute);
//         }
//       });

//     _colorAnimation = ColorTween(
//             begin: Color.fromARGB(255, 54, 244, 70),
//             end: Color.fromARGB(255, 40, 6, 102))
//         .animate(_controller);

//     _controller.forward();
//   }

//   @override
//   void dispose() {
//     _controller.dispose();
//     super.dispose();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: AnimatedBuilder(
//         animation: _controller,
//         builder: (context, child) {
//           return Container(
//             color: _colorAnimation.value,
//             child: Center(
//               child: Transform.rotate(
//                 angle: _rotationAnimation.value * 2 * 3.14,
//                 child: Image.asset(
//                   ImageAssets.openAiAvatar,
//                   fit: BoxFit.contain,
//                 ),
//               ),
//             ),
//           );
//         },
//       ),
//     );
//   }
// }
