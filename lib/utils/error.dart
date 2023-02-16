import 'statics.dart';

Future<void> catchError(dynamic error) async {
  logger.e(error.toString(), error);
}
