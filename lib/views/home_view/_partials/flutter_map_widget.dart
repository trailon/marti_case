import 'package:flutter/material.dart';
import 'package:flutter_background_geolocation/flutter_background_geolocation.dart'
    as bg
    show Location;
import 'package:flutter_map/flutter_map.dart';
import 'package:flutter_map_cancellable_tile_provider/flutter_map_cancellable_tile_provider.dart';
import 'package:latlong2/latlong.dart';
import 'package:marti_case/views/home_view/home_viewmodel.dart';
import 'package:provider/provider.dart';

class FlutterMapWidget extends StatelessWidget {
  const FlutterMapWidget({super.key, required this.initialLocation});
  final bg.Location initialLocation;
  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: FlutterMap(
        mapController: context.read<HomeViewModel>().mapController,
        options: MapOptions(
          initialCenter: LatLng(
            initialLocation.coords.latitude,
            initialLocation.coords.longitude,
          ),
          initialZoom: 13,
          onTap: (_, p) {
            debugPrint('onTap: $p');
          },
          interactionOptions: const InteractionOptions(
            flags: ~InteractiveFlag.doubleTapZoom,
          ),
        ),
        children: [
          TileLayer(
            urlTemplate:
                'https://cartodb-basemaps-{s}.global.ssl.fastly.net/light_all/{z}/{x}/{y}.png',
            userAgentPackageName: 'com.example.marti_case',
            tileProvider: CancellableNetworkTileProvider(),
          ),
          Selector<HomeViewModel, List<Marker>>(
            selector: (context, value) {
              return context.read<HomeViewModel>().markersForEvery100Meters;
            },
            builder: (context, value, child) {
              return MarkerLayer(markers: value);
            },
          ),
          Selector<HomeViewModel, List<Marker>>(
            selector: (context, value) {
              return context.read<HomeViewModel>().currentLocationMarkers;
            },
            builder: (context, value, child) {
              return MarkerLayer(markers: value);
            },
          ),
        ],
      ),
    );
  }
}
