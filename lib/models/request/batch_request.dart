
class BatchRequest {

  int id;
  String name;

  BatchRequest({this.id, this.name});


  BatchRequest.create({this.name});

  BatchRequest.fromJsonMap(Map<String, dynamic> map):
        id = map["id"],
        name = map["name"];

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = id;
    data['name'] = name;
    return data;
  }

}
