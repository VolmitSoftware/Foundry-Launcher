import 'package:arcane/arcane.dart';
import 'package:foundry_launcher/util/imports.dart';

class FoundryHome extends StatelessWidget {
  const FoundryHome({super.key});

  @override
  Widget build(BuildContext context) {
    AppLocalizations localizations = AppLocalizations.of(context)!;
    return SliverScreen(
        gutter: false,
        header: Bar(
          title: Text("BAR"),
          barFooter: Text("BAR 2"),
        ),
        sliver: MultiSliver(
          children: [BasicLayout()],
        ));
  }
}
