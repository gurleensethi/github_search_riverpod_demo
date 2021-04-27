import 'package:riverpod/riverpod.dart';
import 'package:riverpod_demo/data/models/repo.dart';
import 'package:riverpod_demo/data/repository/repo_repository.dart';
import 'package:riverpod_demo/data/task.dart';

class GithubSearchState {
  final Task<List<Repo>> items;

  GithubSearchState({
    required this.items,
  });

  GithubSearchState copyWith({
    String? query,
    Task<List<Repo>>? items,
  }) {
    return GithubSearchState(
      items: items ?? this.items,
    );
  }
}

final initialState = GithubSearchState(
  items: Task(status: TaskStatus.initial),
);

class GithubSearchStateNotifier extends StateNotifier<GithubSearchState> {
  RepoRepository _repoRepository;

  GithubSearchStateNotifier(this._repoRepository) : super(initialState);

  void search(String query, [bool produceError = false]) async {
    // This is a fake error
    if (produceError) {
      state = state.copyWith(
        items: Task(
          status: TaskStatus.loading,
          data: state.items.data,
        ),
      );

      Future.delayed(Duration(seconds: 1), () {
        state = state.copyWith(
          items: Task(
            status: TaskStatus.error,
            error: Exception("Error occurred (fake error)!"),
          ),
        );
      });
      return;
    }

    if (!produceError && query.isNotEmpty) {
      state = state.copyWith(
        items: Task(
          status: TaskStatus.loading,
          data: state.items.data,
        ),
      );

      try {
        final result = await _repoRepository.findRepos(query);

        state = state.copyWith(
          items: Task(
            status: TaskStatus.success,
            data: result.items,
          ),
        );
      } catch (error) {
        state = state.copyWith(
          items: Task(
            status: TaskStatus.error,
            error: error,
          ),
        );
      }
    }
  }
}
