class AddressModel {
  late int? _id;
  late String _addressType;
  late String? _contactPersonName;
  late String? _contactPersonNumder;
  late String _address;
  late String _latitude;
  late String _longitude;

  AddressModel({
    id,
    required addressType,
    contactPersonName,
    contactPersonNumder,
    address,
    latitude,
    longitude,
  }) {
    _id = id;
    _addressType = addressType;
    _contactPersonName = contactPersonName;
    _contactPersonNumder = contactPersonNumder;
    _address = address;
    _latitude = latitude;
    _longitude = longitude;
  }

  String get address => _address;
  String get addressType => _address;
  String? get contactPersonName => _contactPersonName;
  String? get contactPersonNumder => _contactPersonNumder;
  String get latitude => _latitude;
  String get longitude => _longitude;

  AddressModel.fromJson(Map<String, dynamic> json) {
    _id = json['id'];
    _addressType = json['address_type'] ?? '';
    _contactPersonNumder = json['contact_person_number'] ?? '';
    _contactPersonName = json['contact_person_name'] ?? '';
    _address = json['address'];
    _latitude = json['latitude'];
    _longitude = json['longitude'];
  }

  Map<String, dynamic> toJson() {
    return {
      'id': _id,
      'address_type': _addressType,
      'contact_person_number': _contactPersonNumder,
      'contact_person_name': _contactPersonName,
      'address': _address,
      'latitude': _latitude,
      'longitude': _longitude
    };
  }
}
