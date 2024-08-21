
import 'dart:convert';

List<int> userFavoriteIdsModelFromJson(String str) => List<int>.from(json.decode(str).map((x) => x));

String userFavoriteIdsModelToJson(List<int> data) => json.encode(List<dynamic>.from(data.map((x) => x)));
