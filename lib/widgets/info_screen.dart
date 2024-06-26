import 'package:covid_19/others/constant.dart';
import 'package:covid_19/widgets/my_header.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class InfoScreen extends StatelessWidget {
  const InfoScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            MyHeader(
                image: "assets/icons/coronadr.svg",
                textTop: "Get to know",
                textBottom: "About Covid-19"),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Symptoms",
                    style: kTitleTextstyle,
                  ),
                  SizedBox(height: 20),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      SymptomsCard(
                        image: "assets/images/headache.png",
                        title: "Headache",
                        isActive: true,
                      ),
                      SymptomsCard(
                        image: "assets/images/caugh.png",
                        title: "Caugh",
                      ),
                      SymptomsCard(
                        image: "assets/images/fever.png",
                        title: "Fever",
                      ),
                    ],
                  ),
                  SizedBox(height: 20),
                  Text(
                    "Prevention",
                    style: kTitleTextstyle,
                  ),
                  SizedBox(height: 20),
                  PreventCard(
                    text:
                        "Since the start of the coronavirus outbreak some places have fully embraced wearing facemasks",
                    title: "Wear face mask",
                    image: "assets/images/wash_hands.png",
                  ),
                  PreventCard(
                    text:
                        "Since the start of the coronavirus outbreak some places have fully embraced wearing facemasks",
                    title: "Wash your hands",
                    image: "assets/images/wash_hands.png",
                  ),
                  SizedBox(height: 50),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}

class PreventCard extends StatelessWidget {
  final String image;
  final String title;
  final String text;
  const PreventCard({
    super.key,
    required this.image,
    required this.title,
    required this.text,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 10),
      child: SizedBox(
        height: 156,
        child: Stack(
          alignment: Alignment.centerLeft,
          children: [
            Container(
              height: 136,
              width: double.infinity,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
                color: Colors.white,
                boxShadow: [
                  BoxShadow(
                    offset: const Offset(0, 8),
                    blurRadius: 24,
                    color: kShadowColor,
                  )
                ],
              ),
            ),
            Image.asset(image),
            Positioned(
              left: 130,
              child: Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
                height: 136,
                width: MediaQuery.of(context).size.width - 170,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      title,
                      style: kTitleTextstyle.copyWith(
                        fontSize: 16,
                      ),
                    ),
                    Text(
                      text,
                      style: const TextStyle(
                        fontSize: 12,
                      ),
                    ),
                    Align(
                        alignment: Alignment.topRight,
                        child: SvgPicture.asset("assets/icons/forward.svg"))
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class SymptomsCard extends StatelessWidget {
  final String image;
  final String title;
  final bool isActive;
  const SymptomsCard({
    super.key,
    required this.image,
    required this.title,
    this.isActive = false,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(15),
        color: Colors.white,
        boxShadow: [
          isActive
              ? BoxShadow(
                  offset: const Offset(0, 10),
                  blurRadius: 20,
                  color: kActiveShadowColor,
                )
              : BoxShadow(
                  offset: const Offset(0, 3),
                  blurRadius: 6,
                  color: kShadowColor)
        ],
      ),
      child: Column(
        children: [
          Image.asset(
            image,
            height: 90,
          ),
          Text(
            title,
            style: const TextStyle(
              fontWeight: FontWeight.bold,
            ),
          )
        ],
      ),
    );
  }
}
