import 'package:elie_expert/Database/API.dart';
import 'package:elie_expert/Database/Order.dart';
import 'package:elie_expert/Database/Service.dart';
import 'package:elie_expert/Screens/OrderDetailPage/OrderDetailPage.dart';
import 'package:elie_expert/Utils/Colors.dart';
import 'package:elie_expert/Utils/CustomButtons.dart';
import 'package:flutter/material.dart';
import 'package:geocoding/geocoding.dart';
import 'package:maps_launcher/maps_launcher.dart';

//ignore: must_be_immutable
class OrderCard extends StatefulWidget {
  OrderCard({
    Key? key,
    required this.data,
  });
  Order data;

  @override
  State<OrderCard> createState() => _OrderCardState();
}

class _OrderCardState extends State<OrderCard> {
  late Services service;
  bool loading = false;
  getService() async {
    service = await API().getServiceByID(widget.data.serviceId);
    print(service.name);
    loading = true;
    setState(() {});
  }

  @override
  void initState() {
    getService();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.all(6),
      padding: EdgeInsets.all(8),
      height: 220,
      decoration: BoxDecoration(
        color: Color(0xff0F0F0F),
        borderRadius: BorderRadius.all(Radius.circular(16)),
        border: Border.all(
          color: highLcolorLight,
        ),
      ),
      child: loading
          ? Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Container(
                      height: 100,
                      width: 100,
                      decoration: BoxDecoration(
                        image: DecorationImage(
                          fit: BoxFit.contain,
                          image: NetworkImage(
                            '$baseUrl/getServiceImageByID/${widget.data.serviceId}/0',
                          ),
                        ),
                        borderRadius: BorderRadius.all(
                          Radius.circular(16),
                        ),
                      ),
                    ),
                    Expanded(
                      child: Padding(
                        padding: const EdgeInsets.only(left: 10),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            RichText(
                              text: TextSpan(
                                children: [
                                  TextSpan(
                                    text: 'Service: ',
                                    style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 12,
                                      color: Colors.white,
                                    ),
                                  ),
                                  TextSpan(
                                    text: service.name,
                                    style: TextStyle(
                                      fontSize: 12,
                                      color: Colors.white,
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                  )
                                ],
                              ),
                            ),
                            RichText(
                              text: TextSpan(
                                children: [
                                  TextSpan(
                                    text: 'On: ',
                                    style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 12,
                                      color: Colors.white,
                                    ),
                                  ),
                                  TextSpan(
                                    text: widget.data.date,
                                    style: TextStyle(
                                      fontSize: 12,
                                      color: Colors.white,
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                  )
                                ],
                              ),
                            ),
                            RichText(
                              text: TextSpan(
                                children: [
                                  TextSpan(
                                    text: 'From: ',
                                    style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 12,
                                      color: Colors.white,
                                    ),
                                  ),
                                  TextSpan(
                                    text: widget.data.time,
                                    style: TextStyle(
                                      fontSize: 12,
                                      color: Colors.white,
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                  )
                                ],
                              ),
                            ),
                            RichText(
                              text: TextSpan(
                                children: [
                                  TextSpan(
                                    text: 'Duration: ',
                                    style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 12,
                                      color: Colors.white,
                                    ),
                                  ),
                                  TextSpan(
                                    text: "${service.duration}",
                                    style: TextStyle(
                                      fontSize: 12,
                                      color: Colors.white,
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                  )
                                ],
                              ),
                            ),
                            RichText(
                              text: TextSpan(
                                children: [
                                  TextSpan(
                                    text: 'At: ',
                                    style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 12,
                                      color: Colors.white,
                                    ),
                                  ),
                                  TextSpan(
                                    text: widget.data.location,
                                    style: TextStyle(
                                      fontSize: 12,
                                      color: Colors.white,
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                  )
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: 10,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Flexible(
                      child: BackgroundImageButton(
                        onPress: () async {
                          var address =
                              await locationFromAddress(widget.data.location);

                          double lat = address[0].latitude;
                          double long = address[0].longitude;
                          MapsLauncher.launchCoordinates(
                            lat,
                            long,
                          );
                        },
                        title: 'Get Location',
                      ),
                    ),
                    SizedBox(
                      width: 5,
                    ),
                    Flexible(
                      child: BorderRadiusButton(
                        onPress: () async {
                          var address = await locationFromAddress(
                            widget.data.location,
                          );

                          double lat = address[0].latitude;
                          double long = address[0].longitude;

                          Navigator.push(
                            (context),
                            MaterialPageRoute(
                              builder: (context) => OrderDetailPage(
                                order: widget.data,
                                service: service,
                                lat: lat,
                                long: long,
                              ),
                            ),
                          );
                        },
                        title: 'View Details',
                      ),
                    )
                  ],
                )
              ],
            )
          : Center(
              child: CircularProgressIndicator(
              color: highLcolor,
            )),
    );
  }
}
