import 'package:arcane/arcane.dart';
import 'package:foundry_launcher/app.dart';
import 'package:window_manager/window_manager.dart';

void main() => _init().then((_) => runApp(const FoundryApp()));

Future<void> _init() async {
  WidgetsFlutterBinding.ensureInitialized();
  await windowManager.ensureInitialized();

  WindowOptions windowOptions = WindowOptions(
    size: Size(920, 620),
    title: "Foundry",
    center: true,
    backgroundColor: Colors.transparent,
    skipTaskbar: false,
    titleBarStyle: TitleBarStyle.hidden,
    minimumSize: Size(800, 620),
  );
  windowManager.waitUntilReadyToShow(windowOptions, () async {
    await windowManager.show();
    await windowManager.focus();
  });
}
