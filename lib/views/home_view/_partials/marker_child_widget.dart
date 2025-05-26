import 'package:flutter/material.dart';
import 'package:latlong2/latlong.dart';
import 'package:marti_case/utils/geolocation_mixin.dart';

class MarkerChild extends StatefulWidget {
  const MarkerChild({super.key, required this.location});
  final LatLng location;

  @override
  State<MarkerChild> createState() => _MarkerChildState();
}

class _MarkerChildState extends State<MarkerChild> with GeolocationMixin {
  LatLng get location => widget.location;
  bool addressFetching = false;
  String address = '';
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () async {
        if (mounted) {
          address = await getCurrentLocation(location);
          setState(() {
            addressFetching = true;
          });
        }
      },
      child: addressFetching
          ? Stack(
              fit: StackFit.loose,
              clipBehavior: Clip.none,
              children: [
                Positioned(
                  left: 0,
                  right: 0,
                  bottom: 24,
                  child: Card(
                    elevation: 10,
                    margin: EdgeInsets.all(0),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(2),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(2),
                      child: Text(
                        address,
                        textAlign: TextAlign.center,
                        style: TextStyle(color: Colors.white, fontSize: 8),
                      ),
                    ),
                  ),
                ),
                Positioned(
                  right: 0,
                  left: 0,
                  bottom: 10,
                  child: Icon(Icons.location_on, color: Colors.red),
                ),
              ],
            )
          : const Icon(Icons.location_on, color: Colors.red),
    );
  }
}
