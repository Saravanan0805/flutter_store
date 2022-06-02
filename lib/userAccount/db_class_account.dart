class UserDetails {
  final String username;
  final String email;
  final num id;
  final String phone;
  final UserAddress address;
  final UserName name;

  UserDetails(
      {required this.username,
      required this.email,
      required this.id,
      required this.address,
      required this.phone,
      required this.name});
  factory UserDetails.fromJson(Map<String, dynamic> json) {
    return UserDetails(
        username: json['username'],
        email: json['email'],
        id: json['id'],
        phone: json['phone'],
        address: UserAddress.fromJson(json['address']),
        name: UserName.fromJson(json['name']));
  }
}

class UserAddress {
  final String city;
  final String street;
  final num number;
  final String zipcode;

  UserAddress(
      {required this.city,
      required this.street,
      required this.number,
      required this.zipcode});
  factory UserAddress.fromJson(Map<String, dynamic> json) {
    return UserAddress(
        city: json['city'],
        street: json['street'],
        number: json['number'],
        zipcode: json['zipcode']);
  }
}

class UserName {
  final String firstname;
  final String lastname;

  UserName({required this.firstname, required this.lastname});
  factory UserName.fromJson(Map<String, dynamic> json) {
    return UserName(
      firstname: json['firstname'],
      lastname: json['lastname'],
    );
  }
}
