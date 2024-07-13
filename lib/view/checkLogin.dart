import 'package:bdelete/api/networkStatus.dart';
import 'package:bdelete/core/helper.dart';
import 'package:bdelete/provider/checkLoginProvider.dart';
import 'package:bdelete/view/loginHome.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class CheckLogin extends StatelessWidget {
  const CheckLogin({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Consumer<CheckLoginProvider>(
          builder: (context, checkloginProvider, list) => Column(
            children: [
              Text(
                "Check Login",
                style: TextStyle(
                    color: Colors.green[200],
                    fontSize: 30,
                    fontWeight: FontWeight.w800),
              ),
              checkloginProvider.getSetLoginStatus == NetworkStatus.loading
                  ? CircularProgressIndicator()
                  : Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: TextFormField(
                        onChanged: (value) {
                          checkloginProvider.setContact(value);
                        },
                        keyboardType: TextInputType.phone,
                        decoration: InputDecoration(
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10)),
                          labelText: "Contact",
                          prefix: Icon(Icons.phone),
                        ),
                      ),
                    ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextFormField(
                  onChanged: (value) {
                    checkloginProvider.setPassword(value);
                  },
                  decoration: InputDecoration(
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10)),
                      labelText: "Password",
                      prefixIcon: Icon(Icons.lock)),
                ),
              ),
              SizedBox(
                height: 50,
                width: MediaQuery.of(context).size.width * 0.5,
                child: ElevatedButton(
                  onPressed: () async {
                    await checkloginProvider.checkLogin();
                    if (checkloginProvider.getSetLoginStatus ==
                        NetworkStatus.success) {
                      Helper.displaySnakBar(context, "Successfully login");
                      Navigator.push(context,
                          MaterialPageRoute(builder: (context) => LoginHome()));
                    } else if (checkloginProvider.getSetLoginStatus ==
                        NetworkStatus.error) {
                      Helper.displaySnakBar(
                          context, checkloginProvider.errorMessage.toString());
                    }
                  },
                  child: Text("Login"),
                  style: ElevatedButton.styleFrom(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20),
                        // side: BorderSide(color: Colors.black, width: 2)
                      ),
                      onPrimary: Colors.white,
                      primary: Colors.green,
                      elevation: 10),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
