import 'package:android_alarm_manager_plus/android_alarm_manager_plus.dart';
import 'package:get/get.dart';
import 'package:medv/User-mgmt/LoginPage.dart';
import 'package:medv/screens/home_screen.dart';

class AuthController extends GetxController {
  RxBool isAuthenticated = false.obs;

  Future<void> login() async {
    await AndroidAlarmManager.initialize();
    // Perform login logic here
    isAuthenticated.value = true;
    // Navigate to the home page
    Get.to(() => HomeScreen());
  }

  void logout() {
    // Perform logout logic here
    isAuthenticated.value = false;
    // Navigate back to the login page
    // Get.offAllNamed('/login');
    Get.to(() => LoginScreen());
  }
}
