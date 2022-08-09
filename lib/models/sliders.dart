// To parse this JSON data, do
//
//     final slidersResponse = slidersResponseFromJson(jsonString);

import 'dart:convert';

SlidersResponse slidersResponseFromJson(String str) => SlidersResponse.fromJson(json.decode(str));

String slidersResponseToJson(SlidersResponse data) => json.encode(data.toJson());

class SlidersResponse {
  SlidersResponse({
    this.data,
  });

  List<Datum> data;

  factory SlidersResponse.fromJson(Map<String, dynamic> json) => SlidersResponse(
    data: List<Datum>.from(json["data"].map((x) => Datum.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "data": List<dynamic>.from(data.map((x) => x.toJson())),
  };
}

class Datum {
  Datum({
    this.id,
    this.url,
  });

  int id;
  String url;

  factory Datum.fromJson(Map<String, dynamic> json) => Datum(
    id: json["id"],
    url: json["url"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "url": url,
  };
}
