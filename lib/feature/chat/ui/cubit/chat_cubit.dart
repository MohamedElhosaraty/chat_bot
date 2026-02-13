import 'package:chat_bot/feature/chat/data/model/chat_model.dart';
import 'package:chat_bot/feature/chat/domain/chat_repo.dart';
import 'package:flutter_bloc/flutter_bloc.dart';


part 'chat_state.dart';

class ChatCubit extends Cubit<ChatState> {
  ChatCubit(this.chatRepo) : super(ChatInitial());

  final ChatRepo chatRepo;

  Future<void> sendMessage({required List<ChatModel> messages}) async {
    emit(ChatLoading());
    try {
      final response = await chatRepo.sendMessage(messages: messages);
      emit(ChatSuccess(response));
    } catch (e) {
      emit(ChatFailure( errorMessage: e.toString()));
    }
  }
}
