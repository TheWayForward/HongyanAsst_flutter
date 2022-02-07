import 'package:city_pickers/city_pickers.dart';

class AddressModel {
  late String provinceName;
  late String provinceId;
  late String cityName;
  late String cityId;
  late String areaName;
  late String areaId;

  AddressModel(
      {required this.provinceName,
      required this.provinceId,
      required this.cityName,
      required this.cityId,
      required this.areaName,
      required this.areaId});

  AddressModel.fromResult(Result result) {
    provinceName = result.provinceName!;
    provinceId = result.provinceId!;
    cityName = result.cityName!;
    cityId = result.cityId!;
    areaName = result.areaName!;
    areaId = result.areaId!;
  }

  AddressModel.fromJson(Map<String, dynamic> json) {
    provinceName = json['provinceName'];
    provinceId = json['provinceId'];
    cityName = json['cityName'];
    cityId = json['cityId'];
    areaName = json['areaName'];
    areaId = json['areaId'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['provinceName'] = this.provinceName;
    data['provinceId'] = this.provinceId;
    data['cityName'] = this.cityName;
    data['cityId'] = this.cityId;
    data['areaName'] = this.areaName;
    data['areaId'] = this.areaId;
    return data;
  }

  String toString() {
    return "${this.provinceName} ${this.cityName} ${this.areaName}";
  }
}
