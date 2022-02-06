class UserModel {
  late int id;
  late String username;
  late String nickname;
  late String email;
  late String tel;
  late String avatar;
  late String password;
  late int credit;
  late String dateModified;
  late String detail;
  late int valid;

  UserModel(
      {required this.id,
      required this.username,
      required this.nickname,
      required this.email,
      required this.tel,
      required this.avatar,
      required this.password,
      required this.credit,
      required this.dateModified,
      required this.detail,
      required this.valid});

  UserModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    username = json['username'];
    nickname = json['nickname'];
    email = json['email'];
    tel = json['tel'];
    avatar = json['avatar'];
    password = json['password'];
    credit = json['credit'];
    dateModified = json['date_modified'];
    detail = json['detail'];
    valid = json['valid'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['username'] = this.username;
    data['nickname'] = this.nickname;
    data['email'] = this.email;
    data['tel'] = this.tel;
    data['avatar'] = this.avatar;
    data['password'] = this.password;
    data['credit'] = this.credit;
    data['date_modified'] = this.dateModified;
    data['detail'] = this.detail;
    data['valid'] = this.valid;
    return data;
  }
}
