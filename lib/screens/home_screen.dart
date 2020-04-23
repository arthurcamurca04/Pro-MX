import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class HomeScreen extends StatefulWidget {
  final String title;
  HomeScreen({Key key, this.title}) : super(key: key);

  // This widget is the root of your application.
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Pro MX',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: Scaffold(
        body: Map(),
      ),
    );
  }
}

class Map extends StatefulWidget {
  @override
  _MapState createState() => _MapState();
}

class _MapState extends State<Map> {
  GoogleMapController mapController;
  static const _initialPosition = LatLng(-7.19818112, -37.91796505);
  LatLng _lastPosition = _initialPosition;

  final Set<Marker> _markers = {};

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: <Widget>[
        GoogleMap(
          initialCameraPosition: CameraPosition(
            target: _initialPosition,
            zoom: 10,
          ),
          onMapCreated: onCreated,
          mapType: MapType.normal,
          myLocationEnabled: true,
          compassEnabled: true,
          markers: _markers,
          onCameraMove: _onCameraMove,
        ),
        Positioned(
            bottom: 100,
            right: 10,
            child: FloatingActionButton(
              onPressed: _onAddMarkerPress,
              tooltip: "Add Marker",
              backgroundColor: Colors.black,
              child: Icon(Icons.add_location),
            ))
      ],
    );
  }

  void onCreated(GoogleMapController controller) {
    setState(() {
      mapController = controller;
    });
  }

  void _onCameraMove(CameraPosition position) {
    setState(() {
      _lastPosition = position.target;
    });
  }

  void _onAddMarkerPress() {
    setState(() {
      
      _markers.add(Marker(
        markerId: MarkerId(_lastPosition.toString()),
        position:_lastPosition,
        infoWindow: InfoWindow(
          title: 'Remember here',
          snippet: 'Good Place',
        ),
        icon: BitmapDescriptor.defaultMarker,
        ));
    });
  }
}
