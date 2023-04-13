import 'package:flutter/material.dart';

import '../../../app/constants.dart';

class HomeButtonWidget extends StatelessWidget {
  final String textData;
  final IconData iconData;
  final VoidCallback? onTap;
  const HomeButtonWidget(
      {Key? key, required this.textData, this.onTap, required this.iconData})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        height: 110,
        width: double.infinity,
        alignment: Alignment.centerLeft,
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
        decoration: BoxDecoration(
          color: Color.fromARGB(60, 0, 0, 0),
          borderRadius: BorderRadius.circular(210),
          boxShadow: Constants.glowBoxShadow,
        ),
        child: Row(
          children: [
            Icon(
              iconData,
              size: 50,
            ),
            const SizedBox(
              width: 10,
            ),
            Text(
              textData,
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
