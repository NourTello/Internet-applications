import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:web_app/core/const/light-colors.dart';
import 'package:web_app/features/Reports/data/repo/report_repo.dart';
import 'package:web_app/features/Reports/presentation/widgets/report_tile.dart';
import '../../domain/bloc/reports_bloc.dart';
import '../../domain/bloc/reports_event.dart';
import '../../domain/bloc/reports_state.dart';
import 'package:web_app/core/componant/text_style.dart';

showReportsAlertDialog({required context, required int fileID}) =>
    showDialog<String>(
      context: context,
      builder: (BuildContext context) => BlocProvider(
        create: (BuildContext context) => ReportBloc(reportsRepo: ReportsRepo())
          ..add(GetReportEvent(fileID: fileID)),
        child: BlocConsumer<ReportBloc, ReportsState>(
          listener: (BuildContext context, ReportsState state) {},
          builder: (BuildContext context, ReportsState state) {
            var bloc = ReportBloc.get(context);

            return AlertDialog(
              backgroundColor: backgroundColor,
              title: Text(
                'File report',
                style: TextStyle(color: primaryColor,fontFamily: 'Handlee',fontSize: 25,fontWeight: FontWeight.w800),
              ),
              actions: [
                SizedBox(
                    height: 400,
                    width: 400,
                    child: (state is GetReportLoadingState)
                        ? Center(
                            child: CircularProgressIndicator(),
                          )
                        : ListView.separated(
                            itemBuilder: (context, index) =>ReportTile(data:bloc.reportsList[index] ),
                            itemCount:
                            bloc.reportsList.length,
                      separatorBuilder: (BuildContext context, int index)=>Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Divider(
                          color: lightGrey,
                          height: 1,
                        ),
                      )
                          ))
              ],
            );
          },
        ),
      ),
    );
