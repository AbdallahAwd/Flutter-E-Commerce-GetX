import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import 'package:get/get.dart';
import 'package:get_practise/app/modules/auth/controllers/auth_controller.dart';

import '../../../components/componants.dart';

// ignore: use_key_in_widget_constructors, must_be_immutable
class SignUpView extends GetView {
  var emailController = TextEditingController();
  var passwordController = TextEditingController();
  var nameConttroller = TextEditingController();
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
                      'Sign',
                      style: Theme.of(context)
                          .textTheme
                          .bodyText1!
                          .copyWith(color: Colors.blue, fontSize: 50),
                    ),
                    const SizedBox(
                      width: 8,
                    ),
                    Text('Up',
                        style: Theme.of(context)
                            .textTheme
                            .caption!
                            .copyWith(fontSize: 50)),
                  ],
                ),
                const SizedBox(
                  height: 60.0,
                ),
                Components.DefaultFormFeild(
                  Controller: nameConttroller,
                  label: 'Name',
                  icon: const Icon(Icons.person),
                ),
                const SizedBox(
                  height: 20.0,
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
                const SizedBox(
                  height: 40.0,
                ),
                GetBuilder<AuthController>(builder: (val) {
                  return SizedBox(
                    width: double.infinity,
                    child: controller.isLoading == true
                        ? const LinearProgressIndicator()
                        : ElevatedButton(
                            child: const Padding(
                              padding: EdgeInsets.all(12.0),
                              child: Text(
                                'Sign Up',
                                style: TextStyle(fontSize: 18),
                              ),
                            ),
                            onPressed: () {
                              controller.signUp(
                                  email: emailController.text,
                                  password: passwordController.text);
                            },
                          ),
                  );
                }),
                const SizedBox(
                  height: 12,
                ),
                const SizedBox(
                  height: 15,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    InkWell(
                      onTap: () {},
                      child: const CircleAvatar(
                        radius: 25,
                        backgroundColor: Colors.red,
                        child: FaIcon(
                          FontAwesomeIcons.google,
                          color: Colors.white,
                          size: 25,
                        ),
                      ),
                    ),
                    const SizedBox(
                      width: 15,
                    ),
                    InkWell(
                      onTap: () {},
                      child: const CircleAvatar(
                        radius: 25,
                        backgroundColor: Colors.blue,
                        child: FaIcon(
                          FontAwesomeIcons.facebook,
                          color: Colors.white,
                          size: 25,
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
              const Text('Have already an account ?'),
              const SizedBox(
                width: 5,
              ),
              TextButton(
                  onPressed: () {
                    Get.back();
                  },
                  child: const Text(
                    'Log In',
                    style: TextStyle(color: Colors.white),
                  ))
            ],
          ),
        ),
      ),
    );
  }
}
