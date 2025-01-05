part of 'bottom_bar_bloc.dart';

sealed class BottomBarEvent extends Equatable {
  const BottomBarEvent();

  @override
  List<Object> get props => [];
}

class ChangeTabEvent extends BottomBarEvent {
  final int selectedIndex;
  const ChangeTabEvent({required this.selectedIndex});

  @override
  List<Object> get props => [selectedIndex];
}
