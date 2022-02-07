import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_practise/app/routes/app_pages.dart';
import 'package:get_storage/get_storage.dart';
import 'package:google_sign_in/google_sign_in.dart';

class AuthController extends GetxController {
  var storage = GetStorage();
  bool isGoogle = false;
  signUp({
    required String email,
    required String password,
  }) async {
    try {
      isLoading = true;
      update();
      UserCredential userCredential = await FirebaseAuth.instance
          .createUserWithEmailAndPassword(email: email, password: password);
      storage.write('uid', userCredential.user!.uid);
      Get.offAllNamed(Paths.HOME);
    } on FirebaseAuthException catch (e) {
      isLoading = false;
      update();
      if (e.code == 'weak-password') {
        Get.snackbar('Error', e.code.toString(),
            backgroundColor: Colors.red, snackPosition: SnackPosition.BOTTOM);
      } else if (e.code == 'email-already-in-use') {
        isLoading = false;
        update();
        Get.snackbar('Error', e.code.toString(),
            backgroundColor: Colors.red, snackPosition: SnackPosition.BOTTOM);
      } else {
        isLoading = false;
        update();
        Get.snackbar('Error', e.code.toString(),
            backgroundColor: Colors.red, snackPosition: SnackPosition.BOTTOM);
      }
    } catch (e) {
      isLoading = false;
      update();
      Get.snackbar('Error', e.toString(),
          backgroundColor: Colors.red, snackPosition: SnackPosition.BOTTOM);
    }
  }

  bool isLoading = false;
  void logIn({
    required String email,
    required String password,
  }) async {
    try {
      isLoading = true;
      update();
      UserCredential userCredential = await FirebaseAuth.instance
          .signInWithEmailAndPassword(email: email, password: password);
      storage.write('uid', userCredential.user!.uid);
      Get.offAllNamed(Paths.HOME);
    } on FirebaseAuthException catch (e) {
      isLoading = false;
      update();
      if (e.code == 'user-not-found') {
        Get.snackbar('Error', e.code.toString(),
            backgroundColor: Colors.red, snackPosition: SnackPosition.BOTTOM);
      } else if (e.code == 'wrong-password') {
        isLoading = false;
        update();
        Get.snackbar('Error', e.code.toString(),
            backgroundColor: Colors.red, snackPosition: SnackPosition.BOTTOM);
      } else {
        Get.snackbar('Error', e.code.toString(),
            backgroundColor: Colors.red, snackPosition: SnackPosition.BOTTOM);
      }
    }
  }

  final googleSignin = GoogleSignIn();
  GoogleSignInAccount? _user;
  GoogleSignInAccount get user => _user!;
  Future googleLogIn() async {
    try {
      final googleUser = await googleSignin.signIn();
      if (googleUser == null) return;
      _user = googleUser;
      final googleAuth = await googleUser.authentication;

      final credential = GoogleAuthProvider.credential(
        accessToken: googleAuth.accessToken,
        idToken: googleAuth.idToken,
      );
      isGoogle = true;
      storage.write('uid', _user!.id);
      storage.write('isGoogle', isGoogle);

      await FirebaseAuth.instance.signInWithCredential(credential);
      update();
    } catch (e) {
      printError(info: e.toString());
    }
  }

  Future logout() async {
    await googleSignin.disconnect();
    FirebaseAuth.instance.signOut();
  }

  @override
  // ignore: unnecessary_overrides
  void onInit() {
    super.onInit();
  }

  @override
  // ignore: unnecessary_overrides
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {}
}
