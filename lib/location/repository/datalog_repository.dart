import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'datalog_repository.g.dart';

class DatalogRepository {
  Future<void> postDatalog(String firebaseID) async {
    final url = "https://suzi-backend.onrender.com/entries/$firebaseID";
    await Future.delayed(const Duration(seconds: 2));
    final body = jsonEncode({
      "timestamp": "${DateTime.now().toIso8601String()}Z",
      "firebaseID": firebaseID,
      "latitude": 0.0,
      "longitude": 0.0,
      "altitude": 0.0,
      "category": "test",
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
