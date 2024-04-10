import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:firebase_screen/firebase_options.dart';
import 'package:flutter/material.dart';

void main()async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
      options: DefaultFirebaseOptions.currentPlatform
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  FirebaseMessaging messaging = FirebaseMessaging.instance;
  FirebaseFirestore firestore = FirebaseFirestore.instance;


  initialize() async{
    await messaging.requestPermission(
      alert: true,
      announcement: false,
      badge: true,
      carPlay: false,
      criticalAlert: false,
      provisional: false,
      sound: true,
    );
    String? token = await messaging.getToken();
    print("token");
    print(token);
  }

   @override
  void initState() {
    // TODO: implement initState
     initialize();
    super.initState();
  }
  int _counter = 0;

  void _incrementCounter() {
    setState(() async{
         await firestore.collection('User').add({
            'name':'saru',
           'id':'saru123',
           'mail':'saru@gmail.com'
          });
         await firestore.collection('User').get().then((value) {
           print(value.docs.length);
         });
         // to print the first id we use index, how we use for lstvbldr

         // we use get to get the value from firebs database
         await firestore.collection('User').get().then((value){
           print(value.docs[0].id);
         });
         // to print saru's mail id 
         // to print the particular id we use where
         await firestore.collection('User').where('name',isEqualTo: 'saru').get().then((value){
           print(value.docs[0]['mail']);
         });
         
      _counter++;
    });
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(

      ),
      body: Center(

        child: Column(

          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            const Text(
              'You have pushed the button this many times:',
            ),
            Text(
              '$_counter',
              style: Theme.of(context).textTheme.headlineMedium,
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _incrementCounter,
        tooltip: 'Increment',
        child: const Icon(Icons.add),
      ),
    );
  }
}
