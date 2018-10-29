class Donation {
  int id;
  String title;
  String description;
  var photo;
  DateTime createdDate;
  DateTime expirationDate;
  bool active;

  Donation({this.id, this.title, this.description, this.photo, this.createdDate, this.expirationDate, this.active});

  factory Donation.fromJson(Map<String, dynamic> json) {
    return Donation(
      id: json['id'],
      title: json['title'],
      description: json['description'],
      photo: json['photo'],
      createdDate: DateTime.parse(json['createdDate']),
      expirationDate: DateTime.parse(json['expirationDate']),
      active: json['active'],
    );
  }
}