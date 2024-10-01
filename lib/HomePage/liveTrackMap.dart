import 'dart:async';
import 'dart:developer' as developer; // Alias the dart:developer import
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class LiveTracking extends StatefulWidget {
  const LiveTracking({super.key});

  @override
  State<LiveTracking> createState() => _LiveTrackingState();
}

class _LiveTrackingState extends State<LiveTracking> {
  late GoogleMapController _mapController;
  final Completer<GoogleMapController> _controller = Completer();
  late StreamSubscription<Position> _positionStream;
  LatLng _currentPosition = const LatLng(37.7749, -122.4194); // Initial position as a default
  LatLng _destinationPosition = const LatLng(37.7849, -122.4294); // Example destination
  Set<Polyline> _polylines = {};

  @override
  void initState() {
    super.initState();
    _getCurrentLocation();
  }

  Future<void> _getCurrentLocation() async {
    bool serviceEnabled;
    LocationPermission permission;

    // Test if location services are enabled.
    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      developer.log("Location services are disabled.");
      return;
    }

    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        developer.log("Location permissions are denied.");
        return;
      }
    }

    if (permission == LocationPermission.deniedForever) {
      developer.log("Location permissions are permanently denied, we cannot request permissions.");
      return;
    }

    _positionStream = Geolocator.getPositionStream(
      locationSettings: const LocationSettings(
        accuracy: LocationAccuracy.best,
        distanceFilter: 10,
      ),
    ).listen((Position position) {
      setState(() {
        _currentPosition = LatLng(position.latitude, position.longitude);
        _updatePolyline();
      });
      _mapController.animateCamera(CameraUpdate.newLatLng(_currentPosition));
      developer.log("Latitude: ${position.latitude}, Longitude: ${position.longitude}");
    });
  }

  void _updatePolyline() {
    List<LatLng> polylineCoordinates = _createZigzagPattern(_currentPosition, _destinationPosition);

    setState(() {
      _polylines = {
        Polyline(
          polylineId: const PolylineId('route'),
          points: polylineCoordinates,
          color: Colors.blue,
          width: 6,
        ),
      };
    });
  }

  List<LatLng> _createZigzagPattern(LatLng start, LatLng end) {
    List<LatLng> zigzagPoints = [];
    const int numberOfZigs = 10; // Number of zigs in the zigzag pattern
    double latDiff = (end.latitude - start.latitude) / numberOfZigs;
    double lngDiff = (end.longitude - start.longitude) / numberOfZigs;

    for (int i = 0; i <= numberOfZigs; i++) {
      double lat = start.latitude + (latDiff * i);
      double lng = start.longitude + (lngDiff * i);
      if (i % 2 == 0) {
        lat += latDiff / 2; // Adjust to create a zigzag pattern
      } else {
        lat -= latDiff / 2; // Adjust to create a zigzag pattern
      }
      zigzagPoints.add(LatLng(lat, lng));
    }

    return zigzagPoints;
  }

  @override
  void dispose() {
    _positionStream.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.indigo[100],
      appBar: AppBar(

        backgroundColor: Colors.transparent,
        title:  Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'JanBahon',
              style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold, fontStyle: FontStyle.italic),
            ),
            SizedBox(width: 10),
            Icon(Icons.map_outlined, color: Colors.indigo),
          ],
        ),
        centerTitle: true,
      ),
      body: GoogleMap(
        initialCameraPosition: CameraPosition(
          target: _currentPosition,
          zoom: 14.0,
        ),
        onMapCreated: (GoogleMapController controller) {
          _controller.complete(controller);
          _mapController = controller;
        },
        markers: {
          Marker(
            markerId: const MarkerId('bus'),
            position: _currentPosition,
            infoWindow: const InfoWindow(title: "Bus Location"),
          ),
          Marker(
            markerId: const MarkerId('destination'),
            position: _destinationPosition,
            infoWindow: const InfoWindow(title: "Destination"),
          ),
        },
        polylines: _polylines,
      ),
    );
  }
}
