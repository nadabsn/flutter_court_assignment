import 'package:flutter/material.dart';

class Booking {
  final String id;
  final String facilityId;
  final String courtId;
  final DateTime date;
  final TimeOfDay startTime;
  final TimeOfDay endTime;
  final String facilityName;
  final String courtLabel;
  final double price;

  Booking({
    required this.id,
    required this.facilityId,
    required this.courtId,
    required this.date,
    required this.startTime,
    required this.endTime,
    required this.facilityName,
    required this.courtLabel,
    required this.price,
  });

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'facilityId': facilityId,
      'courtId': courtId,
      'date': date.toIso8601String(),
      'startTime':
          '${startTime.hour}:${startTime.minute.toString().padLeft(2, '0')}',
      'endTime': '${endTime.hour}:${endTime.minute.toString().padLeft(2, '0')}',
      'facilityName': facilityName,
      'courtLabel': courtLabel,
      'price': price,
    };
  }

  factory Booking.fromJson(Map<String, dynamic> json) {
    final startTimeParts = json['startTime'].split(':');
    final endTimeParts = json['endTime'].split(':');

    return Booking(
      id: json['id'],
      facilityId: json['facilityId'],
      courtId: json['courtId'],
      date: DateTime.parse(json['date']),
      startTime: TimeOfDay(
        hour: int.parse(startTimeParts[0]),
        minute: int.parse(startTimeParts[1]),
      ),
      endTime: TimeOfDay(
        hour: int.parse(endTimeParts[0]),
        minute: int.parse(endTimeParts[1]),
      ),
      facilityName: json['facilityName'],
      courtLabel: json['courtLabel'],
      price: json['price'].toDouble(),
    );
  }
}
