class RepoModel {
  final int id;
  final String name;
  final bool private;
  final String description;
  final int stargazers_count;
  final int watchers_count;
  final String language;

  RepoModel(this.id, this.name, this.private, this.description,
      this.stargazers_count, this.watchers_count, this.language);

  factory RepoModel.fromJson(Map<String, dynamic> parsedJson) {
    return RepoModel(
        parsedJson['id'],
        parsedJson['name'],
        parsedJson['private'],
        parsedJson['description'],
        parsedJson['stargazers_count'],
        parsedJson['watchers_count'],
        parsedJson['language']);
  }
}
