import 'dart:async';

import 'package:arcane/arcane.dart';
import 'package:fast_log/fast_log.dart';
import 'package:foundry_launcher/screen/foundry.dart';
import 'package:foundry_launcher/service/widgets_binding_service.dart';
import 'package:serviced/serviced.dart';
import 'package:window_manager/window_manager.dart';

void main() => runZonedGuarded(() async {
      PrecisionStopwatch t = PrecisionStopwatch.start();
      WidgetsFlutterBinding.ensureInitialized();
      await windowManager.ensureInitialized();

      WindowOptions windowOptions = WindowOptions(
        size: Size(920, 620),
        title: "Foundry",
        center: true,
        backgroundColor: Colors.transparent,
        skipTaskbar: false,
        titleBarStyle: TitleBarStyle.normal,
        minimumSize: Size(800, 620),
      );

      windowManager.waitUntilReadyToShow(windowOptions, () async {
        await windowManager.show();
        await windowManager.focus();
      });

      registerServices();
      await services().waitForStartup();
      runApp(const FoundryApplication());
      success("Startup completed in ${t.getMilliseconds().round()}ms");
    }, onError);

void onError(Object e, StackTrace s) {
  error(e);
  error(s);
}

void registerServices() {
  // Core Services here
  services().register<WidgetsBindingService>(() => WidgetsBindingService(),
      lazy: false);
}
