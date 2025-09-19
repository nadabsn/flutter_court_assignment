import '../../bookings/models/court.dart';

class Facility {
  final String id;
  final String name;
  final String city;
  final List<String> sports;
  final String thumbnail;
  final List<Court> courts;

  Facility({
    required this.id,
    required this.name,
    required this.city,
    required this.sports,
    required this.thumbnail,
    required this.courts,
  });

  factory Facility.fromJson(Map<String, dynamic> json) {
    return Facility(
      id: json['id'],
      name: json['name'],
      city: json['city'],
      sports: List<String>.from(json['sports']),
      thumbnail: json['thumbnail'],
      courts: (json['courts'] as List)
          .map((court) => Court.fromJson(court))
          .toList(),
    );
  }
}
