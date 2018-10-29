class Media {
  int id;
  String contentUrl;

  Media({this.id, this.contentUrl});

  factory Media.fromJson(Map<String, dynamic> json) {
    return Media(
      id: json['id'],
      contentUrl: json['contentUrl'],
    );
  }
}
