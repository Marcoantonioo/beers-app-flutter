class Beer {
  final int? id;
  final String? name;
  final String? tagline;
  final String? firstBrewed;
  final String? description;
  final String? imageUrl;

  Beer({
    this.id,
    this.name,
    this.tagline,
    this.firstBrewed,
    this.description,
    this.imageUrl,
  });

  factory Beer.fromMap(Map<String, dynamic> map) {
    return Beer(
      id: map['id'],
      name: map['name'],
      tagline: map['tagline'],
      firstBrewed: map['first_brewed'],
      description: map['description'],
      imageUrl: map['image_url'],
    );
  }

  factory Beer.fromJson(Map<String, dynamic> json) => Beer.fromMap(json);
}
