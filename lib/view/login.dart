import 'package:bdelete/api/networkStatus.dart';
import 'package:bdelete/core/helper.dart';
import 'package:bdelete/model/loginModel.dart';
import 'package:bdelete/provider/loginProvider.dart';
import 'package:bdelete/view/loginHome.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';


class Login extends StatefulWidget {
  LoginModel? loginModel;
  Login({super.key, this.loginModel});

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  final _formKey = GlobalKey<FormState>();
  initState() {
    if (widget.loginModel != null) {
      var provider = Provider.of<LoginProvider>(context, listen: false);
      provider.setId(widget.loginModel!.id ?? "");
      provider.setName(widget.loginModel!.name ?? "");
      provider.setAddress(widget.loginModel!.email ?? "");
      provider.setContact(widget.loginModel!.contact ?? "");
      provider.setPasswrod(widget.loginModel!.password ?? "");
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Consumer<LoginProvider>(
          builder: (context, loginProvider, list) => Form(
            key: _formKey,
            child: SingleChildScrollView(
              child: Column(
                children: [
                  loginProvider.getStatus == NetworkStatus.loading
                      ? Helper.backDropFilter(context)
                      : Text("Manish shrestha"),
                  Text("id${loginProvider.id}"),
                  Padding(
                    padding:
                        const EdgeInsets.only(left: 10, right: 10, top: 10),
                    child: TextFormField(
                      initialValue: loginProvider.name,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return "Enter your Name";
                        }
                        return null;
                      },
                      onChanged: (value) {
                        loginProvider.setName(value);
                      },
                      decoration: InputDecoration(
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10)),
                        labelText: "Name",
                        prefixIcon: Icon(Icons.person),
                      ),
                    ),
                  ),
                  Padding(
                    padding:
                        const EdgeInsets.only(left: 10, right: 10, top: 10),
                    child: TextFormField(
                      initialValue: loginProvider.address,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return "Enter Your Email";
                        }
                        return null;
                      },
                      onChanged: (value) {
                        loginProvider.setAddress(value);
                      },
                      decoration: InputDecoration(
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10)),
                        labelText: "Email",
                        prefixIcon: Icon(Icons.email),
                      ),
                    ),
                  ),
                  Padding(
                    padding:
                        const EdgeInsets.only(left: 10, right: 10, top: 10),
                    child: TextFormField(
                      initialValue: loginProvider.contact,
                      keyboardType: TextInputType.phone,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return "Enter your Name";
                        }
                        return null;
                      },
                      onChanged: (value) {
                        loginProvider.setContact(value);
                      },
                      decoration: InputDecoration(
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10)),
                        labelText: "Contact",
                        prefixIcon: Icon(Icons.person),
                      ),
                    ),
                  ),
                  Padding(
                    padding:
                        const EdgeInsets.only(left: 10, right: 10, top: 10),
                    child: TextFormField(
                      initialValue: loginProvider.password,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return "Enter your password";
                        }
                        return null;
                      },
                      onChanged: (value) {
                        loginProvider.setPasswrod(value);
                      },
                      decoration: InputDecoration(
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10)),
                        labelText: "Password",
                        prefixIcon: Icon(Icons.lock),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: SizedBox(
                      width: MediaQuery.of(context).size.width * 0.5,
                      height: 50,
                      child: ElevatedButton(
                        onPressed: () async {
                          if (_formKey.currentState!.validate()) {
                            if (widget.loginModel?.id != null) {
                              await loginProvider.updatelogin();
                              if (loginProvider.getUpdateStudentStatus ==
                                  NetworkStatus.success) {
                                Navigator.pushAndRemoveUntil(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => LoginHome(),
                                    ),
                                    (route) => false);
                                Helper.displaySnakBar(
                                    context, "Successfully edit");
                              } else if (loginProvider.getUpdateStudentStatus ==
                                  NetworkStatus.error) {
                                Helper.displaySnakBar(context, "wrong");
                              }
                            } else {
                              await loginProvider.postLoginValueToDataBase();

                              if (loginProvider.getStatus ==
                                  NetworkStatus.success) {
                                Helper.displaySnakBar(
                                    context, "successfully login");
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => LoginHome()));
                              } else {
                                Helper.displaySnakBar(context,
                                    loginProvider.errorMessage.toString());
                              }
                            }
                          }
                        },
                        child: Text(
                          "Submit",
                          style: TextStyle(
                              fontSize: 25, fontWeight: FontWeight.bold),
                        ),
                        style: ElevatedButton.styleFrom(
                            onPrimary: Colors.grey[200],
                            primary: Colors.green[200]),
                      ),
                    ),
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
