import 'dart:async';
import 'package:carpooling_app/constants/secrets.dart';
import 'package:carpooling_app/widgets/custom_text.dart';
import 'package:carpooling_app/widgets/showSnackBar.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:google_api_headers/google_api_headers.dart';
import 'package:flutter/material.dart';
import 'package:flutter_google_places/flutter_google_places.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:google_maps_webservice/places.dart';

const kGoogleApiKey = Secrets.API_KEY;

class SearchLocation extends StatefulWidget {
  @override
  _SearchLocationState createState() => _SearchLocationState();
}

class _SearchLocationState extends State<SearchLocation> {
  Set<Marker> markers = {};

  late GoogleMapController mapController;
  //30.3753, 69.3451 pakistan
  // 33.6844, 73.0479 islambad
  LatLng? _currentLocation;
  LatLng? _selectedCoordinates;
  CameraPosition _initialLocation =
      CameraPosition(target: LatLng(30.3753, 69.3451), zoom: 5);

  _getCurrentLocation({bool isAddMarker = false}) async {
    await Geolocator.getCurrentPosition(desiredAccuracy: LocationAccuracy.high)
        .then((Position position) async {
      _currentLocation = LatLng(position.latitude, position.longitude);
      if (isAddMarker) {
        _addMarker(_currentLocation!, "Your current Locatioon");
        _selectedCoordinates = _currentLocation;
      }

      setState(() {
        mapController.animateCamera(
          CameraUpdate.newCameraPosition(
            CameraPosition(
              target: _currentLocation!,
              zoom: 15.0,
            ),
          ),
        );
      });
    }).catchError((e) {
      print(e);
    });
  }

  _addMarker(LatLng location, String description) {
    Marker newMarker = Marker(
      markerId: MarkerId(location.toString()),
      position: LatLng(location.latitude, location.longitude),
      // infoWindow: InfoWindow(
      //   title: 'Destination (${location.latitude}, ${location.longitude})',
      //   snippet: description,
      // ),
      icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueRed),
      draggable: true,
    );
    setState(() {
      markers.clear();
      markers.add(newMarker);
    });
  }

  @override
  void initState() {
    super.initState();
    _getCurrentLocation();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Stack(
          children: [
            GoogleMap(
              markers: Set<Marker>.from(markers),
              initialCameraPosition: _initialLocation,
              myLocationEnabled: true,
              myLocationButtonEnabled: true,
              mapType: MapType.normal,
              zoomGesturesEnabled: true,
              zoomControlsEnabled: true,
              padding: EdgeInsets.only(top: 50.0),
              onMapCreated: (GoogleMapController controller) {
                mapController = controller;
              },
            ),
            Container(
              margin: const EdgeInsets.all(10),
              child: Row(
                children: [
                  Expanded(
                    child: GestureDetector(
                      onTap: _handlePressButton,
                      child: Container(
                        padding: const EdgeInsets.all(10),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20),
                          color: Colors.white,
                        ),
                        child: CustomText(
                          text: "Search Your Location",
                          size: 18,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(width: 10),
                  GestureDetector(
                    onTap: () {
                      if (_selectedCoordinates != null) {
                        Get.back(result: _selectedCoordinates);
                      } else {
                        showErrorSnackBar(
                            title: "Select Your Location", message: "");
                      }
                    },
                    child: CustomText(
                      text: "Done",
                      size: 20,
                      color: Colors.red,
                      weight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  void onError(PlacesAutocompleteResponse response) {
    showErrorSnackBar(title: response.errorMessage.toString());
  }

  Future<void> _handlePressButton() async {
    // show input autocomplete with selected mode
    // then get the Prediction selected
    Prediction? p = await PlacesAutocomplete.show(
      context: context,
      apiKey: kGoogleApiKey,
      onError: onError,
      mode: Mode.fullscreen,
      types: [],
      strictbounds: false,
      language: "en",
      logo: GestureDetector(
        onTap: () {
          if (_currentLocation == null) {
            _getCurrentLocation(isAddMarker: true);
            // _addMarker(_currentLocation!, "Your current Locatioon");
          } else {
            _addMarker(_currentLocation!, "Your current Locatioon");
            _selectedCoordinates = _currentLocation;
          }
          Get.back();
        },
        child: Padding(
          padding: const EdgeInsets.all(12.0),
          child: Row(
            children: [
              Icon(
                Icons.location_searching,
                color: Colors.purple,
              ),
              const SizedBox(width: 5),
              CustomText(
                text: "Select Current Location",
                weight: FontWeight.w500,
                color: Colors.purple,
                size: 20,
              ),
            ],
          ),
        ),
      ),
      decoration: InputDecoration(
        hintText: 'Search',
      ),
      components: [Component(Component.country, "pk")],
    );

    displayPrediction(p!);
  }

  Future<Null> displayPrediction(Prediction p) async {
    if (p != null) {
      print("\nreach Display prediction\n");
      // get detail (lat/lng)
      GoogleMapsPlaces _places = GoogleMapsPlaces(
        apiKey: kGoogleApiKey,
        apiHeaders: await GoogleApiHeaders().getHeaders(),
      );
      PlacesDetailsResponse detail =
          await _places.getDetailsByPlaceId(p.placeId!);
      final lat = detail.result.geometry!.location.lat;
      final lng = detail.result.geometry!.location.lng;

      setState(() {
        _selectedCoordinates = LatLng(lat, lng);
        mapController.animateCamera(
          CameraUpdate.newCameraPosition(
            CameraPosition(
              target: _selectedCoordinates!,
              zoom: 15.0,
            ),
          ),
        );
      });
      _addMarker(LatLng(lat, lng), p.description!);
      // showSnackBar("${p.description} - $lat/$lng", "");
    }
  }
}
