import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:insta_clone/generated/l10n.dart';
import 'package:insta_clone/models/data_models/location.dart';

class MapScreen extends StatefulWidget {
  final Location location;

  MapScreen({required this.location});

  @override
  State<MapScreen> createState() => _MapScreenState();
}

class _MapScreenState extends State<MapScreen> {
  late LatLng _latLng;
  late CameraPosition _cameraPosition;
  GoogleMapController? _googleMapController;
  Map<MarkerId, Marker> _markers = <MarkerId, Marker>{};

  @override
  void initState() {
    _latLng = LatLng(widget.location.latitude, widget.location.longitude);
    _cameraPosition = CameraPosition(target: _latLng, zoom: 15.0);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(S.of(context).selectPlace),
        actions: [IconButton(onPressed: null, icon: Icon(Icons.done))],
      ),
      body: GoogleMap(
        initialCameraPosition: _cameraPosition,
        onMapCreated: onMapCreated,
        onTap: onMapTapped,
        markers: Set<Marker>.of(_markers.values),
      ),
    );
  }

  void onMapCreated(GoogleMapController controller) {
    _googleMapController = controller;
  }

  void onMapTapped(LatLng latLng) {
    _latLng = latLng;
    _createMarker(_latLng);
  }

  void _createMarker(LatLng latLng) {
    final markerId = MarkerId("selected");
    final marker = Marker(markerId: markerId, position: latLng);
    setState(() {
      _markers[markerId] = marker;
    });
  }
}
