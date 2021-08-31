import 'package:doctoworld_doctor/providers/appointments.dart';
import 'package:doctoworld_doctor/utils/constants.dart';
import 'package:doctoworld_doctor/widgets/entry_field.dart';
import 'package:doctoworld_doctor/widgets/shared_widgets.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import "package:doctoworld_doctor/utils/extensions.dart";
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class AppointmentDetails extends StatefulWidget {
  static const String ROUTE_NAME = '/appointmentDetails';

  const AppointmentDetails({Key? key}) : super(key: key);

  @override
  _AppointmentDetailsState createState() => _AppointmentDetailsState();
}

class _AppointmentDetailsState extends State<AppointmentDetails> {
  late int id;

  double sizedBoxHeight = 8.0;

  bool _isLoading = false;
  bool _isStatusLoading = false;

  static const int PENDING_VALUE = 0;
  static const int APPROVE_VALUE = 1;
  static const int REJECT_VALUE = 2;

  Future<void> getAppointmentDetails() async {
    try {
      final apptData = Provider.of<Appointments>(context, listen: false);
      await apptData.getAppointmentDetails(id);
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

  Widget buildAppointmentBottomSheet(String action, int statusValue) {
    final locale = AppLocalizations.of(context)!;
    return Container(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              'Are you sure that you wanna $action this appointment?',
              style: TextStyle(
                fontSize: 18,
              ),
            ),
            SizedBox(
              height: sizedBoxHeight,
            ),
            Row(
              children: [
                Expanded(
                  child: SizedBox(
                    height: 48,
                    child: TextButton(
                      onPressed: () async {
                        Navigator.of(context).pop();
                      },
                      child: Text(
                        locale.no,
                      ),
                      style: TextButton.styleFrom(
                          primary: redColor,
                          textStyle: TextStyle(
                            fontSize: 18,
                          )),
                    ),
                  ),
                ),
                Expanded(
                  child: SizedBox(
                    height: 48,
                    child: TextButton(
                      onPressed: () async {
                        Navigator.of(context).pop();
                        await updateStatus(statusValue);
                      },
                      child: Text(
                        locale.yes,
                      ),
                      style: TextButton.styleFrom(
                        primary: greenColor,
                        textStyle: TextStyle(
                          fontSize: 18,
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Future<void> updateStatus(int newStatus) async {
    try {
      setState(() {
        _isStatusLoading = true;
      });
      final apptData = Provider.of<Appointments>(context, listen: false);
      await apptData.editAppointmentStatus(
        apptId: id,
        status: newStatus,
      );
      await getAppointmentDetails();
      setState(() {
        _isStatusLoading = false;
      });
    } catch (e) {
      setState(() {
        _isStatusLoading = false;
      });
      SharedWidgets.showToast(msg: e.toString());
    }
  }

  @override
  void initState() {
    super.initState();
    setState(() {
      _isLoading = true;
    });
    Future.delayed(Duration.zero, () {
      id = ModalRoute.of(context)?.settings.arguments as int;
      getAppointmentDetails();
    });
  }

  String getStatusText(int? status) {
    final locale = AppLocalizations.of(context)!;
    return status == PENDING_VALUE
        ? locale.pending
        : status == APPROVE_VALUE
            ? locale.approved
            : locale.rejected;
  }

  @override
  Widget build(BuildContext context) {
    final locale = AppLocalizations.of(context)!;
    final apptData = Provider.of<Appointments>(context);
    return Scaffold(
      appBar: AppBar(
        title: Text('Appointment Details'),
      ),
      body: _isLoading
          ? SharedWidgets.showLoader()
          : SingleChildScrollView(
              child: Padding(
                padding:
                    const EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
                child: Column(
                  children: [
                    ListTile(
                      leading: apptData.patient?.image == null
                          ? null
                          : CircleAvatar(
                              child: SharedWidgets.buildImgNetwork(
                                imgUrl: apptData.patient!.image!,
                              ),
                            ),
                      title: Text(apptData.patient?.name ?? ''),
                      subtitle: Text(apptData.appointment?.diagnosis ?? ''),
                      trailing: Text(
                        getStatusText(apptData.appointment?.status),
                        style: TextStyle(
                          color: apptData.appointment?.status.getStatusColor(),
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    SizedBox(
                      height: sizedBoxHeight + 8,
                    ),
                    EntryField(
                      initialValue: apptData.patient?.email,
                      hint: 'E-mail',
                      label: 'E-mail',
                      readOnly: true,
                    ),
                    SizedBox(
                      height: sizedBoxHeight,
                    ),
                    EntryField(
                      initialValue: apptData.patient?.phoneNumber,
                      hint: 'Phone Number',
                      label: 'Phone Number',
                      readOnly: true,
                    ),
                    SizedBox(
                      height: sizedBoxHeight,
                    ),
                    EntryField(
                      initialValue: apptData.patient?.diagnosis,
                      hint: 'Diagnosis',
                      label: 'Diagnosis',
                      readOnly: true,
                    ),
                    SizedBox(
                      height: sizedBoxHeight,
                    ),
                    EntryField(
                      initialValue: apptData.patient?.gender,
                      hint: 'Gender',
                      label: 'Gender',
                      readOnly: true,
                    ),
                    SizedBox(
                      height: sizedBoxHeight,
                    ),
                    EntryField(
                      initialValue: apptData.patient?.age.toString(),
                      hint: 'Age',
                      label: 'Age',
                      readOnly: true,
                    ),
                    SizedBox(
                      height: sizedBoxHeight + 8,
                    ),
                    EntryField(
                      initialValue:
                          '${apptData.patient?.city}, ${apptData.patient?.area}',
                      hint: 'Address',
                      label: 'Address',
                      readOnly: true,
                    ),
                    SizedBox(
                      height: sizedBoxHeight + 8,
                    ),
                    Row(
                      children: [
                        Expanded(
                          child: SizedBox(
                            height: 48,
                            child: ElevatedButton(
                              onPressed: _isStatusLoading
                                  ? null
                                  : () {
                                      showModalBottomSheet(
                                        context: context,
                                        isScrollControlled: true,
                                        shape: RoundedRectangleBorder(
                                          borderRadius: BorderRadius.only(
                                            topRight:
                                                Radius.circular(kBorderRadius),
                                            topLeft:
                                                Radius.circular(kBorderRadius),
                                          ),
                                        ),
                                        builder: (ctx) {
                                          return buildAppointmentBottomSheet(
                                            'reject',
                                            REJECT_VALUE,
                                          );
                                        },
                                      );
                                    },
                              style: ElevatedButton.styleFrom(
                                primary: redColor,
                              ),
                              child: Text(locale.reject),
                            ),
                          ),
                        ),
                        SizedBox(
                          width: sizedBoxHeight,
                        ),
                        Expanded(
                          child: SizedBox(
                            height: 48,
                            child: ElevatedButton(
                              onPressed: _isStatusLoading
                                  ? null
                                  : () {
                                      showModalBottomSheet(
                                        context: context,
                                        isScrollControlled: true,
                                        shape: RoundedRectangleBorder(
                                          borderRadius: BorderRadius.only(
                                            topRight:
                                                Radius.circular(kBorderRadius),
                                            topLeft:
                                                Radius.circular(kBorderRadius),
                                          ),
                                        ),
                                        builder: (ctx) {
                                          return buildAppointmentBottomSheet(
                                            'approve',
                                            APPROVE_VALUE,
                                          );
                                        },
                                      );
                                    },
                              style: ElevatedButton.styleFrom(
                                primary: greenColor,
                              ),
                              child: Text(locale.approve),
                            ),
                          ),
                        ),
                      ],
                    )
                  ],
                ),
              ),
            ),
    );
  }
}
