import 'package:material_ui/material_ui.dart';

void main() {
  runApp(const DonutsApp());
}

/// Placeholder root widget until the router and theme land.
class DonutsApp extends StatelessWidget {
  const new({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      title: "J'Donuts",
      home: Scaffold(body: Center(child: Text("J'Donuts"))),
    );
  }
}
