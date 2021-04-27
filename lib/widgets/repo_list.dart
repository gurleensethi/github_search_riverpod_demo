import 'package:flutter/material.dart';
import 'package:riverpod_demo/data/models/repo.dart';

class RepoList extends StatelessWidget {
  final List<Repo> repoList;

  const RepoList({
    Key? key,
    required this.repoList,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: repoList.length,
      itemBuilder: (context, index) {
        final repo = repoList[index];

        return Card(
          child: Container(
            padding: EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Flexible(
                      flex: 1,
                      fit: FlexFit.tight,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "${repo.fullName}",
                            style: TextStyle(
                              fontSize: 12.0,
                              letterSpacing: 1.0,
                              color: Colors.grey,
                            ),
                          ),
                          Text(
                            "${repo.name}",
                            style: TextStyle(
                              fontSize: 20.0,
                              color: Theme.of(context).accentColor,
                            ),
                          ),
                        ],
                      ),
                    ),
                    Icon(
                      Icons.star,
                      size: 16.0,
                      color: Colors.deepOrange,
                    ),
                    SizedBox(
                      width: 4.0,
                    ),
                    Text(
                      '${repo.stargazersCount}',
                      style: TextStyle(
                        fontSize: 14.0,
                        color: Colors.deepOrange,
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: 8.0,
                ),
                Text(
                  "${repo.description}",
                  style: TextStyle(
                    fontSize: 14.0,
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
