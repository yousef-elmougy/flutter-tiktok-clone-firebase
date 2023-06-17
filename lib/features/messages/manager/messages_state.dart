part of 'messages_cubit.dart';

@immutable
abstract class MessagesState {
  const MessagesState();
}

class MessagesInitial extends MessagesState {
  const MessagesInitial();
}

/// Get All Users
class GetAllUsersLoading extends MessagesState {
  const GetAllUsersLoading();
}

class GetAllUsersSuccess extends MessagesState {}

class GetAllUsersError extends MessagesState {
  final String error;
  const GetAllUsersError(this.error);
}

