import 'package:dio/dio.dart';
import 'package:elie_expert/Database/API.dart';
import 'package:elie_expert/Database/Locator.dart';
import 'package:elie_expert/Utils/Colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_sms/flutter_sms.dart';
import 'package:geocoding/geocoding.dart';
import 'package:top_snackbar_flutter/custom_snack_bar.dart';
import 'package:top_snackbar_flutter/top_snack_bar.dart';

class SOSpage extends StatefulWidget {
  const SOSpage({Key? key}) : super(key: key);

  @override
  State<SOSpage> createState() => _SOSpageState();
}

class _SOSpageState extends State<SOSpage> {
  @override
  Widget build(BuildContext context) {
    void _sendSMS(String message, List<String> recipents) async {
      String _result = await sendSMS(
        message: message,
        recipients: recipents,
        sendDirect: true,
      ).catchError((onError) {
        print(onError);
      });
      print(_result);
    }

    Future<Placemark> _getLocation(double latitude, double longitude) async {
      // debugPrint('location: ${position.latitude}');
      List<Placemark> addresses =
          await placemarkFromCoordinates(latitude, longitude);

      var first = addresses.first;
      // print("${first.name} : ${first..administrativeArea}");
      return first;
    }

    return Container(
      color: midBlack,
      child: Center(
        child: Column(
          children: [
            SizedBox(
              height: 20,
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                children: [
                  Text(
                    'Are You In Emergency',
                    style: sosHeadingTextStyle(),
                  ),
                ],
              ),
            ),
            Expanded(
              child: Container(
                width: double.infinity,
                child: Center(
                  child: GestureDetector(
                    onTap: () async {
                      //overlay with SOS options

                      var name =
                          await API().getExpertByPhone(getItUserIn.userPhone);
                      await Dio().post(
                        '$baseUrl/add_sos',
                        data: {
                          "orderId": getItUserIn.userPhone,
                          "sosMessage":
                              "${name!.name} needs help! Phone Number: ${name.phone}",
                          "date_time": DateTime.now().toString()
                        },
                      );

                      showTopSnackBar(
                          context,
                          CustomSnackBar.info(
                            backgroundColor: highLcolor,
                            message:
                                "${name.name}'s SOS has been sent to the office",
                          ),
                          displayDuration: Duration(milliseconds: 500));

                      double lat =
                          double.parse(name.lastLocation?.latitude ?? "0.0");
                      double long =
                          double.parse(name.lastLocation?.longitude ?? "0.0");

                      Placemark locationData = await _getLocation(lat, long);

                      String message =
                          '${name.name} needs help! Phone Number: ${name.phone}, At location: ${locationData.name}, ${locationData.subAdministrativeArea}, ${locationData.administrativeArea}, ${locationData.postalCode}';

                      _sendSMS(message, ['9833275073']);
                    },
                    child: Image.asset(
                      'assets/SOS.png',
                      fit: BoxFit.fill,
                    ),
                  ),
                ),
              ),
            ),
            // Container(
            //   margin: EdgeInsets.all(8),
            //   decoration: BoxDecoration(borderRadius: BorderRadius.circular(12), color: Colors.white),
            //   child: ListTile(
            //     leading: CircleAvatar(),
            //     title: Text('Upcoming Order'),
            //     trailing: Text('12.05 PM'),
            //   ),
            // )
          ],
        ),
      ),
    );
  }
}

sosHeadingTextStyle() => TextStyle(
    color: highLcolorLight, fontSize: 25, fontWeight: FontWeight.bold);
sosBottomTextStyle() =>
    TextStyle(color: dimGrey, fontSize: 18, fontWeight: FontWeight.bold);
sosAppbarTextStyle() => TextStyle(
      color: dimGrey,
      fontSize: 18,
    );

// showMaterialModalBottomSheet(
//   context: context,
//   builder: (context) => SingleChildScrollView(
//     child: Column(
//       children: [
//         Text(
//           "What's your emergency",
//           style: sosBottomTextStyle(),
//         ),
//         ListTile(title: Text('Stuck in traffic')),
//         ListTile(title: Text('Getting late')),
//         ListTile(title: Text('Call admin')),
//         ListTile(title: Text('Not able to go')),
//       ],
//     ),
//   ),
// );
