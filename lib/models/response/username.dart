
class Username {

  final int id;
  final String username;

	Username.fromJsonMap(Map<String, dynamic> map):
		id = map["id"],
		username = map["username"];

	Map<String, dynamic> toJson() {
		final Map<String, dynamic> data = new Map<String, dynamic>();
		data['id'] = id;
		data['username'] = username;
		return data;
	}
}
