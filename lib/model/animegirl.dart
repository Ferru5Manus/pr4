class AnimeGirl {
  final String id;
  final String name;
  final String description;
  final String imagePath;
  final bool isAsset;
  int votes;

  AnimeGirl({
    required this.id,
    required this.name,
    required this.description,
    required this.imagePath,
    this.isAsset = true,
    this.votes = 0,
  });

  factory AnimeGirl.fromJson(Map<String, dynamic> json) {
    return AnimeGirl(
      id: json['id'],
      name: json['name'],
      description: json['description'],
      imagePath: json['imagePath'],
      isAsset: json['isAsset'] ?? true,
      votes: json['votes'] ?? 0,
    );
  }
}
