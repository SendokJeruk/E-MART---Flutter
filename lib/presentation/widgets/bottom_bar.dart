import 'package:e_mart_11bdg/presentation/pages/notifikasi.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:e_mart_11bdg/presentation/pages/home.dart';
import 'package:e_mart_11bdg/presentation/pages/profile.dart';
// import 'package:e_mart_11bdg/presentation/pages/notifikasi.dart';
import 'package:e_mart_11bdg/presentation/pages/trending.dart';
import 'package:e_mart_11bdg/presentation/pages/service.dart';

class BottomBar extends StatelessWidget {
  final int currentIndex;

  const BottomBar({super.key, required this.currentIndex});

  void _handleTap(BuildContext context, int index) {
    if (index == currentIndex) return;

    switch (index) {
      case 0:
        Navigator.pushReplacement(
          context,
          PageRouteBuilder(
            pageBuilder: (context, animation, secondaryAnimation) => const NotifPage(),
            transitionDuration: Duration(seconds: 0)
          ),
        );
        break;
      case 1:
         Navigator.pushReplacement(
          context,
          PageRouteBuilder(
            pageBuilder: (context, animation, secondaryAnimation) => const TrendingPage(),
            transitionDuration: Duration(seconds: 0)
          ),
        );
      case 2:
        Navigator.pushReplacement(
          context,
          PageRouteBuilder(
            pageBuilder: (context, animation, secondaryAnimation) => const HomePage(),
            transitionDuration: Duration(seconds: 0)
          ),
        );
        break;
      case 3:
         Navigator.pushReplacement(
          context,
          PageRouteBuilder(
            pageBuilder: (context, animation, secondaryAnimation) =>  ServicePage(),
            transitionDuration: Duration(seconds: 0)
          ),
         );
        break;
      case 4:
        Navigator.pushReplacement(
          context,
          PageRouteBuilder(
            pageBuilder: (context, animation, secondaryAnimation) => const ProfilePage(),
            transitionDuration: Duration(seconds: 0)
          )
        );
        break;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        border: Border(
          top: BorderSide(
            color: Color(0xFFBF3131), // warna merah
            width: 3.0, // ketebalan garis
          ),
        ),
      ),
      child: BottomNavigationBar(
        currentIndex: currentIndex,
        onTap: (index) => _handleTap(context, index),
        backgroundColor: Colors.white,
        selectedItemColor: const Color(0xFFBF3131),
        unselectedItemColor: Colors.grey,
        type: BottomNavigationBarType.fixed,
        selectedLabelStyle: const TextStyle(
          fontFamily: 'Righteous',
          fontSize: 12,
          fontWeight: FontWeight.bold,
        ),
        items: const [
          BottomNavigationBarItem(
            icon: Padding(padding: 
            EdgeInsets.only(top: 10),
            child: Icon(FontAwesomeIcons.solidBell),
            ),
            label: 'Notifikasi',
          ),
          BottomNavigationBarItem(
            icon: Padding(padding: 
            EdgeInsets.only(top: 10),
            child: Icon(FontAwesomeIcons.fire),
            ),
            label: 'Trending',
          ),
          BottomNavigationBarItem(
            icon: Padding(padding:
            EdgeInsets.only(top: 10),
            child: Icon(FontAwesomeIcons.house)
            ),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Padding(padding:
            EdgeInsets.only(top: 10),
            child: Icon(FontAwesomeIcons.solidComment),
            ),
            label: 'Service',
          ),
          BottomNavigationBarItem(
            icon: Padding(padding:
            EdgeInsets.only(top: 10),
            child: Icon(FontAwesomeIcons.solidUser),
            ),
            label: 'Profile',
          ),
        ],
      ),
    );
  }
}
