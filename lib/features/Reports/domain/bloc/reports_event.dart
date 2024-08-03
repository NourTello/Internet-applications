abstract class ReportEvent {}
class ReportInitialEvent extends ReportEvent{}
class GetReportEvent extends ReportEvent{
  int fileID;

  GetReportEvent({ required this.fileID});
}

