// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_practise/app/modules/auth/controllers/auth_controller.dart';
import 'package:get_practise/app/modules/home/controllers/home_controller.dart';
import 'package:get_practise/app/routes/app_pages.dart';
import 'package:get_storage/get_storage.dart';

class Setting extends GetView<HomeController> {
  Setting({Key? key}) : super(key: key);
  AuthController auth = Get.put(AuthController());
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(12.0),
      child: SizedBox(
        width: double.infinity,
        child: Column(
          children: [
            SizedBox(
              height: 10,
            ),
            Row(
              children: [
                CircleAvatar(
                  backgroundImage: NetworkImage(
                      'https://static.vecteezy.com/packs/media/components/global/search-explore-nav/img/vectors/term-bg-1-666de2d941529c25aa511dc18d727160.jpg'),
                  radius: 60,
                ),
                SizedBox(
                  width: 12,
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('AbdullahMostafa'),
                    SizedBox(
                      height: 5,
                    ),
                    Text('abdallahawad4@gmail.com')
                  ],
                ),
              ],
            ),
            SizedBox(
              height: 5,
            ),
            Divider(thickness: 4),
            ListTile(
                title: Row(
                  children: [
                    ClipRRect(
                        borderRadius: BorderRadius.circular(20),
                        child: Container(
                            color: Colors.purple,
                            child: Icon(Icons.dark_mode))),
                    Text('  Dark Mode'),
                  ],
                ),
                trailing: Obx(
                  () => Switch(
                    value: controller.darkSwitch.value,
                    onChanged: (value) {
                      controller.darkSwitch.value = value;
                      Get.changeTheme(ThemeData.light());
                    },
                  ),
                )),
            GetBuilder<HomeController>(builder: (controller) {
              return ListTile(
                title: Row(
                  children: [
                    ClipRRect(
                        borderRadius: BorderRadius.circular(20),
                        child: Container(
                            color: Colors.pink,
                            child: Padding(
                              padding: const EdgeInsets.all(4.0),
                              child: Icon(Icons.language),
                            ))),
                    Text('  Language'),
                  ],
                ),
                trailing: Container(
                  width: 120,
                  decoration: BoxDecoration(
                    border: Border.all(
                      width: 2,
                    ),
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: DropdownButtonHideUnderline(
                    child: DropdownButton<String>(
                      hint: Padding(
                        padding: const EdgeInsets.only(left: 20),
                        child: Text('Language'),
                      ),
                      isExpanded: true,
                      items: [
                        DropdownMenuItem(
                          child: Text('Arabic'),
                          onTap: () {},
                          value: 'ar',
                        ),
                        DropdownMenuItem(
                          child: Text('English'),
                          onTap: () {},
                          value: 'en',
                        )
                      ],
                      onChanged: (value) {
                        controller.dropDownChangeMenu(value);
                        print(value);
                      },
                    ),
                  ),
                ),
              );
            }),
            GetStorage().read('isGoogle') != null
                ? ListTile(
                    onTap: () {
                      auth.logout();
                      auth.storage.remove('isGoogle');
                      auth.storage.remove('uid');
                      Get.offAllNamed(Paths.AUTH);
                    },
                    title: Row(
                      children: [
                        ClipRRect(
                            borderRadius: BorderRadius.circular(20),
                            child: Container(
                                color: Color.fromARGB(255, 60, 160, 241),
                                child: Padding(
                                  padding: const EdgeInsets.all(4.0),
                                  child: Icon(Icons.logout),
                                ))),
                        Text('  Logout'),
                      ],
                    ),
                  )
                : ListTile(
                    onTap: () {
                      auth.storage.remove('isGoogle');
                      auth.storage.remove('uid');
                      Get.offAllNamed(Paths.AUTH);
                    },
                    title: Row(
                      children: [
                        ClipRRect(
                            borderRadius: BorderRadius.circular(20),
                            child: Container(
                                color: Color.fromARGB(255, 60, 160, 241),
                                child: Padding(
                                  padding: const EdgeInsets.all(4.0),
                                  child: Icon(Icons.logout),
                                ))),
                        Text('  Logout'),
                      ],
                    ),
                  ),
          ],
        ),
      ),
    );
  }
}
