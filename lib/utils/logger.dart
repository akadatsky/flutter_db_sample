// ignore_for_file: avoid_print
import 'package:test_db/utils/config.dart';
import 'package:test_db/utils/pair.dart';

class Log {
  static final Log _instance = Log._internal();

  factory Log() {
    return _instance;
  }

  final errors = <Pair<dynamic, dynamic>>[];

  Log._internal();

  void d({
    String? tag,
    dynamic message,
  }) {
    if (AppConfig.flavor() == Flavor.debug) {
      print(
        '$tag: $message',
      );
    }
  }

  void dFunc({
    String? tag,
    required Future<dynamic> Function() message,
  }) async {
    try {
      if (AppConfig.flavor() == Flavor.debug) {
        print(
          '$tag: ${await message()}',
        );
      }
    } catch (_) {}
  }

  void any({
    String? tag,
    dynamic message,
  }) {
    print('$tag: $message');
  }

  void error({
    String? tag,
    dynamic error,
  }) {
    errors.add(Pair(
      tag,
      error,
    ));
    d(
      tag: tag,
      message: '$error',
    );
    if (error is Error) {
      d(
        tag: tag,
        message: '${error.stackTrace}',
      );
    }
  }
}
