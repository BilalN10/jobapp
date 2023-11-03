import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:get/get_connect/http/src/utils/utils.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:job_app/model/user_model.dart';
import 'package:job_app/view/authentication_pages/login_page.dart';
import 'package:job_app/view/bottom_navbar/bottom_navbar_page.dart';
import 'package:job_app/view/select_language/select_langauge.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AuthcController extends GetxController {
  @override
  void onInit() {
    fetchLanguage();
    firebaseUser.bindStream(auth.authStateChanges());

    super.onInit();
  }

  Future<void> fetchLanguage() async {
    final prefs = await SharedPreferences.getInstance();
    if (prefs.containsKey('language_code') &&
        prefs.containsKey('country_code')) {
      print('its contain the key');
      String langCode = prefs.getString('language_code')!;
      String countCode = prefs.getString('country_code')!;
      languageCode.value = langCode;
      countryCode.value = countCode;
      Get.updateLocale(Locale(languageCode.value, countryCode.value));
    }
  }

  final Rx<String> languageCode = 'en'.obs; // Default language is English
  String get getlanguageCode => languageCode.value;

  final Rx<String> countryCode = 'US'.obs; // Default language is English
  String get getcountryCode => countryCode.value;

  final FirebaseFirestore firestore = FirebaseFirestore.instance;
  final auth = FirebaseAuth.instance;
  final firebaseUser = Rxn<User>();
  User get users => firebaseUser.value!;
  TextEditingController forgotEmail = TextEditingController();

  //=============== LOGIN  ===============>

  TextEditingController loginEmail = TextEditingController();
  TextEditingController loginPassword = TextEditingController();
  RxBool isLogin = false.obs;
  Future<void> login() async {
    isLogin.value = true;
    auth
        .signInWithEmailAndPassword(
            email: loginEmail.text.trim(), password: loginPassword.text.trim())
        .then((value) {
      isLogin.value = false;
      Get.offAll(() => const BottomNavBarPage());
    }).catchError((e) {
      isLogin.value = false;
      ScaffoldMessenger.of(Get.context!).showSnackBar(SnackBar(
        content: Text(e.toString()),
        behavior: SnackBarBehavior.floating,
      ));
    });
  }

  //=============== SIGN UP CONTROLLERS ===============>
  TextEditingController emailCont = TextEditingController();
  TextEditingController passwordCont = TextEditingController();
  TextEditingController userNameContoller = TextEditingController();

  RxBool isSignUp = false.obs;

  //=============== SIGN UP WITH EMAIL ===============>

  Future<void> userSignUp() async {
    print('password is ${passwordCont.text}');
    print('email is ${emailCont.text}');

    final connectivityResult = await (Connectivity().checkConnectivity());

    if (connectivityResult != ConnectivityResult.none) {
      isSignUp.value = true;
      auth
          .createUserWithEmailAndPassword(
              email: emailCont.text.trim(), password: passwordCont.text.trim())
          .then((value) async {
        storeUserData(value).then((value) {
          Get.offAll(() => BottomNavBarPage());
        });
      }).catchError((e) {
        isSignUp.value = false;
        ScaffoldMessenger.of(Get.context!).showSnackBar(SnackBar(
          content: Text(e.toString()),
          behavior: SnackBarBehavior.floating,
        ));
      });
    } else {
      ScaffoldMessenger.of(Get.context!).showSnackBar(const SnackBar(
        content: Text('Internet connection not available'),
        behavior: SnackBarBehavior.floating,
      ));
    }
  }

  //=============== STORE USER DATA ===============>
  Future<void> storeUserData(UserCredential value) async {
    Map<String, dynamic> userData = {
      'email': emailCont.text,
      "user_name": userNameContoller.text,
      'date_time': DateTime.now(),
      'profile_pic': ''
    };
    await firestore
        .collection('users')
        .doc(value.user!.uid)
        .set(userData)
        .then((value) {
      isSignUp.value = false;
      clearSignUpCont();
    });
  }
  //=============== CLEAR SIGNUP CONTROLLERS ===============>

  void clearSignUpCont() {
    emailCont.clear();
    passwordCont.clear();
    userNameContoller.clear();
  }

  //=============== GOOGLE SIGNUP OR SIGNIN  ===============>

  GoogleSignIn googleSignIn = GoogleSignIn(scopes: ['email']);

  RxBool isGoogleSignin = false.obs;

  Future<void> googleSignIN() async {
    final connectivityResult = await (Connectivity().checkConnectivity());

    if (connectivityResult != ConnectivityResult.none) {
      try {
        isGoogleSignin.value = true;

        final GoogleSignInAccount? googleUser = await googleSignIn.signIn();
        final GoogleSignInAuthentication googleAuth =
            await googleUser!.authentication;

        final AuthCredential credential = GoogleAuthProvider.credential(
            idToken: googleAuth.idToken, accessToken: googleAuth.accessToken);

        final UserCredential authResult =
            await auth.signInWithCredential(credential);

        if (authResult.additionalUserInfo!.isNewUser) {
          Map<String, dynamic> userData = {
            'email': authResult.user!.email!,
            "user_name": authResult.user!.displayName,
            'date_time': DateTime.now(),
            'profile_pic': authResult.user!.photoURL
          };

          await firestore
              .collection('users')
              .doc(auth.currentUser!.uid)
              .set(userData)
              .then((value) {
            isGoogleSignin.value = false;
            Get.offAll(() => BottomNavBarPage());
          });
        } else {
          isGoogleSignin.value = false;
          Get.offAll(() => BottomNavBarPage());
        }
      } catch (e) {
        isGoogleSignin.value = false;

        print('error is ${e.toString()}');
      }
    } else {
      ScaffoldMessenger.of(Get.context!).showSnackBar(const SnackBar(
        content: Text('Internet connection not available'),
        behavior: SnackBarBehavior.floating,
      ));
    }
  }

  //=============== GET USER INFORMATION  ===============>

  Rx<UserModel> userData = UserModel().obs;

  UserModel get getUserData => userData.value;
  set getUserData(UserModel value) => userData.value = value;
  Future<void> getData() async {
    var doc = await FirebaseFirestore.instance
        .collection("users")
        .doc(auth.currentUser?.uid)
        .get();
    userData.value = UserModel.fromSnamshot(doc);
  }

  //=============== SIGNOUT  ===============>

  void signOut() async {
    await auth.signOut().then((value) {
      googleSignIn.signOut();
      Get.offAll(() => const SelectLanguagePage());
    });
  }

  RxBool ismailSend = false.obs;

  forgotPassword() async {
    if (await doesEmailExist(forgotEmail.text)) {
      ismailSend.value = true;
      auth.sendPasswordResetEmail(email: forgotEmail.text.trim()).then((value) {
        ismailSend.value = false;
        print('mail send');
        Get.snackbar('Email send', 'Please check you Email');
      }).catchError((e) {
        ismailSend.value = false;
      });
    } else {
      ScaffoldMessenger.of(Get.context!).showSnackBar(SnackBar(
        content: Text('Email not found please register your account'),
        behavior: SnackBarBehavior.floating,
      ));
    }
  }

  Future<bool> checkEmail(String email) async {
    print('mail is $email');
    bool isEmailFound = false;

    await FirebaseFirestore.instance
        .collection('jobs')
        //  .where('email', isEqualTo: email)
        .snapshots()
        .map((event) {
      print('asd');
      if (event.docs.isNotEmpty) {
        isEmailFound = true;
      } else {
        isEmailFound = false;
      }
    });

    return isEmailFound;
  }

  Future<bool> doesEmailExist(String email) async {
    QuerySnapshot querySnapshot = await FirebaseFirestore.instance
        .collection('users')
        .where('email', isEqualTo: email)
        .get();
    print('quetnfdi ${querySnapshot.docs.isNotEmpty}');
    return querySnapshot.docs.isNotEmpty;
  }
}
