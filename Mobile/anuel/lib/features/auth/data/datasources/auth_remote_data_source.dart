import 'dart:convert';
import 'package:http/http.dart' as http;
import '../../domain/entities/user.dart';
import '../models/user_model.dart';

abstract class AuthRemoteDataSource {
  Future<User> signUp(String name, String email, String password);
  Future<User> signIn(String email, String password);
}

class AuthRemoteDataSourceImpl implements AuthRemoteDataSource {
  final http.Client client;
  static const String _baseUrl = 'https://g5-flutter-learning-path-be-tvum.onrender.com';
  static const String _signUpEndpoint = '/api/v2/auth/register';
  static const String _signInEndpoint = '/api/v2/auth/login';

  AuthRemoteDataSourceImpl({required this.client});

  @override
  Future<User> signUp(String name, String email, String password) async {
    try {
      final response = await client.post(
        Uri.parse('$_baseUrl$_signUpEndpoint'),
        headers: {
          'Content-Type': 'application/json',
          'Accept': 'application/json',
        },
        body: jsonEncode({
          'name': name,
          'email': email,
          'password': password
        }),
      );

      return _handleResponse(response);
    } catch (e) {
      throw Exception('Failed to sign up: ${e.toString()}');
    }
  }

  @override
  Future<User> signIn(String email, String password) async {
    try {
      final response = await client.post(
        Uri.parse('$_baseUrl$_signInEndpoint'),
        headers: {
          'Content-Type': 'application/json',
          'Accept': 'application/json',
        },
        body: jsonEncode({
          'email': email,
          'password': password
        }),
      );

      return _handleResponse(response);
    } catch (e) {
      throw Exception('Failed to sign in: ${e.toString()}');
    }
  }

  User _handleResponse(http.Response response) {
    switch (response.statusCode) {
      case 200:
      case 201:
        try {
          final jsonMap = jsonDecode(response.body);
          if (jsonMap['data'] == null) {
            throw FormatException('Missing data field in response');
          }
          return UserModel.fromJson(jsonMap['data']).toEntity();
        } on FormatException catch (e) {
          throw Exception('Invalid response format: ${e.message}');
        }
      case 400:
        throw Exception('Validation error: ${response.body}');
      case 401:
        throw Exception('Invalid credentials');
      case 403:
        throw Exception('Forbidden: ${response.body}');
      case 404:
        throw Exception('Endpoint not found');
      case 500:
        throw Exception('Server error: Please try again later');
      default:
        throw Exception('Request failed with status: ${response.statusCode}');
    }
  }
}