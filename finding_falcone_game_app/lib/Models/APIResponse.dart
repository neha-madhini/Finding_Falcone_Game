class APIResponse<T> {
  dynamic responceType;
  bool? isSuccess;
  T? data;
  dynamic errorCode;
  String? errorMessage;

  APIResponse(
      {this.responceType,
      this.isSuccess,
      this.data,
      this.errorCode,
      this.errorMessage});

  APIResponse.fromJson(Map<String, dynamic> json) {
    responceType = json['responceType'];
    isSuccess = json['isSuccess'];
    data = json['data'];
    errorCode = json['errorCode'];
    errorMessage = json['errorMessage'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['responceType'] = responceType;
    data['isSuccess'] = isSuccess;
    data['data'] = this.data;
    data['errorCode'] = errorCode;
    data['errorMessage'] = errorMessage;
    return data;
  }
}