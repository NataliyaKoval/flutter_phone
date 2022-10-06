import 'dart:convert';

import '../models/country.dart';
import 'package:http/http.dart' as http;

Future<List<Country>> fetchCountries() async {
  final response = await http
      .get(Uri.parse('https://restcountries.com/v3.1/all'));

  if (response.statusCode == 200) {
    return List<Country>.from((jsonDecode(response.body) as List)
        .map((e) => Country.fromJson(e))
        .whereType<Country>());
  } else {
    throw Exception('Failed to load');
  }
}