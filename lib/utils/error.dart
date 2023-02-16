import 'dart:async';

import 'statics.dart';

FutureOr<Null> catchError(dynamic error) async {
  logger.e(error.toString(), error);
}
