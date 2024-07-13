import 'package:bdelete/api/apiResponse.dart';
import 'package:bdelete/api/networkStatus.dart';
import 'package:bdelete/core/helper.dart';
import 'package:bdelete/provider/taskProvider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class Task extends StatelessWidget {
  const Task({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Consumer<TaskProvider>(
          builder: (context, taskProvider, list) => SingleChildScrollView(
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: TextFormField(
                    onChanged: (value) {
                      taskProvider.setUserName(value);
                    },
                    decoration: InputDecoration(
                        label: Text("UserName"),
                        prefixIcon: Icon(Icons.person),
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10))),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: TextFormField(
                    onChanged: (value) {
                      taskProvider.setFirstName(value);
                    },
                    decoration: InputDecoration(
                        label: Text("FirstName"),
                        prefixIcon: Icon(Icons.person),
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10))),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: TextFormField(
                    onChanged: (value) {
                      taskProvider.setLastName(value);
                    },
                    decoration: InputDecoration(
                        label: Text("LastName"),
                        prefixIcon: Icon(Icons.person),
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10))),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: TextFormField(
                    onChanged: (value) {
                      taskProvider.setGender(value);
                    },
                    decoration: InputDecoration(
                        label: Text("Gender"),
                        prefixIcon: Icon(Icons.person),
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10))),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: TextFormField(
                    onChanged: (value) {
                      taskProvider.setEmail(value);
                    },
                    decoration: InputDecoration(
                        labelText: "Email",
                        prefixIcon: Icon(Icons.email),
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10))),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: TextFormField(
                    onChanged: (value) {
                      taskProvider.setPassword(value);
                    },
                    decoration: InputDecoration(
                        labelText: "Password",
                        prefixIcon: Icon(Icons.password),
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10))),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: TextFormField(
                    onChanged: (value) {
                      taskProvider.setProfilePic(value);
                    },
                    decoration: InputDecoration(
                        label: Text("ProfilePic"),
                        prefixIcon: Icon(Icons.person),
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10))),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: TextFormField(
                    onChanged: (value) {
                      taskProvider.setPanNo(value);
                    },
                    decoration: InputDecoration(
                        label: Text("panNo"),
                        prefixIcon: Icon(Icons.person),
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10))),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: TextFormField(
                    onChanged: (value) {
                      taskProvider.setRegistration(value);
                    },
                    decoration: InputDecoration(
                        label: Text("registration no"),
                        prefixIcon: Icon(Icons.person),
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10))),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: TextFormField(
                    onChanged: (value) {
                      taskProvider.setRole(value);
                    },
                    decoration: InputDecoration(
                        label: Text("Role"),
                        prefixIcon: Icon(Icons.person),
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10))),
                  ),
                ),
                SizedBox(
                  height: 50,
                  width: MediaQuery.of(context).size.width * 0.5,
                  child: ElevatedButton(
                    onPressed: () async {
                      await taskProvider.postValueToApi();
                      if (taskProvider.getsetPostApiStatus ==
                          NetworkStatus.success) {
                        Helper.displaySnakBar(context, "Successfully login");
                      } else if (taskProvider.getsetPostApiStatus ==
                          NetworkStatus.error) {
                        showEditBox(taskProvider, context);
                        Helper.displaySnakBar(
                            context, taskProvider.errorMessage.toString());
                      }
                    },
                    child: Text(
                      "Login",
                      style: TextStyle(fontSize: 25),
                    ),
                    style: ElevatedButton.styleFrom(
                        onPrimary: Colors.white, primary: Colors.green[200]),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  showEditBox(TaskProvider taskProvider, context) {
    showDialog(
        context: context,
        builder: (BuildContext context) => AlertDialog(
              title: Text("Error Box"),
              content: Text(taskProvider.errorMessage.toString()),
              actions: [
                TextButton(
                    onPressed: () {
                      Navigator.of(context).pop();
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
