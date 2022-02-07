// ignore_for_file: use_key_in_widget_constructors,

import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import 'package:get/get.dart';
import 'package:get_practise/app/routes/app_pages.dart';

import '../../../components/componants.dart';
import '../controllers/auth_controller.dart';

// ignore: must_be_immutable
class AuthView extends GetView<AuthController> {
  var emailController = TextEditingController();
  var passwordController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    AuthController controller = Get.put(AuthController());
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 15.0, vertical: 100),
        child: SafeArea(
          child: SingleChildScrollView(
            child: Column(
              children: [
                Row(
                  children: [
                    Text(
                      'LOG',
                      style: Theme.of(context)
                          .textTheme
                          .bodyText1!
                          .copyWith(color: Colors.blue, fontSize: 50),
                    ),
                    const SizedBox(
                      width: 8,
                    ),
                    Text('IN',
                        style: Theme.of(context)
                            .textTheme
                            .caption!
                            .copyWith(fontSize: 50)),
                  ],
                ),
                const SizedBox(
                  height: 80.0,
                ),
                Components.DefaultFormFeild(
                  Controller: emailController,
                  label: 'Email',
                  icon: const Icon(Icons.email),
                ),
                const SizedBox(
                  height: 30,
                ),
                Components.DefaultFormFeild(
                    Controller: passwordController,
                    icon: const Icon(Icons.lock),
                    label: 'Password'),
                Align(
                    alignment: Alignment.topRight,
                    child: TextButton(
                        onPressed: () {},
                        child: const Text('Forget Password?'))),
                SizedBox(
                    width: double.infinity,
                    child: GetBuilder<AuthController>(builder: (val) {
                      return controller.isLoading == true
                          ? const LinearProgressIndicator()
                          : ElevatedButton(
                              child: const Padding(
                                padding: EdgeInsets.all(12.0),
                                child: Text(
                                  'LOG IN',
                                  style: TextStyle(fontSize: 18),
                                ),
                              ),
                              onPressed: () {
                                controller.logIn(
                                    email: emailController.text,
                                    password: passwordController.text);
                              },
                            );
                    })),
                const SizedBox(
                  height: 12,
                ),
                const Text('OR'),
                const SizedBox(
                  height: 15,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    GetBuilder<AuthController>(builder: (_) {
                      return InkWell(
                        onTap: () {
                          controller.googleLogIn().then((value) {
                            Get.offAllNamed(Paths.HOME);
                          });
                        },
                        child: const CircleAvatar(
                          radius: 30,
                          backgroundColor: Colors.red,
                          child: FaIcon(
                            FontAwesomeIcons.google,
                            color: Colors.white,
                            size: 30,
                          ),
                        ),
                      );
                    }),
                    const SizedBox(
                      width: 15,
                    ),
                    InkWell(
                      onTap: () {},
                      child: const CircleAvatar(
                        radius: 30,
                        backgroundColor: Colors.blue,
                        child: FaIcon(
                          FontAwesomeIcons.facebook,
                          color: Colors.white,
                          size: 30,
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 15,
                ),
              ],
            ),
          ),
        ),
      ),
      bottomNavigationBar: Container(
        decoration: BoxDecoration(
            color: Colors.blue, borderRadius: BorderRadius.circular(20)),
        child: Padding(
          padding: const EdgeInsets.all(12.0),
          child: Row(
            children: <Widget>[
              const Text('Dont\'t hava an Account?'),
              const SizedBox(
                width: 5,
              ),
              TextButton(
                  onPressed: () {
                    Get.toNamed(
                      Paths.SIGNUP,
                    );
                  },
                  child: const Text(
                    'Sign up',
                    style: TextStyle(color: Colors.white),
                  ))
            ],
          ),
        ),
      ),
    );
  }
}
