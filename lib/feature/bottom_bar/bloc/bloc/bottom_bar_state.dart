part of 'bottom_bar_bloc.dart';

sealed class BottomBarState extends Equatable {
  const BottomBarState();
  
  @override
  List<Object> get props => [];
}

class BottomBarInitial extends BottomBarState {}

class BottomBarStateChanged extends BottomBarState{
 final int selectedIndex;

 const BottomBarStateChanged({required this.selectedIndex});
  @override
  List<Object> get props => [selectedIndex];
}