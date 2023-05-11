import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:geoflutterfire/geoflutterfire.dart';
import 'package:google_place/google_place.dart' as localSearch;
import 'package:image_picker/image_picker.dart';

import 'package:uuid/uuid.dart';

class Extra {
  String userId = FirebaseAuth.instance.currentUser!.uid;
  static String GoogleApiKey =
      "AIzaSyCDfI1GOcaZ2W3xQZyWwN_d2ZUzMufGSS4"; // for test todo: move to
  var googlePlace = localSearch.GooglePlace(GoogleApiKey);
  var firestore = FirebaseFirestore.instance;

  final ImagePicker _picker = ImagePicker();
  final geo = Geoflutterfire();
  var uuid = const Uuid();
}
