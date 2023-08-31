import '/add_chat_caregiver/add_chat_caregiver_widget.dart';
import '/auth/firebase_auth/auth_util.dart';
import '/backend/backend.dart';
import '/chat/chat_widget.dart';
import '/components/appbar_widget.dart';
import '/flutter_flow/chat/index.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

class AllChatsElderlyModel extends FlutterFlowModel {
  ///  State fields for stateful widgets in this page.

  // Model for appbar component.
  late AppbarModel appbarModel;

  /// Initialization and disposal methods.

  void initState(BuildContext context) {
    appbarModel = createModel(context, () => AppbarModel());
  }

  void dispose() {
    appbarModel.dispose();
  }

  /// Action blocks are added here.

  /// Additional helper methods are added here.
}
