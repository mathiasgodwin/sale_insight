// ignore_for_file: public_member_api_docs, sort_constructors_first

part of 'get_data_cubit.dart';

enum GetDataStatus {
  initial,
  loading,
  success,
  failure,
}

class GetDataState extends Equatable {
  const GetDataState({
    this.errorMessage,
    this.data = const <SalesDataModel>[],
    this.status = GetDataStatus.initial,
  });

  final GetDataStatus status;
  final String? errorMessage;
  final List<SalesDataModel> data;

  GetDataState copyWith({
    GetDataStatus? status,
    String? errorMessage,
    List<SalesDataModel>? data,
  }) {
    return GetDataState(
      status: status ?? this.status,
      errorMessage: errorMessage ?? this.errorMessage,
      data: data ?? this.data,
    );
  }

  @override
  List<Object?> get props => [
        status,
        errorMessage,
        data,
      ];
}
