import 'package:dio/dio.dart';

String handleNetworkError(DioException dioError) {
  String errorMessage = "";
  final dioErrorType = dioError.type;
  switch (dioErrorType) {
    case DioExceptionType.connectionError:
      errorMessage = 'Bağlantı Hatası. Tekrar Deneyin.';
      break;

    case DioExceptionType.connectionTimeout:
      errorMessage = 'Bağlantı Zaman Aşımına Uğradı. Tekrar Deneyin.';
      break;

    case DioExceptionType.receiveTimeout:
      errorMessage = 'Bağlantı Zaman Aşımına Uğradı. Tekrar Deneyin.';
      break;

    case DioExceptionType.cancel:
      errorMessage = 'Bağlantı Koptu. Tekrar Deneyin.';
      break;

    case DioExceptionType.badResponse:
      errorMessage =
          'Bağlantı Hatası. Hata Kodu: ${dioError.response?.statusCode.toString()}';
      if (dioError.response?.statusCode == 403) {
        errorMessage =
            'Oturum Süreniz Doldu. Lütfen Uygulamaya Tekrar Giriş Yapın.';
      }
      break;

    default:
      errorMessage = 'Belirlenemeyen Hata. Tekrar Deneyin.';
      break;
  }

  return errorMessage;
}
