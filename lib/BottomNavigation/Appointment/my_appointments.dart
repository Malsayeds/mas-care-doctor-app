import 'package:animation_wrappers/animation_wrappers.dart';
import 'package:doctoworld_doctor/Locale/locale.dart';
import 'package:doctoworld_doctor/Routes/routes.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../../Locale/locale.dart';

class MyAppointmentsPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MyAppointmentsBody();
  }
}

class Appointment {
  String? heading;
  List<AppointmentTile> appts;

  Appointment(this.heading, this.appts);
}

class AppointmentTile {
  String image;
  String name;
  String? disease;
  String dateTime;

  AppointmentTile(this.image, this.name, this.disease, this.dateTime);
}

class MyAppointmentsBody extends StatefulWidget {
  @override
  _MyAppointmentsBodyState createState() => _MyAppointmentsBodyState();
}

class _MyAppointmentsBodyState extends State<MyAppointmentsBody> {
  @override
  Widget build(BuildContext context) {
    var locale = AppLocalizations.of(context)!;
    List<AppointmentTile> todayAppt = [
      AppointmentTile('assets/userprofile.png', 'Samantha Smith',
          locale.chestPain, '12 June 2020 | 12:00 pm'),
      AppointmentTile('assets/userprofile.png', 'Jenlia Peterson',
          locale.chestPain, '12 June 2020 | 2:30 pm'),
    ];
    List<AppointmentTile> tomorrowAppt = [
      AppointmentTile('assets/userprofile.png', 'Samantha Smith',
          locale.chestPain, '12 June 2020 | 12:00 pm'),
      AppointmentTile('assets/userprofile.png', 'Jenlia Peterson',
          locale.chestPain, '12 June 2020 | 2:30 pm'),
      AppointmentTile('assets/userprofile.png', 'Samantha Smith',
          locale.chestPain, '12 June 2020 | 12:00 pm'),
      AppointmentTile('assets/userprofile.png', 'Jenlia Peterson',
          locale.chestPain, '12 June 2020 | 2:30 pm'),
    ];
    List<Appointment> allAppts = [
      Appointment(locale.today, todayAppt),
      Appointment(locale.tomorrow, tomorrowAppt),
    ];
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: FadedScaleAnimation(
          Text(locale.myAppointments!),
          durationInMilliseconds: 400,
        ),
        centerTitle: true,
        actions: [
          IconButton(
            icon: Icon(Icons.history),
            color: Theme.of(context).primaryColor,
            onPressed: () {},
          )
        ],
      ),
      body: ListView.builder(
          physics: BouncingScrollPhysics(),
          shrinkWrap: true,
          itemCount: allAppts.length,
          itemBuilder: (context, index) {
            return Column(
              children: [
                Container(
                  width: MediaQuery.of(context).size.width,
                  padding: EdgeInsets.all(20.0),
                  color: Theme.of(context).primaryColorLight,
                  child: Text(allAppts[index].heading!,
                      style: Theme.of(context)
                          .textTheme
                          .bodyText1!
                          .copyWith(fontSize: 15)),
                ),
                ListView.builder(
                    physics: NeverScrollableScrollPhysics(),
                    itemCount: allAppts[index].appts.length,
                    shrinkWrap: true,
                    itemBuilder: (context, position) {
                      return Column(
                        children: [
                          Padding(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 12.0, vertical: 16),
                            child: Stack(
                              children: [
                                Row(
                                  children: [
                                    FadedScaleAnimation(
                                      Image.asset(
                                        allAppts[index].appts[position].image,
                                        scale: 6,
                                      ),
                                      durationInMilliseconds: 400,
                                    ),
                                    SizedBox(
                                      width: 12,
                                    ),
                                    Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          allAppts[index].appts[position].name,
                                          style: Theme.of(context)
                                              .textTheme
                                              .subtitle1!
                                              .copyWith(
                                                  fontWeight: FontWeight.w600),
                                        ),
                                        SizedBox(
                                          height: 4,
                                        ),
                                        Text(
                                          allAppts[index]
                                              .appts[position]
                                              .disease!,
                                          style: Theme.of(context)
                                              .textTheme
                                              .subtitle2!
                                              .copyWith(
                                                  fontSize: 12,
                                                  color: Theme.of(context)
                                                      .disabledColor),
                                        ),
                                        SizedBox(
                                          height: 10,
                                        ),
                                        Text(allAppts[index]
                                            .appts[position]
                                            .dateTime)
                                      ],
                                    ),
                                  ],
                                ),
                                Align(
                                    alignment: Alignment.topRight,
                                    child: FadedScaleAnimation(
                                      Icon(
                                        Icons.more_vert,
                                        color: Theme.of(context).primaryColor,
                                        size: 18,
                                      ),
                                      durationInMilliseconds: 400,
                                    )),
                                PositionedDirectional(
                                    bottom: 0,
                                    end: 6,
                                    child: Row(
                                      children: [
                                        FadedScaleAnimation(
                                          Icon(
                                            Icons.call,
                                            color:
                                                Theme.of(context).primaryColor,
                                            size: 18,
                                          ),
                                          durationInMilliseconds: 400,
                                        ),
                                        SizedBox(
                                          width: 18,
                                        ),
                                        GestureDetector(
                                          onTap: () {
                                            Navigator.pushNamed(
                                                context, PageRoutes.chatScreen);
                                          },
                                          child: FadedScaleAnimation(
                                            Icon(
                                              Icons.message,
                                              color: Theme.of(context)
                                                  .primaryColor,
                                              size: 18,
                                            ),
                                            durationInMilliseconds: 400,
                                          ),
                                        )
                                      ],
                                    ))
                              ],
                            ),
                          ),
                          position + 1 != allAppts[index].appts.length
                              ? Divider(
                                  thickness: 8,
                                )
                              : SizedBox.shrink(),
                        ],
                      );
                    }),
              ],
            );
          }),
    );
  }
}
