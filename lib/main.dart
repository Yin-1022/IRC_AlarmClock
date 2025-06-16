import 'package:flutter/material.dart';
import 'components/default_view.dart';
import 'components/button_bar.dart';
import 'package:provider/provider.dart';
import 'view/set_alarm_page.dart';


void main()
{
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => AlarmClockProvider()),
        ChangeNotifierProvider(create: (_) => NavigationProvider()),
      ],
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
