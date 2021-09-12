import 'dart:convert';

class ResponseModel {
  final String? status;
  final dynamic params;
  final String? message;

  ResponseModel({
    this.status,
    this.params,
    this.message,
  });

  static const success = 'success';
  static const fail = 'fail';

  bool isSuccess() {
    return status == success;
  }

  bool isFail() {
    return status == fail;
  }

  ResponseModel copyWith({
    String? status,
    dynamic params,
    String? message,
  }) {
    return ResponseModel(
      status: status ?? this.status,
      params: params ?? this.params,
      message: message ?? this.message,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'status': status,
      'params': params,
      'message': message,
    };
  }

  factory ResponseModel.fromMap(Map<String, dynamic> map) {
    return ResponseModel(
      status: map['status'],
      params: map['params'],
      message: map['message'],
    );
  }

  String toJson() => json.encode(toMap());

  factory ResponseModel.fromJson(String source) =>
      ResponseModel.fromMap(json.decode(source));

  @override
  String toString() =>
      'ResponseModel(status: $status, params: $params, message: $message)';

  @override
  bool operator ==(Object o) {
    if (identical(this, o)) return true;

    return o is ResponseModel &&
        o.status == status &&
        o.params == params &&
        o.message == message;
  }

  @override
  int get hashCode => status.hashCode ^ params.hashCode ^ message.hashCode;
}