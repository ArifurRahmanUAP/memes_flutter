import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:meme_app/src/features/home_screen/domain/repositories/product_details__repository.dart';
import 'package:meme_app/src/features/home_screen/domain/usecase/product_details_usecase.dart';

import '../../../../core/di/app_component.dart';
import '../../data/model/memes_response_model.dart';

class HomeScreenController extends GetxController {
  final isLoginLoading = false.obs;
  final memesResponseModel = MemesResponseModel().obs;
  final  filteredMemes = <Memes>[].obs;
  final controller = TextEditingController().obs;

  Future<void> getMemesApiCall() async {
    try {
      isLoginLoading.value = true;
      final productListByLensTypeUseCase =
          GetMemesUseCase(locator<HomeScreenRepository>());
      var response = await productListByLensTypeUseCase();

      if (response != null && response.data != null) {
        memesResponseModel.value = response.data!;
      } else {
        // showSnackBar('Server error! Please try again.'.tr, 2, () {});
      }
    } finally {
      isLoginLoading.value = false;
    }
  }
}
