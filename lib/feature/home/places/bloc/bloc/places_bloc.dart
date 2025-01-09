import 'package:bloc/bloc.dart';
import 'package:career_sphere/data/local/hive/model/wishlist_model.dart';
import 'package:career_sphere/feature/home/places/model/res/places_model.dart';
import 'package:career_sphere/feature/home/places/repo/place_repo.dart';
import 'package:career_sphere/feature/home/places/view/places.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';

part 'places_event.dart';
part 'places_state.dart';

class PlacesBloc extends Bloc<PlacesEvent, PlacesState> {
  PlacesRepo placesRepo;

  PlacesBloc(this.placesRepo) : super(PlacesInitial()) {
    on<PlacesEvent>((event, emit) {});

    on<FetchPlacesEvent>((event, emit) async {
      try {
        if (state is! PlaceLoadedState) {
          emit(PlaceLoadingState());
        }
        final newPlaces = await placesRepo.getPlaces(page: event.page);

        // Load favorites from Hive
        final cartBox = await Hive.openBox<WishlistModel>('wishlist');
        final favorites = cartBox.values
            .map((wishlistItem) => Cart(
                  id: wishlistItem.id.toString(),
                  title: wishlistItem.title.toString(),
                  location: wishlistItem.location.toString(),
                ))
            .toSet();
        emit(PlaceLoadedState(favorites: favorites, place: newPlaces));
      } catch (e) {
        emit(PlaceErrorState(error: e.toString()));
      }
    });

    on<ToggleFavoriteEvent>((event, emit) async {
      final cartBox = await Hive.openBox<WishlistModel>('wishlist');

      {
        if (state is PlaceLoadedState) {
          final currentState = state as PlaceLoadedState;

          // Copy current favorites and toggle the place's favorite state
          final updatedFavorites = Set<Cart>.from(currentState.favorites);

          // Check if the Cart object is already in favorites
          if (updatedFavorites.contains(event.cart)) {
            updatedFavorites
                .remove(event.cart); // Remove if already in favorites
            // Remove from Hive
            final cartToRemove = cartBox.values.firstWhere(
              (cart) => cart.id == event.cart.id,
            );
            await cartBox.delete(cartToRemove.key);
          } else {
            updatedFavorites.add(event.cart); // Add if not in favorites
            // Add to Hive

            await cartBox.add(WishlistModel(
              id: event.cart.id,
              title: event.cart.title,
              location: event.cart.location,
            ));
          }

          debugPrint(updatedFavorites.toString());

          // Emit updated state with updated favorites
          emit(PlaceLoadedState(
            place: currentState.place,
            favorites: updatedFavorites,
          ));
        }
      }
    });
  }
}
