import 'dart:convert';

import 'package:favourite_places/models/place.dart';
import 'package:flutter/material.dart';
import 'package:location/location.dart';
import "package:http/http.dart" as http;

class LocationInput extends StatefulWidget {
  final void Function(PlaceLocation placeLocation) pickLocation;
  const LocationInput({required this.pickLocation, super.key});

  @override
  State<LocationInput> createState() => _LocationInputState();
}

class _LocationInputState extends State<LocationInput> {
  PlaceLocation? _pickedLocation;
  bool _isGettingLocation = false;
  Location location = Location();
  void _getCurrentLocation() async {
    Location location = Location();

    bool serviceEnabled;
    PermissionStatus permissionGranted;
    LocationData locationData;

    serviceEnabled = await location.serviceEnabled();
    if (!serviceEnabled) {
      serviceEnabled = await location.requestService();
      if (!serviceEnabled) {
        return;
      }
    }

    permissionGranted = await location.hasPermission();
    if (permissionGranted == PermissionStatus.denied) {
      permissionGranted = await location.requestPermission();
      if (permissionGranted != PermissionStatus.granted) {
        return;
      }
    }
    setState(() {
      _isGettingLocation = true;
    });

    locationData = await location.getLocation();
    final lng = locationData.longitude;
    final lat = locationData.latitude;
    if (lat == null || lng == null) {
      return;
    }
    final url = Uri.parse(
        "https://geocode.maps.co/reverse?lat=$lat&lon=$lng&api_key=670afe13c0f61190453840hcd67f8ee");
    final response = await http.get(url);
    final rspData = json.decode(response.body);
    final address =
        "${rspData["address"]['building']} ${rspData["address"]['road']}, ${rspData["address"]['state']}, ${rspData["address"]['country_code']}";
    print(address);

    setState(() {
      _pickedLocation =
          PlaceLocation(longitude: lng, latitude: lat, address: address);
      _isGettingLocation = false;
    });
    widget.pickLocation(_pickedLocation!);

    // print(locationData.latitude);
    // print(locationData.longitude);
  }

  String get locationImage {
    if (_pickedLocation == null) {
      return "";
    }

    final lat = _pickedLocation!.latitude;
    final lng = _pickedLocation!.longitude;
    return "https://maps.geoapify.com/v1/staticmap?style=osm-bright&width=600&height=400&center=lonlat:$lng,$lat&zoom=11.5617&scaleFactor=2&apiKey=62fa5664709346f1a1ddfed3094a4463";
  }

  @override
  Widget build(BuildContext context) {
    Widget previewContent = Text(
      "No Location selected yet",
      textAlign: TextAlign.center,
      style: Theme.of(context)
          .textTheme
          .bodyLarge!
          .copyWith(color: Theme.of(context).colorScheme.onSurface),
    );
    if (_pickedLocation != null) {
      previewContent = Image.network(
        locationImage,
        fit: BoxFit.cover,
        width: double.infinity,
        height: double.infinity,
      );
    }

    if (_isGettingLocation) {
      previewContent = const CircularProgressIndicator();
    }
    return Column(
      children: [
        Container(
            height: 170,
            width: double.infinity,
            alignment: Alignment.center,
            decoration: BoxDecoration(
              border: Border.all(
                  width: 1,
                  color:
                      Theme.of(context).colorScheme.primary.withOpacity(0.2)),
            ),
            child: previewContent),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            TextButton.icon(
              icon: const Icon(Icons.location_on),
              onPressed: _getCurrentLocation,
              label: const Text("Current location"),
            ),
            TextButton.icon(
              icon: const Icon(Icons.map),
              onPressed: () {},
              label: const Text("Select on map"),
            ),
          ],
        ),
      ],
    );
  }
}
