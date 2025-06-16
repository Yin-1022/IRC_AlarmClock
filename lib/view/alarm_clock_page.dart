import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../view/set_alarm_page.dart';

class AlarmClockPage extends StatefulWidget {
  const AlarmClockPage({super.key});

  @override
  State<AlarmClockPage> createState() => _AlarmClockPageState();
}

class _AlarmClockPageState extends State<AlarmClockPage>
{
  @override
  Widget build(BuildContext context) {
    final alarmProvider = context.watch<AlarmClockProvider>();
    final clockData = alarmProvider.clockData;

    return Scaffold
    (
      backgroundColor: const Color.fromARGB(255, 210, 210, 210),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column
        (
            children:
            [
              Expanded
                (
                  child: ListView.builder
                  (
                    itemCount : clockData.length,
                    itemBuilder: (context, index)
                    {
                      final task = clockData[index];
                      String month = '';
                      String day = '';
                      if(task["Day"].toString().length>1)
                      {
                        month = task["Day"].substring(0, 2);
                        day = task["Day"].substring(2, 4);
                      }
                      return Column(
                        children: [
                          ListTile
                          (
                            leading: task["Day"].toString().length == 1 ?
                              Text(task["Day"] , style: const TextStyle(fontSize: 30),):
                              Column
                              (
                                mainAxisAlignment: MainAxisAlignment.center,
                                children:
                                [
                                  Text(month , style: const TextStyle(fontSize: 25,height: 1),) ,
                                  Text(day , style: const TextStyle(fontSize: 25, height: 1),)
                                ],
                              ),
                            horizontalTitleGap: 30.0,
                            title: Text(task["Time"], style: const TextStyle(fontSize: 30)),
                            subtitle: Text(task["subtitle"], style: const TextStyle(fontSize: 20)),
                            trailing: Switch
                              (
                                value: task["isON"],
                                activeColor: Colors.green,
                                onChanged: (bool value) {
                                  setState(() {
                                    task["isON"] = value;
                                    alarmProvider.toggleSwitch(index, value);
                                  });
                                },
                              ),
                          ),
                          const Divider(height:10 ,thickness: 1.4,color: Colors.black,)
                        ],
                      );
                    }
                  )
              ),
            ],
        ),
      )
    );
  }
}