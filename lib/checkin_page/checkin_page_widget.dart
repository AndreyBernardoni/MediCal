import '/auth/base_auth_user_provider.dart';
import '/auth/firebase_auth/auth_util.dart';
import '/caregiver_home/caregiver_home_widget.dart';
import '/continue_register/continue_register_widget.dart';
import '/elderly_home/elderly_home_widget.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/login/login_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'checkin_page_model.dart';
export 'checkin_page_model.dart';

class CheckinPageWidget extends StatefulWidget {
  const CheckinPageWidget({Key? key}) : super(key: key);

  @override
  _CheckinPageWidgetState createState() => _CheckinPageWidgetState();
}

class _CheckinPageWidgetState extends State<CheckinPageWidget> {
  late CheckinPageModel _model;

  final scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => CheckinPageModel());

    // On page load action.
    SchedulerBinding.instance.addPostFrameCallback((_) async {
      await Future.delayed(const Duration(milliseconds: 0));
      if (loggedIn) {
        if (!FFAppState().firstAccess) {
          Navigator.pushAndRemoveUntil(
            context,
            PageTransition(
              type: PageTransitionType.bottomToTop,
              duration: Duration(milliseconds: 200),
              reverseDuration: Duration(milliseconds: 200),
              child: ContinueRegisterWidget(),
            ),
            (r) => false,
          );
          return;
        } else {
          if (valueOrDefault<bool>(currentUserDocument?.isCaregiver, false) ==
              true) {
            Navigator.push(
              context,
              PageTransition(
                type: PageTransitionType.bottomToTop,
                duration: Duration(milliseconds: 200),
                reverseDuration: Duration(milliseconds: 200),
                child: CaregiverHomeWidget(),
              ),
            );
            return;
          } else {
            Navigator.push(
              context,
              PageTransition(
                type: PageTransitionType.bottomToTop,
                duration: Duration(milliseconds: 200),
                reverseDuration: Duration(milliseconds: 200),
                child: ElderlyHomeWidget(),
              ),
            );
            return;
          }
        }
      } else {
        Navigator.pushAndRemoveUntil(
          context,
          PageTransition(
            type: PageTransitionType.bottomToTop,
            duration: Duration(milliseconds: 200),
            reverseDuration: Duration(milliseconds: 200),
            child: LoginWidget(),
          ),
          (r) => false,
        );
        return;
      }
    });
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
        backgroundColor: FlutterFlowTheme.of(context).white,
      ),
    );
  }
}
