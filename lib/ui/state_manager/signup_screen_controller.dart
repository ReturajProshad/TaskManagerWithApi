import 'package:get/get.dart';
import 'package:todo/ui/screens/auth/login_screen.dart';
import '../../../data/models/network_response.dart';
import '../../../data/services/network_caller.dart';
import '../../../data/utils/urls.dart';

class SignUpController extends GetxController {
  final RxBool _signUpInProgress = false.obs;

  bool get signUpInProgress => _signUpInProgress.value;

  Future<void> userSignUp({
    required String email,
    required String firstName,
    required String lastName,
    required String mobile,
    required String password,
  }) async {
    _signUpInProgress.value = true;

    Map<String, dynamic> requestBody = {
      "email": email,
      "firstName": firstName,
      "lastName": lastName,
      "mobile": mobile,
      "password": password,
      "photo": ""
    };

    final NetworkResponse response =
        await NetworkCaller().postRequest(Urls.registration, requestBody);

    _signUpInProgress.value = false;

    if (response.isSuccess) {
      Get.snackbar('Success', 'Registration success!');
      Get.offAll(const LoginScreen());
    } else {
      Get.snackbar('Error', 'Registration failed!');
    }
  }
}
