import 'package:flutter/material.dart';

class HeaderSection extends StatelessWidget {
  final String title;

  final String subTitle;

  const HeaderSection({super.key, required this.title, required this.subTitle});

  @override
  Widget build(BuildContext context) {
    return Center(
        child: Container(
      margin: const EdgeInsets.only(top: 35),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image.asset(
            "assets/images/sds_food_logo_transp.png",
            width: 70,
            height: 80,
          ),
          const Text(
            "SDS Food",
            style: TextStyle(
                fontSize: 20,
                fontFamily: 'Sofia',
                fontWeight: FontWeight.w700,
                color: Colors.pink),
          ),
          Text(
            title,
            textAlign: TextAlign.center,
            style: const TextStyle(fontWeight: FontWeight.w800, fontSize: 30),
          ),
          Text(
            subTitle,
            textAlign: TextAlign.center,
            style: const TextStyle(
              color: Colors.grey,
              fontWeight: FontWeight.w500,
            ),
          ),
        ],
      ),
    ));
  }
}
