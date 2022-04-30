import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'pix_state.dart';

class PixCubit extends Cubit<PixState> {
  PixCubit() : super(PixInitial());
}
