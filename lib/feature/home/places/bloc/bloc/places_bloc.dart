import 'package:bloc/bloc.dart';
import 'package:career_sphere/common/response/error_response.dart';
import 'package:career_sphere/feature/home/places/model/res/places_model.dart';
import 'package:career_sphere/feature/home/places/repo/place_repo.dart';
import 'package:career_sphere/feature/home/places/view/places.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

part 'places_event.dart';
part 'places_state.dart';

class PlacesBloc extends Bloc<PlacesEvent, PlacesState> {
  PlacesRepo placesRepo;
  // int page = 1;
  // bool isFetching = false;
  var newPlaces;
  PlacesBloc(this.placesRepo) : super(PlacesInitial()) {
    on<PlacesEvent>((event, emit) {});

    on<FetchPlacesEvent>((event, emit) async {
      // if (isFetching) return;

      // isFetching = true;
      try {
        if (state is! PlaceLoadedState) {
          emit(PlaceLoadingState());
        }
        newPlaces = await placesRepo.getPlaces(page: event.page);
        if (state is PlaceLoadedState) {
          // final currentState = state as PlaceLoadedState;
          emit(PlaceLoadedState(favorites: {}, place: newPlaces));
        } else {
          emit(PlaceLoadedState(favorites: {}, place: newPlaces));
        }
      } catch (e) {
        emit(PlaceErrorState(error: e.toString()));
      }
      // finally {
      //   isFetching = false;
      // }
    });

    // on<GetPlaceEvent>((event, emit) async {
    //   emit(PlaceLoadingState());
    //   try {
    //     var place = await placesRepo.getPlaces();

    //     emit(PlaceLoadedState(place: place));
    //   } on ErrorResponseModel catch (error) {
    //     emit(PlaceErrorState(error: error.message));
    //   } catch (e) {
    //     emit(PlaceErrorState(error: "An unexpected error occurred"));
    //   }
    // });

    on<ToggleFavoriteEvent>((event, emit) async {
      {
        if (state is PlaceLoadedState) {
          final currentState = state as PlaceLoadedState;

          // Copy current favorites and toggle the place's favorite state
          final updatedFavorites = Set<Cart>.from(currentState.favorites);

          // Check if the Cart object is already in favorites
          if (updatedFavorites.contains(event.cart)) {
            updatedFavorites
                .remove(event.cart); // Remove if already in favorites
          } else {
            updatedFavorites.add(event.cart); // Add if not in favorites
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
