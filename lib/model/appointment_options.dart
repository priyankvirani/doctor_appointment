class AppointmentOption {
  List<String> duration;
  List<String> package;

  AppointmentOption({
    required this.duration,
    required this.package,
  });

  factory AppointmentOption.fromJson(Map<String, dynamic> json) => AppointmentOption(
    duration: List<String>.from(json["duration"].map((x) => x)),
    package: List<String>.from(json["package"].map((x) => x)),
  );

  Map<String, dynamic> toJson() => {
    "duration": List<dynamic>.from(duration.map((x) => x)),
    "package": List<dynamic>.from(package.map((x) => x)),
  };
}
