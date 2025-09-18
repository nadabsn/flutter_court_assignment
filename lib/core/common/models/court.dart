class Court {
  final String id;
  final String sport;
  final String label;
  final double price;
  final int slotMinutes;
  final String dailyOpen;
  final String dailyClose;

  Court({
    required this.id,
    required this.sport,
    required this.label,
    required this.price,
    this.slotMinutes = 60,
    this.dailyOpen = "09:00",
    this.dailyClose = "21:00",
  });

  factory Court.fromJson(Map<String, dynamic> json) {
    return Court(
      id: json['id'],
      sport: json['sport'],
      label: json['label'],
      price: json['price'].toDouble(),
      slotMinutes: json['slotMinutes'] ?? 60,
      dailyOpen: json['dailyOpen'] ?? "09:00",
      dailyClose: json['dailyClose'] ?? "21:00",
    );
  }
}