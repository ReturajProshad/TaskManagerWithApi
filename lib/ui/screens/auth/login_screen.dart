import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:todo/ui/screens/auth/signup_screen.dart';
import '../../state_manager/login_controller.dart';
import '../../widgets/screen_background.dart';
import '../bottom_nave_base_screen.dart';
import '../email_verification_screen.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController _emailTEController = TextEditingController();
  final TextEditingController _passwordTEController = TextEditingController();

  // LoginController loginController = Get.find<LoginController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: ScreenBackground(
      child: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(24.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(
                  height: 64,
                ),
                Text(
                  'Get Started With',
                  style: Theme.of(context).textTheme.titleLarge,
                ),
                const SizedBox(
                  height: 16,
                ),
                TextField(
                  controller: _emailTEController,
                  keyboardType: TextInputType.emailAddress,
                  decoration: const InputDecoration(
                    hintText: 'Email',
                  ),
                ),
                const SizedBox(
                  height: 12,
                ),
                TextField(
                  controller: _passwordTEController,
                  obscureText: true,
                  decoration: const InputDecoration(
                    hintText: 'Password',
                  ),
                ),
                const SizedBox(
                  height: 16,
                ),
                GetBuilder<LoginController>(builder: (loginController) {
                  return SizedBox(
                    width: double.infinity,
                    child: Visibility(
                      visible: loginController.loginInProgress == false,
                      replacement: const Center(
                        child: CircularProgressIndicator(),
                      ),
                      child: ElevatedButton(
                        onPressed: () {
                          loginController
                              .login(
                            _emailTEController.text.trim(),
                            _passwordTEController.text,
                          )
                              .then((result) {
                            if (result == true) {
                              Get.offAll(const BottomNavBaseScreen());
                            } else {
                              Get.snackbar(
                                  'Failed', 'Login failed! Try again.');
                            }
                          });
                        },
                        child: const Icon(Icons.arrow_forward_ios),
                      ),
                    ),
                  );
                }),
                const SizedBox(
                  height: 16,
                ),
                Center(
                  child: InkWell(
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => EmailVerificationScreen()));
                    },
                    child: const Text(
                      'Forgot Password?',
                      style: TextStyle(color: Colors.grey),
                    ),
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text(
                      "Don't have an account?",
                      style: TextStyle(
                          fontWeight: FontWeight.w500, letterSpacing: 0.5),
                    ),
                    TextButton(
                        onPressed: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => SignUpScreen()));
                        },
                        child: const Text('Sign up')),
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    ));
  }
}
