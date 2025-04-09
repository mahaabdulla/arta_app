import 'package:arta_app/feature/data/models/commint/commint.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'commints_state.dart';

class CommintsCubit extends Cubit<CommintsState> {
  CommintsCubit() : super(CommintsInitial());
}
