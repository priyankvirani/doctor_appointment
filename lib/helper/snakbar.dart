import 'package:animated_snack_bar/animated_snack_bar.dart';
import 'package:flutter_doctor_appointment/helper/navigation.dart';

class AlertSnackBar {
  static error(String message) {
    AnimatedSnackBar.material(message,
            type: AnimatedSnackBarType.error,
            duration: const Duration(seconds: 4))
        .show(NavigationService.context);
  }

  static success(String message, {Duration? duration}) {
    AnimatedSnackBar.material(message,
            type: AnimatedSnackBarType.success,
            duration: const Duration(seconds: 4))
        .show(
      NavigationService.context,
    );
  }
}
