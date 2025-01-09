part of 'places_bloc.dart';

sealed class PlacesEvent  {
  const PlacesEvent();

  // @override
  // List<Object> get props => [];
}

class GetPlaceEvent extends PlacesEvent {}

class FetchPlacesEvent extends PlacesEvent {
  final int page;
  const FetchPlacesEvent({required this.page});
}

class ToggleFavoriteEvent extends PlacesEvent {
  final Cart cart; // Unique identifier for the cart
  const ToggleFavoriteEvent({required this.cart});
}
