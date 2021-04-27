import 'dart:async';
import 'package:riverpod/riverpod.dart';
import 'package:riverpod_demo/data/models/repo.dart';
import 'package:riverpod_demo/data/network/array_response.dart';
import 'package:riverpod_demo/data/network/network_service.dart';
import 'package:riverpod_demo/data/providers/network_service_provider.dart';

final repoRepositoryProvider = StateProvider<RepoRepository>((ref) {
  final networkService = ref.watch(networkServiceProvider);

  return RepoRepositoryImpl(networkService.state);
});

abstract class RepoRepository {
  Future<ArrayResponse<Repo>> findRepos(String query);
}

class RepoRepositoryImpl extends RepoRepository {
  final NetworkService _networkService;

  RepoRepositoryImpl(this._networkService);

  @override
  Future<ArrayResponse<Repo>> findRepos(String query) {
    return _networkService.findRepos(query);
  }
}
