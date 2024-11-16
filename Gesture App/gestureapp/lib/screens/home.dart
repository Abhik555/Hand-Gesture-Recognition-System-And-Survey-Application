import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gestureapp/providers/pageselector/pageindex_provider.dart';
import 'package:gestureapp/screens/detection_screen.dart';
import 'package:gestureapp/screens/settings.dart';
import 'package:gestureapp/screens/vote.dart';
import 'package:google_fonts/google_fonts.dart';

class HomePage extends ConsumerStatefulWidget {
  const HomePage({super.key, required this.camera});

  final List<CameraDescription> camera;

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _HomePageState();
}

class _HomePageState extends ConsumerState<HomePage> {
  Widget getTitle(int index) {
    switch (index) {
      case 0:
        return Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Text(
              "Detect",
              style: GoogleFonts.roboto(
                  textStyle: const TextStyle()
                      .copyWith(fontSize: 30.0, fontWeight: FontWeight.bold)),
            ),
          ],
        );
      case 1:
        return Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Text(
              "Vote",
              style: GoogleFonts.roboto(
                  textStyle: const TextStyle()
                      .copyWith(fontSize: 30.0, fontWeight: FontWeight.bold)),
            ),
          ],
        );
      case 2:
        return Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Text(
              "Settings",
              style: GoogleFonts.roboto(
                  textStyle: const TextStyle()
                      .copyWith(fontSize: 30.0, fontWeight: FontWeight.bold)),
            ),
          ],
        );
      default:
        return Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Text(
              "Detect",
              style: GoogleFonts.roboto(
                  textStyle: const TextStyle()
                      .copyWith(fontSize: 30.0, fontWeight: FontWeight.bold)),
            ),
          ],
        );
    }
  }

  @override
  Widget build(BuildContext context) {
    //bool isDark = ref.watch(isDarkProvider);
    int pageIndex = ref.watch(pageIndexProvider);

    return Scaffold(
      appBar: AppBar(
        title: getTitle(pageIndex),
        centerTitle: true,
      ),
      bottomNavigationBar: NavigationBar(
        destinations: const <Widget>[
          NavigationDestination(icon: Icon(Icons.search), label: "Detect"),
          NavigationDestination(
              icon: Icon(Icons.bar_chart_rounded), label: "Vote"),
          NavigationDestination(icon: Icon(Icons.settings), label: "Settings"),
        ],
        selectedIndex: pageIndex,
        onDestinationSelected: (value) {
          ref.read(pageIndexProvider.notifier).update(value);
        },
      ),
      //body: DetectPane()
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const SizedBox(
            height: 12.0,
          ),
          if (pageIndex == 0) Expanded(child: DetectionScreen(camera: widget.camera)),
          if (pageIndex == 1) const VotePage(),
          if (pageIndex == 2) const SettingsPage(),
        ],
      ),
    );
  }
}
