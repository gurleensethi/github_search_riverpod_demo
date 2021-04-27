import 'package:riverpod/riverpod.dart';
import 'package:riverpod_demo/data/repository/repo_repository.dart';
import 'package:riverpod_demo/providers/github_search/github_search_state_notifier.dart';

final githubSearchStateProvider =
    StateNotifierProvider<GithubSearchStateNotifier, GithubSearchState>(
  (ref) {
    final repoRepository = ref.watch(repoRepositoryProvider);
    return GithubSearchStateNotifier(repoRepository.state);
  },
);
