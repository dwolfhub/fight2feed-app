class Address {
  int id;
  String streetAddress;
  String addressLocality;
  String addressRegion;
  String postalCode;
  String addressCountry;

  Address({
    this.id,
    this.streetAddress,
    this.addressLocality,
    this.addressRegion,
    this.postalCode,
    this.addressCountry,
  });

  factory Address.fromJson(Map<String, dynamic> json) {
    return Address(
      id: json['id'],
      streetAddress: json['streetAddress'],
      addressLocality: json['addressLocality'],
      addressRegion: json['addressRegion'],
      postalCode: json['postalCode'],
      addressCountry: json['addressCountry'],
    );
  }
}
