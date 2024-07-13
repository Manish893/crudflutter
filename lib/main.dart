import 'package:bdelete/firebase_options.dart';
import 'package:bdelete/provider/checkLoginProvider.dart';
import 'package:bdelete/provider/loginProvider.dart';
import 'package:bdelete/provider/signupProvider.dart';
import 'package:bdelete/provider/taskProvider.dart';
import 'package:bdelete/view/checkLogin.dart';
import 'package:bdelete/view/login.dart';
import 'package:bdelete/view/loginHome.dart';
import 'package:bdelete/view/signup.dart';
import 'package:bdelete/view/task.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  FirebaseMessaging messaging = FirebaseMessaging.instance;
  @override
  void initState() {
    notificationSetting();
    listenForegroundMessage();
    getFCMToken();

    super.initState();
  }

  notificationSetting() async {
    NotificationSettings settings = await messaging.requestPermission(
      alert: true,
      announcement: false,
      badge: true,
      carPlay: false,
      criticalAlert: false,
      provisional: false,
      sound: true,
    );
  }

  ///yo token use garyo vanya chaii xito naii message aauxa

  getFCMToken() async {
    String? token = await messaging.getToken();

    print("FCM token:$token");
  }

//yesle chaii message dini vayo
  listenForegroundMessage() {
    FirebaseMessaging.onMessage.listen((RemoteMessage message) {
      print('Message data: ${message.data}');
    });
  }

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider<SignUpProvider>(create: (_) => SignUpProvider()),
        ChangeNotifierProvider<LoginProvider>(create: (_) => LoginProvider()),
        ChangeNotifierProvider<CheckLoginProvider>(
            create: (_) => CheckLoginProvider()),
        ChangeNotifierProvider<TaskProvider>(create: (_) => TaskProvider()),
      ],
      child: MaterialApp(
        title: 'Flutter Demo',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
          useMaterial3: true,
        ),
        home: Login(),
      ),
    );
  }
}
