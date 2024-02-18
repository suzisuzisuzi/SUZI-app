import 'dart:convert';

import 'package:geolocator/geolocator.dart';
import 'package:http/http.dart' as http;
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'datalog_repository.g.dart';

class DatalogRepository {
  Future<Position> _determinePosition() async {
    bool serviceEnabled;
    LocationPermission permission;
    serviceEnabled = await Geolocator.isLocationServiceEnabled();

    if (!serviceEnabled) {
      return Future.error('Location services are disabled.');
    }

    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        return Future.error('Location permissions are denied');
      }
    }

    if (permission == LocationPermission.deniedForever) {
      return Future.error(
          'Location permissions are permanently denied, we cannot request permissions.');
    }
    return await Geolocator.getCurrentPosition();
  }

  Future<void> postDatalog(String firebaseID, double rating) async {
    final position = await _determinePosition();
    final url = "https://suzi-backend.onrender.com/entries/$firebaseID";
    final body = jsonEncode({
      "timestamp": "${DateTime.now().toIso8601String()}Z",
      "firebaseID": firebaseID,
      "latitude": position.latitude,
      "longitude": position.longitude,
      "altitude": position.altitude,
      "category": "test",
      "rating": rating
    });

    final response = await http.post(
      Uri.parse(url),
      body: body,
      headers: {
        "Content-Type": "application/json",
      },
    );

    if (response.statusCode != 200) {
      throw Exception("Failed to post datalog");
    }
  }
}

@riverpod
DatalogRepository datalogRepository(DatalogRepositoryRef ref) {
  return DatalogRepository();
}
