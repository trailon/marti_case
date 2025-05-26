import 'package:geocode/geocode.dart';
import 'package:latlong2/latlong.dart';

mixin GeolocationMixin {
  GeoCode geoCode = GeoCode();
  Future<String> getCurrentLocation(LatLng location) async {
    final address = await geoCode.reverseGeocoding(
      latitude: location.latitude,
      longitude: location.longitude,
    );
    return address.streetAddress ?? 'No Address Found by Geocoder';
  }
}
