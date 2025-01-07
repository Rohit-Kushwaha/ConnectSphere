part of 'item_bloc.dart';

sealed class ItemState extends Equatable {
  const ItemState();

  @override
  List<Object> get props => [];
}

final class ItemInitial extends ItemState {}

final class ItemLoadingState extends ItemState {}

class ItemSuccessState extends ItemState {
  final ItemsResponse itemsResponse;
  final int currentPage;
  final bool hasMoreItems;

  const ItemSuccessState({
    required this.itemsResponse,
    this.currentPage = 1, // Default page is 1
    this.hasMoreItems = true,
  });

  @override
  List<Object> get props => [itemsResponse, currentPage, hasMoreItems];
}

final class ItemErrorState extends ItemState {
  final String error;
  const ItemErrorState({required this.error});
}

// class NoMoreItemState extends ItemState {

// }
// final class ItemLoadingMoreState extends ItemState {
//   final List<Items> items;
//   const ItemLoadingMoreState({required this.items});
// }
