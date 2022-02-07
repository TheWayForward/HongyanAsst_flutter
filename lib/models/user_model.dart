import 'package:hongyanasst/models/address_model.dart';
import 'dart:convert';

class UserModel {
  late int id;
  late String username;
  late String nickname;
  late AddressModel addressModel;
  late String email;
  late String tel;
  late String avatar;
  late String password;
  late int credit;
  late int isManager;
  late String dateModified;
  late String detail;
  late int valid;


  UserModel(
      {required this.id,
      required this.username,
      required this.nickname,
      required this.addressModel,
      required this.email,
      required this.tel,
      required this.avatar,
      required this.password,
      required this.credit,
        required this.isManager,
      required this.dateModified,
      required this.detail,
      required this.valid});

  UserModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    username = json['username'];
    nickname = json['nickname'];
    addressModel = AddressModel.fromJson(jsonDecode(json['address']));
    email = json['email'];
    tel = json['tel'];
    avatar = json['avatar'];
    password = json['password'];
    credit = json['credit'];
    isManager = json['is_manager'];
    dateModified = json['date_modified'];
    detail = json['detail'];
    valid = json['valid'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['username'] = this.username;
    data['nickname'] = this.nickname;
    data['address'] = this.addressModel.toJson();
    data['email'] = this.email;
    data['tel'] = this.tel;
    data['avatar'] = this.avatar;
    data['password'] = this.password;
    data['credit'] = this.credit;
    data['is_manager'] = this.isManager;
    data['date_modified'] = this.dateModified;
    data['detail'] = this.detail;
    data['valid'] = this.valid;
    return data;
  }
}
