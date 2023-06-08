import 'package:chat_gpt/core/utils/values_manager.dart';
import 'package:flutter/material.dart';

import '../../core/utils/assets_manager.dart';
import '../../core/utils/routes_manager.dart';
import '../../core/utils/strings_manager.dart';
import 'widgets/home_button_widget.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  // ignore: library_private_types_in_public_api
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
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
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFF280666),
      body: Container(
        padding: const EdgeInsets.all(AppPadding.p20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Column(
              children: [
                const SizedBox(
                  height: AppSize.s10,
                ),
              ],
            ),
            Column(
              children: [
                const SizedBox(
                  height: AppSize.s10,
                ),
                GestureDetector(
                  onTapDown: _onTapDown,
                  onTapUp: _onTapUp,
                  child: Transform(
                    alignment: Alignment.center,
                    transform: _isPressed
                        ? (Matrix4.identity()..translate(0.0, 6.0, 0.0))
                        : Matrix4.identity(),
                    child: Hero(
                      tag: 'heroTag',
                      child: Image.asset(ImageAssets.appLogo),
                    ),
                  ),
                ),
              ], 
            ),
            Column(
              children: [
                HomeButtonWidget(
                  textData: AppStrings.imageGeneration,
                  iconData: Icons.image_outlined,
                  onTap: () {
                    Navigator.pushNamed(context, Routes.imageRoute);
                  },
                ),
                const SizedBox(
                  height: AppSize.s30,
                ),
                HomeButtonWidget(
                  textData: AppStrings.textCompletion,
                  iconData: Icons.title,
                  onTap: () {
                    Navigator.pushNamed(context, Routes.textRoute);
                  },
                ),
              ],
            ),
            const Text(
              "Chatty by memodlike",
              style: TextStyle(color: Colors.grey),
            ),
          ],
        ),
      ),
    );
  }
}
