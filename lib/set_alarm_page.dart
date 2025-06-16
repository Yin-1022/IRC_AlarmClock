import 'package:flutter/material.dart';
import 'default_clock_page.dart';

class SetAlarmPage extends StatelessWidget
{
  const SetAlarmPage({super.key});

  @override
  Widget build(BuildContext context)
  {
    return Scaffold
    (
      appBar: AppBar
      (
        backgroundColor: const Color.fromARGB(255, 33, 35, 37),
        automaticallyImplyLeading: false,
        leading: IconButton(onPressed: ()
        {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => const DefaultClockPage()),
          );
        }, icon: const Icon(Icons.arrow_back, color: Colors.white,)),
      )
    );
  }
}
