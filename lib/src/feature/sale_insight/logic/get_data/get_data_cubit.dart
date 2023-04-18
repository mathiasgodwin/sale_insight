import 'package:bloc/bloc.dart';
import 'package:dio_network_exceptions/dio_network_exceptions.dart';
import 'package:equatable/equatable.dart';
import 'package:sales_data/sales_data.dart';

part 'get_data_state.dart';

class GetDataCubit extends Cubit<GetDataState> {
  final SalesData repository;
  GetDataCubit(this.repository) : super(const GetDataState());

  Future<void> getData() async {
    emit(state.copyWith(status: GetDataStatus.loading));
    try {
      final response = await repository.getSalesData();
      emit(state.copyWith(
        status: GetDataStatus.success,
        data: response,
      ));
    } on NetworkException catch (e) {
      emit(
        state.copyWith(status: GetDataStatus.failure, errorMessage: e.message),
      );
    } catch (e) {
      emit(
        state.copyWith(
          status: GetDataStatus.failure,
          errorMessage: 'Request could not complete',
        ),
      );
    }
  }
}
