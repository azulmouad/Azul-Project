// To parse this JSON data, do
//
//     final news = newsFromJson(jsonString);

import 'dart:convert';

List<News> newsFromJson(String str) =>
    List<News>.from(json.decode(str).map((x) => News.fromJson(x)));

String newsToJson(List<News> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class News {
  News({
    this.id,
    this.date,
    this.link,
    this.title,
    this.image,
    this.content,
    this.categories,
    this.links,
    this.featuredMedia,
  });

  int id;
  DateTime date;
  String link;
  Title title;
  String image;
  Content content;
  List<int> categories;
  Links links;
  int featuredMedia;

  factory News.fromJson(Map<String, dynamic> json) => News(
        id: json["id"],
        date: DateTime.parse(json["date"]),
        link: json["link"],
        title: Title.fromJson(json["title"]),
        image: json["image"] == null ? null : json["image"],
        content: Content.fromJson(json["content"]),
        categories: List<int>.from(json["categories"].map((x) => x)),
        links: Links.fromJson(json["_links"]),
        featuredMedia: json["featured_media"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "date": date.toIso8601String(),
        "link": link,
        "title": title.toJson(),
        "image": image == null ? null : image,
        "content": content.toJson(),
        "categories": List<dynamic>.from(categories.map((x) => x)),
        "_links": links.toJson(),
        "featured_media": featuredMedia,
      };
}

class Content {
  Content({
    this.rendered,
    this.protected,
  });

  String rendered;
  bool protected;

  factory Content.fromJson(Map<String, dynamic> json) => Content(
        rendered: json["rendered"],
        protected: json["protected"],
      );

  Map<String, dynamic> toJson() => {
        "rendered": rendered,
        "protected": protected,
      };
}

class Links {
  Links({
    this.wpFeaturedmedia,
  });

  List<WpFeaturedmedia> wpFeaturedmedia;

  factory Links.fromJson(Map<String, dynamic> json) => Links(
        wpFeaturedmedia: List<WpFeaturedmedia>.from(
            json["wp:featuredmedia"].map((x) => WpFeaturedmedia.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "wp:featuredmedia":
            List<dynamic>.from(wpFeaturedmedia.map((x) => x.toJson())),
      };
}

class WpFeaturedmedia {
  WpFeaturedmedia({
    this.embeddable,
    this.href,
  });

  bool embeddable;
  String href;

  factory WpFeaturedmedia.fromJson(Map<String, dynamic> json) =>
      WpFeaturedmedia(
        embeddable: json["embeddable"],
        href: json["href"],
      );

  Map<String, dynamic> toJson() => {
        "embeddable": embeddable,
        "href": href,
      };
}

class Title {
  Title({
    this.rendered,
  });

  String rendered;

  factory Title.fromJson(Map<String, dynamic> json) => Title(
        rendered: json["rendered"],
      );

  Map<String, dynamic> toJson() => {
        "rendered": rendered,
      };
}
