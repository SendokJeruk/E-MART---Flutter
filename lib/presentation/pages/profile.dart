import 'package:flutter/material.dart';
import 'package:e_mart_11bdg/presentation/widgets/bottom_bar.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  int _currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(55),
        child: AppBar(
          backgroundColor: const Color(0xFFBF3131),
          foregroundColor: Colors.white,
          title: Text(
            "Profile",
            style: TextStyle(
              fontFamily: 'Righteous',
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Center(
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              children: [
                Container(
                  padding: EdgeInsets.all(4),
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    border: Border.all(
                      color: const Color(0xFFBF3131),
                      width: 5,
                    ),
                  ),
                  child: ClipOval(
                    child: Image.network(
                      'https://i1.sndcdn.com/artworks-XYlsRlqpoBS8IYWp-hjyv7A-t500x500.jpg',
                      width: 110,
                      height: 110,
                      fit: BoxFit.cover,
                      loadingBuilder: (
                        BuildContext context,
                        Widget child,
                        ImageChunkEvent? loadingProgress,
                      ) {
                        if (loadingProgress == null) {
                          return child;
                        } else {
                          return Center(
                            child: CircularProgressIndicator(
                              value:
                                  loadingProgress.expectedTotalBytes != null
                                      ? loadingProgress.cumulativeBytesLoaded /
                                          (loadingProgress.expectedTotalBytes ??
                                              1)
                                      : null,
                            ),
                          );
                        }
                      },
                      errorBuilder: (
                        BuildContext context,
                        Object error,
                        StackTrace? stackTrace,
                      ) {
                        return Container(
                          height: 110,
                          width: 110,
                          color: Colors.grey.shade300,
                          child: Center(
                            child: Icon(
                              Icons.broken_image,
                              color: Colors.grey,
                              size: 40,
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                ),
                const SizedBox(height: 5),
                Text(
                  'HaanPict',
                  style: TextStyle(
                    fontSize: 25,
                    fontWeight: FontWeight.bold,
                    fontFamily: 'Righteous',
                    color: Color(0xFFBF3131),
                  ),
                ),
                Text(
                  'irhannhantu@gmail.com',
                  style: TextStyle(
                    fontFamily: 'Righteous',
                    fontSize: 14,
                    color: Colors.grey[700],
                  ),
                ),

                Container(
                  width: screenWidth * 0.9,
                  padding: EdgeInsets.all(20),
                  margin: EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(12),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black12,
                        blurRadius: 4,
                        offset: Offset(0, 2),
                      ),
                    ],
                  ),

                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      //Text(''),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 3),

                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            const Text(
                              'NAMA :',
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: Colors.black,
                              ),
                            ),
                            Text('IrhannTuu HannPict'),
                            Icon(
                              Icons.keyboard_arrow_right,
                              color: const Color(0xFFBF3131),
                            ),
                          ],
                        ),
                      ),
                      const Divider(),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 3),

                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            const Text(
                              'ASAL  :',
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: Colors.black,
                              ),
                            ),
                            Text('SMKN 11 BANDUNG'),
                            Icon(
                              Icons.keyboard_arrow_right,
                              color: const Color(0xFFBF3131),
                            ),
                          ],
                        ),
                      ),
                      const Divider(),
                      Padding(
                        padding: const EdgeInsets.only(top: 10),
                        child: GestureDetector(
                          onTap: () {
                            print('History Tapped');
                          },
                          child: Padding(
                            padding: EdgeInsets.all(10),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                const Text(
                                  'RIWAYAT PEMBAYARAN',
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    color: Colors.black,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 1),
                Container(
                  width: screenWidth * 1,
                  padding: EdgeInsets.all(1),
                  margin: EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    color: Color(0xFFBF3131),
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),

                //BUTTON UNTUK LOGOUT DAN SWITCH ACCOUNT
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    //Logout
                    Container(
                      width: screenWidth * 0.3,
                      padding: const EdgeInsets.all(10),
                      margin: const EdgeInsets.all(10),
                      decoration: BoxDecoration(
                        color: Color(0xFFBF3131),
                        borderRadius: BorderRadius.circular(12),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black12,
                            blurRadius: 4,
                            offset: Offset(0, 2),
                          ),
                        ],
                      ),
                      child: GestureDetector(
                        onTap: () {
                          print('Logout Tapped');
                        },
                        child: Center(
                          // Ganti jadi Center biar langsung tengah
                          child: Text(
                            'LOG OUT',
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                              fontFamily: 'Righteous',
                              fontSize: 10,
                            ),
                          ),
                        ),
                      ),
                    ),

                    SizedBox(
                      child: Text(
                        '|',
                        style: TextStyle(
                          fontSize: 20,
                          color: Color(0xFFBF3131),
                        ),
                      ),
                    ),
                    // Switch Account
                    Container(
                      width: screenWidth * 0.3,
                      padding: const EdgeInsets.all(10),
                      margin: const EdgeInsets.all(10),
                      decoration: BoxDecoration(
                        color: Color(0xFFBF3131),
                        borderRadius: BorderRadius.circular(12),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black12,
                            blurRadius: 4,
                            offset: Offset(0, 2),
                          ),
                        ],
                      ),
                      child: GestureDetector(
                        onTap: () {
                          print('Switch Account Tapped');
                        },
                        child: Center(
                          child: Text(
                            'SWITCH ACCOUNT',
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                              fontFamily: 'Righteous',
                              fontSize: 10,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
      bottomNavigationBar: BottomBar(currentIndex: 4),
    );
  }
}
