
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class AuthenticationScreen extends StatelessWidget {
  final FirebaseAuth _auth = FirebaseAuth.instance;

   AuthenticationScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Firebase Auth Demo'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
              onPressed: () => _registerUser(context),
              child: const Text('Register'),
            ),
            ElevatedButton(
              onPressed: () => _loginUser(context),
              child: const Text('Login'),
            ),
            ElevatedButton(
              onPressed: () => _logoutUser(),
              child: const Text('Logout'),
            ),
            StreamBuilder<User?>(
              stream: _auth.authStateChanges(),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.active) {
                  final user = snapshot.data;
                  if (user == null) {
                    return Text('Not logged in');
                  } else {
                    return Text('Logged in as: ${user.email}');
                  }
                } else {
                  return CircularProgressIndicator();
                }
              },
            ),
          ],
        ),
      ),
    );
  }

  Future<void> _registerUser(BuildContext context) async {
    try {
       await _auth.createUserWithEmailAndPassword(
        email: 'test@example.com',
        password: 'test1234',
      
      );
      // You can also customize this to ask for user information like name, etc.
      // and save additional user data to a Firestore database or other storage.
    } catch (e) {
      print('Error registering user: $e');
    }
  }

  Future<void> _loginUser(BuildContext context) async {
    try {
      await _auth.signInWithEmailAndPassword(
        email: 'mash@gmail.com',
        password: '123456',
      );
    } catch (e) {
      print('Error logging in user: $e');
    }
  }

  Future<void> _logoutUser() async {
    await _auth.signOut();
  }
}
