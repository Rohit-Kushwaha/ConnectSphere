import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'bottom_bar_event.dart';
part 'bottom_bar_state.dart';

class BottomBarBloc extends Bloc<BottomBarEvent, BottomBarState> {
  BottomBarBloc() : super(BottomBarStateChanged(selectedIndex: 0)) {
    on<BottomBarEvent>((event, emit) {});

    on<ChangeTabEvent>((event, emit) {
      emit(BottomBarStateChanged(selectedIndex: event.selectedIndex));
    });
  }
}
