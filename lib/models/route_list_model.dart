import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';

class RouteListModel {
  List<Marker>? markers;

  RouteListModel({this.markers});

  RouteListModel.fromJson(Map<String, dynamic> json) {
    if (json['markers'] != null) {
      markers = <Marker>[];
      json['markers'].forEach((v) {
        markers!.add(
          Marker(
            point: LatLng(v['coordinates'][0], v['coordinates'][1]),
            child: Icon(Icons.location_on, color: Colors.red),
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
