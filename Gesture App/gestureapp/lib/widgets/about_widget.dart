import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class AboutMe extends ConsumerWidget {
  const AboutMe({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Column(
      children: [
        const Text(
          "About",
          style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 15.0),
        CircleAvatarWithTransition(
          primaryColor: Theme.of(context).colorScheme.primary,
          image: const NetworkImage(
            "https://github.com/Abhik555.png",
          ),
        ),
        const SizedBox(height: 15.0),
        const Text("Abthedev", style: TextStyle(fontSize: 20.0)),
        GitHubBtn1(onPressed: () {}),
        const SizedBox(height: 10.0),
        const Text("Version: 1.0", style: TextStyle(fontSize: 16.0)),
        const SizedBox(height: 10.0),
      ],
    );
  }
}

class CircleAvatarWithTransition extends StatelessWidget {
  /// the base color of the images background and its concentric circles.
  final Color primaryColor;

  /// the profile image to be displayed.
  final ImageProvider image;

  ///the diameter of the entire widget, including the concentric circles.
  final double size;

  /// the width between the edges of each concentric circle.
  final double transitionBorderwidth;

  const CircleAvatarWithTransition(
      {super.key,
      required this.primaryColor,
      required this.image,
      this.size = 190.0,
      this.transitionBorderwidth = 20.0});
  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: AlignmentDirectional.center,
      children: <Widget>[
        Container(
          height: size,
          width: size,
          decoration: BoxDecoration(
              shape: BoxShape.circle, color: primaryColor.withOpacity(0.05)),
        ),
        Container(
            height: size - transitionBorderwidth,
            width: size - transitionBorderwidth,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              gradient: RadialGradient(
                  stops: const [0.01, 0.5],
                  colors: [Colors.white, primaryColor.withOpacity(0.1)]),
            )),
        Container(
            height: size - (transitionBorderwidth * 2),
            width: size - (transitionBorderwidth * 2),
            decoration: BoxDecoration(
                shape: BoxShape.circle, color: primaryColor.withOpacity(0.4))),
        Container(
            height: size - (transitionBorderwidth * 3),
            width: size - (transitionBorderwidth * 3),
            decoration: BoxDecoration(
                shape: BoxShape.circle, color: primaryColor.withOpacity(0.5))),
        Container(
            height: size - (transitionBorderwidth * 4),
            width: size - (transitionBorderwidth * 4),
            decoration: BoxDecoration(
                shape: BoxShape.circle,
                image: DecorationImage(fit: BoxFit.cover, image: image)))
      ],
    );
  }
}

class GitHubBtn1 extends StatelessWidget {
  final Function() onPressed;
  const GitHubBtn1({
    required this.onPressed,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
        height: 54,
        margin: const EdgeInsets.all(15),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(15),
          color: Theme.of(context).colorScheme.primaryContainer,
        ),
        child: TextButton(
          style: ButtonStyle(
              shape: WidgetStateProperty.all(RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15)))),
          onPressed: onPressed,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.network(
                "https://firebasestorage.googleapis.com/v0/b/flutterbricks-public.appspot.com/o/socials%2Fgithub.png?alt=media&token=c8a341e8-2f34-490c-a924-627b84fa3c43",
                width: 20,
              ),
              const SizedBox(
                width: 10,
              ),
              Text("GitHub",
                  style: TextStyle(
                      color: Theme.of(context).colorScheme.onPrimaryContainer,
                      fontSize: 16)),
            ],
          ),
        ));
  }
}
