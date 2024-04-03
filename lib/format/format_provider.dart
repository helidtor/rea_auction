import 'package:intl/intl.dart';

class FormatProvider {
  String formatCurrency(String input) {
    final formatter = NumberFormat("#,###");
    final number = num.parse(input);
    return formatter.format(number);
  }

  String convertStatus(int? postStatus) {
    switch (postStatus) {
      case 1:
        return 'Đợi duyệt';
      case 2:
        return 'Từ chối';
      case 3:
        return 'Đã duyệt';
      case 4:
        return 'Hoàn tất';
      default:
        return '';
    }
  }

  String convertTypeProperty(int? idType) {
    switch (idType) {
      case 1:
        return 'Nhà';
      case 2:
        return 'Đất';
      default:
        return 'Không xác định';
    }
  }
}
