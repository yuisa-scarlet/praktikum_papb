import 'dart:convert';

import 'package:crypto/crypto.dart';
import 'package:get/get.dart';
import 'package:praktikum_papb/database/app_database.dart';
import 'package:praktikum_papb/model/user.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AuthException implements Exception {
  final String message;

  AuthException(this.message);

  @override
  String toString() => message;
}

class AuthService extends GetxService {
  static const _sessionKey = 'session_user_id';

  final AppDatabase database;
  final SharedPreferences prefs;

  AuthService({required this.database, required this.prefs});

  final currentUser = Rxn<User>();

  bool get isLoggedIn => currentUser.value != null;

  Future<AuthService> init() async {
    final userId = prefs.getInt(_sessionKey);
    if (userId != null) {
      final user = await database.findUserById(userId);
      currentUser.value = user;
    }
    return this;
  }

  Future<void> register({
    required String name,
    required String email,
    required String password
  }) async {
    final normalizeEmail = email.trim().toLowerCase();

    final existsUser = await database.findUserByEmail(email);
    if (existsUser != null) {
      throw Exception('User with this email already exists');
    }

    await database.insertUser(User(
      name: name,
      email: normalizeEmail,
      passwordHash: _hash(password),
      createdAt: DateTime.now(),
    ));
  }

  Future<void> login({
    required String email,
    required String password
  }) async {
    final normalizeEmail = email.trim().toLowerCase();

    final user = await database.findUserByEmail(normalizeEmail);
    if (user == null || user.passwordHash != _hash(password)) {
      throw AuthException('Invalid email or password');
    }

    await prefs.setInt(_sessionKey, user.id!);
    currentUser.value = user;
  }

  Future<void> logout() async {
    await prefs.remove(_sessionKey);
    currentUser.value = null;
  }

  String _hash(String password) => sha256.convert(utf8.encode(password)).toString();
}