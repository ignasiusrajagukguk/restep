class ErrorModel {
  int? id;
  String? errorCode;
  int? line;
  int? apiId;
  String? statusMessage;

  ErrorModel({
    this.id,
    this.errorCode,
    this.line,
    this.apiId,
    this.statusMessage,
  });

  ErrorModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    errorCode = json['error_code'];
    line = json['line'];
    apiId = json['api_id'];
    statusMessage = json['status_message'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['error_code'] = errorCode;
    data['line'] = line;
    data['api_id'] = apiId;
    data['status_message'] = statusMessage;
    return data;
  }
}
