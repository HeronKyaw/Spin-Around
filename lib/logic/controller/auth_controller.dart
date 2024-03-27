import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

enum AuthMode { login, register }

class AuthController extends GetxController {
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;

  static AuthController get instance => Get.find();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _conPasswordController = TextEditingController();
  
  final RxBool isObscurePw = true.obs;
  final RxBool isObscureConPw = true.obs;
  final RxBool isLoading = false.obs;
  final RxBool isLogin = true.obs;

  TextEditingController get emailController => _emailController;
  TextEditingController get passwordController => _passwordController;
  TextEditingController get conPasswordController => _conPasswordController;

  // Rx variables for storing user data and error messages
  final Rx<User?> _user = Rx<User?>(null);
  final RxString _errorMessage = RxString('');

  Stream<User?> get userStream => _user.stream;
  String get errorMessage => _errorMessage.value;

  @override
  void onInit() {
    super.onInit();
    _user.value = _firebaseAuth.currentUser;
    _user.listen((user) {
      if (user == null) {
        // User logged out
        _errorMessage.value = '';
      }
    });
  }

  Future<void> login(String email, String password) async {
    try {
      final UserCredential userCredential = await _firebaseAuth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      _user.value = userCredential.user;
      _errorMessage.value = '';
    } on FirebaseAuthException catch (e) {
      _errorMessage.value = e.message!;
    } catch (e) {
      _errorMessage.value = 'An unexpected error occurred.';
    }
  }

  Future<void> loginAnonymous() async {
    try {
      final UserCredential userCredential = await _firebaseAuth.signInAnonymously();
      _user.value = userCredential.user;
      _errorMessage.value = '';
    } on FirebaseAuthException catch (e) {
      _errorMessage.value = e.message!;
    } catch (e) {
      _errorMessage.value = 'An unexpected error occurred.';
    }
  }

  Future<void> register(String email, String password) async {
    try {
      final UserCredential userCredential = await _firebaseAuth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      _user.value = userCredential.user;
      _errorMessage.value = '';
    } on FirebaseAuthException catch (e) {
      _errorMessage.value = e.message!;
    } catch (e) {
      _errorMessage.value = 'An unexpected error occurred.';
    }
  }

  Future<void> signOut() async {
    await _firebaseAuth.signOut();
    _user.value = null;
  }
}
