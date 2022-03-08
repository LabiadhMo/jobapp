import 'package:job/core/models/offers.dart';

abstract class HomeState {
  const HomeState();
}

class InitialState extends HomeState {}

class LoadingData extends HomeState {}

class DataLoaded extends HomeState {
  final JobOffers jobOffers;

  DataLoaded(this.jobOffers);
}

class DataLoadingFailure extends HomeState {
  final String message;

  DataLoadingFailure(this.message);
}
