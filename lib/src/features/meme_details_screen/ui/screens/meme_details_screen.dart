import 'dart:async';
import 'dart:io';
import 'dart:math';
import 'dart:typed_data';
import 'dart:ui' as ui; // Ensure you import 'dart:ui' for the UI image handling
import 'package:custom_image_crop/custom_image_crop.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:meme_app/src/core/di/app_component.dart';
import 'package:meme_app/src/features/home_screen/data/model/memes_response_model.dart';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';

import '../controller/meme_details_screen_controller.dart';

class MemeDetailsScreen extends StatelessWidget {
  MemeDetailsScreen({required this.memesResponse, super.key});

  final Memes memesResponse;
  final memeDetailsController = locator<MemeDetailsController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 3,
        title: Text(memesResponse.name!),
      ),
      body: Obx(() {
        return Column(
          children: [
            Expanded(
              child: CustomImageCrop(
                cropController: memeDetailsController.controller.value,
                image: NetworkImage(memesResponse.url!),
                shape: memeDetailsController.currentShape.value,
                ratio: memeDetailsController.currentShape.value ==
                    CustomCropShape.Ratio
                    ? Ratio(width: 16, height: 9)
                    : null,
                canRotate: true,
                canMove: false,
                forceInsideCropArea: true,
                canScale: true,
                clipShapeOnCrop: false,
                borderRadius:
                memeDetailsController.currentShape.value ==
                    CustomCropShape.Ratio ? 4 : 0,
                customProgressIndicator: const CupertinoActivityIndicator(),
                imageFit: memeDetailsController.imageFit.value,
                pathPaint: Paint()
                  ..color = Colors.red
                  ..strokeWidth = 4.0
                  ..style = PaintingStyle.stroke
                  ..strokeJoin = StrokeJoin.round,
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                IconButton(
                    icon: const Icon(Icons.refresh),
                    onPressed: memeDetailsController.controller.value.reset),

                IconButton(
                    icon: const Icon(Icons.rotate_left),
                    onPressed: () =>
                        memeDetailsController.controller.value.addTransition(
                            CropImageData(angle: -pi / 4))),
                IconButton(
                    icon: const Icon(Icons.rotate_right),
                    onPressed: () =>
                        memeDetailsController.controller.value.addTransition(
                            CropImageData(angle: pi / 4))),
                PopupMenuButton(
                  icon: const Icon(Icons.crop_original),
                  onSelected: (value) {
                    memeDetailsController.currentShape.value = value;
                  },
                  itemBuilder: (BuildContext context) {
                    return CustomCropShape.values.map(
                          (shape) {
                        return PopupMenuItem(
                          value: shape,
                          child: getShapeIcon(shape),
                        );
                      },
                    ).toList();
                  },
                ),
                PopupMenuButton(
                  icon: const Icon(Icons.fit_screen),
                  onSelected: (value) {
                    memeDetailsController.imageFit.value = value;
                  },
                  itemBuilder: (BuildContext context) {
                    return CustomImageFit.values.map(
                          (imageFit) {
                        return PopupMenuItem(
                          value: imageFit,
                          child: Text(imageFit.label),
                        );
                      },
                    ).toList();
                  },
                ),
                IconButton(
                  icon: const Icon(
                    Icons.save,
                    color: Colors.green,
                  ),
                  onPressed: () => memeDetailsController.saveImageToGallery(memesResponse: memesResponse, context: context)
                ),
              ],
            ),
            SizedBox(height: MediaQuery
                .of(context)
                .padding
                .bottom),
          ],
        );
      }),
    );
  }

  Widget getShapeIcon(CustomCropShape shape) {
    switch (shape) {
      case CustomCropShape.Circle:
        return const Row(
          children: [
            Icon(Icons.circle_outlined),
            Text("Circle")
          ],
        );
      case CustomCropShape.Square:
        return const Row(
          children: [
            Icon(Icons.square_outlined),
            Text("Square")
          ],
        );
      case CustomCropShape.Ratio:
        return const Row(
          children: [
            Icon(Icons.crop_16_9_outlined),
            Text("Rectangle")
          ],
        );
    }
  }
}

extension CustomImageFitExtension on CustomImageFit {
  String get label {
    switch (this) {
      case CustomImageFit.fillCropSpace:
        return 'Fill crop space';
      case CustomImageFit.fitCropSpace:
        return 'Fit crop space';
      case CustomImageFit.fillCropHeight:
        return 'Fill crop height';
      case CustomImageFit.fillCropWidth:
        return 'Fill crop width';
      case CustomImageFit.fillVisibleSpace:
        return 'Fill visible space';
      case CustomImageFit.fitVisibleSpace:
        return 'Fit visible space';
      case CustomImageFit.fillVisibleHeight:
        return 'Fill visible height';
      case CustomImageFit.fillVisibleWidth:
        return 'Fill visible width';
    }
  }
}
