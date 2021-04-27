class ArrayResponse<T> {
  final int totalCount;
  final List<T> items;

  ArrayResponse({
    required this.totalCount,
    required this.items,
  });

  factory ArrayResponse.fromJson(
    Map<String, dynamic> json,
    T itemMapper(dynamic json),
  ) {
    return ArrayResponse(
      totalCount: json['total_count'],
      items: json['items'].map((item) => itemMapper(item)).toList().cast<T>(),
    );
  }
}
