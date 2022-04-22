import 'dart:math';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:label_marker/label_marker.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Label Marker example',
      home: MyHomePage(title: 'Label Marker Example'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);
  final String title;
  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  Set<Marker> markers = {};
  GoogleMapController? controller;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: GoogleMap(
        initialCameraPosition: const CameraPosition(
          target: LatLng(0, 0),
          zoom: 1,
        ),
        markers: markers,
        onMapCreated: ((mapController) {
          setState(() {
            controller = mapController;
          });
        }),
      ),
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.add),
        onPressed: (() {
          final lat = (Random().nextDouble() * 180) - 90;
          final lng = (Random().nextDouble() * 360) - 180;
          final title = "title${Random().nextInt(1000)}";
          markers
              .addLabelMarker(LabelMarker(
            label: title,
            markerId: MarkerId(title),
            position: LatLng(lat, lng),
            backgroundColor: Colors.green,
          ))
              .then(
            (value) {
              setState(() {});
            },
          );
        }),
      ),
    );
  }
}
