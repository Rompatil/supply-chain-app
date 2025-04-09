import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart';

class RoutesPage extends StatefulWidget {
  const RoutesPage({super.key});

  @override
  _RoutesPageState createState() => _RoutesPageState();
}

class _RoutesPageState extends State<RoutesPage> {
  GoogleMapController? mapController;
  LocationData? currentLocation;
  Location location = Location();

  final List<LatLng> deliveryPoints = [
    LatLng(37.7749, -122.4194),
    LatLng(37.7849, -122.4094),
    LatLng(37.7949, -122.3994),
  ];

  final Set<Polyline> polylines = {};

  @override
  void initState() {
    super.initState();
    initLocation();
  }

  void initLocation() async {
    bool serviceEnabled = await location.serviceEnabled();
    if (!serviceEnabled) serviceEnabled = await location.requestService();

    PermissionStatus permissionGranted = await location.hasPermission();
    if (permissionGranted == PermissionStatus.denied) {
      permissionGranted = await location.requestPermission();
    }

    final loc = await location.getLocation();
    setState(() {
      currentLocation = loc;
    });

    drawPolyline();
  }

  void drawPolyline() {
    setState(() {
      polylines.add(Polyline(
        polylineId: PolylineId('route1'),
        color: Colors.blue,
        width: 5,
        points: deliveryPoints,
      ));
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Optimized Delivery Route')),
      body: currentLocation == null
          ? Center(child: CircularProgressIndicator())
          : GoogleMap(
              onMapCreated: (controller) => mapController = controller,
              initialCameraPosition: CameraPosition(
                target: LatLng(currentLocation!.latitude!, currentLocation!.longitude!),
                zoom: 14,
              ),
              markers: deliveryPoints
                  .map((point) => Marker(
                        markerId: MarkerId(point.toString()),
                        position: point,
                        infoWindow: InfoWindow(title: 'Delivery Stop'),
                      ))
                  .toSet(),
              polylines: polylines,
              myLocationEnabled: true,
            ),
    );
  }
}
