import 'package:arcane/arcane.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class HOME extends StatelessWidget {
  const HOME({super.key});

  @override
  Widget build(BuildContext context) {
    final localizations = AppLocalizations.of(context)!;
    return FillScreen(
        child: Center(
      child: Text(localizations.appTitle),
    ));
  }
}
