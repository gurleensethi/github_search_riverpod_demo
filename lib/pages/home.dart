import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_demo/data/task.dart';
import 'package:riverpod_demo/providers/github_search/github_search_state_notifier.dart';
import 'package:riverpod_demo/providers/github_search/github_search_state_provider.dart';
import 'package:riverpod_demo/widgets/repo_list.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final _queryTextController = TextEditingController(text: "");

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Github Search (Riverpod Demo)",
        ),
      ),
      body: Container(
        padding: EdgeInsets.all(16.0),
        child: ProviderListener<GithubSearchState>(
          provider: githubSearchStateProvider,
          onChange: (context, state) {
            switch (state.items.status) {
              case TaskStatus.error:
                ScaffoldMessenger.of(context).hideCurrentSnackBar();
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text(
                      state.items.error?.toString() ?? "Some Error Occurred",
                      style: TextStyle(
                        color: Colors.white,
                      ),
                    ),
                    backgroundColor: Colors.red,
                  ),
                );
                break;
              case TaskStatus.initial:
                break;
              case TaskStatus.loading:
                break;
              case TaskStatus.success:
                ScaffoldMessenger.of(context).hideCurrentSnackBar();
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text(
                      "${state.items.data!.length} total items found for '${_queryTextController.text}'.",
                      style: TextStyle(
                        color: Colors.white,
                      ),
                    ),
                    backgroundColor: Colors.green,
                  ),
                );
                break;
            }
          },
          child: Consumer(
            builder: (context, watch, _) {
              final gitHubSeachState = watch(githubSearchStateProvider);

              return Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Card(
                    child: Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Column(
                        children: [
                          TextField(
                            controller: _queryTextController,
                            decoration: InputDecoration(
                              labelText: 'Search GitHub Repos',
                              enabled: gitHubSeachState.items.status !=
                                  TaskStatus.loading,
                            ),
                          ),
                          SizedBox(
                            height: 16.0,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              ElevatedButton(
                                onPressed: gitHubSeachState.items.status ==
                                        TaskStatus.loading
                                    ? null
                                    : () {
                                        context
                                            .read(githubSearchStateProvider
                                                .notifier)
                                            .search(_queryTextController.text);
                                      },
                                child: Text('Search'),
                              ),
                              SizedBox(
                                width: 20.0,
                              ),
                              ElevatedButton(
                                onPressed: gitHubSeachState.items.status ==
                                        TaskStatus.loading
                                    ? null
                                    : () {
                                        context
                                            .read(githubSearchStateProvider
                                                .notifier)
                                            .search(_queryTextController.text,
                                                true);
                                      },
                                child: Text('Produce Fake Error'),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                  if (gitHubSeachState.items.status == TaskStatus.loading)
                    Container(
                      margin: EdgeInsets.all(16.0),
                      child: CircularProgressIndicator(),
                    ),
                  if (gitHubSeachState.items.status == TaskStatus.success) ...[
                    Padding(
                      padding: EdgeInsets.all(8.0),
                      child: Align(
                        alignment: Alignment.centerLeft,
                        child: Text(
                          'Results',
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 16.0,
                          ),
                        ),
                      ),
                    ),
                    Expanded(
                      child: RepoList(
                        repoList: gitHubSeachState.items.data!,
                      ),
                    )
                  ],
                ],
              );
            },
          ),
        ),
      ),
    );
  }
}
