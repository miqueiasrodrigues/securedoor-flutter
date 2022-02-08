class User {
  final String id;
  final String name;
  final String email;
  final String password;
  final String description;
  final bool isActive;

  const User({
    this.id = '',
    required this.name,
    required this.email,
    required this.password,
    required this.description,
    required this.isActive,
  });
}
