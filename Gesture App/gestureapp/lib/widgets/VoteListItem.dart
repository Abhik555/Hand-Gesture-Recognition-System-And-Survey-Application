import 'package:flutter/material.dart';

class InfoCard extends StatelessWidget {
  final String title;
  final String body;
  final Function() onMoreTap;
  final Function() onVoteTap;
  final Color main;
  final Color mainAccent;

  final String subInfoTitle;
  final String subInfoText;
  final Widget subIcon;

  const InfoCard(
      {required this.title,
      this.body = """""",
      required this.onMoreTap,
      required this.onVoteTap,
      this.main = Colors.lightBlue,
      this.mainAccent = Colors.lightBlueAccent,
      this.subIcon = const CircleAvatar(
        backgroundColor: Colors.lightBlue,
        radius: 25,
        child: Icon(
          Icons.how_to_vote_rounded,
          color: Colors.white,
        ),
      ),
      this.subInfoText = "",
      this.subInfoTitle = "",
      super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(25.0),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(25.0),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(.05),
              offset: const Offset(0, 10),
              blurRadius: 0,
              spreadRadius: 0,
            )
          ],
          gradient: RadialGradient(
            colors: [mainAccent, main],
            focal: Alignment.topCenter,
            radius: .85,
          )),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                title,
                style: const TextStyle(
                    color: Colors.white,
                    fontSize: 26,
                    fontWeight: FontWeight.bold),
              ),
              Container(
                width: 75,
                height: 30,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(100.0),
                  gradient: const LinearGradient(
                      colors: [Colors.white, Colors.white],
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter),
                ),
                child: GestureDetector(
                  onTap: onMoreTap,
                  child: Center(
                      child: Text(
                    "More",
                    style: TextStyle(color: main),
                  )),
                ),
              ),
            ],
          ),
          const SizedBox(height: 10),
          Text(
            body,
            style:
                TextStyle(color: Colors.white.withOpacity(.95), fontSize: 14),
          ),
          const SizedBox(height: 15),
          GestureDetector(
            onTap: onVoteTap,
            child: Container(
              width: double.infinity,
              height: 75,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(25.0),
                color: Colors.white,
              ),
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  children: [
                    subIcon,
                    const SizedBox(width: 10),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          subInfoTitle,
                          style: TextStyle(
                              color: main.withOpacity(.95),
                              fontSize: 14),
                        ),
                        Text(
                          subInfoText,
                          style: TextStyle(
                            color: main,
                            fontSize: 22,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    )
                  ],
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
