import 'package:flutter/material.dart';
import 'package:my_webapp/Screens/components/appbar.dart';
import 'package:my_webapp/Screens/tumurun.dart';
import 'package:my_webapp/http.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  void getData() async {
    await Api().getMarka();
    await Api().getEkran();
    await Api().getDisk();
    await Api().getRam();
    await Api().getSistem();

    await Api().fetchData();
  }

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    getData();
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        // This is the theme of your application.
        //
        // Try running your application with "flutter run". You'll see the
        // application has a blue toolbar. Then, without quitting the app, try
        // changing the primarySwatch below to Colors.green and then invoke
        // "hot reload" (press "r" in the console where you ran "flutter run",
        // or simply save your changes to "hot reload" in a Flutter IDE).
        // Notice that the counter didn't reset back to zero; the application
        // is not restarted.
        primarySwatch: Colors.blue,
      ),
      home: TumUrun(
          appbar: CustomAppBar(), field: "none", search: "none", value: "none"),
    );
  }
}
