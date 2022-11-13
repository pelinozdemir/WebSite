import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:my_webapp/Screens/adminWidget/Admin%C4%B0lkSayfa.dart';
import 'package:my_webapp/Screens/adminWidget/AdminPage.dart';
import 'package:my_webapp/Screens/components/appbar.dart';
import 'package:my_webapp/http.dart';

class AdminPanelWidget extends StatefulWidget {
  @override
  State<AdminPanelWidget> createState() => _AdminPanelWidgetState();
}

class _AdminPanelWidgetState extends State<AdminPanelWidget> {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    TextEditingController mail = TextEditingController();
    TextEditingController password = TextEditingController();
    void signIn() async {
      try {
        String giris = await Api().adminlogin(mail.text, password.text);
        if (giris == 'Login') {
          Navigator.pushAndRemoveUntil(
              context,
              MaterialPageRoute(builder: (context) => AdminFirstPage()),
              (route) => true);
          print(giris);
        } else {
          print(giris);
        }
      } catch (e) {
        print(e);
      }
    }

    return Center(
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(20.0),
          border: Border.all(color: Colors.transparent),
          boxShadow: [
            BoxShadow(
              offset: Offset(0, -2),
              blurRadius: 30,
              color: Colors.black.withOpacity(0.16),
            ),
          ],
        ),
        width: 500,
        height: 400,
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(
                height: 50,
              ),
              Center(
                child: Text(
                  "Admin",
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
              ),
              SizedBox(
                height: 50,
              ),
              Container(
                width: 300,
                child: TextField(
                  controller: mail,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(20))),
                    labelText: "Mail",
                  ),
                ),
              ),
              SizedBox(
                height: 25,
              ),
              Container(
                width: 300,
                child: TextField(
                  controller: password,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(20))),
                    labelText: "Şifre",
                  ),
                ),
              ),
              SizedBox(
                height: 35,
              ),
              ElevatedButton(
                onPressed: (() {
                  signIn();
                }),
                child: Text('GİRİŞ YAP', style: TextStyle(fontSize: 25)),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
