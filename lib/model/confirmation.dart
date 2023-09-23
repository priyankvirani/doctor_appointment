class Confirmation {
  String doctorName;
  DateTime appointmentDate;
  String appointmentTime;
  String location;
  String appointmentPackage;

  Confirmation({
    required this.doctorName,
    required this.appointmentDate,
    required this.appointmentTime,
    required this.location,
    required this.appointmentPackage,
  });

  factory Confirmation.fromJson(Map<String, dynamic> json) => Confirmation(
    doctorName: json["doctor_name"],
    appointmentDate: DateTime.parse(json["appointment_date"]),
    appointmentTime: json["appointment_time"],
    location: json["location"],
    appointmentPackage: json["appointment_package"],
  );

  Map<String, dynamic> toJson() => {
    "doctor_name": doctorName,
    "appointment_date": "${appointmentDate.year.toString().padLeft(4, '0')}-${appointmentDate.month.toString().padLeft(2, '0')}-${appointmentDate.day.toString().padLeft(2, '0')}",
    "appointment_time": appointmentTime,
    "location": location,
    "appointment_package": appointmentPackage,
  };
}
