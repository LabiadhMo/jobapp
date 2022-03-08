import 'dart:async';
import 'dart:convert';

import 'package:bloc/bloc.dart';
import 'package:flutter/services.dart';
import 'package:job/core/models/offers.dart';
import 'package:job/feature/home/bloc/home_events.dart';
import 'package:job/feature/home/bloc/home_state.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  HomeBloc() : super(InitialState());
  HomeState get initialState => InitialState();

  @override
  Stream<HomeState> mapEventToState(
    HomeEvent event,
  ) async* {
    if (event is GetDataEvent) {
      yield* _mapGetDataEventToState();
    }
  }

  Stream<HomeState> _mapGetDataEventToState() async* {
    yield LoadingData();
    try {
      final String response = await rootBundle.loadString('assets/data.json');
      final data = await json.decode(response);
      final jobOffers = JobOffers.fromJson(data);
      yield DataLoaded(jobOffers);
    } catch (e) {
      yield DataLoadingFailure('Failed to get data');
    }
  }
}
