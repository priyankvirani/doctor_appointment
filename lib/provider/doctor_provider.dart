import 'package:flutter/material.dart';
import 'package:flutter_doctor_appointment/helper/strings.dart';
import 'package:flutter_doctor_appointment/model/appointment_options.dart';
import 'package:flutter_doctor_appointment/model/confirmation.dart';
import 'package:flutter_doctor_appointment/model/doctor.dart';
import 'package:flutter_doctor_appointment/model/my_booking.dart';
import 'package:flutter_doctor_appointment/model/package.dart';
import 'package:flutter_doctor_appointment/repository/auth_repository.dart';
import 'package:provider/provider.dart';

DoctorProvider getDoctorStore(BuildContext context) {
  var store = Provider.of<DoctorProvider>(context, listen: false);
  return store;
}

class DoctorProvider extends ChangeNotifier {
  final DoctorRepository _doctorRepository = DoctorRepository();

  bool _isLoading = false;

  bool get isLoading => _isLoading;

  changeLoadingStatus(bool val) {
    _isLoading = val;
    notifyListeners();
  }

  List<Doctor> doctorList = [];

  List<String> dateList = [];

  Future<dynamic> doctors() async {
    changeLoadingStatus(true);
    dynamic res = await _doctorRepository.doctors();
    doctorList.clear();
    changeLoadingStatus(false);
    try {
      res.forEach((element) {
        doctorList.add(Doctor.fromJson(element));
      });
    } catch (e) {
      e.toString();
    }
    return res;
  }

  String getDateFromList(Doctor doctor, int pos) {
    List<String> tmpList = [];
    for (var element in doctor.availability.keys) {
      tmpList.add(element);
    }
    return tmpList[pos];
  }

  List<String> getTimeList(Doctor doctor, String name) {
    List<String> values = [];
    values = doctor.availability[name] ?? [];
    return values;
  }

  AppointmentOption? appointmentOption;

  List<Package> packageList = [];

  Future<dynamic> appointmentOptions() async {
    changeLoadingStatus(true);
    dynamic res = await _doctorRepository.appointmentOptions();
    changeLoadingStatus(false);
    try {
      appointmentOption = AppointmentOption.fromJson(res);
      packageList.clear();
      for (var element in appointmentOption!.package) {
        packageList
            .add(Package(getIcon(element), element, getContent(element)));
      }
      notifyListeners();
    } catch (e) {
      e.toString();
    }
    return res;
  }

  getIcon(String name) {
    if (name == "Messaging") {
      return Images.message;
    } else if (name.contains("Voice")) {
      return Images.voice;
    } else if (name.contains("Video")) {
      return Images.video;
    } else {
      return Images.user;
    }
  }

  getContent(String name) {
    if (name == "Messaging") {
      return "Chat with Doctor";
    } else if (name.contains("Voice")) {
      return "Voice call with Doctor";
    } else if (name.contains("Video")) {
      return "Video call with Doctor";
    } else {
      return "In Person visit with Doctor";
    }
  }

  Confirmation? confirmation;

  Future<dynamic> bookingConfirmation() async {
    changeLoadingStatus(true);
    dynamic res = await _doctorRepository.bookingConfirmation();
    changeLoadingStatus(false);
    try {
      confirmation = Confirmation.fromJson(res);
      notifyListeners();
    } catch (e) {
      e.toString();
    }
    return res;
  }

  List<MyBooking> myBookingList = [];

  Future<dynamic> myBooking() async {
    changeLoadingStatus(true);
    dynamic res = await _doctorRepository.myBooking();
    changeLoadingStatus(false);
    myBookingList.clear();
    try {
      res.forEach((element) {
        myBookingList.add(MyBooking.fromJson(element));
      });
    } catch (e) {
      e.toString();
    }
    return res;
  }
}
