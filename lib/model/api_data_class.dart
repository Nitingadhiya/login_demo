class APIDataClass {
  bool isSuccess;
  dynamic data;
  String? message;
  bool? validation;
  int? status;

  APIDataClass({required this.isSuccess, this.data, this.message, this.validation, this.status});

  factory APIDataClass.fromJson(Map<String, dynamic> json) {
    return APIDataClass(
      message: json['message'] as String?,
      isSuccess: json['isSuccess'] as bool,
      data: json['data'] as String?,
      validation: json['validation'] as bool?,
      status: json['status'] as int,
    );
  }
}

///Command to create files
//flutter pub run build_runner build --delete-conflicting-outputs
