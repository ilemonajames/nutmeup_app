import 'package:flutter/material.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geoflutterfire/geoflutterfire.dart';
import 'package:google_place/google_place.dart';
import 'package:nutmeup/widgets/Inputes/SearchText.dart';
import 'package:nutmeup/widgets/Navigators/AppBar.dart';

import '../../constants/Colors.dart';
import '../../constants/DBNames.dart';
import '../../controllers/extras.dart';

class LocationSearchPage extends StatefulWidget {
  const LocationSearchPage({Key? key}) : super(key: key);

  @override
  State<LocationSearchPage> createState() => _LocationSearchPageState();
}

class _LocationSearchPageState extends State<LocationSearchPage> with Extra {
  var controller = ScrollController();
  var searchController = TextEditingController();
  var searchQuery = "";

  @override
  void initState() {}

  @override
  Widget build(BuildContext context) {
    GeoFirePoint center = geo.point(latitude: 9.0719056, longitude: 7.4675026);
    var dataStram = geo
        .collection(collectionRef: firestore.collection(PRODUCTS))
        .within(center: center, radius: 100, field: 'location');

    return Scaffold(
      appBar: AppBars(context).BackAppBarWithTitle(title: "My Location"),
      body: Container(
        color: backgroundGray,
        padding: const EdgeInsets.only(left: 10, right: 10),
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          const SizedBox(
            height: 10,
          ),
          Container(
            child: SearchTextField(
              onChange: (v) {
                setState(() {
                  searchQuery = v.toString();
                });
              },
              controller: searchController,
              hint: "Location..",
            ),
          ),
          const SizedBox(
            height: 20,
          ),
          Expanded(
            child: FutureBuilder(
                future: searchQuery.isEmpty
                    ? null
                    : googlePlace.queryAutocomplete.get(searchQuery),
                builder: (a, AsyncSnapshot<AutocompleteResponse?> b) {
                  var places = [];

                  if (b.connectionState == ConnectionState.none) {
                    return const Center(
                      child: Text("Nothing here yet!!"),
                    );
                  }

                  if (b.connectionState == ConnectionState.waiting) {
                    return const Center(
                      child: CircularProgressIndicator.adaptive(),
                    );
                  }

                  if (b.hasData) {
                    if (b.data == null) {
                      return const Center(
                        child: Text("Nothing here yet!!"),
                      );
                    } else {
                      b.data!.predictions!.forEach((element) {
                        places.add({
                          "title": element.description.toString(),
                          "ref": element.reference
                        });
                      });
                    }
                  } else {
                    return const Center(
                      child: CircularProgressIndicator.adaptive(),
                    );
                  }
                  return ListView.builder(
                      itemCount: places.length,
                      shrinkWrap: false,
                      itemBuilder: (a, index) {
                        var suggestion = places[index];

                        return GestureDetector(
                          onTap: () async {
                            Navigator.pop(context, suggestion);
                          },
                          child: ListTile(
                              leading: Icon(
                                Icons.location_pin,
                                color: colorBlue,
                              ),
                              title: Text(
                                "${(suggestion as Map)["title"]}",
                                style: const TextStyle(fontSize: 14),
                              )),
                        );
                      });
                }),
          ),
          const SizedBox(
            height: 20,
          ),
        ]),
      ),
    );
  }
}
