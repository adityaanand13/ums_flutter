import 'package:ums_flutter/api/api.dart';
import 'package:meta/meta.dart';
import 'package:ums_flutter/utils/utils.dart';

class StudentService {
  final ServerApiProvider serverApiProvider;

  final String baseUrl = GROUP_URL;

  StudentService({@required this.serverApiProvider});


}