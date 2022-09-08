// To parse this JSON data, do
//
//     final movieDetailsResponse = movieDetailsResponseFromJson(jsonString);

import 'dart:convert';

MovieDetailsResponse movieDetailsResponseFromJson(String str) => MovieDetailsResponse.fromJson(json.decode(str));

String movieDetailsResponseToJson(MovieDetailsResponse data) => json.encode(data.toJson());

class MovieDetailsResponse {
  MovieDetailsResponse({
    this.data,
  });

  Data data;

  factory MovieDetailsResponse.fromJson(Map<String, dynamic> json) => MovieDetailsResponse(
    data: Data.fromJson(json["data"]),
  );

  Map<String, dynamic> toJson() => {
    "data": data.toJson(),
  };
}

class Data {
  Data({
    this.id,
    this.name,
    this.category,
    this.image,
    this.link,
    this.rating,
    this.duration,
    this.description,
    this.releaseDate,
  });

  int id;
  String name;
  String category;
  String image;
  String link;
  String rating;
  String duration;
  String description;
  String releaseDate;

  factory Data.fromJson(Map<String, dynamic> json) => Data(
    id: json["id"],
    name: json["name"],
    category: json["category"],
    image: json["image"],
    link: json["link"],
    rating: json["rating"],
    duration: json["duration"],
    description: json["description"],
    releaseDate: json["release_date"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "name": name,
    "category": category,
    "image": image,
    "link": link,
    "rating": rating,
    "duration": duration,
    "description": description,
    "release_date": releaseDate,
  };
}
