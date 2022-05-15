// ignore_for_file: prefer_const_constructors, prefer_null_aware_operators, unnecessary_null_comparison, unused_element

import 'dart:collection';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/constant.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:flutter_polyline_points/flutter_polyline_points.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key}) : super(key: key);

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  GoogleMapController? controller;
  // ignore: prefer_collection_literals
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        floatingActionButton: FloatingActionButton(
          child: Icon(Icons.map_outlined, color: Colors.black),
          backgroundColor: Color(0xFFFAFAFA),
          onPressed: () {
            if (controller != null) {
              controller!
                  .animateCamera(CameraUpdate.newCameraPosition(intialpos));
            }
          },
        ),
        appBar: AppBar(
          actions: [
            TextButton(
                onPressed: () {
                  if (source != null) {
                    controller!.animateCamera(CameraUpdate.newCameraPosition(
                        CameraPosition(
                            target: source!.position, zoom: 18, tilt: 30)));
                  }
                },
                child: Text('source')),
            TextButton(
                onPressed: () {
                  if (destination != null) {
                    controller!.animateCamera(CameraUpdate.newCameraPosition(
                        CameraPosition(
                            target: destination!.position,
                            zoom: 18,
                            tilt: 30)));
                  }
                },
                child: Text(
                  'destination',
                  style: TextStyle(color: Colors.green),
                )),
          ],
          backgroundColor: Color(0xFFFAFAFA),
          elevation: 0,
          title: Text(
            'Google Maps',
            style: TextStyle(color: Colors.black),
          ),
        ),
        body:
            // ignore: prefer_const_literals_to_create_immutables
            Stack(
          // ignore: prefer_const_literals_to_create_immutables
          children: [
            GoogleMap(
              zoomControlsEnabled: false,
              myLocationButtonEnabled: false,
              initialCameraPosition: intialpos,
              onMapCreated: (GoogleMapController map) => controller = map,
              polylines: polyLine.toSet(),
              markers: {
                if (source != null) source!,
                if (destination != null) destination!
              },
              circles: {
                if (circle1 != null) circle1!,
                if (circle2 != null) circle2!
              },
              onLongPress: addmarks,
            ),
            Align(
              alignment: Alignment.bottomCenter,
              child: Text(
                'Alex is my life',
                style: TextStyle(fontSize: 25),
              ),
            )
          ],
        ));
  }

  @override
  void dispose() {
    controller != null ? controller!.dispose() : null;
    super.dispose();
  }

  void addmarks(LatLng latLng) {
    if (source == null || (source != null && destination != null)) {
      setState(() {
        source = Marker(
            markerId: const MarkerId('source'),
            position: latLng,
            // ignore: prefer_const_constructors
            infoWindow: InfoWindow(
              title: 'source',
            ));
        circle1 = Circle(
            circleId: CircleId('1'),
            center: latLng,
            radius: 500,
            fillColor: Colors.blue.shade100.withOpacity(0.5),
            strokeColor: Colors.white.withOpacity(0));
        destination = null;
        circle2 = null;
        polyLine.clear();
      });
    } else {
      setState(() {
        destination = Marker(
            markerId: const MarkerId('des'),
            position: latLng,
            icon: BitmapDescriptor.defaultMarkerWithHue(
                BitmapDescriptor.hueYellow),
            // ignore: prefer_const_constructors
            infoWindow: InfoWindow(
              title: 'destination',
            ));
        circle2 = Circle(
            circleId: CircleId('2'),
            center: latLng,
            radius: 500,
            fillColor: Colors.blue.shade100.withOpacity(0.5),
            strokeColor: Colors.white.withOpacity(0));
        polyLine.add(Polyline(
          polylineId: PolylineId("route1"),
          color: Colors.blue.withOpacity(0.7),
          patterns: [PatternItem.dash(20.0), PatternItem.gap(10)],
          width: 3,
          // ignore: prefer_const_literals_to_create_immutables
          points: [
            source!.position,
            destination!.position,
          ],
        ));
      });
    }
  }
}
