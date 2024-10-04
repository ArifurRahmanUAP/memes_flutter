class Response<T> {
  Status? status;
  T? data;
  String? message;
  int? statusCode;

  Response.loading() : status = Status.loading;

  Response.error(this.message, this.statusCode) : status = Status.failed;

  Response.success(this.data) : status = Status.success;
}

enum Status { success, failed, loading, validation }
