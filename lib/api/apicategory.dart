// category.dart
class Category {
  final int id;
  final String name;
  final String slug;

  Category({
    required this.id,
    required this.name,
    required this.slug,
  });

  Category.fromJson(Map<String, dynamic> json)
      : id = json['id'] ?? 0,
        name = json['name'] ?? '',
        slug = json['slug'] ?? '';

  @override
  String toString() {
    return slug;
  }
}
