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

  String formatString(String input) {
    String cleanedInput = input.replaceAll(',', '');
    return cleanedInput;
  }

  String convertDateTimeFormat(String inputDateTime) {
    final inputFormat = DateFormat("yyyy-MM-dd HH:mm:ss.SSS");
    final outputFormat = DateFormat("yyyy-MM-dd'T'HH:mm:ss.SSS");
    final dateTime = inputFormat.parse(inputDateTime);
    final formattedDateTime = outputFormat.format(dateTime);
    return formattedDateTime;
  }

  String convertDateTimeDisplay(String inputDateTime) {
    final inputFormat = DateFormat("yyyy-MM-dd'T'HH:mm:ss.SSS");
    final outputFormat = DateFormat("dd/MM/yyyy - HH:mm");
    final dateTime = inputFormat.parse(inputDateTime);
    final formattedDateTime = outputFormat.format(dateTime);
    return formattedDateTime;
  }

  String getCurrentDateTimeFormatted() {
    final DateFormat formatter = DateFormat("yyyy-MM-dd'T'HH:mm:ss.SSS");
    final String formattedDateTime = formatter.format(DateTime.now());
    return formattedDateTime;
  }
}
