import 'package:dio/dio.dart';
import 'package:get/get.dart';
import 'package:get_it/get_it.dart';
import 'package:meme_app/src/features/home_screen/data/source/home_screen_data_source.dart';
import '../../features/home_screen/data/repositories/product_details_repository_impl.dart';
import '../../features/home_screen/domain/repositories/product_details__repository.dart';
import '../../features/home_screen/ui/controller/home_screen_controller.dart';
import '../../features/meme_details_screen/ui/controller/meme_details_screen_controller.dart';
import '../data/source/dio_client.dart';

final locator = GetIt.instance;

Future<void> init() async {
  locator.registerFactory<Dio>(() => Dio()
    ..interceptors.add(InterceptorsWrapper()));
  locator.registerFactory<DioClient>(() => DioClient(locator<Dio>()));

  locator.registerFactory<MemeDetailsController>(() => Get.put(MemeDetailsController()));
  locator.registerFactory<HomeScreenController>(() => Get.put(HomeScreenController()));
  locator.registerFactory<HomeScreenDataSource>(() => HomeScreenDataSource());
  locator.registerFactory<HomeScreenRepository>(
      () => HomeScreenRepositoryImpl(locator<HomeScreenDataSource>()));

}
