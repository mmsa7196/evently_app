import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:provider/provider.dart';
import 'package:todo_c13_sun/providers/create_events_provider.dart';

class PickerLocationScreen extends StatefulWidget {
  final CreateEventsProvider provider;
  static const String routeName="PickerLocationScreen";
  const PickerLocationScreen({required this.provider, super.key});

  @override
  State<PickerLocationScreen> createState() => _PickerLocationScreenState();
}

class _PickerLocationScreenState extends State<PickerLocationScreen> {

  late CreateEventsProvider provider=widget.provider;
  @override
  void initState() {
    super.initState();
    provider.getLocation();
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider.value(
      value: provider,
      child: Consumer<CreateEventsProvider>
        (builder: (context, value, child) =>Scaffold(
        body:Column(
          children: [
            Expanded(child: GoogleMap(
              onTap: (location) {
                provider.changeLocation(location);
                Navigator.pop(context);
              },
              initialCameraPosition: provider.cameraPosition,
              mapType: MapType.normal,
              onMapCreated: (mapController) {
                provider.mapController = mapController;
              },
              markers: provider.markers,
            ),
            ),
            Container(
              padding: const EdgeInsets.all(16),
              decoration: const BoxDecoration(
                  color: Color(0xFF5669FF)
              ),
              alignment: Alignment.center,
              width: double.infinity,
              child:
              Text( context.tr('Tap on Location To Select'),
                style: const TextStyle(fontSize: 20,fontWeight: FontWeight.bold,color: Colors.white,),
              ),
                ),
          ],
        ) ,
      ),
      
      ),
    );
  }
}
