import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_polyline_points/flutter_polyline_points.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:http/http.dart' as http;

import '../controllers/extras.dart';
import '../models/Location/LocationDataModel.dart';

class LocationApi {
  BuildContext context;
  LocationApi(this.context);

  Future<dynamic> LocationData(startLocation, endLocation) async {
    PolylinePoints polylinePoints = PolylinePoints();
    PolylineResult polyPoints = await polylinePoints.getRouteBetweenCoordinates(
      Extra.GoogleApiKey,
      PointLatLng(startLocation.latitude, startLocation.longitude),
      PointLatLng(endLocation.latitude, endLocation.longitude),
      travelMode: TravelMode.driving,
    );
    GetLocationData? local = await LocationApi(context)
        .getLocation(start: startLocation, destination: endLocation);

    return {"poly": polyPoints, "local": local};
  }

  Future<GetLocationData?> getLocation(
      {required LatLng start, required LatLng destination}) async {
    String url =
        "https://maps.googleapis.com/maps/api/distancematrix/json?units=imperial&origins=${start.longitude},${start.latitude}&destinations=${destination.longitude},${destination.latitude}&key=${Extra.GoogleApiKey}";

    print(url);
    var res = await http.get(Uri.parse(url));
    GetLocationData? local_data =
        GetLocationData.fromJson(jsonDecode(res.body));
    return local_data;
  }
}
