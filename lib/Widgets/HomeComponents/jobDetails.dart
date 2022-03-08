import 'package:flutter/material.dart';
import 'package:geocoding/geocoding.dart';
import 'package:intl/intl.dart';
import 'package:job/core/models/job.dart';
import 'package:job/core/models/offers.dart';
import 'package:job/core/utils/colors.dart';

class JobDetails extends StatefulWidget {
  final Job job;
  final JobOffers jobOffers;
  final bool isToday;
  const JobDetails({Key key, this.job, this.jobOffers, this.isToday})
      : super(key: key);

  @override
  _JobDetailsState createState() => _JobDetailsState();
}

class _JobDetailsState extends State<JobDetails> {
  String _currentAddress;
  @override
  void initState() {
    _getAddressFromLatLng();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorConstant.whiteColor,
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: ColorConstant.whiteColor,
        elevation: 0,
        leading: Padding(
          padding: const EdgeInsets.all(8.0),
          child: CircleAvatar(
            backgroundColor: ColorConstant.blackColor,
            child: IconButton(
              icon: Icon(
                Icons.arrow_back,
                color: ColorConstant.whiteColor,
              ),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ),
        ),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.only(left: 15.0, right: 15, top: 30),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                CircleAvatar(
                    radius: 40,
                    backgroundColor: ColorConstant.lightGrey,
                    backgroundImage: const AssetImage(
                      'assets/job.png',
                    )),
                const SizedBox(
                  height: 30,
                ),
                Text(
                  widget.job.company.toString(),
                  textAlign: TextAlign.left,
                  style: TextStyle(
                      color: ColorConstant.blackColor,
                      fontSize: 18,
                      fontWeight: FontWeight.bold),
                ),
                const SizedBox(
                  height: 8,
                ),
                Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    widget.isToday
                        ? 'Aujourd\'hui'.toUpperCase()
                        : DateFormat('EEEE d MMM', 'FR').format(
                            DateTime.parse(widget.job.startAt.toString())),
                    style: TextStyle(
                        color: widget.isToday
                            ? ColorConstant.redColor
                            : ColorConstant.greyColor,
                        fontSize: 14,
                        fontWeight: FontWeight.w400),
                  ),
                ),
                const SizedBox(
                  height: 8,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      flex: 4,
                      child: Row(
                        children: [
                          Expanded(
                            child: Container(
                              child: Text(
                                widget.job.postName.toString(),
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                    color: ColorConstant.greyColor,
                                    fontSize: 14,
                                    fontWeight: FontWeight.w400),
                              ),
                              padding: const EdgeInsets.all(8),
                              decoration: BoxDecoration(
                                  borderRadius: const BorderRadius.all(
                                    Radius.circular(15),
                                  ),
                                  color: ColorConstant.lightGrey),
                            ),
                          ),
                          const SizedBox(
                            width: 8,
                          ),
                          Expanded(
                            child: RichText(
                              textAlign: TextAlign.left,
                              text: TextSpan(
                                text: widget.job.buyPrice.toString() + '\$ / H',
                                style: TextStyle(
                                    color: ColorConstant.greyColor,
                                    fontSize: 14,
                                    fontWeight: FontWeight.w400),
                              ),
                            ),
                          )
                        ],
                      ),
                    ),
                    Expanded(
                      flex: 1,
                      child: Text(
                          DateTime.parse(widget.job.startAt.toString())
                                  .hour
                                  .toString() +
                              ':' +
                              DateTime.parse(widget.job.startAt.toString())
                                  .minute
                                  .toString() +
                              ':' +
                              (DateTime.parse(widget.job.endAt.toString())
                                  .hour
                                  .toString()) +
                              ':' +
                              (DateTime.parse(widget.job.endAt.toString())
                                  .minute
                                  .toString()),
                          textAlign: TextAlign.left,
                          style: TextStyle(
                              color: ColorConstant.greyColor,
                              fontSize: 14,
                              fontWeight: FontWeight.w400)),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 30,
                ),
                Row(
                  children: [
                    Container(
                      decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          border: Border.fromBorderSide(BorderSide(
                              color: ColorConstant.lightBlackColor))),
                      child: Icon(
                        Icons.location_on,
                        size: 20,
                        color: ColorConstant.lightBlackColor,
                      ),
                    ),
                    const SizedBox(
                      width: 10,
                    ),
                    Expanded(
                      child: Text(
                        _currentAddress.toString(),
                        textAlign: TextAlign.left,
                        style: TextStyle(
                            color: ColorConstant.lightBlackColor,
                            fontSize: 14,
                            fontWeight: FontWeight.w400),
                      ),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 8,
                ),
                Row(
                  children: [
                    Container(
                      decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          border: Border.fromBorderSide(BorderSide(
                              color: ColorConstant.lightBlackColor))),
                      child: Icon(
                        Icons.attach_money,
                        size: 20,
                        color: ColorConstant.lightBlackColor,
                      ),
                    ),
                    const SizedBox(
                      width: 10,
                    ),
                    Expanded(
                      child: Text(
                        'Bonus au travailleur: ' +
                            widget.job.bonus.toString() +
                            '\$ / H',
                        textAlign: TextAlign.left,
                        style: TextStyle(
                            color: ColorConstant.lightBlackColor,
                            fontSize: 14,
                            fontWeight: FontWeight.w400),
                      ),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 8,
                ),
                Row(
                  children: [
                    Container(
                      decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          border: Border.fromBorderSide(BorderSide(
                              color: ColorConstant.lightBlackColor))),
                      child: Icon(
                        Icons.pause,
                        size: 20,
                        color: ColorConstant.lightBlackColor,
                      ),
                    ),
                    const SizedBox(
                      width: 10,
                    ),
                    Expanded(
                      child: Text(
                        "Pause de 30 minutes",
                        textAlign: TextAlign.left,
                        style: TextStyle(
                            color: ColorConstant.lightBlackColor,
                            fontSize: 14,
                            fontWeight: FontWeight.w400),
                      ),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 8,
                ),
                Row(
                  children: [
                    Container(
                      decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          border: Border.fromBorderSide(BorderSide(
                              color: ColorConstant.lightBlackColor))),
                      child: const Padding(
                        padding: EdgeInsets.all(4.0),
                        child: Text(
                          'P',
                          style: TextStyle(fontSize: 15),
                        ),
                      ),
                    ),
                    const SizedBox(
                      width: 10,
                    ),
                    Expanded(
                      child: Text(
                        'Stationnement gratuit',
                        textAlign: TextAlign.left,
                        style: TextStyle(
                            color: ColorConstant.lightBlackColor,
                            fontSize: 14,
                            fontWeight: FontWeight.w400),
                      ),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 8,
                ),
                Row(
                  children: [
                    Container(
                      decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          border: Border.fromBorderSide(BorderSide(
                              color: ColorConstant.lightBlackColor))),
                      child: Icon(
                        Icons.dry_cleaning,
                        size: 20,
                        color: ColorConstant.lightBlackColor,
                      ),
                    ),
                    const SizedBox(
                      width: 10,
                    ),
                    Expanded(
                      child: Text(
                        "Pantalon noir, chemise noir",
                        textAlign: TextAlign.left,
                        style: TextStyle(
                            color: ColorConstant.lightBlackColor,
                            fontSize: 14,
                            fontWeight: FontWeight.w400),
                      ),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 20,
                ),
                Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    'RESPONSABLE',
                    textAlign: TextAlign.left,
                    style: TextStyle(
                        color: ColorConstant.greyColor,
                        fontSize: 14,
                        fontWeight: FontWeight.w400),
                  ),
                ),
                const SizedBox(
                  height: 8,
                ),
                Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      "Fisrt  Last ",
                      textAlign: TextAlign.left,
                      style: TextStyle(
                          color: ColorConstant.lightBlackColor,
                          fontSize: 14,
                          fontWeight: FontWeight.w400),
                    )),
                const SizedBox(
                  height: 50,
                ),
                SizedBox(
                  width: MediaQuery.of(context).size.width,
                  child: ElevatedButton(
                      onPressed: () {},
                      style: ButtonStyle(
                          elevation: MaterialStateProperty.all(0),
                          shape:
                              MaterialStateProperty.all<RoundedRectangleBorder>(
                                  RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(20.0),
                                      side: BorderSide.none)),
                          backgroundColor: MaterialStateProperty.all(
                              ColorConstant.blueColor)),
                      child: Padding(
                        padding: const EdgeInsets.all(12.0),
                        child: Text(
                          'Postuler',
                          style: TextStyle(
                              color: ColorConstant.whiteColor,
                              fontSize: 18,
                              fontWeight: FontWeight.w400),
                        ),
                      )),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  _getAddressFromLatLng() async {
    try {
      List<Placemark> placemarks = await placemarkFromCoordinates(
          widget.job.latitude.toDouble(), widget.job.longitude.toDouble());

      Placemark place = placemarks[0];

      setState(() {
        _currentAddress =
            "${place.locality}, ${place.postalCode}, ${place.country}";
      });
    } catch (e) {
      print(e);
    }
  }
}
