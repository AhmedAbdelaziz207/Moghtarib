
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart' show Cubit;
import 'package:mo3tarib/core/di/di.dart';
import '../../../core/network/api_error_handler.dart';
import '../../../core/network/api_service.dart';
import 'otp_state.dart';

class OtpCubit extends Cubit<OtpState> {
  OtpCubit() : super(OtpInitialState());
  TextEditingController otpController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  final apiService = getIt<ApiService>();
  int? code;

  sendEmailOTP() async {
    emit(OtpSentLoading());
    try {
      final int response = await apiService.sendEmailOTP(emailController.text);
      code = response;
      emit(OtpSentSuccess(code: response));
    } catch (e) {
      final errorMessage = ApiErrorHandler.handle(e).getErrorsMessage();
      emit(OtpErrorState(errorMessage.toString()));
    }
  }

  verifyEmailOTP(code, inputCode) async {
    emit(OtpLoadingState());
    if (code.toString() == inputCode) {
      emit(OtpSuccessState());
    } else {
      emit(OtpErrorState(" كود التحقق غير صحيح"));
    }
  }

  @override
  Future<void> close() {
    otpController.dispose();
    return super.close();
  }
}
