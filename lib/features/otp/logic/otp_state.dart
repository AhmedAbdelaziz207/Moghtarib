sealed class OtpState {}

class OtpInitialState extends OtpState {}

class OtpLoadingState extends OtpState {}

class OtpErrorState extends OtpState {
  final String message;

  OtpErrorState(this.message);
}

class OtpSuccessState extends OtpState {}

class OtpSentSuccess extends OtpState {
  final int code;

  OtpSentSuccess({required this.code});
}

class OtpSentFailure extends OtpState {
  final String? message;

  OtpSentFailure({this.message});
}

class OtpSentLoading extends OtpState {}
