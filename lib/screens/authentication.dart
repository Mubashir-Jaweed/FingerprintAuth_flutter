import 'package:fingerprintscanner/screens/home.dart';
import 'package:flutter/material.dart';
import 'package:local_auth/local_auth.dart';

class AuthenticationPage extends StatefulWidget {
  const AuthenticationPage({super.key});

  @override
  State<AuthenticationPage> createState() => _AuthenticationPageState();
}

class _AuthenticationPageState extends State<AuthenticationPage> {
  final LocalAuthentication auth = LocalAuthentication();

  checkAuthentication() async {
    bool isAvailable;
    isAvailable = await auth.canCheckBiometrics;
    print(isAvailable);

    if (isAvailable) {
      bool result = await auth.authenticate(
        localizedReason: 'Scan your finger to proceed',
      );

      if (result) {
        Navigator.push(
            context, MaterialPageRoute(builder: (context) => HomePage()));
      } else {
        print('Permission Denied!');
      }
    } else {
      print('Biometrics not Available');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blue[800],
      body: Center(
        child: ElevatedButton.icon(
          onPressed: () {
            checkAuthentication();
          },
          icon: Icon(Icons.fingerprint),
          label: Text('Scan Your Finger'),
        ),
      ),
    );
  }
}
