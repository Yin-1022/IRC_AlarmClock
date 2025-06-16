import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'button_bar.dart';
import '../view/set_alarm_page.dart';
import '../view/alarm_clock_page.dart';
import '../view/friend_page.dart';

class DefaultClockPage extends StatefulWidget
{
  const DefaultClockPage({super.key});

  @override
  State<DefaultClockPage> createState() => _DefaultClockPageState();
}

class _DefaultClockPageState extends State<DefaultClockPage> {
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
                setState(() {});
                index == 0 ?
                showAlarmEditDialog(context) :
                print("a");
              },
              icon: const Icon(Icons.add, color: Colors.white, size: 30,)
            )
        ],
      ),
      body: index==0 ? const AlarmClockPage() : const FriendPage(),
      bottomNavigationBar: const HomeButtonBar(),
    );
  }
}


