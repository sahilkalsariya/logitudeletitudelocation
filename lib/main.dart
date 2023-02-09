import 'package:geolocation/geolocation.dart';
import "package:flutter/material.dart";
import 'package:permission_handler/permission_handler.dart';

void main() {
  runApp(MaterialApp(
    debugShowCheckedModeBanner: false,
    home: myApp(),
  ));
}

class myApp extends StatefulWidget {
  const myApp({Key? key}) : super(key: key);

  @override
  State<myApp> createState() => _myAppState();
}

class _myAppState extends State<myApp> {
  @override
  Widget build(BuildContext context) {

    // LONGITUDE , LETITUDE MALE... BY DDEFULTS CITY JE JOTU HOE YE MALE..
    return Scaffold(
        appBar: AppBar(
          title: Text("GPS Location"),
          centerTitle: true,
          actions: [
            IconButton(
                onPressed: () async {
                  await openAppSettings();
                },
                icon: Icon(Icons.settings)),
          ],
        ),
        body: Container(
          child: Column(
            children: [
              ElevatedButton(
                  onPressed: () async {
                    PermissionStatus status =
                        await Permission.location.request();

                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text("$status"),
                        backgroundColor: Colors.green,
                        behavior: SnackBarBehavior.floating,
                      ),
                    );

                    if (status == PermissionStatus.granted) {
                      print("Grants...");
                    } else {
                      print("Denied...");
                    }
                  },
                  child: Text("Request Permission")),
              ElevatedButton(
                onPressed: () {
                  Geolocation.currentLocation(accuracy: LocationAccuracy.city)
                      .listen((position) {
                    print(position.location.latitude);
                    print(position.location.longitude);
                  });
                },
                child: Text("Get Location"),
              ),
            ],
          ),
        ));
  }
}
