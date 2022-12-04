import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:reading_tracker/services/library_repository.dart';
import 'package:reading_tracker/services/settings_controller.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../constants.dart';


class SettingsView extends StatelessWidget {
  const SettingsView();

  //SharedPreferences prefs;

  //Future<void> _getPrefs() async{
  //  prefs = await SharedPreferences.getInstance();
  //}

  @override
  Widget build(BuildContext context) {

    //final prefs = SharedPreferences.getInstance();


    return Scaffold(
      appBar: AppBar(
        title: 
          const Text("Settings")                
      ),

      body: Column(
        children: [
          SizedBox(height: 20),
          const Center( child:
            const Text(
            "Settings",
            style: TextStyle(fontSize: 30, color: Colors.white, fontWeight: FontWeight.bold),
            textAlign: TextAlign.center,
            )
          ),
          SizedBox(height: 20),
          Row(
            
            children: [
            SizedBox(width: 20),
            Text("Light Mode",style: TextStyle(fontSize: 20, color: Colors.white, fontWeight: FontWeight.bold),),
          FutureBuilder( 
            future: SharedPreferences.getInstance(), //prefs.getBool('lightMode'),
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                return Switch(
                  value: 
                    snapshot.data?.getBool('lightMode') ?? false,
                  
                  onChanged: (value) async{
                    await snapshot.data?.setBool('lightMode', value);
                    await SettingsController.UpdateColorScheme();

                     Navigator.pop(context);  // pop current page
                     Navigator.pushNamed(context, settingsRoute);
                    // push it back in  
                  }
                );
              }
            return CircularProgressIndicator(); // or some other widget
          },
            
            
          )],),
          
          SizedBox(height: 40),
          ElevatedButton(
            style: TextButton.styleFrom(
              textStyle: const TextStyle(fontSize: 20),
            ),
            onPressed: () async {
            await Clipboard.setData(ClipboardData(text: await LibraryRepository().getJson()));
              // copied successfully
            },
            child: const Padding (
              padding: EdgeInsets.all(5),
              child: Text('Copy all data as JSON'),
            )),
            SizedBox(height: 140),
            Container(
            margin: const EdgeInsets.only(left: 20.0, right: 20.0),
            child: 
            Center(child: Text("Created by Matthew Glazar, Aidan Walsh, and Dominique Mittermeier",style: TextStyle(fontSize:15, color: Colors.white, fontWeight: FontWeight.bold),),
      ))],
      )
    );
  }
}