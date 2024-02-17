// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class RequestModel {
  final int area;
  final int bedrooms;
  final int bathrooms;
  final int balcony;
  final int parking;
  final int lift;
  final int newProperty;
  final int flat;

  RequestModel(
      {required this.area,
      required this.bedrooms,
      required this.bathrooms,
      required this.balcony,
      required this.parking,
      required this.lift,
      required this.newProperty,
      required this.flat});

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'area': area,
      'bedrooms': bedrooms,
      'bathrooms': bathrooms,
      'balcony': balcony,
      'parking': parking,
      'lift': lift,
      'new_property': newProperty,
      'flat': flat,
    };
  }

  factory RequestModel.fromMap(Map<String, dynamic> map) {
    return RequestModel(
      area: map['area'] as int,
      bedrooms: map['bedrooms'] as int,
      bathrooms: map['bathrooms'] as int,
      balcony: map['balcony'] as int,
      parking: map['parking'] as int,
      lift: map['lift'] as int,
      newProperty: map['new_property'] as int,
      flat: map['flat'] as int,
    );
  }

  String toJson() => json.encode(toMap());

  factory RequestModel.fromJson(String source) =>
      RequestModel.fromMap(json.decode(source) as Map<String, dynamic>);
}
