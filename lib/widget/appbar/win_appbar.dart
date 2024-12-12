import 'package:arcane/arcane.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:window_manager/window_manager.dart';

class FoundryAppBarWindows extends StatefulWidget {
  const FoundryAppBarWindows({super.key});

  @override
  State<FoundryAppBarWindows> createState() => _FoundryAppBarWindowsState();
}

class _FoundryAppBarWindowsState extends State<FoundryAppBarWindows> {

  @override
  Widget build(BuildContext context) {
    AppLocalizations localizations = AppLocalizations.of(context)!;
    return GestureDetector(
      child: Bar(
        backgroundColor: Colors.black.withOpacity(0.2),
        title: Text(localizations.appTitle),
        trailing: [
          GhostButton(
            child: Icon(Icons.minus),
            // density: ButtonDensity.compact,
            onPressed: () async {
              await windowManager.minimize();
            },
          ),
          GhostButton(
            child: Icon(BootstrapIcons.fullscreen),
            // density: ButtonDensity.compact,
            onPressed: () async {
              await windowManager.maximize();
            },
          ),
          GhostButton(
            child: Icon(Icons.close_ionic),
            // density: ButtonDensity.compact,
            onPressed: () async {
              await windowManager.close();
            },
          )
        ],
      ),
      onPanStart: (_) => windowManager.startDragging(),
    );
  }
}
