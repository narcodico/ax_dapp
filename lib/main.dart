import 'package:ax_dapp/pages/LandingPage.dart';
import 'package:ax_dapp/service/AthleteData.dart';
import 'package:get_storage/get_storage.dart';
import 'package:flutter/material.dart';

void main() async {
    // Setup Storage of the data I download
    await GetStorage.init();

  // Immediately start querying the database for latest stats + prices
  
  // Run the app
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {

    // Returns anything!
    return MaterialApp(
      title: "AthleteX",
      debugShowCheckedModeBanner: false,
      initialRoute: "/",
      theme: ThemeData(
          brightness: Brightness.dark,
          primaryColor: Colors.yellow[700],
          colorScheme: ColorScheme.fromSwatch(brightness: Brightness.dark)
              .copyWith(secondary: Colors.black)),
      home: LandingPage(),
      // home: V1App(),
      // home: HomePage()
    );
  }
}
