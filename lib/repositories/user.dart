import 'package:bank/repositories/adapters.dart';
import 'package:flutter_data/flutter_data.dart';
import 'package:json_annotation/json_annotation.dart';

part 'user.g.dart';

@JsonSerializable()
@DataRepository([MyJSONServerAdapter, BankRemoteAdapter])
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
  String get type => 'user';
  @override
  String get baseUrl => 'http://127.0.0.1:8080/';
  @override
  String urlForFindAll(params) => 'user/find';
  @override
  DataRequestMethod methodForSave(id, params) =>
      id != null ? DataRequestMethod.PUT : DataRequestMethod.POST;
}
