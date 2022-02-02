// Network Exception
class HiNetError implements Exception {
  final int code;
  final String message;
  final dynamic data;

  HiNetError(this.code, this.message, {this.data});
}

// Authorization Exception
class NeedAuth extends HiNetError {
  NeedAuth(String message, {int code = 403, dynamic data})
      : super(code, message, data: data);
}

// Login Exception
class NeedLogin extends HiNetError {
  NeedLogin({String message = "您尚未登录", int code = 401}) : super(code, message);
}
