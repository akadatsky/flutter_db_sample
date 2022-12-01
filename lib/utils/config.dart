
import 'package:logging/logging.dart';

class AppConfig {
  static Flavor _flavor = Flavor.debug;
  static bool _configured = false;

  static setup({
    Flavor flavor = Flavor.debug,
  }) {
    if (_configured) {
      throw StateError("AppConfig has alredy been configured");
    }
    _configured = true;

    _flavor = flavor;
    _configureLogger();
  }

  static Flavor flavor() => _flavor;

  static _configureLogger() {
    Logger.root.onRecord
        .listen((log) => _flavor == Flavor.debug ? print(log) : null);
  }
}

enum Flavor {
  release,
  debug,
}
