import 'package:bloc/bloc.dart';
import 'package:career_sphere/common/response/error_response.dart';
import 'package:career_sphere/feature/home/items/model/req/item_res.dart';
import 'package:career_sphere/feature/home/items/repo/items_repo.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

part 'item_event.dart';
part 'item_state.dart';

class ItemBloc extends Bloc<ItemEvent, ItemState> {
  final ItemsRepoImpl itemsRepoImpl;
  ItemBloc(this.itemsRepoImpl) : super(ItemInitial()) {
    on<ItemEvent>((event, emit) {});

    on<ItemsEvent>((event, emit) async {
      try {
        emit(ItemLoadingState());
        final itemsResponse = await itemsRepoImpl.getItems();
        emit(ItemSuccessState(itemsResponse: itemsResponse));
      } on ErrorResponseModel catch (error) {
        emit(ItemErrorState(error: error.message));
      } catch (e) {
        emit(ItemErrorState(error: "An unexpected error"));
      }
    });

    on<LoadMoreItemsEvent>((event, emit) async {
      // if (state is ItemLoadingMoreState) return;

      final currentState = state;
      if (currentState is ItemSuccessState) {
        try {
          // emit(ItemLoadingMoreState());
          // Emit a temporary loading state without affecting the current list
          // emit(ItemLoadingMoreState(items: currentState.itemsResponse.items!));
          // debugPrint("Loading more items...");

          // Get the current page from state or start from 1
          final currentPage = currentState.currentPage;

          // Fetch additional items for the next page
          final newItemsResponse = await itemsRepoImpl.getItemsPage(
            limit: 30,
            page: currentPage + 1,
          );
          debugPrint("Fetched new items: ${newItemsResponse.items?.length}");

          // Check if new items are fetched
          if (newItemsResponse.items != null &&
              newItemsResponse.items!.isNotEmpty) {
            // Combine old and new items
            final List<Items> updatedItems =
                List.from(currentState.itemsResponse.items!)
                  ..addAll(newItemsResponse.items!);

            debugPrint("Updated items length: ${updatedItems.length}");

            // Emit the updated state with new items
            emit(ItemSuccessState(
              itemsResponse: ItemsResponse(
                status: currentState.itemsResponse.status,
                result: currentState.itemsResponse.result,
                items: updatedItems, // Merge old and new items
              ),
              currentPage: currentPage + 1, // Increment the page
              hasMoreItems: true,
            ));

            debugPrint("ItemSuccessState emitted with updated items.");
          } else {
            // No new items fetched; stop further loading
            debugPrint("No new items found. Reached end of data.");
            // emit(NoMoreItemState());
            // emit(currentState);
            emit(ItemSuccessState(
              itemsResponse: currentState.itemsResponse,
              currentPage: currentPage, // Keep the current page
              hasMoreItems: false,
            ));
          }
        } catch (error) {
          // Handle errors and restore the previous state
          debugPrint("Error loading more items: $error");
          emit(ItemErrorState(error: error.toString()));
          emit(currentState); // Restore the previous state
        }
      } else {
        debugPrint(
            "Current state is not ItemSuccessState; cannot load more items.");
      }
    });
  }
}
