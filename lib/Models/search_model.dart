import 'user_model.dart';

class SearchModel {
  final int total_count;
  final bool incomplete_results;
  final List<UserModel> items;

  SearchModel({this.total_count, this.incomplete_results, this.items});

  factory SearchModel.fromJson(Map<String, dynamic> parsedJson) {
    List<UserModel> items = List<UserModel>();

    for (var item in parsedJson['items']) {
      items.add(UserModel.fromJson(item));
    }

    return SearchModel(
        total_count: parsedJson['total_count'],
        incomplete_results: parsedJson['incomplete_results'],
        items: items);
  }
}
