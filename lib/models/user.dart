class User {
  final String id;
  final String phoneNumber;
  final String? name;
  final String? email;

  User({
    required this.id,
    required this.phoneNumber,
    this.name,
    this.email,
  });

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      id: json['id'],
      phoneNumber: json['phoneNumber'],
      name: json['name'],
      email: json['email'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'phoneNumber': phoneNumber,
      'name': name,
      'email': email,
    };
  }

  User copyWith({
    String? id,
    String? phoneNumber,
    String? name,
    String? email,
  }) {
    return User(
      id: id ?? this.id,
      phoneNumber: phoneNumber ?? this.phoneNumber,
      name: name ?? this.name,
      email: email ?? this.email,
    );
  }
}
