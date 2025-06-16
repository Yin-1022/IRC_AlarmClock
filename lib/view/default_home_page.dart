import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'button_bar.dart';
import 'set_alarm_page.dart';

class DefaultClockPage extends StatelessWidget
{
  const DefaultClockPage({super.key});

  @override
  Widget build(BuildContext context)
  {
    final index = context.watch<NavigationProvider>().currentIndex;
    return Scaffold
    (
      appBar: AppBar
      (
        backgroundColor: const Color.fromARGB(255, 33, 35, 37),
        automaticallyImplyLeading: false,
        leading: IconButton(onPressed: (){}, icon: const Icon(Icons.settings, color: Colors.white,)),
        centerTitle: true,
        title: const Text("Unsleep Me",style: TextStyle(color: Colors.white)),
        actions:
        [
          IconButton
            (
              onPressed: ()
              {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const SetAlarmPage()),
                );
              },
              icon: const Icon(Icons.add, color: Colors.white, size: 30,)
            )
        ],
      ),
      backgroundColor: index==0 ? Color.fromARGB(255, 210, 210, 210) : Color.fromARGB(255, 0, 210, 210),
      bottomNavigationBar: const HomeButtonBar(),
    );
  }
}
