class GithubUser {
  final String login;
  final String? name;
  final String? avatarUrl;
  final String htmlUrl;
  final String? bio;
  final int followers;
  final int following;
  final int publicRepos;
  final String? company;
  final String? blog;
  final String? location;
  final String createdAt;

  GithubUser({
    required this.login,
    this.name,
    this.avatarUrl,
    required this.htmlUrl,
    this.bio,
    required this.followers,
    required this.following,
    required this.publicRepos,
    this.company,
    this.blog,
    this.location,
    required this.createdAt,
  });

  factory GithubUser.fromJson(Map<String, dynamic> json) {
    return GithubUser(
      login: json['login'] as String,
      name: json['name'] as String?,
      avatarUrl: json['avatar_url'] as String?,
      htmlUrl: json['html_url'] as String,
      bio: json['bio'] as String?,
      followers: json['followers'] as int,
      following: json['following'] as int,
      publicRepos: json['public_repos'] as int,
      company: json['company'] as String?,
      blog: json['blog'] as String?,
      location: json['location'] as String?,
      createdAt: json['created_at'] as String,
    );
  }
}
