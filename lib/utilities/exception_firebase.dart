class ExceptionFirebase {
  static String getErrorFirebase(e) {
    String errorMessage = 'Đã xảy ra lỗi. Vui lòng thử lại.';

    if (e.code == 'invalid-credential') {
      errorMessage =
          'Thông tin đăng nhập không đúng hoặc đã hết hạn. Vui lòng kiểm tra và thử lại.';
    } else if (e.code == 'user-not-found') {
      errorMessage = 'Tài khoản không tồn tại.';
    } else if (e.code == 'wrong-password') {
      errorMessage = 'Mật khẩu không đúng.';
    } else if (e.code == 'too-many-requests') {
      errorMessage = 'Quá nhiều lần thử. Vui lòng chờ 1 phút.';
    } else if (e.code == 'expired-action-code') {
      errorMessage = 'Mã xác thực đã hết hạn. Vui lòng yêu cầu mã mới.';
    }
    return errorMessage;
  }
}
