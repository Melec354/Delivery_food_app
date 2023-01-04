import 'package:food_app/data/api/api_client.dart';
import 'package:food_app/models/signup_body_model.dart';
import 'package:food_app/utils/app_constants.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AuthRepository {
  final ApiClient apiClient;
  final SharedPreferences sharedPreferences;

  AuthRepository({required this.apiClient, required this.sharedPreferences});

  Future<Response> registration(SignUpBody signUpBody) async {
    return await apiClient.postData(
        AppConstants.registrationURL, signUpBody.toJson());
  }

  bool userLoggedIn() {
    return sharedPreferences.containsKey(AppConstants.token);
  }

  Future<String> getUserToken() async {
    return await sharedPreferences.getString(AppConstants.token) ?? 'None';
  }

  Future<Response> login(String phone, String password) async {
    return await apiClient.postData(
        AppConstants.loginURL, {"phone": phone, "password": password});
  }

  Future<bool> saveUserToken(String token) async {
    apiClient.token = token;
    apiClient.updateHeader(token);
    return await sharedPreferences.setString(AppConstants.token, token);
  }

  Future<void> saveUserNumberPassword(String number, String password) async {
    try {
      await sharedPreferences.setString(AppConstants.phone, number);
      await sharedPreferences.setString(AppConstants.password, password);
    } catch (err) {
      throw err;
    }
  }

  bool clearSharedData() {
    sharedPreferences.remove(AppConstants.token);
    sharedPreferences.remove(AppConstants.password);
    sharedPreferences.remove(AppConstants.phone);
    apiClient.token = '';
    apiClient.updateHeader('');
    return true;
  }
}
