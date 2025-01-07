part of 'item_bloc.dart';

sealed class ItemEvent extends Equatable {
  const ItemEvent();

  @override
  List<Object> get props => [];
}

class ItemsEvent extends ItemEvent {}

class LoadMoreItemsEvent extends ItemEvent {}
