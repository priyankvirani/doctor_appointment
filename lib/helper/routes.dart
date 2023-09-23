import 'package:flutter/cupertino.dart';
import 'package:flutter_doctor_appointment/model/doctor.dart';
import 'package:flutter_doctor_appointment/screens/book_appointment.dart';
import 'package:flutter_doctor_appointment/screens/confirm_summary.dart';
import 'package:flutter_doctor_appointment/screens/main_screen.dart';
import 'package:flutter_doctor_appointment/screens/my_booking.dart';
import 'package:flutter_doctor_appointment/screens/review_summary.dart';
import 'package:flutter_doctor_appointment/screens/select_package.dart';
import 'package:flutter_doctor_appointment/screens/splash.dart';
import 'package:page_transition/page_transition.dart';


class Routes {
  static const String splash = '/splash';
  static const String main = '/main';
  static const String bookAppointment = '/bookAppointment';
  static const String selectPackage = '/selectPackage';
  static const String reviewSummary = '/reviewSummary';
  static const String bookingConfirm = '/bookingConfirm';
  static const String myBooking = '/myBooking';
}

class RouteGenerator {
  static Route<dynamic>? generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case Routes.splash:
        return fadePageTransition(SplashScreen());
      case Routes.main:
        return fadePageTransition(MainScreen());
      case Routes.bookAppointment:
        return fadePageTransition(BookAppointMentScreen(settings.arguments as Doctor));
      case Routes.selectPackage:
        return fadePageTransition(SelectPackageScreen(settings.arguments as SelectPackageArgs));
      case Routes.reviewSummary:
        return fadePageTransition(ReviewSummaryScreen(settings.arguments as ReviewSummaryArgs));
      case Routes.bookingConfirm:
        return fadePageTransition(BookingConfirmScreen());
      case Routes.myBooking:
        return fadePageTransition(MyBookingScreen());
      default:
        return null;
    }
  }

  static PageTransition fadePageTransition(Widget screen,
      {RouteSettings? settings}) {
    return PageTransition(
        child: screen, type: PageTransitionType.fade, settings: settings);
  }

  static PageTransition rightToLeftTransition(Widget screen,
      {RouteSettings? settings}) {
    return PageTransition(
      child: screen,
      type: PageTransitionType.rightToLeft,
      settings: settings,
    );
  }

  static PageTransition bottomToTopTransition(Widget screen,
      {RouteSettings? settings}) {
    return PageTransition(
      child: screen,
      type: PageTransitionType.bottomToTop,
      settings: settings,
    );
  }
}

