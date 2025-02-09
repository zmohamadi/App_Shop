import 'package:Shop/App/auth/signin.dart';
import 'package:Shop/App/home.dart';
import 'package:get/get.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '../App/helpers/data.dart';

class AuthController extends GetxController {
  var isLoading = false.obs;
  var user = Rxn<User>();

  /// **ثبت‌نام کاربر**
  Future<void> register(String name, String email, String mobile, String password) async {
    isLoading(true);
    try {
      var response = await Data.post('api-register', {
        'firstname': name,
        'email': email,
        'mobile': mobile,
        'password': password
      });

      Get.snackbar('موفق', 'ثبت‌نام انجام شد');
      Get.to(() => SignInScreen());
    } catch (e) {
      Get.snackbar('خطا', 'مشکلی در ثبت‌نام پیش آمد: $e');
    } finally {
      isLoading(false);
    }
  }

  /// **ورود کاربر**
  Future<void> login(String email, String mobile, String password) async {
    isLoading(true);
    try {
      var response = await Data.post('api-login', {
        'email': email,
        'mobile': mobile,
        'password': password
      });

      Get.snackbar('موفق', 'ورود انجام شد');
      Get.to(() => Home());
    } catch (e) {
      Get.snackbar('خطا', 'مشکلی در ورود پیش آمد: $e');
    } finally {
      isLoading(false);
    }
  }

  /// **ورود با جیمیل**
  Future<void> loginWithGoogle() async {
    try {
      final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();
      if (googleUser == null) return;

      final GoogleSignInAuthentication googleAuth = await googleUser.authentication;
      final AuthCredential credential = GoogleAuthProvider.credential(
        accessToken: googleAuth.accessToken,
        idToken: googleAuth.idToken,
      );

      final userCredential = await FirebaseAuth.instance.signInWithCredential(credential);
      user.value = userCredential.user;

      Get.snackbar('موفق', 'ورود با جیمیل انجام شد');
    } catch (e) {
      Get.snackbar('خطا', 'مشکلی در ورود با جیمیل پیش آمد: $e');
    }
  }

  /// **خروج از حساب**
  Future<void> logout() async {
    await FirebaseAuth.instance.signOut();
    user.value = null;
    Get.snackbar('موفق', 'خروج انجام شد');
  }
}
