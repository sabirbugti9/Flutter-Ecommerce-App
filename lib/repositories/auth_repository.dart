import 'package:dio/dio.dart';
import 'package:velvet_app/models/user_model.dart';

class AuthRepository {
  final Dio _dio = Dio(BaseOptions(baseUrl: 'https://api.escuelajs.co/api/v1'));

  // Login Method
  Future<UserModel> login(String email, String password) async {
    try {
      final response = await _dio.post('/auth/login', data: {
        'email': email,
        'password': password,
      });

      if (response.statusCode == 200 || response.statusCode == 201) {
        return UserModel.fromJson(response.data);
      } else {
        throw Exception('Failed to login');
      }
    } catch (e) {
      throw Exception('Error: $e');
    }
  }

  // Register Method
  Future<UserModel> register(String name, String email, String password) async {
    try {
      final response = await _dio.post('/users', data: {
        'name': name,
        'email': email,
        'password': password,
        'avatar': 'https://i.pravatar.cc/300' // Avatar default
      });

      if (response.statusCode == 200 || response.statusCode == 201) {
        return await login(email, password);
      } else {
        throw Exception('Failed to register');
      }
    } catch (e) {
      throw Exception('Error: $e');
    }
  }

  // method to get the user profile
  Future<UserModel> getUserProfile(String token) async {
    try {
      final response = await _dio.get('/auth/profile',
          options: Options(headers: {'Authorization': 'Bearer $token'}));

      return UserModel.fromJson(response.data);
    } catch (e) {
      throw Exception('Error: $e');
    }
  }
}
