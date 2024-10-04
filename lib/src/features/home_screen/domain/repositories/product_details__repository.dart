import '../../../../core/data/model/api_response.dart';
import '../../data/model/memes_response_model.dart';
import '../../data/source/home_screen_data_source.dart';

abstract class HomeScreenRepository {
  final HomeScreenDataSource homeScreenDataSource;

  HomeScreenRepository(this.homeScreenDataSource);

  Future<Response<MemesResponseModel?>?> getMemes();
}
