import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:spin_around/logic/controller/auth_controller.dart';
import 'package:spin_around/view/widget/button_widget.dart';
import 'package:spin_around/view/widget/text_form_field_widget.dart';

class AuthScreen extends StatelessWidget {
  final AuthController controller = Get.put(AuthController());

  final _formKey = GlobalKey<FormState>();

  AuthScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Obx(() => Text(controller.isLogin.value ? 'Login' : 'Sign Up')),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Form(
          key: _formKey,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              TextFormFieldWidget(
                controller: controller.emailController,
                labelText: '',
                text: 'Email',
                validator: (value) =>
                    (value!.isEmpty) ? 'Email is required' : null,
              ),
              const SizedBox(height: 10.0),
              Obx(
                () => TextFormFieldWidget(
                  controller: controller.passwordController,
                  labelText: '',
                  text: 'Password',
                  obscureText: controller.isObscurePw.value,
                  validator: (value) =>
                      (value!.isEmpty) ? 'Password is required' : null,
                  shffixWidget: IconButton(
                    icon: Icon(controller.isObscurePw.value
                        ? Icons.visibility_off
                        : Icons.visibility),
                    onPressed: () {
                      controller.isObscurePw.value =
                          !controller.isObscurePw.value;
                    },
                  ),
                ),
              ),
              const SizedBox(height: 20.0),
              Obx(
                () => Visibility(
                  visible: !controller.isLogin.value,
                  child: TextFormFieldWidget(
                    controller: controller.conPasswordController,
                    labelText: '',
                    text: 'Confirm Password',
                    obscureText: controller.isObscureConPw.value,
                    validator: (value) {
                      if (controller.passwordController.text !=
                          controller.conPasswordController.text) {
                        return 'Password not match';
                      } else if (value!.isEmpty) {
                        return 'Confirm Password is required';
                      }
                      return null;
                    },
                    shffixWidget: IconButton(
                      icon: Icon(controller.isObscureConPw.value
                          ? Icons.visibility_off
                          : Icons.visibility),
                      onPressed: () {
                        controller.isObscureConPw.value =
                            !controller.isObscureConPw.value;
                      },
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 20.0),
              ButtonWidget(
                onPressed: () {
                  if (_formKey.currentState!.validate()) {
                    if (controller.isLogin.value) {
                      controller.login(
                        controller.emailController.text,
                        controller.passwordController.text,
                      );
                    } else {
                      if (controller.passwordController.text ==
                          controller.conPasswordController.text) {
                        controller.register(
                          controller.emailController.text,
                          controller.passwordController.text,
                        );
                      } else {}
                    }
                  }
                },
                child: Obx(
                    () => Text(controller.isLogin.value ? 'Login' : 'Sign Up')),
              ),
              const SizedBox(height: 10.0),
              Obx(() => Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(controller.isLogin.value
                          ? 'Don\'t have an account?'
                          : 'Already have an account?'),
                      TextButton(
                        onPressed: () {
                          _formKey.currentState!.reset();
                          controller.emailController.clear();
                          controller.passwordController.clear();
                          controller.conPasswordController.clear();
                          controller.isLogin.value = !controller.isLogin.value;
                        },
                        child: Text(
                            controller.isLogin.value ? 'Sign Up' : 'Login'),
                      ),
                    ],
                  )),
              const SizedBox(height: 10.0),
              ButtonWidget(
                onPressed: () async {
                  await controller.loginAnonymous();
                },
                child: const Text('Sign in as Guest'),
              ),
              Obx(
                () => Text(
                  controller.errorMessage,
                  style: const TextStyle(color: Colors.red),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
