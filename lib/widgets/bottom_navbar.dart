import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
void main() {
  runApp(MaterialApp(home: BottomNavBar(selectedIndex: 0, onItemSelected: (int index) {  },)));
}

class BottomNavBar extends StatefulWidget {
  final int selectedIndex;
  final void Function(int index) onItemSelected;

  const BottomNavBar({Key? key, required this.selectedIndex, required this.onItemSelected})
      : super(key: key);

  @override
  State<BottomNavBar> createState() => _BottomNavBarState();
}

class _BottomNavBarState extends State<BottomNavBar> {
  late int _selectedIndex;

  @override
  void initState() {
    super.initState();
    _selectedIndex = widget.selectedIndex;
  }

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
    widget.onItemSelected(index);
  }

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      backgroundColor: Colors.white,
      items: <BottomNavigationBarItem>[
        BottomNavigationBarItem(
          icon: SvgPicture.asset('lib/images/home_true.svg', color: Colors.grey,),
          activeIcon: SvgPicture.asset('lib/images/home_true.svg'),
          label: 'Home',
        ),
        BottomNavigationBarItem(
          icon: SvgPicture.asset('lib/images/fontisto_mic_v1.svg', ),
          activeIcon: SvgPicture.asset('lib/images/fontisto_mic.svg'),
          label: 'Interview',
        ),
        BottomNavigationBarItem(
          icon: SvgPicture.asset('lib/images/cv_logo.svg', color: Colors.grey,),
          activeIcon: SvgPicture.asset('lib/images/cv_logo.svg'),
          label: 'Cover Letter',
        ),
        BottomNavigationBarItem(
          icon: SvgPicture.asset('lib/images/mdi_account.svg', color: Colors.grey,),
          activeIcon: SvgPicture.asset('lib/images/mdi_account.svg'),
          label: 'Account',
        ),
      ],
      currentIndex: _selectedIndex,
      selectedItemColor: const Color(0xFFFF6C37),
      unselectedItemColor: Colors.grey,
      onTap: _onItemTapped,
    );
  }
}
