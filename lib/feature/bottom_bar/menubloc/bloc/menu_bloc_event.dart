part of 'menu_bloc_bloc.dart';

// sealed class MenuBlocEvent extends Equatable {
//   const MenuBlocEvent();

//   @override
//   List<Object> get props => [];
// }

abstract class MenuEvent {}

class OpenDrawerEvent extends MenuEvent {}