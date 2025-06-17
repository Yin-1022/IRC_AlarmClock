import 'package:flutter/material.dart';
import 'package:hive_flutter/adapters.dart';
import 'components/default_view.dart';
import 'components/button_bar.dart';
import 'package:provider/provider.dart';
  import 'data/clock_database.dart';

void main() async
{
  WidgetsFlutterBinding.ensureInitialized();

  await Hive.initFlutter();
  await Hive.openBox('dataBox');

  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_)
        {
          final provider = AlarmClockProvider();
          provider.loadInitialData(); // 這裡載入資料
          return provider;
        }),
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
