import '../../../../core/data/model/api_response.dart';
import '../../data/model/memes_response_model.dart';
import 'home_screen_use_case.dart';

class GetMemesUseCase extends HomeScreenUseCase {
  GetMemesUseCase(super.homeScreenRepository);

  Future<Response<MemesResponseModel?>?> call() async {
    return await homeScreenRepository.getMemes();
  }
}
