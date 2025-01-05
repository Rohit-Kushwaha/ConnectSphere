part of 'places_bloc.dart';

sealed class PlacesState  {
  const PlacesState();

  // @override
  // List<Object> get props => [];
}

final class PlacesInitial extends PlacesState {}

class PlaceLoadingState extends PlacesState {}

class PlaceLoadedState extends PlacesState {
  final PlaceResponseModel place;
  final Set<Cart> favorites; // A set to store IDs or unique names of favorite places

  const PlaceLoadedState({required this.place, required this.favorites});
}

class PlaceErrorState extends PlacesState {
  final String error;
  const PlaceErrorState({required this.error});
}

