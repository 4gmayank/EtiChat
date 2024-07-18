part of 'home_bloc.dart';

abstract class HomeEvent extends Equatable {
  const HomeEvent();
}

class FetchChatMessagesEvent extends HomeEvent {
  @override
  List<Object?> get props => [];
}

class SendChatMessagesEvent extends HomeEvent {
  const SendChatMessagesEvent(ChatMessageEntity chatMessageEntity);

  @override
  List<Object?> get props => [];
}
