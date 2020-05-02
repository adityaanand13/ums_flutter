
class BatchRequest {

  int id = null;
  String name;
  String description;

  BatchRequest(this.id, this.name, this.description);


  BatchRequest.create({this.name, this.description});

  BatchRequest.fromJsonMap(Map<String, dynamic> map):
        id = map["id"],
        name = map["name"],
        description = map["description"];

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = id;
    data['name'] = name;
    data['description'] = description;
    return data;
  }

}
