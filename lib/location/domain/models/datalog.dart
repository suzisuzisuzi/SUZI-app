class Datalog {
  final DateTime time;
  final String firebaseID;
  final double latitude;
  final double longitude;
  final double altitude;
  final String category;

  Datalog({
    required this.time,
    required this.firebaseID,
    required this.latitude,
    required this.longitude,
    required this.altitude,
    required this.category,
  });

  Map<String, dynamic> toMap() {
    return {
      'timestamp': time,
      'firebaseID': firebaseID,
      'latitude': latitude,
      'longitude': longitude,
      'altitude': altitude,
      'category': category,
    };
  }

  factory Datalog.fromMap(Map<String, dynamic> map) {
    return Datalog(
      time: map['timestamp'],
      firebaseID: map['firebaseID'],
      latitude: map['latitude'],
      longitude: map['longitude'],
      altitude: map['altitude'],
      category: map['category'],
    );
  }
}
