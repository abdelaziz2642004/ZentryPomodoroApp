class ProfileStates {}

class ProfileInitialState extends ProfileStates {}

class ProfileLoadingState extends ProfileStates {}

class ProfileSuccessState extends ProfileStates {}

class ProfileErrorState extends ProfileStates {
  final String error;
  ProfileErrorState(this.error);
}

class FullNameError extends ProfileStates {
  final String error;
  FullNameError(this.error);
}

class FullNameSuccess extends ProfileStates {}
