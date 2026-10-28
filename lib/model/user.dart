class User {
  final int? id;
  final String name;
  final String email;
  final String passwordHash;
  final DateTime createdAt;

  const User({
    this.id,
    required this.name,
    required this.email,
    required this.passwordHash,
    required this.createdAt,
  });

  factory User.fromMap(Map<String, dynamic> map) => User(
    id: map['id'] as int,
    name: map['name'] as String,
    email: map['email'] as String,
    passwordHash: map['password_hash'] as String,
    createdAt: DateTime.parse(map['created_at'] as String),
  );

  Map<String, dynamic> toMap() => {
    if (id != null) 'id': id,
    'name': name,
    'email': email,
    'password_hash': passwordHash,
    'created_at': createdAt.toIso8601String(),
  };
}