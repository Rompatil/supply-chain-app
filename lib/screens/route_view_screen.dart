import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart';
import 'dart:async';

class RouteViewScreen extends StatefulWidget {
  const RouteViewScreen({super.key});

  @override
  _RouteViewScreenState createState() => _RouteViewScreenState();
}

class _RouteViewScreenState extends State<RouteViewScreen> {
  GoogleMapController? _mapController;
  final Location _location = Location();
  LatLng _initialPosition = LatLng(37.7749, -122.4194); // fallback (San Francisco)
  final Set<Marker> _markers = {};
  final Set<Polyline> _polylines = {};

  final List<LatLng> _routeCoordinates = [
    LatLng(37.7749, -122.4194),
    LatLng(37.7796, -122.4177),
    LatLng(37.7683, -122.4148),
    LatLng(37.7597, -122.4103),
  ];

  @override
  void initState() {
    super.initState();
    _setupLiveLocation();
    _setDeliveryMarkers();
    _drawRoutePolyline();
  }

  Future<void> _setupLiveLocation() async {
    final locationData = await _location.getLocation();
    setState(() {
      _initialPosition = LatLng(locationData.latitude!, locationData.longitude!);
    });
    _location.onLocationChanged.listen((newLoc) {
      _mapController?.animateCamera(
        CameraUpdate.newLatLng(
          LatLng(newLoc.latitude!, newLoc.longitude!),
        ),
      );
    });
  }

  void _setDeliveryMarkers() {
    for (int i = 1; i < _routeCoordinates.length; i++) {
      _markers.add(
        Marker(
          markerId: MarkerId('delivery_$i'),
          position: _routeCoordinates[i],
          infoWindow: InfoWindow(title: 'Delivery $i'),
          icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueBlue),
        ),
      );
    }
  }

  void _drawRoutePolyline() {
    _polylines.add(
      Polyline(
        polylineId: PolylineId("route_path"),
        visible: true,
        points: _routeCoordinates,
        color: Colors.blue,
        width: 5,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Optimized Route View')),
      body: GoogleMap(
        initialCameraPosition: CameraPosition(
          target: _initialPosition,
          zoom: 13,
        ),
        markers: _markers,
        polylines: _polylines,
        myLocationEnabled: true,
        onMapCreated: (controller) {
          _mapController = controller;
        },
      ),
    );
  }
}
