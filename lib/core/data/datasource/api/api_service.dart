import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';
import 'package:nutrisee/core/data/model/article/article.dart';
import 'package:retrofit/http.dart';
import '../../model/api_response.dart';
import '../../model/user.dart';
part '../../../../gen/core/data/datasource/api/api_service.g.dart';

@RestApi()
@Injectable() // dependensi yang diperlukan oleh kelas dengan anotasi injectable akan diresolve otomatis
abstract class ApiService {
  @factoryMethod // diperlukan anotasi factoryMethod jika objek dibuat menggunakan factory
  factory ApiService(Dio dio) = _ApiService;

  // sisanya sama persis seperti retrofit di android
  @GET('/user/{id}')
  Future<ApiResponse<User>> getUser(@Path('id') String userId);

  @GET('/top-headlines?country=id&category=health&apiKey={apikey}')
  Future<ArticleData> getArticle(
    @Path('apiKey') String apiKey,
  );
}
