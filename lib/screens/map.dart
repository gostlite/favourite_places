import 'package:favourite_places/models/place.dart';
import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
// import "package:latlng/latlng.dart" as mylatlng;
import 'package:latlong2/latlong.dart';

class MapScreen extends StatefulWidget {
  const MapScreen(
      {this.place = const PlaceLocation(
          longitude: -122.084, latitude: 37.422, address: ''),
      super.key});
  final PlaceLocation place;
  final _isSelecting = true;

  @override
  State<MapScreen> createState() => _MapScreenState();
}

class _MapScreenState extends State<MapScreen> {
  LatLng? _pickedPosition;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
            widget._isSelecting ? "Select your location" : "Your location"),
        actions: <Widget>[
          if (widget._isSelecting)
            IconButton(
                onPressed: () {
                  Navigator.of(context).pop(_pickedPosition);
                },
                icon: const Icon(Icons.save))
        ],
      ),
      body: FlutterMap(
        options: MapOptions(
            initialCenter:
                LatLng(widget.place.latitude, widget.place.longitude),
            initialZoom: 3.2,
            onTap: !widget._isSelecting
                ? null
                : (tapPosit, latlng) {
                    setState(() {
                      _pickedPosition = latlng;
                    });
                  }),
        children: [
          MarkerLayer(
            markers: [
              Marker(
                rotate: true,
                point: _pickedPosition ??
                    LatLng(widget.place.latitude, widget.place.longitude),
                width: 80,
                height: 80,
                child: const Icon(Icons.location_on),
              ),
            ],
          ),
          TileLayer(
            urlTemplate: 'https://tile.openstreetmap.org/{z}/{x}/{y}.png',
            userAgentPackageName: 'com.example.app',
          ),
        ],
      ),
    );
  }
}
