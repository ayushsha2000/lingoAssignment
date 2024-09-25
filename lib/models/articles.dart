class Article {
  Source? source;
  String? title;
  String? urlToImage;
  String? publishedAt;

  Article({
    this.source,
    this.title,
    this.urlToImage,
    this.publishedAt,
  });

  factory Article.fromJson(Map<String, dynamic> json) => Article(
        source: json['source'] == null
            ? null
            : Source.fromJson(json['source'] as Map<String, dynamic>),
        title: json['title'] as String?,
        urlToImage: json['urlToImage'] as String?,
        publishedAt: json['publishedAt'] as String?,
      );

  Map<String, dynamic> toJson() => {
        'source': source?.toJson(),
        'title': title,
        'urlToImage': urlToImage,
        'publishedAt': publishedAt,
      };
}

class Source {
  String? name;

  Source({this.name});

  factory Source.fromJson(Map<String, dynamic> json) => Source(
        name: json['name'] as String?,
      );

  Map<String, dynamic> toJson() => {
        'name': name,
      };
}

