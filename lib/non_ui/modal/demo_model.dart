import 'package:hive/hive.dart';
import 'package:json_annotation/json_annotation.dart';

part 'demo_model.g.dart';

@JsonSerializable(explicitToJson: true)
@HiveType(typeId: 0)
class DemoModel {
  @HiveField(0)
  String _name;

  @HiveField(1)
  String _country;

  String get name => _name;
  String get country => _country;

  DemoModel({
       String name,
       String country}){
    _name = name;
    _country = country;
}

  factory DemoModel.fromJson(Map<String, dynamic> json) => _$DemoModelFromJson(json);

  Map<String, dynamic> toJson() => _$DemoModelToJson(this);
  

}