class UserModel {
  final String login;
  final int id;
  final String node_id;
  final String avatar_url;
  final String gravatar_id;
  final String url;
  final String html_url;
  final String followers_url;
  final String following_url;
  final String gists_url;
  final String starred_url;
  final String subscriptions_url;
  final String organizations_url;
  final String repos_url;
  final String events_url;
  final String received_events_url;
  final String type;
  final bool site_admin;
  final double score;

  UserModel(
      {this.login,
      this.id,
      this.node_id,
      this.avatar_url,
      this.gravatar_id,
      this.url,
      this.html_url,
      this.followers_url,
      this.following_url,
      this.gists_url,
      this.starred_url,
      this.subscriptions_url,
      this.organizations_url,
      this.repos_url,
      this.events_url,
      this.received_events_url,
      this.type,
      this.site_admin,
      this.score});

  factory UserModel.fromJson(Map<String, dynamic> parsedJson) {
    return UserModel(
        login: parsedJson['login'],
        id: parsedJson['id'],
        node_id: parsedJson['node_id'],
        avatar_url: parsedJson['avatar_url'],
        gravatar_id: parsedJson['gravatar_id'],
        url: parsedJson['url'],
        html_url: parsedJson['html_url'],
        followers_url: parsedJson['followers_url'],
        following_url: parsedJson['following_url'],
        gists_url: parsedJson['gists_url'],
        starred_url: parsedJson['starred_url'],
        subscriptions_url: parsedJson['subscriptions_url'],
        organizations_url: parsedJson['organizations_url'],
        repos_url: parsedJson['repos_url'],
        events_url: parsedJson['events_url'],
        received_events_url: parsedJson['received_events_url'],
        type: parsedJson['type'],
        site_admin: parsedJson['site_admin'],
        score: parsedJson['score']);
  }
}
