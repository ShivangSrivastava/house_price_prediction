// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class ResponseModel {
  final double accuracy;
  final double expectedPrice;

  ResponseModel({required this.accuracy, required this.expectedPrice});

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'accuracy': accuracy,
      'expected_price': expectedPrice,
    };
  }

  factory ResponseModel.fromMap(Map<String, dynamic> map) {
    return ResponseModel(
      accuracy: map['accuracy'] as double,
      expectedPrice: map['expected_price'] as double,
    );
  }

  String toJson() => json.encode(toMap());

  factory ResponseModel.fromJson(String source) => ResponseModel.fromMap(json.decode(source) as Map<String, dynamic>);
}
