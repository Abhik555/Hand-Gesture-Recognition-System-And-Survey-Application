import 'dart:typed_data';
//import 'dart:io';
import 'package:camera/camera.dart';
//import 'package:gal/gal.dart';
import 'package:image/image.dart' as img;
//import 'package:path_provider/path_provider.dart';
import 'package:tflite_flutter/tflite_flutter.dart';

// void saveImageToFile(img.Image image) async {
//   final directory = await getApplicationDocumentsDirectory();
//   String filePath = "${directory.path}/image.png";
//   // Convert the image to PNG format
//   List<int> pngBytes = img.encodePng(image);

//   Gal.putImageBytes(pngBytes as Uint8List);

//   // Write the PNG bytes to a file
//   File(filePath).writeAsBytesSync(pngBytes);
// }

List<dynamic> convertCameraImage(CameraImage image, int width , int height) {
  // Convert YUV420 to RGB
  //img.Image rgbImage = _convertYUV420ToImage(image);
  img.Image rgbImage = convertYUV420ToImage(image);

  // Rotate the image 90 degrees
  img.Image rotatedImage = img.copyRotate(rgbImage, angle: 90);

  // Resize the image to 256x256
  img.Image resizedImage = img.copyResize(rotatedImage, width: width, height: height);

  //saveImageToFile(resizedImage);

  // Convert the image to a list of shape [1, 256, 256, 3]
  List<dynamic> imageList = imageToArray(resizedImage , width , height);

  return imageList;
}

// void savetest(CameraImage image) async {
//   img.Image rgbImage = _convertYUV420ToImage(image);
//   img.Image resizedImage = img.copyResize(rgbImage, width: 224, height: 224);
//   await Gal.putImageBytes(resizedImage.data!.getBytes());
// }


img.Image convertYUV420ToImage(CameraImage cameraImage) {
    final imageWidth = cameraImage.width;
    final imageHeight = cameraImage.height;

    final yBuffer = cameraImage.planes[0].bytes;
    final uBuffer = cameraImage.planes[1].bytes;
    final vBuffer = cameraImage.planes[2].bytes;

    final int yRowStride = cameraImage.planes[0].bytesPerRow;
    final int yPixelStride = cameraImage.planes[0].bytesPerPixel!;

    final int uvRowStride = cameraImage.planes[1].bytesPerRow;
    final int uvPixelStride = cameraImage.planes[1].bytesPerPixel!;

    final image = img.Image(width: imageWidth, height: imageHeight);

    for (int h = 0; h < imageHeight; h++) {
      int uvh = (h / 2).floor();

      for (int w = 0; w < imageWidth; w++) {
        int uvw = (w / 2).floor();

        final yIndex = (h * yRowStride) + (w * yPixelStride);

        // Y plane should have positive values belonging to [0...255]
        final int y = yBuffer[yIndex];

        // U/V Values are subsampled i.e. each pixel in U/V chanel in a
        // YUV_420 image act as chroma value for 4 neighbouring pixels
        final int uvIndex = (uvh * uvRowStride) + (uvw * uvPixelStride);

        // U/V values ideally fall under [-0.5, 0.5] range. To fit them into
        // [0, 255] range they are scaled up and centered to 128.
        // Operation below brings U/V values to [-128, 127].
        final int u = uBuffer[uvIndex];
        final int v = vBuffer[uvIndex];

        // Compute RGB values per formula above.
        int r = (y + v * 1436 / 1024 - 179).round();
        int g = (y - u * 46549 / 131072 + 44 - v * 93604 / 131072 + 91).round();
        int b = (y + u * 1814 / 1024 - 227).round();

        r = r.clamp(0, 255);
        g = g.clamp(0, 255);
        b = b.clamp(0, 255);

        image.setPixelRgb(w, h, r, g, b);
      }
    }

    return image;
  }

// img.Image _convertYUV420ToImage(CameraImage image) {
//   final int width = image.width;
//   final int height = image.height;
//   final int uvRowStride = image.planes[1].bytesPerRow;
//   final int uvPixelStride = image.planes[1].bytesPerPixel!;

//   final img.Image imgImage = img.Image(width: width, height: height);

//   for (int y = 0; y < height; y++) {
//     for (int x = 0; x < width; x++) {
//       final int uvIndex = uvPixelStride * (x ~/ 2) + uvRowStride * (y ~/ 2);
//       final int index = y * width + x;

//       final int yValue = image.planes[0].bytes[index];
//       final int uValue = image.planes[1].bytes[uvIndex];
//       final int vValue = image.planes[2].bytes[uvIndex];

//       final int r = (yValue + (1.370705 * (vValue - 128))).toInt();
//       final int g =
//           (yValue - (0.337633 * (uValue - 128)) - (0.698001 * (vValue - 128)))
//               .toInt();
//       final int b = (yValue + (1.732446 * (uValue - 128))).toInt();

//       imgImage.setPixelRgb(x, y, r, g, b);
//     }
//   }

//   return imgImage;
// }

List<dynamic> imageToArray(img.Image inputImage , int w , int h) {
  img.Image resizedImage = img.copyResize(inputImage, width: w, height: h);
  List<double> flattenedList = resizedImage.data!
      .expand((channel) => [channel.r, channel.g, channel.b])
      .map((value) => value.toDouble())
      .toList();
  Float32List float32Array = Float32List.fromList(flattenedList);
  int channels = 3;
  int height = h;
  int width = w;
  Float32List reshapedArray = Float32List(1 * height * width * channels);
  for (int c = 0; c < channels; c++) {
    for (int h = 0; h < height; h++) {
      for (int w = 0; w < width; w++) {
        int index = c * height * width + h * width + w;
        reshapedArray[index] =
            (float32Array[c * height * width + h * width + w] - 127.5) / 127.5;
      }
    }
  }
  return reshapedArray.reshape([1, w, h, 3]);
}
