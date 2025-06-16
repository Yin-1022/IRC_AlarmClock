import 'package:flutter/material.dart';
import 'view/default_home_page.dart';
import 'package:provider/provider.dart';
import 'view/button_bar.dart';

void main()
{
  runApp(
    ChangeNotifierProvider(
      create: (_) => NavigationProvider(),
      child: const App(),
    ),
  );
}

class App extends StatelessWidget
{
  const App({super.key});

  @override
  Widget build(BuildContext context)
  {
    return const MaterialApp
    (
      home:DefaultClockPage(),
    );
  }
}
