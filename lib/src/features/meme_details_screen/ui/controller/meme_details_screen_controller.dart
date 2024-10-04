import 'dart:async';
import 'dart:io';
import 'dart:ui' as ui; // Ensure you import 'dart:ui' for the UI image handling
import 'package:custom_image_crop/custom_image_crop.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:permission_handler/permission_handler.dart';
import 'dart:typed_data';
import 'package:meme_app/src/features/home_screen/data/model/memes_response_model.dart';

class MemeDetailsController extends GetxController {
  final isLoginLoading = false.obs;

  final controller = CustomImageCropController().obs;
  final currentShape = CustomCropShape.Circle.obs;
  final imageFit = CustomImageFit.fillCropSpace.obs;
  final radiusController = TextEditingController().obs;

  Future<void> saveImageToGallery({required Memes memesResponse, required context}) async {
    final status = await Permission.storage.request();
    if (status.isDenied) {
      // You can show a dialog or toast to inform the user that permission is needed
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
        content: Text("Storage permission is denied. Please enable it in settings."),
      ));
    }

    final croppedImage = await controller.value.onCropImage();

    if (croppedImage != null) {
      final Completer<ui.Image> completer = Completer();
      final ImageStream stream = croppedImage.resolve(ImageConfiguration.empty);

      // Add a listener to the image stream
      stream.addListener(
          ImageStreamListener((ImageInfo info, bool synchronousCall) {
        completer.complete(info.image);
      }));

      // Wait for the image to be loaded
      final ui.Image img = await completer.future;

      // Convert the ui.Image to ByteData
      ByteData? byteData = await img.toByteData(format: ui.ImageByteFormat.png);
      Uint8List pngBytes = byteData!.buffer.asUint8List();

      final Directory? dcimDir = Directory('/storage/emulated/0/DCIM/MEME');

      // Define the directory and file path
      final String directoryPath = dcimDir!.path;
      final String filePath = '$directoryPath/${memesResponse.name}.png';

      final Directory newDir = Directory(directoryPath);
      if (!await newDir.exists()) {
        await newDir.create(recursive: true);
      }

      // Create the directory if it doesn't exist
      final File file = File(filePath);
      await file.writeAsBytes(pngBytes);

      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
        content: Text("Image successfully saved to mobile"),
      ));
    }
  }
}
