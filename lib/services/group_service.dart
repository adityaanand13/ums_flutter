import 'package:ums_flutter/api/api.dart';
import 'package:ums_flutter/models/models.dart';
import 'package:ums_flutter/utils/utils.dart';
import 'package:meta/meta.dart';

class GroupService {
  final ServerApiProvider serverApiProvider;

  final String baseUrl = GROUP_URL;
  final String sectionUrl = SECTION_URL;

  GroupService({@required this.serverApiProvider});

  Future<SectionResponse> createGroup({@required GroupResponse groupResponse, @required int sectionId}) async {
    String token = await storageApiProvider.getToken();
    var sectionResponse = await serverApiProvider.post(
      route: "$sectionUrl/$sectionId/add-group",
      token: token,
      body:groupResponse.toJson(),
    );
    return SectionResponse.fromJsonMap(sectionResponse);
  }

  Future<GroupResponse> createStudent({@required int groupId, @required Student student}) async {
    String token = await storageApiProvider.getToken();
    var groupJson = await serverApiProvider.post(
        route: "$GROUP_URL/$groupId/add-student/",
        token: token,
        body:student.toJson(),
    );
    return GroupResponse.fromJsonMap(groupJson);
  }

  Future<GroupResponse> getGroup({@required int groupId}) async {
    String token = await storageApiProvider.getToken();
    var groupJson = await serverApiProvider.get(
        route: "$GROUP_URL/$groupId",
        token: token,
    );
    return GroupResponse.fromJsonMap(groupJson);
  }
}
