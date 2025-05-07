class User{
  final String slug;
  final String name;
  final String email;
  final String role;

  User({required this.slug, required this.name, required this.email, required this.role});

  factory User.fromJson(Map<String, dynamic> json) {
  return User(
    slug: json['slug'] ?? '',
    name: json['name'] ?? '',
    email: json['email'] ?? '',
    role: json['role'] ?? '',
  );
}
}