class UserModel {
  UserModel();

  int id;
  String username;
  String firstName;
  String lastName;
  String email;
  String gender;
  String phone;
  String blood;
  String religion;
  String category;
  int aadhar;
  String userType;
  String address;
  String city;
  String state;
  int pinCode;
  String country;
  String dob;

  UserModel.fromJsonMap(Map<String, dynamic> map)
      : id = map["id"],
        username = map["username"],
        firstName = map["firstName"],
        lastName = map["lastName"],
        email = map["email"],
        gender = map["gender"],
        phone = map["phone"],
        blood = map["blood"],
        religion = map["religion"],
        category = map["category"],
        aadhar = map["aadhar"],
        userType = map["userType"],
        address = map["address"],
        city = map["city"],
        state = map["state"],
        pinCode = map["pinCode"],
        country = map["country"],
        dob = map["dob"];

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = id;
    data['username'] = username;
    data['firstName'] = firstName;
    data['lastName'] = lastName;
    data['email'] = email;
    data['gender'] = gender;
    data['phone'] = phone;
    data['blood'] = blood;
    data['religion'] = religion;
    data['category'] = category;
    data['aadhar'] = aadhar;
    data['userType'] = userType;
    data['address'] = address;
    data['city'] = city;
    data['state'] = state;
    data['pinCode'] = pinCode;
    data['country'] = country;
    data['dob'] = dob;
    return data;
  }

  UserModel.add(
      {this.username,
      this.firstName,
      this.lastName,
      this.email,
      this.gender,
      this.phone,
      this.blood,
      this.religion,
      this.category,
      this.aadhar,
      this.userType,
      this.address,
      this.city,
      this.state,
      this.pinCode,
      this.country,
      this.dob});
}
