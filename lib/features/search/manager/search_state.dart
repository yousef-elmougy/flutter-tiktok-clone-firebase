part of 'search_cubit.dart';

@immutable
abstract class SearchState {
  const SearchState();
}

class SearchInitial extends SearchState {
  const SearchInitial();
}

class SearchUsersLoading extends SearchState {
  const SearchUsersLoading();
}

class SearchUsersSuccess extends SearchState {}

class SearchUsersError extends SearchState {
  final String error;
  const SearchUsersError(this.error);
}

class ClearUsers extends SearchState {}
