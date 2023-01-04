import 'package:food_app/data/repository/auth_repository.dart';
import 'package:food_app/models/response_model.dart';
import 'package:food_app/models/signup_body_model.dart';
import 'package:get/get.dart';

class AuthController extends GetxController implements GetxService {
  final AuthRepository authRepository;

  AuthController({required this.authRepository});

  bool _isLoading = false;
  bool get isLoading => _isLoading;

  Future<ResponseModel> registration(SignUpBody signUpBody) async {
    _isLoading = true;
    update();
    Response response = await authRepository.registration(signUpBody);
    late ResponseModel responseModel;
    if (response.statusCode == 200) {
      authRepository.saveUserToken(response.body['token']);
      responseModel = ResponseModel(true, response.body['token']);
    } else {
      responseModel = ResponseModel(false, response.statusText!);
    }
    _isLoading = false;
    update();
    return responseModel;
  }

  Future<ResponseModel> login(String phone, String password) async {
    authRepository.getUserToken();
    _isLoading = true;
    update();
    Response response = await authRepository.login(phone, password);
    late ResponseModel responseModel;
    if (response.statusCode == 200) {
      authRepository.saveUserToken(response.body['token']);
      responseModel = ResponseModel(true, response.body['token']);
    } else {
      responseModel = ResponseModel(false, response.statusText!);
    }
    _isLoading = false;
    update();
    return responseModel;
  }

  Future<void> saveUserNumberPassword(String number, String password) async {
    authRepository.saveUserNumberPassword(number, password);
  }

  bool userLoggedIn() {
    return authRepository.userLoggedIn();
  }

  bool clearSharedData() {
    return authRepository.clearSharedData();
  }
}
