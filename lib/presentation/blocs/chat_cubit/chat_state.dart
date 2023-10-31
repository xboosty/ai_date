part of 'chat_cubit.dart';

enum ChatStatus { initial, isLoading, sending, sent, recived, error }

enum ChatType { messageType, audioType }

class ChatState extends Equatable {
  const ChatState({required this.status, required this.type, this.message});

  final ChatStatus status;
  final ChatType type;
  final String? message;

  @override
  List<Object?> get props => [status, type, message];
}
