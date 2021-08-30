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

  Widget buildAppointmentBottomSheet(String action) {
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
                      onPressed: () {},
                      child: Text(
                        locale.reject,
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
                      onPressed: () {},
                      child: Text(
                        locale.approve,
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
    return status == 0
        ? 'Pending'
        : status == 1
            ? 'Approved'
            : 'Rejected';
  }

  @override
  Widget build(BuildContext context) {
    final locale = AppLocalizations.of(context)!;
    final apptData = Provider.of<Appointments>(context);
    return Scaffold(
      appBar: AppBar(
        title: Text('Appointment Details'),
        actions: [
          TextButton(
            onPressed: () {},
            child: Text(
              getStatusText(apptData.appointment?.status),
              style: TextStyle(
                color: apptData.appointment?.status.getStatusColor(),
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ],
      ),
      body: _isLoading
          ? SharedWidgets.showLoader()
          : SingleChildScrollView(
              child: Padding(
                padding:
                    const EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
                child: Column(
                  children: [
                    if (apptData.patient?.image != null)
                      SharedWidgets.buildImgNetwork(
                        imgUrl: apptData.patient!.image!,
                      ),
                    if (apptData.patient?.image != null)
                      SizedBox(
                        height: sizedBoxHeight + 8,
                      ),
                    EntryField(
                      initialValue: apptData.patient?.name,
                      hint: 'Patient Name',
                      label: 'Patient Name',
                      readOnly: true,
                    ),
                    SizedBox(
                      height: sizedBoxHeight,
                    ),
                    EntryField(
                      initialValue: apptData.patient?.email,
                      hint: 'Patient E-mail',
                      label: 'Patient E-mail',
                      readOnly: true,
                    ),
                    SizedBox(
                      height: sizedBoxHeight,
                    ),
                    EntryField(
                      initialValue: apptData.patient?.phoneNumber,
                      hint: 'Patient Phone Number',
                      label: 'Patient Phone Number',
                      readOnly: true,
                    ),
                    SizedBox(
                      height: sizedBoxHeight,
                    ),
                    EntryField(
                      initialValue: apptData.patient?.diagnosis,
                      hint: 'Patient Diagnosis',
                      label: 'Patient Diagnosis',
                      readOnly: true,
                    ),
                    SizedBox(
                      height: sizedBoxHeight,
                    ),
                    EntryField(
                      initialValue: apptData.patient?.gender,
                      hint: 'Patient Gender',
                      label: 'Patient Gender',
                      readOnly: true,
                    ),
                    SizedBox(
                      height: sizedBoxHeight,
                    ),
                    EntryField(
                      initialValue: apptData.patient?.age.toString(),
                      hint: 'Patient Age',
                      label: 'Patient Age',
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
                              onPressed: () {
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
                                    return buildAppointmentBottomSheet(
                                        'reject');
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
                              onPressed: () {
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
                                    return buildAppointmentBottomSheet(
                                        'approve');
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
