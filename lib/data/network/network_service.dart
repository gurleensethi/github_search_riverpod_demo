import 'dart:async';
import 'package:dio/dio.dart';
import 'package:riverpod_demo/data/models/repo.dart';
import 'package:riverpod_demo/data/network/array_response.dart';

class NetworkService {
  final Dio _dio = Dio(
    BaseOptions(
      baseUrl: "https://api.github.com/",
    ),
  );

  Future<ArrayResponse<Repo>> findRepos(String query) async {
    final response = await _dio.get(
      "/search/repositories",
      queryParameters: {'q': query},
    );

    return ArrayResponse.fromJson(response.data, (json) => Repo.fromJson(json));
  }
}
