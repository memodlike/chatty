import 'package:chat_gpt/core/utils/values_manager.dart';
import 'package:flutter/material.dart';

import '../../core/utils/assets_manager.dart';
import '../../core/utils/routes_manager.dart';
import '../../core/utils/strings_manager.dart';
import 'widgets/home_button_widget.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromARGB(255, 137, 121, 78),
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
                  height: AppSize.s150,
                  child: Text(
                    "Chatty",
                    style: TextStyle(
                        fontWeight: FontWeight.bold, height: 2, fontSize: 40),
                  ),
                ),
                Image.asset(ImageAssets.appLogo),
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
