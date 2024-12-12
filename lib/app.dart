import 'package:arcane/arcane.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:foundry_launcher/screens/home.dart';

class FoundryApp extends StatelessWidget {
  const FoundryApp({super.key});

  @override
  Widget build(BuildContext context) => ArcaneApp(
        localizationsDelegates: const [
          AppLocalizations.delegate,
          GlobalMaterialLocalizations.delegate,
          GlobalWidgetsLocalizations.delegate,
          GlobalCupertinoLocalizations.delegate,
        ],
        supportedLocales: const [
          Locale('en'), // Add other supported locales as needed
        ],
        title: 'Foundry',
        home: HOME(),
        theme: ArcaneTheme(
            scheme: ContrastedColorScheme.fromScheme(ColorSchemes.green),
            themeMode: ThemeMode.dark),
      );
}
