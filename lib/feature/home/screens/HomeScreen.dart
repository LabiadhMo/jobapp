import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:job/core/models/job.dart';
import 'package:job/core/utils/colors.dart';
import 'package:job/feature/home/bloc/home_bloc.dart';
import 'package:job/feature/home/bloc/home_events.dart';
import 'package:job/feature/home/bloc/home_state.dart';
import '../../../Widgets/HomeComponents/offerWidget.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key key}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  List<Job> today = [];
  List<Job> aVenir = [];
  var thisInstant = DateTime.now();

  @override
  void initState() {
    super.initState();
  }

  sortOfferts(state) {
    state.jobOffers.jobs.forEach((element) {
      if (DateTime(
                  DateTime.parse(element.startAt.toString()).year,
                  DateTime.parse(element.startAt.toString()).month,
                  DateTime.parse(element.startAt.toString()).day)
              .compareTo(
            DateTime(
                DateTime.now().year, DateTime.now().month, DateTime.now().day),
          ) ==
          0) {
        if (DateTime.now().hour <
            DateTime.parse(element.startAt.toString()).hour) {
          today.add(element);
        }
      } else {
        if (DateTime.parse(element.startAt.toString())
                .compareTo(DateTime.now()) !=
            -1) {
          aVenir.add(element);
        }
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => HomeBloc()..add(GetDataEvent()),
      child: Scaffold(
        backgroundColor: ColorConstant.lightGrey,
        bottomNavigationBar: Container(
          color: ColorConstant.lightGrey,
          child: Padding(
            padding:
                const EdgeInsets.only(bottom: 20.0, left: 6, right: 6, top: 10),
            child: Container(
              decoration: BoxDecoration(
                  color: ColorConstant.whiteColor,
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.16),
                      offset: const Offset(0.0, 3.0),
                      //  spreadRadius: 7.0,
                      blurRadius: 6.0,
                    ),
                  ],
                  borderRadius: const BorderRadius.all(Radius.circular(30))),
              child: Padding(
                padding: const EdgeInsets.only(left: 4.0, right: 4),
                child: Row(
                  children: [
                    Expanded(
                      child: Container(
                        margin: const EdgeInsets.only(top: 8.0, bottom: 8),
                        decoration: BoxDecoration(
                            color: ColorConstant.blueColor,
                            borderRadius:
                                const BorderRadius.all(Radius.circular(30))),
                        child: TextFormField(
                          keyboardType: TextInputType.text,
                          style: TextStyle(
                              color: ColorConstant.whiteColor,
                              fontSize: 14,
                              fontWeight: FontWeight.w500),
                          onChanged: (String value) {},
                          cursorColor: ColorConstant.whiteColor,
                          decoration: InputDecoration(
                            border: InputBorder.none,
                            focusedBorder: InputBorder.none,
                            enabledBorder: InputBorder.none,
                            errorBorder: InputBorder.none,
                            disabledBorder: InputBorder.none,

                            prefixIcon: Icon(
                              Icons.search_outlined,
                              color: ColorConstant.whiteColor,
                            ),
                            // contentPadding: EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
                            hintText: 'Shifts offerts',
                            hintStyle: TextStyle(
                                color: ColorConstant.whiteColor,
                                fontSize: 14,
                                fontWeight: FontWeight.w500),
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(
                      width: 10,
                    ),
                    CircleAvatar(
                      backgroundColor: ColorConstant.lightGrey,
                      child: IconButton(
                        icon: Icon(
                          Icons.file_copy,
                          color: ColorConstant.greyColor,
                          size: 20,
                        ),
                        onPressed: () {},
                      ),
                    ),
                    const SizedBox(
                      width: 10,
                    ),
                    CircleAvatar(
                      backgroundColor: ColorConstant.lightGrey,
                      child: IconButton(
                        icon: Icon(
                          Icons.person,
                          color: ColorConstant.greyColor,
                          size: 20,
                        ),
                        onPressed: () {},
                      ),
                    )
                  ],
                ),
              ),
            ),
          ),
        ),
        body: BlocListener<HomeBloc, HomeState>(
          listener: (context, state) {
            if (state is DataLoaded) sortOfferts(state);
            return;
          },
          child: BlocBuilder<HomeBloc, HomeState>(builder: (context, state) {
            if (state is DataLoaded) {
              return SafeArea(
                child: SingleChildScrollView(
                  child: Padding(
                    padding:
                        const EdgeInsets.only(left: 15.0, right: 15, top: 30),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Shifts offerts',
                          textAlign: TextAlign.left,
                          style: TextStyle(
                              color: ColorConstant.blackColor,
                              fontSize: 24,
                              fontWeight: FontWeight.bold),
                        ),
                        const SizedBox(
                          height: 30,
                        ),
                        Text(
                          'Dernière minute'.toUpperCase(),
                          textAlign: TextAlign.left,
                          style: TextStyle(
                              color: ColorConstant.greyColor,
                              fontSize: 12,
                              letterSpacing: 1,
                              fontWeight: FontWeight.w500),
                        ),
                        ListView.builder(
                            physics: const ScrollPhysics(),
                            shrinkWrap: true,
                            itemCount: today.length,
                            itemBuilder: (BuildContext context, int index) {
                              return OfferWidget(
                                job: today[index],
                                jobOffers: state.jobOffers,
                                isToday: true,
                              );
                            }),
                        const SizedBox(
                          height: 30,
                        ),
                        Text(
                          'chifts à venir'.toUpperCase(),
                          textAlign: TextAlign.left,
                          style: TextStyle(
                              color: ColorConstant.greyColor,
                              fontSize: 12,
                              letterSpacing: 1,
                              fontWeight: FontWeight.w500),
                        ),
                        ListView.builder(
                            physics: const ScrollPhysics(),
                            shrinkWrap: true,
                            itemCount: aVenir.length,
                            itemBuilder: (BuildContext context, int index) {
                              return OfferWidget(
                                job: aVenir[index],
                                jobOffers: state.jobOffers,
                                isToday: false,
                              );
                            }),
                        const SizedBox(
                          height: 20,
                        )
                      ],
                    ),
                  ),
                ),
              );
            } else if (state is DataLoadingFailure)
              return Text('Error');
            else
              return CircularProgressIndicator();
          }),
        ),
      ),
    );
  }
}
