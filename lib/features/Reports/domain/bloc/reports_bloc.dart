import 'dart:async';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:web_app/features/Reports/domain/bloc/reports_event.dart';
import 'package:web_app/features/Reports/domain/bloc/reports_state.dart';
import '../../data/repo/report_repo.dart';
import '../model/report_model.dart';

class ReportBloc extends Bloc<ReportEvent, ReportsState> {
  List<dynamic> reportsList = [];

  ReportsRepo reportsRepo;
  static ReportBloc get(context) => BlocProvider.of(context);

  ReportBloc({required this.reportsRepo}) : super(ReportsInitialState()) {
    on<GetReportEvent>(getReportsRepo);
  }

  FutureOr<void> getReportsRepo(
      GetReportEvent event, Emitter<ReportsState> emit) async {
    emit(GetReportLoadingState());
    var response = await reportsRepo.getReport(fileID: event.fileID);
    if (response.success!) {
      print(response.msg);
      print(response.data);
      emit(GetReportSuccessState());
      reportsList = response.data!;
    } else
      emit(GetReportErrorState());
  }
}
