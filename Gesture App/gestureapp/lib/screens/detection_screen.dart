import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gestureapp/providers/modelprovider/model_provider.dart';
import 'package:gestureapp/utils/image_helper.dart';
import 'package:tflite_flutter/tflite_flutter.dart';

class DetectionScreen extends ConsumerStatefulWidget {
  const DetectionScreen({super.key, required this.camera});

  final List<CameraDescription> camera;

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _DetectionScreenState();
}

class _DetectionScreenState extends ConsumerState<DetectionScreen> {
  late Interpreter _interpreter;
  late CameraController controller;
  bool isModelLoaded = false;
  int camID = 0;
  String pred = "Not Predicting";
  String conf = "0";

  @override
  void initState() {
    super.initState();
    _loadCamera();
    _loadModel();
    setState(() {});
  }

  @override
  void dispose() {
    super.dispose();
    if (controller.value.isStreamingImages) {
      controller.stopImageStream();
    }
    controller.dispose();
    _interpreter.close();
  }

  void _loadCamera() async {
    controller = CameraController(widget.camera[camID], ResolutionPreset.medium,
        enableAudio: false, fps: 30, imageFormatGroup: ImageFormatGroup.yuv420);

    controller.initialize().then((_) {
      if (!mounted) {
        return;
      }
      setState(() {});
    }).catchError((Object e) {
      if (e is CameraException) {
        switch (e.code) {
          case 'CameraAccessDenied':
            // Handle access errors here.
            break;
          default:
            // Handle other errors here.
            break;
        }
      }
    });
  }

  void _loadModel() async {
    _interpreter = await ref
        .watch(modelProviderProvider.notifier)
        .getInterpreter()
        .then((v) {
      setState(() {
        isModelLoaded = true;
      });

      return v;
    });
    setState(() {
      isModelLoaded = true;
    });
  }

  void _predict() async {
    if (controller.value.isInitialized) {
      if (isModelLoaded) {
        int frame = 0;
        var modelnoti = ref.watch(modelProviderProvider.notifier);
        List<dynamic> inputsize = modelnoti.getInputSize();
        controller.startImageStream((image) {
          if (frame % 60 == 0) {
            List output = List.filled(
                    modelnoti.getOutputList()[0] * modelnoti.getOutputList()[1],
                    0.0)
                .reshape([
              modelnoti.getOutputList()[0],
              modelnoti.getOutputList()[1]
            ]);
            List<dynamic> input =
                convertCameraImage(image, inputsize[0], inputsize[1]);

            _interpreter.run(input, output);

            int maxIndex = 0;
            double maxConfidence = output[0][0];
            for (int i = 1; i < output[0].length; i++) {
              if (output[0][i] > maxConfidence) {
                maxConfidence = output[0][i];
                maxIndex = i;
              }
            }

            String outputClass = modelnoti.getLabels()[maxIndex];
            setState(() {
              pred =
                  "$outputClass\nConfidence:${(maxConfidence * 100).round()}%";
            });
            frame = 0;
          } else {
            frame++;
          }
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    if (isModelLoaded && controller.value.isInitialized) {
      return Column(
        children: [
          if (controller.value.isInitialized)
            Stack(
              alignment: Alignment.bottomCenter,
              children: [
                CameraPreview(controller),
                Container(
                  color: Colors.black54,
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    pred,
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 24.0,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ],
            ),
          const SizedBox(height: 10),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              ElevatedButton(
                onPressed: () {
                  setState(() {
                    //isPredicting = true;
                    _predict();
                  });
                },
                child: const Text("Start Prediction"),
              ),
              const SizedBox(height: 10),
              ElevatedButton(
                onPressed: () {
                  setState(() {
                    if (controller.value.isStreamingImages) {
                      controller.stopImageStream();
                    }
                    //isPredicting = false;
                    pred = "Not Predicting";
                  });
                },
                child: const Text("Stop Prediction"),
              ),
              IconButton(
                  onPressed: () {
                    camID = camID == 0 ? 1 : 0;
                    setState(() {
                      isModelLoaded = false;
                    });
                    _loadCamera();
                    setState(() {
                      isModelLoaded = true;
                    });
                  },
                  icon: const Icon(Icons.cameraswitch))
            ],
          ),
        ],
      );
    } else {
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const SizedBox(height: 10),
            const CircularProgressIndicator(),
            const SizedBox(height: 10),
            const Text("Getting things ready..."),
            const Text("Please wait before loading model"),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                _loadModel();
              },
              child: const Text("Load Model"),
            ),
          ],
        ),
      );
    }
  }
}
