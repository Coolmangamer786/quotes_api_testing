import 'dart:async';
import 'dart:convert';

import 'package:http/http.dart' as http;

Future<Quotes> fetchAlbum() async {
  final response = await http.get(
    Uri.parse(
        'https://quotes15.p.rapidapi.com/quotes/random/?language_code=en'),
    // Send authorization headers to the backend.
    headers: {
      'x-rapidapi-host': 'quotes15.p.rapidapi.com',
      'x-rapidapi-key': 'c23cd37918msh4137dd9f8ad5a58p1c802fjsn750a70fbd198'
    },
  );
  final responseJson = jsonDecode(response.body);
  print(responseJson);
  return Quotes.fromJson(responseJson);
}

// To parse this JSON data, do
//
//     final quotes = quotesFromJson(jsonString);

Quotes quotesFromJson(String str) => Quotes.fromJson(json.decode(str));

String quotesToJson(Quotes data) => json.encode(data.toJson());

class Quotes {
  Quotes({
    required this.id,
    required this.languageCode,
    required this.content,
    required this.url,
    required this.originator,
  });

  int id;
  String languageCode;
  String content;
  String url;
  Originator originator;

  factory Quotes.fromJson(Map<String, dynamic> json) => Quotes(
        id: json["id"],
        languageCode: json["language_code"],
        content: json["content"],
        url: json["url"],
        originator: Originator.fromJson(json["originator"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "language_code": languageCode,
        "content": content,
        "url": url,
        "originator": originator.toJson(),
      };
}

class Originator {
  Originator({
    required this.id,
    required this.name,
    required this.url,
  });

  int id;
  String name;
  String url;

  factory Originator.fromJson(Map<String, dynamic> json) => Originator(
        id: json["id"],
        name: json["name"],
        url: json["url"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "url": url,
      };
}
