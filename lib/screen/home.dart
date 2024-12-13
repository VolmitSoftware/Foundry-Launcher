import 'package:arcane/arcane.dart';
import 'package:arcane/generated/arcane_shadcn/shadcn_flutter_extension.dart';
import 'package:foundry_launcher/screen/root/tab_one.dart';
import 'package:serviced/serviced.dart';

class FoundaryRoot extends StatefulWidget {
  const FoundaryRoot({super.key});

  static void go(BuildContext context) => Navigator.pushAndRemoveUntil(
      context,
      MaterialPageRoute(builder: (context) => const FoundaryRoot()),
          (route) => false);

  @override
  State<FoundaryRoot> createState() => _FoundaryRootState();
}

class _FoundaryRootState extends State<FoundaryRoot> {
  int index = 0;
  double kMobileBreakpoint = 1000;

  final List<NavTab> navigationTabs = [
    NavTab(
      label: "Something",
      icon: Icons.cube,
      selectedIcon: Icons.cube_fill,
      builder: (context) => const OutlinedContainer(
        borderRadius: BorderRadius.zero, child: TabOne()),
    ),
  ];



  NavigationType _getNavigationType(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    if (screenWidth < kMobileBreakpoint) {
      return NavigationType.sidebar; // this is the "mobile" version
    } else {
      return NavigationType.sidebar;
    }
  }

  @override
  Widget build(BuildContext context)  => NavigationScreen(
      type: _getNavigationType(context),
      endSide: false,
      index: index,
      onIndexChanged: (index) => setState(() => this.index = index),
      tabs: navigationTabs,
      header: PaddingAll(
          padding: 8,
          child: Column(
            children: [
              ConstrainedBox(
                  constraints: const BoxConstraints(maxHeight: 100),
                  child: Icon(Icons.cube, size: 64)), // lol
              Text("Foundry", style: context.theme.typography.h2),
              Text("Foundry is a thing",
                  style: context.theme.typography.small),
            ],
          )),
      sidebarConstraints:
      const BoxConstraints(minWidth: 100, maxWidth: 200));

}
