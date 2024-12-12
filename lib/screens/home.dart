import 'package:arcane/arcane.dart';
import 'package:foundry_launcher/util/imports.dart';

class HOME extends StatelessWidget {
  const HOME({super.key});

  @override
  Widget build(BuildContext context) {
    AppLocalizations localizations = AppLocalizations.of(context)!;
    return FillScreen(
        header: Platform.isMacOS ? FoundryAppBarMac() : FoundryAppBarWindows(),
        child: Center(
          child: Text(localizations.appTitle),
        ));
  }
}
