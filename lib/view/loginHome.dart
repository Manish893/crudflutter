import 'package:bdelete/api/networkStatus.dart';
import 'package:bdelete/core/helper.dart';
import 'package:bdelete/provider/loginProvider.dart';
import 'package:bdelete/view/login.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class LoginHome extends StatefulWidget {
  const LoginHome({super.key});

  @override
  State<LoginHome> createState() => _LoginHomeState();
}

class _LoginHomeState extends State<LoginHome> {
  @override
  void initState() {
    getValue();
    super.initState();
  }

  getValue() async {
    Future.delayed(Duration.zero, () async {
      var provider = Provider.of<LoginProvider>(context, listen: false);
      await provider.getValueFromFirebase();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Consumer<LoginProvider>(
        builder: (context, loginProvider, list) => SafeArea(
          child: Column(
            children: [
              Text("Login Home"),
              loginProvider.getDataStatus == NetworkStatus.loading
                  ? CircularProgressIndicator()
                  : Expanded(
                      child: ListView.builder(
                        itemCount: loginProvider.userData.length,
                        itemBuilder: (BuildContext context, int index) {
                          return Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Container(
                              height: 50,
                              margin: EdgeInsets.only(left: 10, right: 10),
                              decoration: BoxDecoration(
                                  color: Colors.grey[200],
                                  borderRadius: BorderRadius.circular(10)),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                            "Name:${loginProvider.userData[index].name}"),
                                        Text(
                                            "Password:${loginProvider.userData[index].password}"),
                                      ],
                                    ),
                                  ),
                                  Row(
                                    children: [
                                      IconButton(
                                          onPressed: () {
                                            showEditBox(loginProvider, index);
                                          },
                                          icon: Icon(
                                            Icons.edit,
                                            color: Colors.green[200],
                                          )),
                                      IconButton(
                                        onPressed: () {
                                          loginProvider.getsetDeleteStatus ==
                                                  NetworkStatus.loading
                                              ? CircularProgressIndicator()
                                              : showErrorBox(
                                                  loginProvider, index);
                                        },
                                        icon: Icon(
                                          Icons.delete,
                                          color: Colors.red[700],
                                        ),
                                      )
                                    ],
                                  )
                                ],
                              ),
                            ),
                          );
                        },
                      ),
                    ),
            ],
          ),
        ),
      ),
    );
  }

  showErrorBox(LoginProvider loginProvider, index) {
    showDialog(
        context: context,
        builder: (BuildContext context) => AlertDialog(
              title: Text("Error Box"),
              content: Text("Did you want to continue"),
              actions: [
                TextButton(
                    onPressed: () async {
                      await loginProvider.deleteValueFromFireBase(
                          loginProvider.userData[index].id!);
                      if (loginProvider.getsetDeleteStatus ==
                          NetworkStatus.success) {
                        Navigator.pushAndRemoveUntil(
                            context,
                            MaterialPageRoute(
                                builder: (context) => LoginHome()),
                            (route) => false);
                      }
                    },
                    child: Text("Yes")),
                TextButton(
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                    child: Text("No")),
              ],
            ));
  }

  showEditBox(LoginProvider loginProvider, index) {
    final loginModel = loginProvider.userData[index];
    showDialog(
        context: context,
        builder: (BuildContext context) => AlertDialog(
              title: Text("Error Box"),
              content: Text("Did you want to continue"),
              actions: [
                TextButton(
                    onPressed: () async {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => Login(
                                    loginModel: loginModel,
                                  )));
                    },
                    child: Text("Yes")),
                TextButton(
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                    child: Text("No")),
              ],
            ));
  }
}
