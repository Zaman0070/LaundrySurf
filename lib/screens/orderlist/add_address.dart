

import 'package:flutter/material.dart';

import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:laundry_app/provider/order_provider.dart';

import 'package:provider/provider.dart';
import 'package:location/location.dart';

class CustomGoogleMap extends StatefulWidget {
  const CustomGoogleMap({Key? key}) : super(key: key);



  @override
  _CustomGoogleMapState createState() => _CustomGoogleMapState();
}

class _CustomGoogleMapState extends State<CustomGoogleMap> {

  LatLng _initialCameraPosition =  LatLng(20.5937, 78.9629);

  GoogleMapController? controller;
  Location _location = Location();
  void _onMapCreated(GoogleMapController _value){
    controller = _value;
    _location.onLocationChanged.listen((event) {
      controller!.animateCamera(CameraUpdate.newCameraPosition(const CameraPosition(
        target: LatLng(20.5937, 78.9629),
        zoom: 15,
      ),
      ),
      );
    });
  }
  @override
  Widget build(BuildContext context) {
    OrderProvider checkOutProvider = Provider.of(context);
    return Scaffold(
      body: SafeArea(
        child: Container(
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
          child: Stack(
            children: [
              GoogleMap(
                initialCameraPosition: CameraPosition(
                  target: _initialCameraPosition,
                ),
                mapType: MapType.normal,
                onMapCreated:_onMapCreated,
                myLocationEnabled: true,
              ),
              Positioned(
                  bottom: 0,
                  left: 0,
                  right: 0,
                  child: Container(
                    margin: const EdgeInsets.fromLTRB(10, 40, 60, 40),
                    height: 45,
                    width: double.infinity,
                    child: MaterialButton(
                      onPressed: ()async{
                        await _location.getLocation().then((value) {
                          setState(() {
                            checkOutProvider.setLocation = value;
                          });
                        });
                        Navigator.of(context).pop();
                      },
                      color: Colors.grey[200],
                      child: const Text('Set Location',
                        style: TextStyle(
                          fontSize: 18,
                        ),
                      ),
                    ),
                  ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
