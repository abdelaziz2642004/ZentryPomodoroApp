class AccountStates {}

class accountInitialState extends AccountStates {}

class accountLoadingState extends AccountStates {}

class PasswordSuccess extends AccountStates {}

class SameOldPassword extends AccountStates {}

class PasswordError extends AccountStates {
  final String error;
  PasswordError(this.error);
}

class UserDeletionSuccess extends AccountStates {}

class UserDeletionError extends AccountStates {
  final String error;
  UserDeletionError(this.error);
}
