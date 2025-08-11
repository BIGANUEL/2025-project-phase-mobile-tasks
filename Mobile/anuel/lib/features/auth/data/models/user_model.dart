import '../../domain/entities/user.dart';

class UserModel extends User {
  const UserModel({
    required String id,
    required String name,
    required String email,
  }) : super(id: id, name: name, email: email);

  /// Factory constructor to create a UserModel from JSON
  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      // Use `_id` if backend sends MongoDB-like object, otherwise 'id'
      id: json['_id'] ?? json['id'] ?? '',
      name: json['name'] ?? '',
      email: json['email'] ?? '',
    );
  }

  /// Convert this UserModel into a User entity
  User toEntity() {
    return User(id: id, name: name, email: email);
  }

  /// Convert a User entity into a UserModel
  factory UserModel.fromEntity(User user) {
    return UserModel(id: user.id, name: user.name, email: user.email);
  }

  /// Convert UserModel to JSON for API requests
  Map<String, dynamic> toJson() {
    return {'id': id, 'name': name, 'email': email};
  }
}
