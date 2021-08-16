import 'dart:io';

import 'package:animation_wrappers/animation_wrappers.dart';
import 'package:doctoworld_doctor/cubit/appointments_cubit.dart';
import 'package:doctoworld_doctor/models/appointment.dart';
import 'package:doctoworld_doctor/screens/BottomNavigation/Appointment/chat_page.dart';
import 'package:doctoworld_doctor/utils/constants.dart';
import 'package:doctoworld_doctor/widgets/shared_widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import "package:doctoworld_doctor/utils/extensions.dart";

class MyAppointmentsPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MyAppointmentsBody();
  }
}

class MyAppointmentsBody extends StatefulWidget {
  @override
  _MyAppointmentsBodyState createState() => _MyAppointmentsBodyState();
}

class _MyAppointmentsBodyState extends State<MyAppointmentsBody> {
  bool _isLoading = false;

  @override
  void initState() {
    super.initState();
    getAppointments();
  }

  Future<void> getAppointments() async {
    try {
      setState(() {
        _isLoading = true;
      });
      final apptData =
          BlocProvider.of<AppointmentsCubit>(context, listen: false);
      await apptData.getAppointments();
      setState(() {
        _isLoading = false;
      });
    } catch (e) {
      setState(() {
        _isLoading = false;
      });
      SharedWidgets.showToast(msg: e.toString());
    }
  }

  Widget buildAppointmentBottomSheet(BuildContext ctx) {
    final locale = AppLocalizations.of(context)!;
    return Container(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          mainAxisSize: MainAxisSize.min,
          children: [
            SizedBox(
              height: 48,
              child: TextButton(
                onPressed: () async {},
                child: Text(locale.approve),
                style: TextButton.styleFrom(
                  textStyle: TextStyle(
                    fontSize: 18,
                    color: greenColor,
                  ),
                ),
              ),
            ),
            Divider(
              color: Colors.grey,
            ),
            SizedBox(
              height: 48,
              child: TextButton(
                onPressed: () async {},
                child: Text(locale.reject),
                style: TextButton.styleFrom(
                  textStyle: TextStyle(
                    fontSize: 18,
                    color: redColor,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  String getStatusText(int status) {
    return status == 0
        ? 'Pending'
        : status == 1
            ? 'Approved'
            : 'Rejected';
  }

  Widget buildAppointmentCard(Appointment appt) {
    return InkWell(
      onTap: () {
        showModalBottomSheet(
          context: context,
          isScrollControlled: true,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.only(
              topRight: Radius.circular(kBorderRadius),
              topLeft: Radius.circular(kBorderRadius),
            ),
          ),
          builder: (ctx) {
            return buildAppointmentBottomSheet(ctx);
          },
        );
      },
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 12.0, vertical: 16),
        color: Colors.white,
        child: Row(
          children: [
            FadedScaleAnimation(
              Image.network(
                appt.image ?? imagePlaceHolderError,
                width: 75,
                height: 75,
              ),
              durationInMilliseconds: 400,
            ),
            SizedBox(
              width: 12,
            ),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Expanded(
                        child: Text(
                          appt.patientName,
                          style: Theme.of(context)
                              .textTheme
                              .subtitle1!
                              .copyWith(fontWeight: FontWeight.w600),
                        ),
                      ),
                      Text(
                        getStatusText(appt.status),
                        style: TextStyle(
                          color: appt.status.getStatusColor(),
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 4,
                  ),
                  Text(
                    appt.diagnosis ?? '',
                    style: Theme.of(context).textTheme.subtitle2!.copyWith(
                        fontSize: 12, color: Theme.of(context).disabledColor),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Row(
                    children: [
                      Expanded(
                        child: Text(
                          '${appt.date} | ${appt.time}',
                        ),
                      ),
                      InkWell(
                        onTap: () async {
                          if (appt.phone != null) {
                            await SharedWidgets.launchPhoneCall(appt.phone!);
                          } else {
                            SharedWidgets.showToast(
                                msg: 'No Phone number specified');
                          }
                        },
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: FadedScaleAnimation(
                            Icon(
                              Icons.call,
                              color: Theme.of(context).primaryColor,
                              size: 18,
                            ),
                            durationInMilliseconds: 400,
                          ),
                        ),
                      ),
                      SizedBox(
                        width: 10,
                      ),
                      InkWell(
                        onTap: () {
                          Navigator.pushNamed(context, ChatScreen.ROUTE_NAME);
                        },
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: FadedScaleAnimation(
                            Icon(
                              Icons.message,
                              color: Theme.of(context).primaryColor,
                              size: 18,
                            ),
                            durationInMilliseconds: 400,
                          ),
                        ),
                      )
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    var locale = AppLocalizations.of(context)!;
    final apptsData = BlocProvider.of<AppointmentsCubit>(context);

    return Scaffold(
      backgroundColor: Theme.of(context).primaryColorLight,
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: FadedScaleAnimation(
          Text(locale.myAppointments),
          durationInMilliseconds: 400,
        ),
        centerTitle: true,
        backgroundColor: Colors.white,
      ),
      body: _isLoading
          ? Center(
              child: SharedWidgets.showLoader(),
            )
          : FadedSlideAnimation(
              ListView(
                physics: BouncingScrollPhysics(),
                shrinkWrap: true,
                children: [
                  Container(
                    color: Theme.of(context).primaryColorLight,
                    padding: const EdgeInsets.all(16.0),
                    child: Text(
                      locale.today.toUpperCase(),
                      style: TextStyle(
                        color: Colors.grey,
                      ),
                    ),
                  ),
                  apptsData.todayAppointments.length == 0
                      ? SizedBox(
                          height: 100,
                          child: Center(
                            child: Text(locale.noApptsFoundToday),
                          ),
                        )
                      : ListView.separated(
                          physics: BouncingScrollPhysics(),
                          itemCount: apptsData.todayAppointments.length,
                          shrinkWrap: true,
                          separatorBuilder: (context, i) {
                            return Divider(thickness: 4);
                          },
                          itemBuilder: (context, i) {
                            return buildAppointmentCard(
                                apptsData.todayAppointments[i]);
                          },
                        ),
                  Container(
                    color: Theme.of(context).primaryColorLight,
                    padding: const EdgeInsets.all(16.0),
                    child: Text(
                      locale.tomorrow.toUpperCase(),
                      style: TextStyle(
                        color: Colors.grey,
                      ),
                    ),
                  ),
                  apptsData.tomorrowAppointments.length == 0
                      ? SizedBox(
                          height: 100,
                          child: Center(
                            child: Text(locale.noApptsFoundTomorrow),
                          ),
                        )
                      : ListView.separated(
                          physics: BouncingScrollPhysics(),
                          itemCount: apptsData.tomorrowAppointments.length,
                          shrinkWrap: true,
                          separatorBuilder: (context, i) {
                            return Divider(thickness: 4);
                          },
                          itemBuilder: (context, i) {
                            return buildAppointmentCard(
                                apptsData.tomorrowAppointments[i]);
                          },
                        ),
                ],
              ),
              beginOffset: Offset(0, 0.3),
              endOffset: Offset(0, 0),
              slideCurve: Curves.linearToEaseOut,
            ),
    );
  }
}
