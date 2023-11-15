import 'dart:convert';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:map_launcher/map_launcher.dart';
import 'package:mapbox_gl/mapbox_gl.dart';
import 'package:photo_view/photo_view.dart';
import 'package:pollingstation/config/constant.dart';
import 'package:pollingstation/res/app_icon.dart';
import 'package:pollingstation/ui/widget/custom_text.dart';

import '../../../model/center_model.dart';

class StationDetailsScreen extends StatelessWidget {
  final Datum data;

  StationDetailsScreen({super.key, required this.data});

  @override
  Widget build(BuildContext context) {
    List<String>? stringList = [];
    if (data.image != null) {
      stringList = json.decode(data.image ?? '').cast<String>();
    }

    List<String>? attachmentList = [];
    if (data.attachment != null) {
      attachmentList = json.decode(data.attachment ?? '').cast<String>();
    }
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Details',
          style: const TextStyle(color: Colors.white),
        ),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: SingleChildScrollView(
          child: Column(
            children: [
              data.image == null
                  ? const SizedBox()
                  : CarouselSlider.builder(
                      itemCount: stringList?.length,
                      itemBuilder: (context, index, position) {
                        return InkWell(
                          child: Card(
                            color: Colors.white,
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10)),
                            shadowColor: Colors.white,
                            elevation: 10,
                            child: ClipRRect(
                                borderRadius: BorderRadius.circular(10),
                                child: CachedNetworkImage(
                                  imageUrl: imageUrl + stringList![index],
                                )),
                          ),
                          onTap: () {
                            showDialog(
                                context: context,
                                builder: (BuildContext dialogContext) {
                                  return Dialog(
                                    child: SizedBox(
                                      width: 3000 / 10,
                                      height: 2002 / 10,
                                      child: PhotoView(
                                        tightMode: true,
                                        imageProvider:
                                            CachedNetworkImageProvider(
                                                imageUrl + stringList![index]),
                                        heroAttributes: const PhotoViewHeroAttributes(tag: "Center Image"),
                                      ),
                                    ),
                                  );
                                });
                          },
                        );
                      },
                      options: CarouselOptions(
                        autoPlay: true,
                        aspectRatio: 2.0,
                        enlargeCenterPage: false,
                      )),
              Card(
                elevation: 5,
                shadowColor: Colors.white,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10)),
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    children: [
                      titleDetails('Project Name', data.name ?? ''),
                     /* titleDetails('Address', data.address ?? ''),*/
                      titleDetails('Division', data.division!.name ?? ''),
                      titleDetails('District', data.district!.name ?? ''),
                      titleDetails('Upazila', data.upazila!.name ?? ''),
                      titleDetails('Union', data.union!.name ?? ''),
                      if (data.booth != null)
                        titleDetails('Booth', data.booth ?? ''),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          data.upazilaDistance !=null ?
                          Container(
                                  padding: EdgeInsets.all(5),
                                  decoration: BoxDecoration(
                                    border: Border.all(
                                        color: Colors.green, width: 1),
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                  child: Column(
                                    children: [
                                      CustomSimpleText(
                                        text: 'Upazila Distance',
                                        fontSize: 18,
                                        color: Colors.red,
                                      ),
                                      CustomSimpleText(
                                        text: '${data.upazilaDistance} Km',
                                        fontSize: 20,
                                        color: Colors.green,
                                      ),
                                      Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.start,
                                            children: [
                                              CustomSimpleText(
                                                text: 'পাকা রাস্তা: ',
                                                fontSize: 16,
                                                color: Colors.red,
                                              ),
                                              CustomSimpleText(
                                                text: data.upPavedRoad == null
                                                    ? ''
                                                    : '${data.upPavedRoad} Km',
                                                fontSize: 14,
                                                color: Colors.green,
                                              ),
                                            ],
                                          ),
                                          Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.start,
                                            children: [
                                              CustomSimpleText(
                                                text: 'কাঁচা রাস্তা: ',
                                                fontSize: 16,
                                                color: Colors.red,
                                              ),
                                              CustomSimpleText(
                                                text: data.upDirtRoad == null
                                                    ? 'o Km'
                                                    : '${data.upDirtRoad} Km',
                                                fontSize: 14,
                                                color: Colors.green,
                                              ),
                                            ],
                                          )
                                        ],
                                      )
                                    ],
                                  ),
                                )
                              :SizedBox(),
                          data.unionDistance !=null ?
                          Container(
                            padding: EdgeInsets.all(5),
                            decoration: BoxDecoration(
                              border: Border.all(color: Colors.green, width: 1),
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: Column(
                              children: [
                                      CustomSimpleText(
                                        text: 'Union Distance',
                                        fontSize: 18,
                                        color: Colors.red,
                                      ),
                                      CustomSimpleText(
                                        text: '${data.unionDistance} Km',
                                        fontSize: 20,
                                        color: Colors.green,
                                      ),
                                      Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.start,
                                            children: [
                                              CustomSimpleText(
                                                text: 'পাকা রাস্তা: ',
                                                fontSize: 16,
                                                color: Colors.red,
                                              ),
                                              CustomSimpleText(
                                                text: data.unPavedRoad == null
                                                    ? 'o Km'
                                                    : '${data.unPavedRoad} Km',
                                                fontSize: 14,
                                                color: Colors.green,
                                              ),
                                            ],
                                          ),
                                          Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.start,
                                            children: [
                                              CustomSimpleText(
                                                text: 'কাঁচা রাস্তা: ',
                                                fontSize: 16,
                                                color: Colors.red,
                                              ),
                                              CustomSimpleText(
                                                text: data.unDirtRoad == null
                                                    ? 'o Km'
                                                    : '${data.unDirtRoad} Km',
                                                fontSize: 14,
                                                color: Colors.green,
                                              ),
                                            ],
                                          )
                                        ],
                                      )
                                    ],
                            ),
                          ):SizedBox(),
                        ],
                      ),
                      data.latitude == null || data.longitude == null
                          ? SizedBox()
                          : InkWell(
                              child: Container(
                                margin: EdgeInsets.symmetric(
                                    horizontal: 30, vertical: 5),
                                padding: EdgeInsets.symmetric(horizontal: 10),
                                decoration: BoxDecoration(
                                    color: Colors.white,
                                    border: Border.all(
                                        color: Colors.grey, width: 1),
                                    borderRadius: BorderRadius.circular(10)),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Icon(
                                      Icons.my_location_sharp,
                                      size: 20,
                                      color: Colors.red,
                                    ),
                                    Text(
                                      'Get Map Direction',
                                      style: TextStyle(
                                          fontSize: 16, color: Colors.green),
                                    ),
                                  ],
                                ),
                              ),
                              onTap: () async {
                                final isGoogleMapsAvailable = await MapLauncher.isMapAvailable(MapType.google);

                                if (isGoogleMapsAvailable != null && isGoogleMapsAvailable) {
                                  try {
                                    await MapLauncher.showMarker(
                                      mapType: MapType.google,
                                      coords: Coords(
                                        double.parse(data.latitude.toString()),
                                        double.parse(data.longitude.toString()),
                                      ),
                                      title: data.name ?? '',
                                    );
                                  } catch (e) {
                                    // Handle the exception, which indicates that Google Maps is not available
                                    showDialog(
                                      context: context,
                                      builder: (BuildContext context) {
                                        return AlertDialog(
                                          title: Text('Google Maps Not Found'),
                                          content: Text('Google Maps is not installed on your device. Install Google map to see station location'),
                                          actions: <Widget>[
                                            TextButton(
                                              child: Text('OK'),
                                              onPressed: () {
                                                Navigator.of(context).pop();
                                              },
                                            ),
                                          ],
                                        );
                                      },
                                    );
                                  }
                                }

                               /* await dotenv.load(fileName: "assets/.env");

                                showMapDialog(context, data);*/
                              },
                            )
                    ],
                  ),
                ),
              ),

              data.male == null && data.female == null ? SizedBox.shrink() :

              Container(
                width: MediaQuery.of(context).size.width,
                child: Card(
                  elevation: 5,
                  shadowColor: Colors.white,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10)),
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      children: [
                        CustomSimpleText(
                          text: 'Total Votar',
                          fontSize: 22,
                          color: Colors.red,
                        ),
                        CustomSimpleText(
                          text:
                              '${int.parse(data.male ?? '0') + int.parse(data.female ?? '0')} Persons',
                          fontSize: 22,
                          color: Colors.green,
                        )
                      ],
                    ),
                  ),
                ),
              ),
              data.male == null && data.female == null ? SizedBox.shrink() :
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Expanded(
                    child: Card(
                      elevation: 5,
                      shadowColor: Colors.white,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10)),
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Column(
                          children: [
                            CustomSimpleText(
                              text: 'Male',
                              fontSize: 22,
                              color: Colors.red,
                            ),
                            CustomSimpleText(
                              text: '${data.male ?? '0'} Persons',
                              fontSize: 22,
                              color: Colors.green,
                            )
                          ],
                        ),
                      ),
                    ),
                  ),
                  Expanded(
                    child: Card(
                      elevation: 5,
                      shadowColor: Colors.white,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10)),
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Column(
                          children: [
                            CustomSimpleText(
                              text: 'Female',
                              fontSize: 22,
                              color: Colors.red,
                            ),
                            CustomSimpleText(
                              text: '${data.female ?? '0'} Persons',
                              fontSize: 22,
                              color: Colors.green,
                            )
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),

              data.category != null
                  ? Container(
                width: MediaQuery.of(context).size.width,
                child: Card(
                  elevation: 5,
                  shadowColor: Colors.white,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10)),
                  child: Padding(
                    padding: const EdgeInsets.only(
                        left: 8, right: 8, bottom: 5),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Text(
                          'Project Category',
                          style: TextStyle(
                            color: Colors.red,
                            fontSize: 18,
                          ),
                        ),
                        Text(
                          data.category!.name ?? '',
                          style: TextStyle(
                              color: Colors.green,
                              fontSize: 16,
                              height: 1.3,
                              fontWeight: FontWeight.bold
                          ),
                          textAlign: TextAlign.center,
                        ),
                      ],
                    ),
                  ),
                ),
              )
                  : SizedBox(),

              data.status != null
                  ? Container(
                width: MediaQuery.of(context).size.width,
                child: Card(
                  elevation: 5,
                  shadowColor: Colors.white,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10)),
                  child: Padding(
                    padding: const EdgeInsets.only(
                        left: 8, right: 8, bottom: 5),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Text(
                          'Project Status',
                          style: TextStyle(
                            color: Colors.red,
                            fontSize: 18,
                          ),
                        ),
                        Text(
                          data.status!,
                          style: TextStyle(
                            color: Colors.green,
                            fontSize: 16,
                            height: 1.3,
                            fontWeight: FontWeight.bold
                          ),
                          textAlign: TextAlign.center,
                        ),
                      ],
                    ),
                  ),
                ),
              )
                  : SizedBox(),
              data.description != null
                  ? Container(
                      width: MediaQuery.of(context).size.width,
                      child: Card(
                        elevation: 5,
                        shadowColor: Colors.white,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10)),
                        child: Padding(
                          padding: const EdgeInsets.only(
                              left: 8, right: 8, bottom: 5),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Text(
                                'Description',
                                style: TextStyle(
                                  color: Colors.red,
                                  fontSize: 18,
                                ),
                              ),
                              Text(
                                data.description!,
                                style: TextStyle(
                                  color: Colors.green,
                                  fontSize: 16,
                                  height: 1.3,
                                ),
                                textAlign: TextAlign.center,
                              ),
                            ],
                          ),
                        ),
                      ),
                    )
                  : SizedBox(),
            data.attachment == null
              ? const SizedBox() :
              Container(
                width: MediaQuery.of(context).size.width,
                child: Card(
                  elevation: 5,
                  shadowColor: Colors.white,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10)),
                  child: Padding(
                    padding:
                        const EdgeInsets.only(left: 8, right: 8, bottom: 5),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Text(
                          'Check Attachment',
                          style: TextStyle(
                            color: Colors.green,
                            fontSize: 18,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              data.attachment == null
                  ? const SizedBox()
                  : CarouselSlider.builder(
                      itemCount: attachmentList?.length,
                      itemBuilder: (context, index, position) {
                        return InkWell(
                          child: Card(
                            color: Colors.white,
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(3)),
                            shadowColor: Colors.green,
                            elevation: 10,
                            child: ClipRRect(
                                borderRadius: BorderRadius.circular(3),
                                child: CachedNetworkImage(
                                  imageUrl: imageUrl + attachmentList![index],
                                )),
                          ),
                          onTap: () {
                            showDialog(
                                context: context,
                                builder: (BuildContext dialogContext) {
                                  return Dialog(
                                    child: SizedBox(
                                      width: 3000 / 10,
                                      height: 2002 / 10,
                                      child: PhotoView(
                                        tightMode: true,
                                        imageProvider:
                                            CachedNetworkImageProvider(
                                                imageUrl +
                                                    attachmentList![index]),
                                        heroAttributes:
                                            const PhotoViewHeroAttributes(
                                                tag: "Center Image"),
                                      ),
                                    ),
                                  );
                                });
                          },
                        );
                      },
                      options: CarouselOptions(
                          autoPlay: false,
                          aspectRatio: 1.0,
                          enlargeCenterPage: false,
                          scrollDirection: Axis.vertical)),
            ],
          ),
        ),
      ),
    );
  }

  Widget titleDetails(String title, String details) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        CustomSimpleText(
          text: '$title: ',
          fontSize: 18,
          color: Colors.red,
          fontWeight: FontWeight.bold,
        ),
        Flexible(
          child: CustomSimpleText(
            text: details,
            fontSize: 20,
            alignment: TextAlign.start,
            color: Colors.green,
          ),
        )
      ],
    );
  }

  void showMapDialog(BuildContext context, Datum data) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        _onMapCreated(MapboxMapController controller) async {
          await controller.addSymbol(SymbolOptions(
            iconSize: 0.1,
            iconImage: AppIcon.locationMap,
            geometry: LatLng(double.parse(data.latitude!), double.parse(data.longitude!)),
            iconAnchor: "bottom",
          ));
        }

        _onStyleLoadedCallback() async {}

        return Dialog(
          insetPadding: const EdgeInsets.symmetric(vertical: 40, horizontal: 10),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                constraints: const BoxConstraints(minHeight: 50),
                decoration: BoxDecoration(
                  color: Colors.green,
                  borderRadius: const BorderRadius.only(
                    topLeft: Radius.circular(5),
                    topRight: Radius.circular(5),
                  ),
                ),
                width: MediaQuery.of(context).size.width,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(left: 16.0),
                      child: CustomSimpleText(
                        text: data.name!,
                        color: Colors.white,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(right: 16.0),
                      child: IconButton(
                        icon: Icon(Icons.close),
                        onPressed: () {
                          Navigator.of(context).pop(); // Close the dialog
                        },
                        color: Colors.white,
                      ),
                    ),
                  ],
                ),
              ),

              Container(
                constraints: const BoxConstraints(
                  minHeight: 350,
                ),
                child: data.latitude == null && data.longitude == null
                    ? Padding(
                  padding: EdgeInsets.all(16.0),
                  child: Center(
                    child: Text(
                      'Latitude and Longitude need to be initialized',
                      style: TextStyle(fontSize: 16),
                    ),
                  ),
                )
                    : SafeArea(
                  child: Stack(
                    children: [
                      SizedBox(
                        height: MediaQuery.of(context).size.height * 0.8,
                        child: MapboxMap(
                          initialCameraPosition: CameraPosition(
                            target: LatLng(double.parse(data.latitude!), double.parse(data.longitude!)),
                            zoom: 15,
                          ),
                          accessToken: dotenv.env['MAPBOX_ACCESS_TOKEN'],
                          onMapCreated: _onMapCreated,
                          myLocationEnabled: true,
                          onStyleLoadedCallback: _onStyleLoadedCallback,
                          myLocationTrackingMode: MyLocationTrackingMode.TrackingGPS,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
