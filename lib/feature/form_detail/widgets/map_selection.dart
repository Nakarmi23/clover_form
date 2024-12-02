import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';
import 'package:geolocator/geolocator.dart';

class OSMMapWidget extends StatefulWidget {
  const OSMMapWidget({
    super.key,
    required this.onMarkerPlaced,
    this.initialMarkerPosition,
  });

  final Function(LatLng) onMarkerPlaced;
  final LatLng? initialMarkerPosition;

  @override
  _OSMMapWidgetState createState() => _OSMMapWidgetState();
}

class _OSMMapWidgetState extends State<OSMMapWidget> {
  final MapController _mapController = MapController();
  List<Marker> _markers = [];
   LatLng _initialPosition = const LatLng(27.882859279,
      85.410628655); // Initial position, you can set this to any default value

  @override
  void initState() {
    super.initState();
    if (widget.initialMarkerPosition != null) {
      _initialPosition = widget.initialMarkerPosition!;
      _markers = [
        Marker(
          width: 80.0,
          height: 80.0,
          point: _initialPosition,
          child: const Icon(
            Icons.location_pin,
            color: Colors.red,
            size: 40.0,
          ),
        ),
      ];
    } else {
      _determinePosition().then((position) {
        if (position != null) {
          setState(() {
            _initialPosition = LatLng(position.latitude, position.longitude);
            _markers = [
              Marker(
                width: 80.0,
                height: 80.0,
                point: _initialPosition,
                child: const Icon(
                  Icons.location_pin,
                  color: Colors.red,
                  size: 40.0,
                ),
              ),
            ];
            _mapController.move(_initialPosition, 15.0);
          });
        }
      });
    }
  }

  Future<Position?> _determinePosition() async {
    bool serviceEnabled;
    LocationPermission permission;

    // Test if location services are enabled.
    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      // Location services are not enabled don't continue
      // accessing the position and request users of the
      // App to enable the location services.
      return null;
    }

    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        // Permissions are denied, next time you could try
        // requesting permissions again (this is also where
        // Android's shouldShowRequestPermissionRationale
        // returned true. According to Android guidelines
        // your App should show an explanatory UI now.
        return null;
      }
    }

    if (permission == LocationPermission.deniedForever) {
      // Permissions are denied forever, handle appropriately.
      return null;
    }

    // When we reach here, permissions are granted and we can
    // continue accessing the position of the device.
    return await Geolocator.getCurrentPosition();
  }

  void _onTap(LatLng latLng) {
    setState(() {
      _markers = [
        Marker(
          width: 80.0,
          height: 80.0,
          point: latLng,
          child: const Icon(
            Icons.location_pin,
            color: Colors.red,
            size: 40.0,
          ),
        ),
      ];
    });
    widget.onMarkerPlaced(latLng);
  }

  void _zoomIn() {
    _mapController.move(
        _mapController.camera.center, _mapController.camera.zoom + 1);
  }

  void _zoomOut() {
    _mapController.move(
        _mapController.camera.center, _mapController.camera.zoom - 1);
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        SizedBox(
          width: double.infinity,
          height: 250,
          child: FlutterMap(
            mapController: _mapController,
            options: MapOptions(
              initialCenter: widget.initialMarkerPosition != null
                  ? widget.initialMarkerPosition!
                  : _initialPosition,
              initialZoom: 15.0,
              onTap: (tapPosition, point) {
                _onTap(point);
              },
            ),
            children: [
              TileLayer(
                urlTemplate: 'https://tile.openstreetmap.org/{z}/{x}/{y}.png',
              ),
              MarkerLayer(
                markers: _markers,
              ),
            ],
          ),
        ),
        Positioned(
          top: 10,
          right: 10,
          child: Column(
            children: [
              FloatingActionButton(
                onPressed: _zoomIn,
                mini: true,
                child: const Icon(Icons.add),
              ),
              const SizedBox(height: 10),
              FloatingActionButton(
                onPressed: _zoomOut,
                mini: true,
                child: const Icon(Icons.remove),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
