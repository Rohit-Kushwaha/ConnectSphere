import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';

part 'menu_bloc_event.dart';
part 'menu_bloc_state.dart';

class MenuBloc extends Bloc<MenuEvent, MenuState> {
  MenuBloc()
      : super(MenuState(
          scaffoldKey: GlobalKey<ScaffoldState>(),
        )) {
    on<OpenDrawerEvent>(_onOpenDrawerEvent);
  }

  void _onOpenDrawerEvent(OpenDrawerEvent event, Emitter<MenuState> emit) {
    final scaffoldKey = state.scaffoldKey;
    if (!scaffoldKey.currentState!.isDrawerOpen) {
      scaffoldKey.currentState!.openDrawer();
    }
  }
}
