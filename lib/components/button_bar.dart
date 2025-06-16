import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class NavigationProvider extends ChangeNotifier {
  int _currentIndex = 0;

  int get currentIndex => _currentIndex;

  void setIndex(int index) {
    _currentIndex = index;
    notifyListeners(); // 通知 UI 更新
  }
}

class HomeButtonBar extends StatefulWidget
{
  const HomeButtonBar({super.key});

  @override
  State<HomeButtonBar> createState() => _HomeButtonBarState();
}

int _selectedBottom = 0;

class _HomeButtonBarState extends State<HomeButtonBar> {
  @override
  Widget build(BuildContext context)
  {
    final navProvider = Provider.of<NavigationProvider>(context);
    return Container
    (
      padding: const EdgeInsets.symmetric(horizontal: 50),
      height: 80,
      decoration: BoxDecoration
      (
          color: const Color(0xFF212325),
          boxShadow:
          [
            BoxShadow
            (
              color: Colors.black.withValues(alpha: 0.9),
              spreadRadius: 1,
              blurRadius: 8,
            )
          ]
      ),
      child: Row
      (
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children:
        [
          ButtonBelow
          (
            buttonIcon: Icons.alarm_on,
            buttonID: 0,
            onTap:()
            {
              setState(() {
                _selectedBottom = 0;
                navProvider.setIndex(_selectedBottom);
              });
            },
          ),
          ButtonBelow
            (
            buttonIcon: Icons.group,
            buttonID: 1,
            onTap:()
            {
              setState(() {
                _selectedBottom = 1;
                navProvider.setIndex(_selectedBottom);
              });
            },
          ),
        ],
      ),
    );
  }
}

class ButtonBelow extends StatelessWidget
{
  final VoidCallback onTap;
  final IconData buttonIcon;
  final int buttonID;

  const ButtonBelow({
    required this.onTap,
    required this.buttonIcon,
    required this.buttonID,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        color: const Color(0xFF212325),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon
            (
                size: 45,
                buttonIcon,
                color: _selectedBottom == buttonID ? Colors.blue : Colors.grey),
          ],
        ),
      ),
    );
  }
}
