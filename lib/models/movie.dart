// To parse this JSON data, do
//
//     final moviesResponse = moviesResponseFromJson(jsonString);

import 'dart:convert';

MoviesResponse moviesResponseFromJson(String str) => MoviesResponse.fromJson(json.decode(str));

String moviesResponseToJson(MoviesResponse data) => json.encode(data.toJson());

class MoviesResponse {
  MoviesResponse({
    this.data,
    this.links,
    this.meta,
  });

  List<MovieData> data;
  Links links;
  Meta meta;

  factory MoviesResponse.fromJson(Map<String, dynamic> json) => MoviesResponse(
    data: List<MovieData>.from(json["data"].map((x) => MovieData.fromJson(x))),
    links: Links.fromJson(json["links"]),
    meta: Meta.fromJson(json["meta"]),
  );

  Map<String, dynamic> toJson() => {
    "data": List<dynamic>.from(data.map((x) => x.toJson())),
    "links": links.toJson(),
    "meta": meta.toJson(),
  };
}

class MovieData {
  MovieData({
    this.id,
    this.name,
    this.category,
    this.image,
    this.link,
    this.rating,
    this.duration,
    this.description,
    this.releaseDate,
    this.tranding,
  });

  var id;
  String name;
  String category;
  String image;
  String link;
  String rating;
  String duration;
  String description;
  String releaseDate;
  String tranding;

  factory MovieData.fromJson(Map<String, dynamic> json) => MovieData(
    id: json["id"],
    name: json["name"],
    category: json["category"],
    image: json["image"],
    link: json["link"],
    rating: json["rating"],
    duration: json["duration"],
    description: json["description"],
    releaseDate: json["release_date"],
    tranding: json["tranding"],
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
    "tranding": tranding,
  };
}

class Links {
  Links({
    this.first,
    this.last,
    this.prev,
    this.next,
  });

  String first;
  String last;
  dynamic prev;
  dynamic next;

  factory Links.fromJson(Map<String, dynamic> json) => Links(
    first: json["first"],
    last: json["last"],
    prev: json["prev"],
    next: json["next"],
  );

  Map<String, dynamic> toJson() => {
    "first": first,
    "last": last,
    "prev": prev,
    "next": next,
  };
}

class Meta {
  Meta({
    this.currentPage,
    this.from,
    this.lastPage,
    this.links,
    this.path,
    this.perPage,
    this.to,
    this.total,
  });

  int currentPage;
  int from;
  int lastPage;
  List<Link> links;
  String path;
  int perPage;
  int to;
  int total;

  factory Meta.fromJson(Map<String, dynamic> json) => Meta(
    currentPage: json["current_page"],
    from: json["from"],
    lastPage: json["last_page"],
    links: List<Link>.from(json["links"].map((x) => Link.fromJson(x))),
    path: json["path"],
    perPage: json["per_page"],
    to: json["to"],
    total: json["total"],
  );

  Map<String, dynamic> toJson() => {
    "current_page": currentPage,
    "from": from,
    "last_page": lastPage,
    "links": List<dynamic>.from(links.map((x) => x.toJson())),
    "path": path,
    "per_page": perPage,
    "to": to,
    "total": total,
  };
}

class Link {
  Link({
    this.url,
    this.label,
    this.active,
  });

  String url;
  String label;
  bool active;

  factory Link.fromJson(Map<String, dynamic> json) => Link(
    url: json["url"] == null ? null : json["url"],
    label: json["label"],
    active: json["active"],
  );

  Map<String, dynamic> toJson() => {
    "url": url == null ? null : url,
    "label": label,
    "active": active,
  };
}
