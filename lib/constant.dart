// ignore_for_file: prefer_const_constructors, prefer_equal_for_default_values

import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

const String apikey = 'AIzaSyDw_Q7r7UXHT_q0wXGdlUTeiaZnK-TIQZc';
const String img =
    'https://imgs.search.brave.com/s13T9tbpcmQfykCjDqfNPQJ0ppXkfrdVhKpPDYfuayE/rs:fit:577:577:1/g:ce/aHR0cHM6Ly9sb2dv/c2F2ZS5jb20vaW1h/Z2VzL2xhcmdlL2Nv/bW1vbi8wMi96YW1h/bGVrLnBuZw';

const LatLng pos1 = LatLng(31.205753, 29.924526);
const LatLng pos2 = LatLng(31.209501790573892, 29.909451061010536);

Marker? source;
Marker? destination;

// ignore: prefer_collection_literals
Circle? circle1;
Circle? circle2;

CameraPosition intialpos = CameraPosition(target: pos1, zoom: 13);

// ignore: use_function_type_syntax_for_parameters
List<Polyline> polyLine = [];

// ignore: use_function_type_syntax_for_parameters
