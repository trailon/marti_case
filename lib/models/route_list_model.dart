import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';
import 'package:marti_case/utils/geolocation_mixin.dart';
import 'package:marti_case/views/home_view/_partials/marker_child_widget.dart';

class RouteListModel with GeolocationMixin {
  List<Marker>? markers;

  RouteListModel({this.markers});

  RouteListModel.fromJson(Map<String, dynamic> json) {
    if (json['markers'] != null) {
      markers = <Marker>[];
      json['markers'].forEach((v) {
        markers!.add(
          Marker(
            point: LatLng(v['coordinates'][1], v['coordinates'][0]),
            child: MarkerChild(
              location: LatLng(v['coordinates'][1], v['coordinates'][0]),
            ),
          ),
        );
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (markers != null) {
      data['markers'] = markers!.map((v) => v.point.toJson()).toList();
    }
    return data;
  }
}
