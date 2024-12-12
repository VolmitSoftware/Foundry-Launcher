import 'package:arcane/arcane.dart';
import 'package:foundry_launcher/screen/root/home.dart';
import 'package:foundry_launcher/service/widgets_binding_service.dart';
import 'package:serviced/serviced.dart';

import '../util/imports.dart';

BehaviorSubject<ThemeMode> _themeModeStream =
    BehaviorSubject<ThemeMode>.seeded(ThemeMode.system);

class FoundryApplication extends StatefulWidget {
  const FoundryApplication({super.key});

  @override
  State<FoundryApplication> createState() => FoundryApplicationState();

  static void updateTheme(ThemeMode themeMode) {
    Arcane.app.setTheme(FoundryApplicationState.buildTheme(mode: themeMode));
    _themeModeStream.add(themeMode);
  }
}

class FoundryTheme extends ArcaneTheme {
  FoundryTheme(
      {super.scheme,
      super.radius = 0.5,
      super.themeMode,
      super.surfaceBlur = 18,
      super.surfaceOpacity = 0.66});
}

class FoundryApplicationState extends State<FoundryApplication> {
  @override
  void initState() {
    super.initState();
    svc<WidgetsBindingService>().dropSplash();
  }

  static ArcaneTheme buildTheme({
    required ThemeMode mode,
  }) {
    mode =
        ThemeMode.dark; //todo: change this to use the user's theme preference
    ArcaneTheme theme = FoundryTheme(themeMode: mode);

    return theme;
  }

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
        title: 'Foundry Launcher',
        home: FoundryHome(),
        theme: FoundryTheme(themeMode: ThemeMode.system),
      );
}

BehaviorSubject<int> _appUpdateStream = BehaviorSubject<int>.seeded(0);

void updateApp() => _appUpdateStream.add(_appUpdateStream.value + 1);

//If you ever want different behavior for different screen sizes, you can use the following extension:
//Hopefully when dan updates bar we can do this. technically it has a Phone mode / tablet mode but
//that's just based on screen size
extension XContextNType on BuildContext {
  NavigationType get navigationType => MediaQuery.of(this).size.width > 600
      ? NavigationType.navigationRail
      : NavigationType.bottomNavigationBar;
}
