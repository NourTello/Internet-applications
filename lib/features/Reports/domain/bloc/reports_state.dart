import 'package:web_app/features/group/domain/model/group_list_model.dart';

abstract class ReportsState {}
class ReportsInitialState extends ReportsState{}
class GetReportLoadingState extends ReportsState{}
class GetReportErrorState extends ReportsState{}
class GetReportSuccessState extends ReportsState{}
