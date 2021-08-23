import 'package:flutter_data/flutter_data.dart';
import 'package:json_annotation/json_annotation.dart';

part 'user.g.dart';

@JsonSerializable()
@DataRepository([MyJSONServerAdapter])
class User with DataModel<User> {
  @override
  final int id;
  final String username;
  final String? password;
  final String firstName;
  final String lastName;

  User(
      {required this.id,
      required this.username,
      required this.password,
      required this.firstName,
      required this.lastName});
}

mixin MyJSONServerAdapter on RemoteAdapter<User> {
  @override
  String get baseUrl => 'http://192.168.0.23:8080/';
  @override
  String urlForFindAll(params) => 'user/find';
  @override
  String urlForFindOne(id, params) => 'user/$id';
  @override
  DataRequestMethod methodForSave(id, params) =>
      id != null ? DataRequestMethod.PUT : DataRequestMethod.POST;
}
