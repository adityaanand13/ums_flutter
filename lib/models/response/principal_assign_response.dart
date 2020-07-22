import 'package:equatable/equatable.dart';
import 'package:ums_flutter/models/user_model.dart';

class PrincipalAssignResponse extends Equatable {
  @override
  List<Object> get props => [id, principal];

  final int id;
  final UserModel principal;

  PrincipalAssignResponse.fromJsonMap(Map<String, dynamic> map)
      : id = map["id"],
        principal =
            map["principal"] != null ? UserModel.fromJsonMap(map["principal"]) : null;
}
