import 'package:arcane/arcane.dart';
import 'package:fast_log/fast_log.dart';

class TabOne extends StatefulWidget {
  const TabOne({super.key});

  @override
  State<TabOne> createState() => _TabOneState();
}

class _TabOneState extends State<TabOne> {
  @override
  void initState() {
    super.initState();
    info("Initialized");
  }


  @override
  Widget build(BuildContext context) => SliverScreen(

    sliver:SliverFillRemaining(
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.cube, size: 512),
          ],
        ),
      ),
    )
  );
}
