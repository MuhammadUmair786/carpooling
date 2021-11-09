// import 'package:flutter/material.dart';



// import 'dart:convert';
// import 'dart:io';

// import 'package:http/http.dart';

// class AddressSearch extends SearchDelegate<Suggestion> {
//   AddressSearch(this.sessionToken) {
//     apiClient = PlaceApiProvider(sessionToken);
//   }

//   final sessionToken;
//   PlaceApiProvider apiClient;

//   @override
//   List<Widget> buildActions(BuildContext context) {
//     return [
//       IconButton(
//         tooltip: 'Clear',
//         icon: Icon(Icons.clear),
//         onPressed: () {
//           query = '';
//         },
//       )
//     ];
//   }

//   @override
//   Widget buildLeading(BuildContext context) {
//     return IconButton(
//       tooltip: 'Back',
//       icon: Icon(Icons.arrow_back),
//       onPressed: () {
//         close(context, null);
//       },
//     );
//   }

//   @override
//   Widget buildResults(BuildContext context) {
//     return null;
//   }

//   @override
//   Widget buildSuggestions(BuildContext context) {
//     return FutureBuilder(
//       future: query == ""
//           ? null
//           : apiClient.fetchSuggestions(
//               query, Localizations.localeOf(context).languageCode),
//       builder: (context, snapshot) => query == ''
//           ? Container(
//               padding: EdgeInsets.all(16.0),
//               child: Text('Enter your address'),
//             )
//           : snapshot.hasData
//               ? ListView.builder(
//                   itemBuilder: (context, index) => ListTile(
//                     title:
//                         Text((snapshot.data[index] as Suggestion).description),
//                     onTap: () {
//                       close(context, snapshot.data[index] as Suggestion);
//                     },
//                   ),
//                   itemCount: snapshot.data.length,
//                 )
//               : Container(child: Text('Loading...')),
//     );
//   }
// }




// class Place {
//   String streetNumber;
//   String street;
//   String city;
//   String zipCode;

//   Place({
//     this.streetNumber,
//     this.street,
//     this.city,
//     this.zipCode,
//   });

//   @override
//   String toString() {
//     return 'Place(streetNumber: $streetNumber, street: $street, city: $city, zipCode: $zipCode)';
//   }
// }

// class Suggestion {
//   final String placeId;
//   final String description;

//   Suggestion(this.placeId, this.description);

//   @override
//   String toString() {
//     return 'Suggestion(description: $description, placeId: $placeId)';
//   }
// }

// class PlaceApiProvider {
//   final client = Client();

//   PlaceApiProvider(this.sessionToken);

//   final sessionToken;

//   static final String androidKey = 'YOUR_API_KEY_HERE';
//   static final String iosKey = 'YOUR_API_KEY_HERE';
//   final apiKey = Platform.isAndroid ? androidKey : iosKey;

//   Future<List<Suggestion>> fetchSuggestions(String input, String lang) async {
//     final request =
//         'https://maps.googleapis.com/maps/api/place/autocomplete/json?input=$input&types=address&language=$lang&components=country:ch&key=$apiKey&sessiontoken=$sessionToken';
//     final response = await client.get(request);

//     if (response.statusCode == 200) {
//       final result = json.decode(response.body);
//       if (result['status'] == 'OK') {
//         // compose suggestions in a list
//         return result['predictions']
//             .map<Suggestion>((p) => Suggestion(p['place_id'], p['description']))
//             .toList();
//       }
//       if (result['status'] == 'ZERO_RESULTS') {
//         return [];
//       }
//       throw Exception(result['error_message']);
//     } else {
//       throw Exception('Failed to fetch suggestion');
//     }
//   }

//   Future<Place> getPlaceDetailFromId(String placeId) async {
//     final request =
//         'https://maps.googleapis.com/maps/api/place/details/json?place_id=$placeId&fields=address_component&key=$apiKey&sessiontoken=$sessionToken';
//     final response = await client.get(request);

//     if (response.statusCode == 200) {
//       final result = json.decode(response.body);
//       if (result['status'] == 'OK') {
//         final components =
//             result['result']['address_components'] as List<dynamic>;
//         // build result
//         final place = Place();
//         components.forEach((c) {
//           final List type = c['types'];
//           if (type.contains('street_number')) {
//             place.streetNumber = c['long_name'];
//           }
//           if (type.contains('route')) {
//             place.street = c['long_name'];
//           }
//           if (type.contains('locality')) {
//             place.city = c['long_name'];
//           }
//           if (type.contains('postal_code')) {
//             place.zipCode = c['long_name'];
//           }
//         });
//         return place;
//       }
//       throw Exception(result['error_message']);
//     } else {
//       throw Exception('Failed to fetch suggestion');
//     }
//   }
// }