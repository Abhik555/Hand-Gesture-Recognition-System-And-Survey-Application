import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:tflite_flutter/tflite_flutter.dart';

part 'model_provider.g.dart';

@Riverpod(keepAlive: true)
class ModelProvider extends _$ModelProvider {
  @override
  int build() {
    return 0;
  }

  void changeModel(int n) {
    state = n;
  }

  List<int> getInputSize() {
    if (state == 0) {
      return [224, 224];
    } else {
      return [256, 256];
    }
  }

  List<int> getOutputList() {
    if (state == 0) {
      return [1, 7];
    } else {
      return [1, 19];
    }
  }

  Future<Interpreter> getInterpreter() async {
    switch (state) {
      case 0:
        Interpreter i =
            await Interpreter.fromAsset("assets/model_unquant.tflite");
        return i;
      case 1:
        Interpreter i =
            await Interpreter.fromAsset("assets/Simple_Hagrid_Model.tflite");
        return i;
      case 2:
        Interpreter i =
            await Interpreter.fromAsset("assets/Complex_Hagrid_Model.tflite");
        return i;
      case 3:
        Interpreter i =
            await Interpreter.fromAsset("assets/ResNET_Hagrid_Model.tflite");
        return i;
      default:
        Interpreter i =
            await Interpreter.fromAsset("assets/model_unquant.tflite");
        return i;
    }
  }

  List<dynamic> getLabels() {
    if (state == 0) {
      return ["Call", "Dislike", "Fist", "Four", "Like", "Mute", "No Gesture"];
    } else {
      return [
        'call',
        'dislike',
        'fist',
        'four',
        'like',
        'mute',
        'no gesture',
        'ok',
        'one',
        'palm',
        'peace',
        'peace inverted',
        'rock',
        'stop',
        'stop inverted',
        'three',
        'three2',
        'two up',
        'two up inverted'
      ];
    }
  }
}
