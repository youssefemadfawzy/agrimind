import 'package:flutter_bloc/flutter_bloc.dart' show Cubit;

class OnboardingCubit extends Cubit<int> {
  OnboardingCubit() : super(0);

  void changePage(int index) => emit(index);

  void nextPage() {
    if (state < 2) {
      emit(state + 1);
    }
  }

  void skip() {
    emit(2);
  }
  bool isLastPage() => state == 2;
}