import 'package:bdelete/api/networkStatus.dart';
import 'package:bdelete/core/helper.dart';
import 'package:bdelete/model/signupModel.dart';
import 'package:bdelete/provider/signupProvider.dart';
import 'package:bdelete/view/home.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class Signup extends StatefulWidget {
  SignupModel? signupModel;
  Signup({super.key, this.signupModel});

  @override
  State<Signup> createState() => _SignupState();
}

class _SignupState extends State<Signup> {
  final formkey = GlobalKey<FormState>();
  @override
  void initState() {
    var provider = Provider.of<SignUpProvider>(context, listen: false);
    if (widget.signupModel != null) {
      provider.setFullName(widget.signupModel!.fullName);
      provider.setAddress(widget.signupModel!.address);
      provider.setContact(widget.signupModel!.contact);
      provider.setPassword(widget.signupModel!.password);
      provider.setId(widget.signupModel!.id!);
    }

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
          appBar: AppBar(
            title: Text("SignUp Form"),
            centerTitle: true,
            backgroundColor: Colors.green[200],
          ),
          body: SingleChildScrollView(
            child: Consumer<SignUpProvider>(
              builder: (context, signupProvider, list) => Stack(
                children: [
                  signupProvider.getSetNetworkStatus == NetworkStatus.loading
                      ? CircularProgressIndicator()
                      : signupUi(context, signupProvider),
                ],
              ),
            ),
          )),
    );
  }

  signupUi(context, SignUpProvider signUpProvider) {
    return SafeArea(
      child: Form(
          key: formkey,
          child: Column(
            children: [
              SizedBox(
                height: 20,
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextFormField(
                  initialValue: signUpProvider.fullName,
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return "Enter the full name";
                    }
                    return null;
                  },
                  onChanged: (value) {
                    signUpProvider.setFullName(value);
                  },
                  decoration: InputDecoration(
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10)),
                    prefixIcon: Icon(Icons.person),
                    labelText: "Full_Name",
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextFormField(
                  initialValue: signUpProvider.address,
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return "Enter the address";
                    }
                    return null;
                  },
                  onChanged: (value) {
                    signUpProvider.setAddress(value);
                  },
                  decoration: InputDecoration(
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10)),
                    prefixIcon: Icon(Icons.location_on),
                    labelText: "Address",
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextFormField(
                  initialValue: signUpProvider.contact.toString(),
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return "Enter the contact";
                    }
                    return null;
                  },
                  onChanged: (value) {
                    signUpProvider.setContact(value);
                  },
                  decoration: InputDecoration(
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10)),
                    prefixIcon: Icon(Icons.phone),
                    labelText: "Contact",
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextFormField(
                  initialValue: signUpProvider.password,
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return "Enter the password";
                    }
                    return null;
                  },
                  onChanged: (value) {
                    signUpProvider.setPassword(value);
                  },
                  decoration: InputDecoration(
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10)),
                    prefixIcon: Icon(Icons.password),
                    labelText: "Password",
                  ),
                ),
              ),
              SizedBox(
                width: MediaQuery.of(context).size.width * 0.6,
                height: 50,
                child: ElevatedButton(
                  onPressed: () async {
                    if (formkey.currentState!.validate()) {
                      await signUpProvider.postValueToFirebase();
                      if (signUpProvider.getSetNetworkStatus ==
                          NetworkStatus.success) {
                        Helper.displaySnakBar(context, "Successfully signup");
                        Navigator.push(context,
                            MaterialPageRoute(builder: (context) => Home()));
                      } else if (signUpProvider.getSetNetworkStatus ==
                          NetworkStatus.error) {
                        Helper.displaySnakBar(
                            context, signUpProvider.errorMessage.toString());
                      }
                    }
                  },
                  child: Text("Sumbit"),
                  style: ElevatedButton.styleFrom(
                      onPrimary: Colors.black, primary: Colors.green[100]),
                ),
              )
            ],
          )),
    );
  }
}
