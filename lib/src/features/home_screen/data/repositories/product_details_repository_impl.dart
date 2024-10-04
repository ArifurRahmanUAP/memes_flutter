import '../../../../core/data/model/api_response.dart';
import '../../domain/repositories/product_details__repository.dart';
import '../model/memes_response_model.dart';

class HomeScreenRepositoryImpl extends HomeScreenRepository {
  HomeScreenRepositoryImpl(super.homeScreenDataSource);

  @override
  Future<Response<MemesResponseModel?>?> getMemes() async {
    return await homeScreenDataSource.getMemes();
  }



}
