import 'dart:convert';

Map<String, String> allCurrenciesFromJson(String str) =>
    Map.from(json.decode(str))
        .map((key, value) => MapEntry<String, String>(key, value));

String allCurrenciesToJson(Map<String, String> data) => json.encode(
  Map.from(data).map((key, value) => MapEntry<String, dynamic>(key, value)),
);
