import 'package:json_annotation/json_annotation.dart';

part 'base_response.g.dart';

@JsonSerializable(createToJson: false, genericArgumentFactories: true)
class BaseResponse{
  final bool status;
  final dynamic data;
  final dynamic message;

  BaseResponse({
    required this.status,
    required this.data,
    required this.message,
  });

  factory BaseResponse.fromJson(Map<String, dynamic> json) =>
      _$BaseResponseFromJson(json);
}
