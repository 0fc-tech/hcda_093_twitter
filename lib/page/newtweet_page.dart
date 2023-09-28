import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:geolocator/geolocator.dart';
import 'package:go_router/go_router.dart';
import 'package:latlong2/latlong.dart';

class NewTweetPage extends StatefulWidget {
  const NewTweetPage({super.key});

  @override
  State<NewTweetPage> createState() => _NewTweetPageState();
}

class _NewTweetPageState extends State<NewTweetPage> {
  File? fileImage;
  bool showMap = false;
  final MapController controller = MapController();
  LatLng myPosition = LatLng(0, 0);

  @override
  Widget build(BuildContext context) {
    _determinePosition().then((value) {
      setState(() {
        myPosition = LatLng(value.latitude, value.longitude);
      });
    });
    return Scaffold(
        appBar: AppBar(title: const Text("Nouveau Tweet"),),
        floatingActionButton: FloatingActionButton(
          child: Icon(Icons.location_on_rounded),
          onPressed: ()=>_determinePosition().then((value) {

              myPosition = LatLng(value.latitude, value.longitude);
            controller.move(myPosition, 12);
          }),
        ),
        body: Form(
          child: Column(
            children: [
              TextFormField(
                minLines: 3,
                maxLines: 5,
                decoration: const InputDecoration(
                    hintText: "Qu'est-ce qui se passe...",
                    labelText: "Nouveau Tweet"
                ),
              ),
              fileImage != null ? Image.file(fileImage!,height: 100,) : Container(),
              Row(
                //mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  IconButton(onPressed: () async{
                    FilePickerResult? fp = await FilePicker.platform.pickFiles(type: FileType.media);
                    setState(() {
                      fileImage = fp?.files[0].path != null ? File(fp!.files[0].path!) : null;
                    });
                  }, icon: const Icon(Icons.image)),
                  IconButton(onPressed: (){
                    setState(() {
                      showMap = !showMap;
                    });
                  }, icon: const Icon(Icons.map)),
                  const Spacer(),
                  ElevatedButton.icon(onPressed: (){},
                    icon: const Hero(tag: "edit",child: Icon(Icons.edit)),
                    label: const Text("Post"),
                  )
                ],
              ),
              showMap ? Flexible(
                  child: FlutterMap(
                      mapController: controller,
                      options: MapOptions(
                        center:myPosition,// myPosition,
                        zoom: 12
                      ),
                      children: [
                        TileLayer(
                          urlTemplate: 'https://tile.openstreetmap.org/{z}/{x}/{y}.png',
                          userAgentPackageName: 'com.example.app',
                        ),
                      ]
                  )
              ) : Container()
            ],
          ),
        ),
      );
  }

  Future<Position> _determinePosition() async {
    bool serviceEnabled;
    LocationPermission permission;

    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      return Future.error('Location services are disabled.');
    }

    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        return Future.error('Location permissions are denied');
      }
    }

    if (permission == LocationPermission.deniedForever) {
      return Future.error(
          'Location permissions are permanently denied, we cannot request permissions.');
    }
    return await Geolocator.getCurrentPosition();
  }
}
