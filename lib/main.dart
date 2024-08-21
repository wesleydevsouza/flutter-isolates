import 'package:flutter/material.dart';
import 'commons/routes.dart';
import 'constants/styling.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const Isolates());
}

class Isolates extends StatelessWidget {
  const Isolates({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Isolates Chart',
      theme: AppTheme.mikuTheme,
      initialRoute: '/intro',
      onGenerateRoute: RouteGenerator.generateRoute,
    );
  }
}
