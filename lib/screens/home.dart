import 'package:arcane/arcane.dart';
import 'package:foundry_launcher/util/imports.dart';

class HOME extends StatelessWidget {
  const HOME({super.key});

  @override
  Widget build(BuildContext context) {
    AppLocalizations localizations = AppLocalizations.of(context)!;
    return SliverScreen(
        gutter: false,
        header: Bar(titleText: "BAR"),
        sliver: MultiSliver(
          children: [
            SliverPadding(
              padding: EdgeInsets.symmetric(horizontal: 8),
              sliver: SGridView.builder(
                childCount: 16,
                crossAxisSpacing: 8,
                crossAxisCount: 2,
                childAspectRatio: 1,
                mainAxisSpacing: 8,
                builder: (context, index) => Card(
                  child: Center(
                    child: Basic(
                      title: Text("Item s1 $index"),
                      subtitle: Text("Subtitle or something"),
                    ),
                  ),
                ),
              ),
            ),
            BarSection(
                titleText: "Grid Section",
                subtitleText: "Subtitle or something",
                trailing: [
                  IconButton(
                    icon: Icon(Icons.add_circle_ionic),
                    onPressed: () {},
                  )
                ],
                sliver: SliverPadding(
                  padding: EdgeInsets.symmetric(horizontal: 8),
                  sliver: SGridView.builder(
                    childCount: 24,
                    crossAxisSpacing: 8,
                    childAspectRatio: 2,
                    mainAxisSpacing: 8,
                    builder: (context, index) => Card(
                      child: Center(
                        child: Basic(
                          title: Text("Item $index"),
                          subtitle: Text("Subtitle or something"),
                        ),
                      ),
                    ),
                  ),
                ))
          ],
        )
    );
  }
}
