String formatToE164(String phone, {String? countryCode}) {
  phone = phone.trim().replaceAll(RegExp(r'[^\d]'), '');

  if (phone.startsWith('+')) {
    return phone;
  }

  if (phone.startsWith('0')) {
    if (countryCode == 'VN' || phone.length == 10) {
      return '+84${phone.substring(1)}';
    }
  }

  throw ArgumentError('Số điện thoại không hợp lệ. Phải bắt đầu bằng 0 hoặc +');
}
