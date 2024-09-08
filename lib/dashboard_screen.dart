import 'package:flutter/material.dart';
import 'adding_screen.dart';  // Import the AddingScreen

class DashboardScreen extends StatefulWidget {
  final int userId;  // Pass the userId to the dashboard from login

  DashboardScreen({required this.userId});

  @override
  _DashboardScreenState createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Miền Nam',
          style: TextStyle(
            color: Colors.red,
            fontSize: 24,
            fontWeight: FontWeight.bold,
          ),
        ),
        backgroundColor: Colors.white,
        centerTitle: true,
        leading: Builder(
          builder: (BuildContext context) {
            return IconButton(
              icon: Icon(Icons.menu, color: Colors.red), // Left side menu button
              onPressed: () {
                Scaffold.of(context).openDrawer(); // Open the drawer
              },
            );
          },
        ),
        actions: [
          IconButton(
            icon: Icon(Icons.person_add, color: Colors.red), // Right side add customer button
            onPressed: () {
              // Navigate to the AddingScreen when the add button is pressed
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => AddingScreen(userId: widget.userId),
                ),
              );
            },
          ),
        ],
      ),
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: <Widget>[
            DrawerHeader(
              decoration: BoxDecoration(
                color: Colors.red,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Image.asset('assets/logo.png', height: 60, width: 60), // Replace with your logo
                  SizedBox(height: 10),
                  Text(
                    'SSV123',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: 10),
                  Text(
                    'Hạn sử dụng: 2024-09-13\nTài khoản: ip45 (v5.5.8)',
                    style: TextStyle(
                      color: Colors.white,
                    ),
                  ),
                ],
              ),
            ),
            _createDrawerItem(icon: Icons.chat, text: 'Tin nhắn nội bộ'),
            _createDrawerItem(icon: Icons.people, text: 'Yêu cầu kết bạn'),
            _createDrawerItem(icon: Icons.attach_money, text: 'Xử lý Miền Nam'),
            _createDrawerItem(icon: Icons.attach_money, text: 'Xử lý Miền Trung'),
            _createDrawerItem(icon: Icons.attach_money, text: 'Xử lý Miền Bắc'),
            _createDrawerItem(icon: Icons.list_alt, text: 'Kết quả xổ số'),
            _createDrawerItem(icon: Icons.analytics, text: 'Tổng kết ngày'),
            _createDrawerItem(icon: Icons.settings, text: 'Cài đặt'),
            _createDrawerItem(icon: Icons.notifications, text: 'Thông báo'),
            _createDrawerItem(icon: Icons.logout, text: 'Thoát'),
          ],
        ),
      ),
      body: Center(
        child: Text(
          'No customers added yet',
          style: TextStyle(fontSize: 18),
        ),
      ),
    );
  }

  // Function to create each drawer item
  Widget _createDrawerItem({required IconData icon, required String text}) {
    return ListTile(
      leading: Icon(icon, color: Colors.red),
      title: Text(text, style: TextStyle(fontSize: 16)),
      onTap: () {
        // Handle item tap if needed
        Navigator.of(context).pop(); // Close the drawer
      },
    );
  }
}
