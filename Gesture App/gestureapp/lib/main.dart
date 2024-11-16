import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gestureapp/providers/thememode/thememode_provider.dart';
import 'package:gestureapp/screens/home.dart';
import 'package:gestureapp/themes/theme.dart';
import 'package:gestureapp/themes/util.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  List<CameraDescription> _cameras = await availableCameras();

  runApp(ProviderScope(child: App(cameras: _cameras)));
}

class App extends ConsumerStatefulWidget {
  const App({super.key, required this.cameras});

  final List<CameraDescription> cameras;

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _AppState();
}

class _AppState extends ConsumerState<App> {
  @override
  Widget build(BuildContext context) {
    TextTheme textTheme = createTextTheme(context, "Roboto", "Roboto");
    MaterialTheme theme = MaterialTheme(textTheme);

    bool isDark = ref.watch(isDarkProvider);

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: "GestVision",
      theme: isDark ? theme.dark() : theme.light(),
      home: HomePage(camera: widget.cameras),
    );
  }
}
