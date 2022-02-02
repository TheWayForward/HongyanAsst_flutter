import 'package:hongyanasst/provider/theme_provider.dart';
import 'package:provider/provider.dart';
import 'package:provider/single_child_widget.dart';

// apply theme to application

List<SingleChildWidget> topProviders = [
  ChangeNotifierProvider(create: (_) => ThemeProvider())
];
