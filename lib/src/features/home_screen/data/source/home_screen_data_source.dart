import '../../../../core/data/source/dio_client.dart';
import '../../../../core/di/app_component.dart';
import '../../../../core/data/model/api_response.dart';
import '../model/memes_response_model.dart';

class HomeScreenDataSource {
  final DioClient _dioClient = locator<DioClient>();

  Future<Response<MemesResponseModel>?> getMemes() async {
    Response<MemesResponseModel>? apiResponse;
    await _dioClient.get(
      path: "https://api.imgflip.com/get_memes",
      responseCallback: (response, message) {
        apiResponse = Response.success(MemesResponseModel.fromJson(response));
      },
      failureCallback: (message, status) {
        apiResponse = Response.error(message, status);
      },
    );
    return apiResponse;
  }
}
