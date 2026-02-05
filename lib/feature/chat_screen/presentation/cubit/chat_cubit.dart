
import 'package:dartz/dartz.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/error/failures.dart';
import '../../domain/entity/chat_entity.dart';
import '../../domain/usecase/chat_usecase.dart';

part 'chat_state.dart';

class ChatCubit extends Cubit<ChatState> {
  ChatCubit(this.sendMessageUseCase) : super(ChatInitial());

  final SendMessageUseCase sendMessageUseCase;

  final List<ChatEntity> messages = [];

  void sendMessage(String text) async {
    final userMessage = ChatEntity(text: text, isUser: true);
    messages.add(userMessage);
    emit(ChatSuccess(List.from(messages)));
    emit(ChatLoading());

    final Either<Failures, ChatEntity> result =
    await sendMessageUseCase(messages);

    result.fold(
          (failure) => emit(ChatError(failure.error),),
          (reply) {
        messages.add(reply);
        emit(ChatSuccess(List.from(messages)));
      },
    );
  }
}
