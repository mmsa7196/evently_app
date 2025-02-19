import 'package:flutter/material.dart';
import 'package:geocode/geocode.dart';
class EventLocationCard extends StatefulWidget {
  final double latitude;
  final double longitude;


  EventLocationCard({ required this.latitude, required this.longitude, super.key});

  @override
  State<EventLocationCard> createState() => _EventLocationCardState();
}

class _EventLocationCardState extends State<EventLocationCard> {
  String locationMessage = "";
  bool _isLoading = true;
  @override
  void initState() {
    super.initState();
    _getLocation();
  }

  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(8),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: Theme.of(context).primaryColor, width: 2) ,
      ),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: Theme.of(context).primaryColor,
              borderRadius: BorderRadius.circular(8),
            ),
            child: Icon(Icons.gps_fixed, color: Theme.of(context).scaffoldBackgroundColor,size: 32,),
          ),
          const SizedBox(width: 8,),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [Text(

                  locationMessage, style: Theme.of(context).textTheme.titleSmall),
              ],
            ),
          ),
        ],

      ),
    );
  }

  void _getLocation() async {
    // Set the loading flag to true to show loading state
    setState(() {
      locationMessage = "جارٍ إحضار الموقع...";
      _isLoading = true;
    });

    try {
      // Fetch the address using the provided latitude and longitude
      final response = await GeoCode().reverseGeocoding(
        latitude: widget.latitude,
        longitude: widget.longitude,
      );

      // Extract city and country from the response while handling null values gracefully
      final city = response.city ?? 'مدينة غير معروفة';
      final country = response.countryName ?? 'بلد غير معروف';

      // Update the location message with the fetched address
      locationMessage = '$city, $country';
    } catch (e) {
      // Handle any exceptions that might occur during the API call
      locationMessage = "لم يتم العثور على الموقع";
    } finally {
      // Set the loading flag to false to hide loading state
      setState(() {
        _isLoading = false;
      });
    }
  }


}
