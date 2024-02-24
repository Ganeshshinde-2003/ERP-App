// ignore_for_file: use_build_context_synchronously, avoid_print

import 'package:erp_app/constant/data/student_onboarding.dart';
import 'package:erp_app/constant/widgets/logo_loading.dart';
import 'package:erp_app/constant/widgets/snack_bar.dart';
import 'package:erp_app/features/common/subapp_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_polyline_points/flutter_polyline_points.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:geolocator/geolocator.dart';

class VanDriverLocationMap extends StatefulWidget {
  final String driverId;

  const VanDriverLocationMap({Key? key, required this.driverId})
      : super(key: key);

  @override
  State<VanDriverLocationMap> createState() => _VanDriverLocationMapState();
}

class _VanDriverLocationMapState extends State<VanDriverLocationMap> {
  GoogleMapController? mapController;
  late LatLng selectedLocation;
  bool isLoading = true;
  bool mapLoading = false;

  Map<String, dynamic>? mapData;
  Map<PolylineId, Polyline> polylines = {};
  List<LatLng> polylineCoordinates = [];
  PolylinePoints polylinePoints = PolylinePoints();
  Map<MarkerId, Marker> markers = {};

  @override
  void initState() {
    super.initState();
    requestLocationPermission();
  }

  Future<void> getCurrentLocation() async {
    try {
      Position position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high,
      );
      setState(() {
        selectedLocation = LatLng(position.latitude, position.longitude);
      });

      await getStaticDriverData();

      setState(() {
        isLoading = false;
      });
    } catch (e) {
      showSnackBar(
        context: context,
        content: "Error getting current location: $e",
      );
    }
  }

  Future<void> getStaticDriverData() async {
    setState(() {
      mapLoading = true;
    });

    Map<String, dynamic> staticData = {
      'latitude': '15.470123617513478',
      'longitude': '75.01165509223938',
      'timestamp': DateTime.now(),
    };

    setState(() {
      mapData = staticData;
      mapLoading = false;
    });
  }

  void _onMapCreated(GoogleMapController controller) async {
    mapController = controller;
    _getPolyline();
  }

  _addPolyLine() {
    PolylineId id = const PolylineId("poly");
    Polyline polyline = Polyline(
      polylineId: id,
      color: Colors.red,
      points: polylineCoordinates,
    );
    polylines[id] = polyline;
    setState(() {});
  }

  _getPolyline() async {
    PolylineResult result = await polylinePoints.getRouteBetweenCoordinates(
      GoogleMapsAPI,
      const PointLatLng(15.470123617513478, 75.01165509223938),
      const PointLatLng(15.468716709229895, 75.00425856560469),
      travelMode: TravelMode.driving,
    );

    if (result.points.isNotEmpty) {
      for (var point in result.points) {
        polylineCoordinates.add(LatLng(point.latitude, point.longitude));
      }
    } else {
      polylineCoordinates
          .add(const LatLng(15.470123617513478, 75.01165509223938));
      polylineCoordinates
          .add(const LatLng(15.466375933886523, 75.0107840448618));
    }
    _addPolyLine();
  }

  Future<void> requestLocationPermission() async {
    var status = await Permission.location.request();
    showSnackBar(
      context: context,
      content: "Location permission status: $status",
    );
    if (status == PermissionStatus.granted) {
      getCurrentLocation();
    } else if (status == PermissionStatus.denied) {
      showSnackBar(
        context: context,
        content: 'Location permission denied',
      );
    } else if (status == PermissionStatus.permanentlyDenied) {
      showSnackBar(
        context: context,
        content: 'Location permission permanently denied',
      );
      _showPermissionDialog();
    }
  }

  void _showPermissionDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Location Permission Required'),
          content: const Text(
            'Please enable location permission in app settings to use this feature.',
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text('OK'),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    var deviceWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      appBar: SubPageAppBar(context, 'Van Location'),
      floatingActionButton: isLoading
          ? const SizedBox.shrink()
          : mapLoading
              ? FloatingActionButton(
                  onPressed: () {},
                  backgroundColor: Colors.black,
                  child: const CircularProgressIndicator(
                    color: Colors.white,
                  ),
                )
              : FloatingActionButton.extended(
                  onPressed: getStaticDriverData,
                  backgroundColor: Colors.black,
                  icon: const Icon(
                    Icons.refresh,
                    color: Colors.white,
                  ),
                  label: Text(
                    'Refresh',
                    style:
                        GoogleFonts.poppins(fontSize: 12, color: Colors.white),
                  ),
                ),
      body: isLoading
          ? Center(child: LogoLoading(deviceWidth))
          : SizedBox(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(15),
                  child: Stack(
                    children: [
                      GoogleMap(
                        mapType: MapType.normal,
                        initialCameraPosition: CameraPosition(
                          bearing: 192.8334901395799,
                          target: LatLng(
                            double.parse(mapData!['latitude'].toString()),
                            double.parse(mapData!['longitude'].toString()),
                          ),
                          tilt: 59.440717697143555,
                          zoom: 14.151926040649414,
                        ),
                        polylines: Set<Polyline>.of(polylines.values),
                        markers: <Marker>{
                          Marker(
                            markerId: const MarkerId('shopId'),
                            position: LatLng(
                              double.parse(mapData!['latitude'].toString()),
                              double.parse(mapData!['longitude'].toString()),
                            ),
                            rotation: 0.0,
                          )
                        },
                        onMapCreated: _onMapCreated,
                        onTap: (LatLng value) {
                          print(':::: ${value.latitude} ${value.longitude}');
                        },
                        onLongPress: (value) {
                          print(':::: $value');
                        },
                        zoomControlsEnabled: true,
                        zoomGesturesEnabled: true,
                      ),
                      Positioned(
                        top: 50,
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Container(
                            decoration: BoxDecoration(
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.grey.shade200,
                                  blurRadius: 1.0,
                                  spreadRadius: 1.0,
                                )
                              ],
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(8),
                              border: Border.all(color: Colors.grey.shade400),
                            ),
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Text(
                                'Updated Time ${DateTime.now()})}',
                                style: GoogleFonts.poppins(fontSize: 13),
                              ),
                            ),
                          ),
                        ),
                      )
                    ],
                  ),
                ),
              ),
            ),
    );
  }
}
