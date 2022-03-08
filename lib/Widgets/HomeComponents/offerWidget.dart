import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:job/Widgets/HomeComponents/jobDetails.dart';
import 'package:job/core/models/job.dart';
import 'package:job/core/models/offers.dart';
import 'package:job/core/utils/colors.dart';

class OfferWidget extends StatefulWidget {
  final Job job;
  final bool isToday;
  final JobOffers jobOffers;
  const OfferWidget({Key key, this.job, this.isToday, this.jobOffers})
      : super(key: key);

  @override
  State<OfferWidget> createState() => _OfferWidgetState();
}

class _OfferWidgetState extends State<OfferWidget> {
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Navigator.of(context).push(MaterialPageRoute(
            builder: (_) => JobDetails(
                  job: widget.job,
                  isToday: widget.isToday,
                  jobOffers: widget.jobOffers,
                )));
      },
      child: Container(
        width: MediaQuery.of(context).size.width,
        margin: const EdgeInsets.only(top: 8),
        padding: const EdgeInsets.all(8),
        decoration: BoxDecoration(
            borderRadius: const BorderRadius.all(
              Radius.circular(12),
            ),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.16),
                offset: const Offset(0.0, 3.0),
                //  spreadRadius: 7.0,
                blurRadius: 6.0,
              ),
            ],
            color: ColorConstant.whiteColor),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
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
            Text(
              widget.isToday
                  ? 'Aujourd\'hui'.toUpperCase()
                  : DateFormat('EEEE d MMM', 'FR')
                      .format(DateTime.parse(widget.job.startAt.toString())),
              textAlign: TextAlign.left,
              style: TextStyle(
                  color: widget.isToday
                      ? ColorConstant.redColor
                      : ColorConstant.greyColor,
                  fontSize: 14,
                  letterSpacing: 1,
                  fontWeight: FontWeight.w600),
            ),
            const SizedBox(
              height: 8,
            ),
            Row(
              children: [
                Expanded(
                  flex: 3,
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
                                fontWeight: FontWeight.w500),
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
                        width: 6,
                      ),
                      Expanded(
                        child: RichText(
                          textAlign: TextAlign.left,
                          text: TextSpan(
                              text: widget.job.buyPrice.toString() + '\$ / H',
                              style: TextStyle(
                                  color: ColorConstant.greyColor,
                                  fontSize: 14,
                                  fontWeight: FontWeight.w500),
                              children: [
                                TextSpan(
                                  text:
                                      ' + ${widget.job.bonus.toString()}\$ / H',
                                  style: TextStyle(
                                      color: ColorConstant.greenColor,
                                      fontSize: 14,
                                      fontWeight: FontWeight.w500),
                                )
                              ]),
                        ),
                      )
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 8.0),
                  child: Text(
                    DateTime.parse(widget.job.startAt.toString())
                            .hour
                            .toString() +
                        ':' +
                        DateTime.parse(widget.job.startAt.toString())
                            .minute
                            .toString() +
                        '-' +
                        (DateTime.parse(widget.job.endAt.toString())
                            .hour
                            .toString()) +
                        ':' +
                        (DateTime.parse(widget.job.endAt.toString())
                            .minute
                            .toString()),
                    textAlign: TextAlign.right,
                    style: TextStyle(
                        color: widget.isToday
                            ? ColorConstant.redColor
                            : ColorConstant.greyColor,
                        fontSize: 14,
                        fontWeight: FontWeight.w500),
                  ),
                )
              ],
            )
          ],
        ),
      ),
    );
  }
}
