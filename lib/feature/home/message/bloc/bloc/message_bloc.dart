import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:career_sphere/common/response/error_response.dart';
import 'package:career_sphere/feature/home/message/model/req/req.dart';
import 'package:career_sphere/feature/home/message/model/res/res.dart';
import 'package:career_sphere/feature/home/message/repo/message_repo.dart';
import 'package:career_sphere/utils/deboucing.dart';
import 'package:equatable/equatable.dart';

part 'message_event.dart';
part 'message_state.dart';

class MessageBloc extends Bloc<MessageEvent, MessageState> {
  final _debouncer = Debouncer(second: 1);
  final MessageRepo messageRepo;
  MessageBloc(this.messageRepo) : super(MessageInitial()) {
    on<MessageEvent>((event, emit) {});

// Debounce the search

    on<SearchUserEvent>((event, emit) async {
      // Use a Completer to handle async operations in the debouncer
      final completer = Completer<void>();
      _debouncer.run(() async {
        emit(SearchUserWaitState());

        // Check if the search query has at least 3 characters
        if (event.name.length < 3) {
          // If less than 3 characters, emit an empty or cleared state
          return emit(SearchEmptySuccessState(searchResponseModel: []));
        }
        try {
          var searchRequestModel = SearchRequestModel(name: event.name);

          final searchResponseModel = await messageRepo.searchUser(
              searchRequestModel: searchRequestModel);
          emit(SearchSuccessState(searchResponseModel: searchResponseModel));
        } on ErrorResponseModel catch (error) {
          emit(SearchErrorState(msg: error.message));
        } catch (e) {
          emit(SearchErrorState(msg: "An unexpected errror"));
        }
      });
      // Await the Completer to ensure the handler doesn't exit early
      await completer.future;
    });
  }
}
