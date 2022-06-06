import 'package:flutter/material.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      appBar: AppBar(
        
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: const Center(
          child: Padding(
            padding: EdgeInsets.only(top: 20),
            child: Text(
              'Settings',
              style: TextStyle(
                  fontFamily: 'colonnamt', fontSize: 35, color: Color.fromARGB(255, 255, 255, 255)),
            ),
          ),
        ),
        
      ),
      

    
     
    );
    
  }
}
