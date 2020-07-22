import 'package:meta/meta.dart';

class Student {
  int id;
  String username;
  String firstName;
  String lastName;
  String dob;
  String blood;
  String gender;
  String phone;
  String email;
  int aadhar;
  String religion;
  String category;
  String nationality;

  String fathersName;
  String fathersPhone;
  String fathersOccupation;
  int fathersIncome;
  String mothersName;
  String mothersPhone;
  int mothersIncome;
  String mothersOccupation;

  int familyIncome;
  String localAddress;
  String address;
  String city;
  String state;
  int pinCode;
  String country;

  String password;

  Student({
    this.id,
    this.username,
    this.firstName,
    this.lastName,
    this.dob,
    this.blood,
    this.gender,
    this.phone,
    this.email,
    this.aadhar,
    this.religion,
    this.category,
    this.nationality,
    this.fathersName,
    this.fathersPhone,
    this.fathersOccupation,
    this.fathersIncome,
    this.mothersName,
    this.mothersPhone,
    this.mothersIncome,
    this.mothersOccupation,
    this.familyIncome,
    this.localAddress,
    this.address,
    this.city,
    this.state,
    this.pinCode,
    this.country,
    this.password,
  });

  Student.create({
    @required this.username,
    @required this.firstName,
    @required this.lastName,
    @required this.dob,
    @required this.blood,
    @required this.gender,
    @required this.phone,
    @required this.email,
    @required this.aadhar,
    @required this.religion,
    @required this.category,
    @required this.nationality,
    @required this.fathersName,
    @required this.fathersPhone,
    @required this.fathersOccupation,
    @required this.fathersIncome,
    @required this.mothersName,
    @required this.mothersPhone,
    @required this.mothersIncome,
    @required this.mothersOccupation,
    @required this.familyIncome,
    @required this.localAddress,
    @required this.address,
    @required this.city,
    @required this.state,
    @required this.pinCode,
    @required this.country,
  });

  Student.fromJsonMap(Map<String, dynamic> map)
      : id = map["id"],
        username = map["username"],
        firstName = map["firstName"],
        lastName = map["lastName"],
        dob = map["dob"],
        blood = map["blood"],
        email = map["email"],
        phone = map["phone"],
        gender = map["gender"],
        religion = map["religion"],
        category = map["category"],
        aadhar = map["aadhar"],
        address = map["address"],
        city = map["city"],
        state = map["state"],
        pinCode = map["pinCode"],
        country = map["country"],
        localAddress = map["localAddress"],
        nationality = map["nationality"],
        fathersName = map["fathersName"],
        fathersPhone = map["fathersPhone"],
        fathersIncome = map["fathersIncome"],
        fathersOccupation = map["fathersOccupation"],
        mothersName = map["mothersName"],
        mothersPhone = map["mothersPhone"],
        mothersIncome = map["mothersIncome"],
        mothersOccupation = map["mothersOccupation"],
        familyIncome = map["familyIncome"];

  Map<String, dynamic> toJson() {
    Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = id;
    data['username'] = username;
    data['firstName'] = firstName;
    data['lastName'] = lastName;
    data['dob'] = dob;
    data['blood'] = blood;
    data['email'] = email;
    data['phone'] = phone;
    data['gender'] = gender;
    data['religion'] = religion;
    data['category'] = category;
    data['aadhar'] = aadhar;
    data['address'] = address;
    data['city'] = city;
    data['state'] = state;
    data['pinCode'] = pinCode;
    data['country'] = country;
    data['localAddress'] = localAddress;
    data['nationality'] = nationality;
    data['fathersName'] = fathersName;
    data['fathersPhone'] = fathersPhone;
    data['fathersIncome'] = fathersIncome;
    data['fathersOccupation'] = fathersOccupation;
    data['mothersName'] = mothersName;
    data['mothersPhone'] = mothersPhone;
    data['mothersIncome'] = mothersIncome;
    data['mothersOccupation'] = mothersOccupation;
    data['familyIncome'] = familyIncome;
    data['password'] = password;
    return data;
  }

  @override
  String toString() {
    return 'Student{\n\tid: $id, \n\tusername: $username, \n\tfirstName: $firstName, \n\tlastName: $lastName, \n\tdob: $dob, \n\tblood: $blood, \n\temail: $email, \n\tphone: $phone, \n\tgender: $gender, \n\treligion: $religion, \n\tcategory: $category, \n\taadhar: $aadhar, \n\taddress: $address, \n\tcity: $city, \n\tstate: $state, \n\tpinCode: $pinCode, \n\tcountry: $country, \n\tlocalAddress: $localAddress, \n\tnationality: $nationality, \n\tfathersName: $fathersName, \n\tfathersPhone: $fathersPhone, \n\tfathersIncome: $fathersIncome, \n\tfathersOccupation: $fathersOccupation, \n\tmothersName: $mothersName, \n\tmothersPhone: $mothersPhone, \n\tmothersIncome: $mothersIncome, \n\tmothersOccupation: $mothersOccupation, \n\tfamilyIncome: $familyIncome \n\tpassword: $password\n}';
  }
}
