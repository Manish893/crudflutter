import 'package:bdelete/api/networkStatus.dart';
import 'package:bdelete/provider/signupProvider.dart';
import 'package:bdelete/view/signup.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  void initState() {
    getvalue();
    super.initState();
  }

  getvalue() async {
    Future.delayed(Duration.zero, () async {
      var provider = Provider.of<SignUpProvider>(context, listen: false);
      await provider.getValueFromFirebase();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Home"),
        centerTitle: true,
        backgroundColor: Colors.green[200],
      ),
      body: Consumer<SignUpProvider>(
        builder: (context, signupProvider, list) => signupProvider
                    .setGetUserStatus ==
                NetworkStatus.loading
            ? CircularProgressIndicator()
            : Column(
                children: [
                  Expanded(
                    child: ListView.builder(
                      itemCount: signupProvider.userList.length,
                      itemBuilder: (BuildContext context, int index) {
                        return Padding(
                          padding: const EdgeInsets.all(8),
                          child: Container(
                            height: 50,
                            margin: EdgeInsets.only(left: 10, right: 10),
                            decoration: BoxDecoration(
                                color: Colors.grey[200],
                                borderRadius: BorderRadius.circular(10)),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Text(
                                        "Name :${signupProvider.userList[index].fullName}"),
                                    Text(
                                        "Address : ${signupProvider.userList[index].address}"),
                                  ],
                                ),
                                IconButton(
                                    onPressed: () {
                                      Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              builder: (context) => Signup(signupModel: signupProvider.userList[index],)));
                                    },
                                    icon: Icon(Icons.edit)),
                                    
                                IconButton(
                                  onPressed: () {
                                    showErrorBox(
                                        context, signupProvider, index);
                                  },
                                  icon: Icon(
                                    Icons.delete,
                                    color: Colors.red[700],
                                  ),
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
    );
  }

  showErrorBox(context, SignUpProvider signUpProvider, index) {
    showDialog(
        context: context,
        builder: (BuildContext context) => AlertDialog(
              title: Text("Error"),
              content: Text("Did you want to continue"),
              actions: [
                TextButton(
                    onPressed: () async {
                      await signUpProvider.deleteValueFromTable(
                          signUpProvider.userList[index].id!);
                      Navigator.of(context).pop();
                      if (signUpProvider.getSetDeleteStatus ==
                          NetworkStatus.success) {
                        Navigator.pushAndRemoveUntil(
                            context,
                            MaterialPageRoute(builder: (context) => Home()),
                            (route) => false);
                      }
                    },
                    child: Text("yes")),
                TextButton(
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                    child: Text("no"))
              ],
            ));
  }
}
