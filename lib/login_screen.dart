import 'package:flutter/material.dart';
import 'db/database_helper.dart';  // Import the DatabaseHelper
import 'dashboard_screen.dart';    // Import the DashboardScreen

class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final DatabaseHelper _dbHelper = DatabaseHelper();  // Use the DatabaseHelper

  String _message = '';

  // Login function to check the credentials in the database
  void _login() async {
    String username = _usernameController.text;
    String password = _passwordController.text;

    if (username.isEmpty || password.isEmpty) {
      setState(() {
        _message = 'Please fill in all fields';
      });
      return;
    }

    // Check if the user exists in the database
    var user = await _dbHelper.getUser(username, password);

    if (user != null) {
      // If login is successful, navigate to the dashboard and pass the user ID
      int userId = user['id'];  // Get the user ID from the user record
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) => DashboardScreen(userId: userId), // Pass userId
        ),
      );
    } else {
      setState(() {
        _message = 'Invalid username or password';
      });
    }
  }

  // Insert a sample user for testing (you can remove this after testing)
  @override
  void initState() {
    super.initState();
    _dbHelper.insertUser({
      'username': 'testuser',
      'password': '123456',
    });

    // Insert a second user for testing
    _dbHelper.insertUser({
      'username': 'testuser2',
      'password': '123456',
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Login'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: _usernameController,
              decoration: InputDecoration(labelText: 'Username'),
            ),
            TextField(
              controller: _passwordController,
              decoration: InputDecoration(labelText: 'Password'),
              obscureText: true,  // Hide password input
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: _login,  // Trigger login function
              child: Text('Login'),
            ),
            SizedBox(height: 20),
            Text(
              _message,  // Show validation or login status
              style: TextStyle(color: Colors.red),
            ),
          ],
        ),
      ),
    );
  }
}
