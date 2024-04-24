import 'package:covid_19/others/constant.dart';
import 'package:covid_19/widgets/info_screen.dart';
import 'package:flutter/material.dart';

import 'package:flutter_svg/flutter_svg.dart';

class MyHeader extends StatelessWidget {
  final String image;
  final String textTop;
  final String textBottom;
  const MyHeader({
    super.key,
    required this.image,
    required this.textTop,
    required this.textBottom,
  });

  @override
  Widget build(BuildContext context) {
    return ClipPath(
      clipper: MyClipper(),
      child: Container(
        padding: const EdgeInsets.only(left: 40, top: 50, right: 20),
        height: 360,
        width: double.infinity,
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topRight,
            end: Alignment.bottomLeft,
            colors: [
              Color(0xFF3383CD),
              Color(0xFF11249F),
            ],
          ),
          image: DecorationImage(
            image: AssetImage("assets/images/virus.png"),
          ),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Align(
              alignment: Alignment.topRight,
              child: GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) {
                          return const InfoScreen();
                        },
                      ),
                    );
                  },
                  child: SvgPicture.asset("assets/icons/menu.svg")),
            ),
            const SizedBox(
              height: 20,
            ),
            Expanded(
                child: Stack(
              children: [
                SvgPicture.asset(
                  image,
                  width: 250,
                  fit: BoxFit.fitWidth,
                  alignment: Alignment.topCenter,
                ),
                Positioned(
                  top: 20,
                  left: 130,
                  child: Text(
                    "$textTop \n$textBottom",
                    style: kHeadingTextStyle.copyWith(
                      color: Colors.white,
                    ),
                  ),
                ),
                Container(),
              ],
            ))
          ],
        ),
      ),
    );
  }
}

class MyClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    var height = size.height * 0.65;
    var path = Path();
    path.lineTo(0, size.height - height * 0.5);
    path.quadraticBezierTo(
        size.width * 0.55, size.height * 0.9, size.width, height);
    path.lineTo(size.width, 0);
    path.close();
    return path;
  }

  @override
  bool shouldReclip(covariant CustomClipper<Path> oldClipper) {
    throw UnimplementedError();
  }
}
