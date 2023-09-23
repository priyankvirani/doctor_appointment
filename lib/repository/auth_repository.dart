import 'package:flutter_doctor_appointment/networking/api_endpoints.dart';
import 'package:flutter_doctor_appointment/networking/dio_client.dart';

class DoctorRepository {
  Future<dynamic> doctors() {
    return RestApiService().get(ApiEndpoints.doctorDetails);
  }

  Future<dynamic> appointmentOptions() {
    return RestApiService().get(ApiEndpoints.appointmentOptions);
  }

  Future<dynamic> bookingConfirmation() {
    return RestApiService().get(ApiEndpoints.bookingConfirmation);
  }

  Future<dynamic> myBooking() {
    return RestApiService().get(ApiEndpoints.myBooking);
  }

}
