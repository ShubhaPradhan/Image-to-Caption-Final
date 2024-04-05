import 'package:image_caption_generator/app/data/caption_generation_response.dart';

import '../app/config/api_end_point.dart';
import '../app/services/api_client.dart';

class CaptionGenerationRepository {
  Future<ApiResponse<CaptionGenerationResponse>> generateCaption(
    image,
  ) async {
    final response = await ApiClient().postApi<CaptionGenerationResponse>(
      ApiUrls.imageUpload,
      requestBody: {},
      imageBody: image,
      responseType: (json) => CaptionGenerationResponse.fromJson(json),
      isMultiPartRequest: true,
      isTokenRequired: false,
    );
    return response;
  }
}
