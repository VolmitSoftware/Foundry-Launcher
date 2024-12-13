import 'package:arcane/arcane.dart';

class FoundryTechnicalFooter extends StatefulWidget {
  const FoundryTechnicalFooter({super.key});

  @override
  State<FoundryTechnicalFooter> createState() => _FoundryTechnicalFooterState();
}

class _FoundryTechnicalFooterState extends State<FoundryTechnicalFooter> {
  @override
  Widget build(BuildContext context) {
    return ConstrainedBox(
      constraints: BoxConstraints(minHeight: 36, maxHeight: 36),
      child: OutlinedContainer(
        padding: EdgeInsets.all(0),
        // borderColor: Colors.black.withOpacity(0.9),
        borderRadius: BorderRadius.circular(0),
        child: Row(
          children: [
            Gap(8),
            // Text(
            //   "Foundry v 1.0.0",
            //   style: context.theme.typography.textMuted,
            // ),
            Breadcrumb(
              separator: Breadcrumb.arrowSeparator,
              children: [
                TextButton(
                  onPressed: () {},
                  density: ButtonDensity.compact,
                  child: const Text('Workspace'),
                ),
                // const MoreDots(),
                // TextButton(
                //   onPressed: () {},
                //   density: ButtonDensity.compact,
                //   child: const Text('Components'),
                // ),
                // const Text('Breadcrumb'),
              ],
            ),
            Spacer(),
            SizedBox(
              child: Row(
                children: [
                  Tooltip(
                      child: Icon(
                        FontAwesomeIcons.docker,
                        color: Color(0xFF00FF54),
                      ),
                      tooltip: Text(" Docker Engine Running ")),
                  Gap(16),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
