import '/alert_page/alert_page_widget.dart';
import '/auth/firebase_auth/auth_util.dart';
import '/backend/backend.dart';
import '/backend/push_notifications/push_notifications_util.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/flutter_flow_widgets.dart';
import '/taked_page/taked_page_widget.dart';
import '/flutter_flow/custom_functions.dart' as functions;
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lottie/lottie.dart';
import 'package:provider/provider.dart';
import 'medication_alert_model.dart';
export 'medication_alert_model.dart';

class MedicationAlertWidget extends StatefulWidget {
  const MedicationAlertWidget({
    Key? key,
    required this.medication,
  }) : super(key: key);

  final MedicationsRecord? medication;

  @override
  _MedicationAlertWidgetState createState() => _MedicationAlertWidgetState();
}

class _MedicationAlertWidgetState extends State<MedicationAlertWidget> {
  late MedicationAlertModel _model;

  final scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => MedicationAlertModel());
  }

  @override
  void dispose() {
    _model.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    context.watch<FFAppState>();

    return GestureDetector(
      onTap: () => FocusScope.of(context).requestFocus(_model.unfocusNode),
      child: Scaffold(
        key: scaffoldKey,
        backgroundColor: FlutterFlowTheme.of(context).primary,
        body: SafeArea(
          top: true,
          child: StreamBuilder<UsersRecord>(
            stream: UsersRecord.getDocument(widget.medication!.owner!),
            builder: (context, snapshot) {
              // Customize what your widget looks like when it's loading.
              if (!snapshot.hasData) {
                return Center(
                  child: SizedBox(
                    width: 50.0,
                    height: 50.0,
                    child: CircularProgressIndicator(
                      valueColor: AlwaysStoppedAnimation<Color>(
                        FlutterFlowTheme.of(context).primary,
                      ),
                    ),
                  ),
                );
              }
              final columnUsersRecord = snapshot.data!;
              return Column(
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Padding(
                    padding:
                        EdgeInsetsDirectional.fromSTEB(0.0, 0.0, 0.0, 24.0),
                    child: Row(
                      mainAxisSize: MainAxisSize.max,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Lottie.network(
                          'https://assets6.lottiefiles.com/packages/lf20_yc16hka0.json',
                          width: 200.0,
                          height: 200.0,
                          fit: BoxFit.contain,
                          frameRate: FrameRate(60.0),
                          reverse: true,
                          animate: true,
                        ),
                      ],
                    ),
                  ),
                  Text(
                    'Atenção',
                    style: FlutterFlowTheme.of(context).headlineMedium.override(
                          fontFamily: 'Outfit',
                          color: FlutterFlowTheme.of(context).customColor4,
                          fontSize: 40.0,
                          fontWeight: FontWeight.w500,
                          useGoogleFonts: GoogleFonts.asMap().containsKey(
                              FlutterFlowTheme.of(context)
                                  .headlineMediumFamily),
                        ),
                  ),
                  Padding(
                    padding:
                        EdgeInsetsDirectional.fromSTEB(16.0, 12.0, 16.0, 0.0),
                    child: Text(
                      'Chegou a hora de tomar sua medicação!',
                      textAlign: TextAlign.center,
                      style: FlutterFlowTheme.of(context).titleSmall.override(
                            fontFamily: 'Outfit',
                            color: FlutterFlowTheme.of(context).customColor4,
                            fontSize: 26.0,
                            fontWeight: FontWeight.w300,
                            useGoogleFonts: GoogleFonts.asMap().containsKey(
                                FlutterFlowTheme.of(context).titleSmallFamily),
                          ),
                    ),
                  ),
                  Padding(
                    padding:
                        EdgeInsetsDirectional.fromSTEB(0.0, 44.0, 0.0, 0.0),
                    child: Row(
                      mainAxisSize: MainAxisSize.max,
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        FFButtonWidget(
                          onPressed: () async {
                            if (widget.medication?.frequency == 'daily') {
                              await widget.medication!.reference
                                  .update(createMedicationsRecordData(
                                scheduleTime: functions
                                    .setDaily(widget.medication!.scheduleTime!),
                              ));
                              triggerPushNotification(
                                notificationTitle:
                                    'Hora de tomar sua medicação',
                                notificationText:
                                    'Chegou a hora de tomar sua medicação: ${widget.medication?.name}',
                                scheduledTime: widget.medication!.scheduleTime!,
                                notificationSound: 'default',
                                userRefs: [currentUserReference!],
                                initialPageName: 'MedicationAlert',
                                parameterData: {
                                  'medication': widget.medication,
                                },
                              );
                            } else if (widget.medication?.frequency ==
                                'weekly') {
                              await widget.medication!.reference
                                  .update(createMedicationsRecordData(
                                scheduleTime: functions.setWeekly(
                                    null, widget.medication?.scheduleTime),
                              ));
                              triggerPushNotification(
                                notificationTitle:
                                    'Hora de tomar sua medicação',
                                notificationText:
                                    'Chegou a hora de tomar sua medicação: ${widget.medication?.name}',
                                scheduledTime: widget.medication!.scheduleTime!,
                                notificationSound: 'default',
                                userRefs: [currentUserReference!],
                                initialPageName: 'MedicationAlert',
                                parameterData: {
                                  'medication': widget.medication,
                                },
                              );
                            } else if (widget.medication?.frequency ==
                                'monthly') {
                              await widget.medication!.reference
                                  .update(createMedicationsRecordData(
                                scheduleTime: functions.setMonthly(
                                    widget.medication!.scheduleTime!),
                              ));
                              triggerPushNotification(
                                notificationTitle:
                                    'Hora de tomar sua medicação',
                                notificationText:
                                    'Chegou a hora de tomar sua medicação: ${widget.medication?.name}',
                                scheduledTime: widget.medication!.scheduleTime!,
                                notificationSound: 'default',
                                userRefs: [currentUserReference!],
                                initialPageName: 'MedicationAlert',
                                parameterData: {
                                  'medication': widget.medication,
                                },
                              );
                            } else {
                              await widget.medication!.reference.delete();
                            }

                            triggerPushNotification(
                              notificationTitle: 'Alerta!',
                              notificationText:
                                  'O usuário ${columnUsersRecord.displayName}tomou a medicação!',
                              notificationSound: 'default',
                              userRefs: [widget.medication!.caregiver!],
                              initialPageName: 'CaregiverHome',
                              parameterData: {},
                            );
                            Navigator.pushAndRemoveUntil(
                              context,
                              PageTransition(
                                type: PageTransitionType.bottomToTop,
                                duration: Duration(milliseconds: 200),
                                reverseDuration: Duration(milliseconds: 200),
                                child: TakedPageWidget(),
                              ),
                              (r) => false,
                            );
                          },
                          text: 'Tomar',
                          options: FFButtonOptions(
                            width: MediaQuery.sizeOf(context).width * 0.35,
                            height: MediaQuery.sizeOf(context).height * 0.08,
                            padding: EdgeInsetsDirectional.fromSTEB(
                                0.0, 0.0, 0.0, 0.0),
                            iconPadding: EdgeInsetsDirectional.fromSTEB(
                                0.0, 0.0, 0.0, 0.0),
                            color: Colors.white,
                            textStyle: FlutterFlowTheme.of(context)
                                .titleSmall
                                .override(
                                  fontFamily: 'Outfit',
                                  color: FlutterFlowTheme.of(context).primary,
                                  fontSize: 20.0,
                                  fontWeight: FontWeight.normal,
                                  useGoogleFonts: GoogleFonts.asMap()
                                      .containsKey(FlutterFlowTheme.of(context)
                                          .titleSmallFamily),
                                ),
                            elevation: 3.0,
                            borderSide: BorderSide(
                              color: Colors.transparent,
                              width: 1.0,
                            ),
                            borderRadius: BorderRadius.circular(8.0),
                          ),
                        ),
                        FFButtonWidget(
                          onPressed: () async {
                            triggerPushNotification(
                              notificationTitle: 'Alerta!',
                              notificationText:
                                  'O usuário ${columnUsersRecord.displayName} adiou a medicação dele em 5 minutos!',
                              notificationSound: 'default',
                              userRefs: [widget.medication!.caregiver!],
                              initialPageName: 'CaregiverHome',
                              parameterData: {},
                            );
                            triggerPushNotification(
                              notificationTitle: 'Atenção!',
                              notificationText:
                                  'Chegou a hora de tomar o remédio que você adiou!',
                              scheduledTime: functions
                                  .takeLater(widget.medication!.scheduleTime!),
                              userRefs: [widget.medication!.owner!],
                              initialPageName: 'MedicationAlert',
                              parameterData: {
                                'medication': widget.medication,
                              },
                            );
                            Navigator.pushAndRemoveUntil(
                              context,
                              PageTransition(
                                type: PageTransitionType.bottomToTop,
                                duration: Duration(milliseconds: 200),
                                reverseDuration: Duration(milliseconds: 200),
                                child: AlertPageWidget(),
                              ),
                              (r) => false,
                            );
                          },
                          text: 'Adiar',
                          options: FFButtonOptions(
                            width: MediaQuery.sizeOf(context).width * 0.35,
                            height: MediaQuery.sizeOf(context).height * 0.08,
                            padding: EdgeInsetsDirectional.fromSTEB(
                                0.0, 0.0, 0.0, 0.0),
                            iconPadding: EdgeInsetsDirectional.fromSTEB(
                                0.0, 0.0, 0.0, 0.0),
                            color: FlutterFlowTheme.of(context).white,
                            textStyle: FlutterFlowTheme.of(context)
                                .titleSmall
                                .override(
                                  fontFamily: 'Outfit',
                                  color: FlutterFlowTheme.of(context).primary,
                                  fontSize: 20.0,
                                  fontWeight: FontWeight.normal,
                                  useGoogleFonts: GoogleFonts.asMap()
                                      .containsKey(FlutterFlowTheme.of(context)
                                          .titleSmallFamily),
                                ),
                            elevation: 3.0,
                            borderSide: BorderSide(
                              color: Colors.transparent,
                              width: 1.0,
                            ),
                            borderRadius: BorderRadius.circular(8.0),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              );
            },
          ),
        ),
      ),
    );
  }
}
