
class Doctor {
  String doctorName;
  String image;
  String speciality;
  String location;
  int patientsServed;
  int yearsOfExperience;
  double rating;
  int numberOfReviews;
  Map<String, List<String>> availability;

  Doctor({
    required this.doctorName,
    required this.image,
    required this.speciality,
    required this.location,
    required this.patientsServed,
    required this.yearsOfExperience,
    required this.rating,
    required this.numberOfReviews,
    required this.availability,
  });

  factory Doctor.fromJson(Map<String, dynamic> json) => Doctor(
    doctorName: json["doctor_name"],
    image: json["image"],
    speciality: json["speciality"],
    location: json["location"],
    patientsServed: json["patients_served"],
    yearsOfExperience: json["years_of_experience"],
    rating: json["rating"]?.toDouble(),
    numberOfReviews: json["number_of_reviews"],
    availability: Map.from(json["availability"]).map((k, v) => MapEntry<String, List<String>>(k, List<String>.from(v.map((x) => x)))),
  );


}
