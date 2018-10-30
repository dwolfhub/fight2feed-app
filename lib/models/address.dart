class Address {
  int id;
  String line1;
  String line2;
  String city;
  String state;
  String zip;

  Address({
    this.id,
    this.line1,
    this.line2,
    this.city,
    this.state,
    this.zip,
  });

  factory Address.fromJson(Map<String, dynamic> json) {
    return Address(
      id: json['id'],
      line1: json['line1'],
      line2: json['line2'],
      city: json['city'],
      state: json['state'],
      zip: json['zip'],
    );
  }
}
