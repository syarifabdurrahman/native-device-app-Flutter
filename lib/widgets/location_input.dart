import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart'; // Suitable for most situations
import 'package:flutter_map/plugin_api.dart';
import 'package:latlong2/latlong.dart';
import 'package:location/location.dart';
import 'package:native_device_app/helpers/location_helper.dart';

class LocationInput extends StatefulWidget {
  const LocationInput({Key? key}) : super(key: key);

  @override
  State<LocationInput> createState() => _LocationInputState();
}

class _LocationInputState extends State<LocationInput> {
  String? _previewImageUrl;
  double? _latitude;
  double? _longitude;
  MapController? mapController;

  Future<void> _getCurrentUserLocation() async {
    final locData = await Location().getLocation();
    final staticMapImageUrl = LocationHelper.generateImageLocation();
    setState(() {
      _latitude = locData.latitude;
      _longitude = locData.longitude;
      _previewImageUrl = staticMapImageUrl;
      mapController?.move(LatLng(_latitude!, _longitude!), 17.0);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          height: 170,
          width: double.infinity,
          alignment: Alignment.center,
          decoration:
              BoxDecoration(border: Border.all(width: 1, color: Colors.grey)),
          child: _previewImageUrl == null
              ? Text(
                  'No location chosen',
                  textAlign: TextAlign.center,
                )
              : FlutterMap(
                  options: MapOptions(
                    center: LatLng(_latitude!, _longitude!),
                  ),
                  layers: [
                    TileLayerOptions(
                      urlTemplate: LocationHelper.generateImageLocation(),
                      userAgentPackageName: 'dev.fleaflet.flutter_map.example',
                    ),
                  ],
                ),
          // : Image.network(
          //     _previewImageUrl!,
          //     fit: BoxFit.cover,
          //   ),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            FlatButton.icon(
              icon: Icon(Icons.location_on),
              onPressed: _getCurrentUserLocation,
              label: Text('Current location'),
              textColor: Theme.of(context).primaryColor,
            ),
            FlatButton.icon(
              icon: Icon(Icons.map),
              onPressed: () {},
              label: Text('Select on map'),
              textColor: Theme.of(context).primaryColor,
            )
          ],
        )
      ],
    );
  }
}
