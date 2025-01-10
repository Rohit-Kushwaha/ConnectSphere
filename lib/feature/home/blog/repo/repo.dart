import 'package:career_sphere/data/remote/network/base_api.dart';
import 'package:career_sphere/data/remote/network/network_api.dart';
import 'package:career_sphere/feature/home/blog/model/res/blog_response.dart';
import 'package:career_sphere/utils/strings.dart';

abstract class BlogRepo {
  Future<List<BlogResponse>> getBlogs();
}

class BlogRepoImpl extends BlogRepo {
  BaseApiService apiService = NetworkApiService();
  @override
  Future<List<BlogResponse>> getBlogs() async {
    List<dynamic> json = await apiService.getApiResponse(ApiString.getBlog);
    // Parsing each object in the list
    return json.map((blog) => BlogResponse.fromJson(blog)).toList();
  }
}

