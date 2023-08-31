import 'dart:async';
import 'dart:convert';

import 'serialization_util.dart';
import '../backend.dart';
import '../../flutter_flow/flutter_flow_theme.dart';
import '../../flutter_flow/flutter_flow_util.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';

import '../../index.dart';
import '../../main.dart';

final _handledMessageIds = <String?>{};

class PushNotificationsHandler extends StatefulWidget {
  const PushNotificationsHandler({Key? key, required this.child})
      : super(key: key);

  final Widget child;

  @override
  _PushNotificationsHandlerState createState() =>
      _PushNotificationsHandlerState();
}

class _PushNotificationsHandlerState extends State<PushNotificationsHandler> {
  bool _loading = false;

  Future handleOpenedPushNotification() async {
    if (isWeb) {
      return;
    }

    final notification = await FirebaseMessaging.instance.getInitialMessage();
    if (notification != null) {
      await _handlePushNotification(notification);
    }
    FirebaseMessaging.onMessageOpenedApp.listen(_handlePushNotification);
  }

  Future _handlePushNotification(RemoteMessage message) async {
    if (_handledMessageIds.contains(message.messageId)) {
      return;
    }
    _handledMessageIds.add(message.messageId);

    if (mounted) {
      setState(() => _loading = true);
    }
    try {
      final initialPageName = message.data['initialPageName'] as String;
      final initialParameterData = getInitialParameterData(message.data);
      final pageBuilder = pageBuilderMap[initialPageName];
      if (pageBuilder != null) {
        final page = await pageBuilder(initialParameterData);
        await Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => page),
        );
      }
    } catch (e) {
      print('Error: $e');
    } finally {
      if (mounted) {
        setState(() => _loading = false);
      }
    }
  }

  @override
  void initState() {
    super.initState();
    handleOpenedPushNotification();
  }

  @override
  Widget build(BuildContext context) => _loading
      ? Center(
          child: SizedBox(
            width: 50.0,
            height: 50.0,
            child: CircularProgressIndicator(
              valueColor: AlwaysStoppedAnimation<Color>(
                FlutterFlowTheme.of(context).primary,
              ),
            ),
          ),
        )
      : widget.child;
}

final pageBuilderMap = <String, Future<Widget> Function(Map<String, dynamic>)>{
  'CreateMedication': (data) async => CreateMedicationWidget(),
  'CaregiverHome': (data) async => CaregiverHomeWidget(),
  'MedicationDetails': (data) async => MedicationDetailsWidget(
        medication: await getDocumentParameter(
            data, 'medication', MedicationsRecord.fromSnapshot),
      ),
  'PairConnect': (data) async => PairConnectWidget(),
  'ContinueRegister': (data) async => ContinueRegisterWidget(),
  'Login': (data) async => LoginWidget(),
  'ElderlyHome': (data) async => ElderlyHomeWidget(),
  'MedicationDetailsElderly': (data) async => MedicationDetailsElderlyWidget(
        medication: await getDocumentParameter(
            data, 'medication', MedicationsRecord.fromSnapshot),
      ),
  'TakedPage': (data) async => TakedPageWidget(),
  'AlertPage': (data) async => AlertPageWidget(),
  'ConnectionsList': (data) async => ConnectionsListWidget(),
  'MedicationAlert': (data) async => MedicationAlertWidget(
        medication: await getDocumentParameter(
            data, 'medication', MedicationsRecord.fromSnapshot),
      ),
  'EditMedication': (data) async => EditMedicationWidget(
        medication: await getDocumentParameter(
            data, 'medication', MedicationsRecord.fromSnapshot),
      ),
  'Chat': (data) async => ChatWidget(
        chatUser: await getDocumentParameter(
            data, 'chatUser', UsersRecord.fromSnapshot),
        chatRef: getParameter(data, 'chatRef'),
      ),
  'AddChatCaregiver': (data) async => AddChatCaregiverWidget(
        chat:
            await getDocumentParameter(data, 'chat', ChatsRecord.fromSnapshot),
      ),
  'AllChatsCaregiver': (data) async => AllChatsCaregiverWidget(),
  'AddChatElderly': (data) async => AddChatElderlyWidget(
        chat:
            await getDocumentParameter(data, 'chat', ChatsRecord.fromSnapshot),
      ),
  'AllChatsElderly': (data) async => AllChatsElderlyWidget(),
};

bool hasMatchingParameters(Map<String, dynamic> data, Set<String> params) =>
    params.any((param) => getParameter(data, param) != null);

Map<String, dynamic> getInitialParameterData(Map<String, dynamic> data) {
  try {
    final parameterDataStr = data['parameterData'];
    if (parameterDataStr == null ||
        parameterDataStr is! String ||
        parameterDataStr.isEmpty) {
      return {};
    }
    return jsonDecode(parameterDataStr) as Map<String, dynamic>;
  } catch (e) {
    print('Error parsing parameter data: $e');
    return {};
  }
}
