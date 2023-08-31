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
import 'all_chats_caregiver_model.dart';
export 'all_chats_caregiver_model.dart';

class AllChatsCaregiverWidget extends StatefulWidget {
  const AllChatsCaregiverWidget({Key? key}) : super(key: key);

  @override
  _AllChatsCaregiverWidgetState createState() =>
      _AllChatsCaregiverWidgetState();
}

class _AllChatsCaregiverWidgetState extends State<AllChatsCaregiverWidget> {
  late AllChatsCaregiverModel _model;

  final scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => AllChatsCaregiverModel());
  }

  @override
  void dispose() {
    _model.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    context.watch<FFAppState>();

    return Scaffold(
      key: scaffoldKey,
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          Navigator.push(
            context,
            PageTransition(
              type: PageTransitionType.bottomToTop,
              duration: Duration(milliseconds: 200),
              reverseDuration: Duration(milliseconds: 200),
              child: AddChatCaregiverWidget(),
            ),
          );
        },
        backgroundColor: FlutterFlowTheme.of(context).primary,
        elevation: 8.0,
        child: Icon(
          Icons.add,
          color: FlutterFlowTheme.of(context).secondaryText,
          size: 24.0,
        ),
      ),
      body: SafeArea(
        top: true,
        child: Column(
          mainAxisSize: MainAxisSize.max,
          children: [
            wrapWithModel(
              model: _model.appbarModel,
              updateCallback: () => setState(() {}),
              updateOnChange: true,
              child: AppbarWidget(
                title: 'Conversas',
              ),
            ),
            Padding(
              padding: EdgeInsetsDirectional.fromSTEB(0.0, 2.0, 0.0, 0.0),
              child: StreamBuilder<List<ChatsRecord>>(
                stream: queryChatsRecord(
                  queryBuilder: (chatsRecord) => chatsRecord
                      .where('users', arrayContains: currentUserReference)
                      .orderBy('last_message_time', descending: true),
                ),
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
                  List<ChatsRecord> listViewChatsRecordList = snapshot.data!;
                  return ListView.builder(
                    padding: EdgeInsets.zero,
                    shrinkWrap: true,
                    scrollDirection: Axis.vertical,
                    itemCount: listViewChatsRecordList.length,
                    itemBuilder: (context, listViewIndex) {
                      final listViewChatsRecord =
                          listViewChatsRecordList[listViewIndex];
                      return StreamBuilder<FFChatInfo>(
                        stream: FFChatManager.instance
                            .getChatInfo(chatRecord: listViewChatsRecord),
                        builder: (context, snapshot) {
                          final chatInfo =
                              snapshot.data ?? FFChatInfo(listViewChatsRecord);
                          return FFChatPreview(
                            onTap: () => Navigator.push(
                              context,
                              PageTransition(
                                type: PageTransitionType.bottomToTop,
                                duration: Duration(milliseconds: 200),
                                reverseDuration: Duration(milliseconds: 200),
                                child: ChatWidget(
                                  chatUser: chatInfo.otherUsers.length == 1
                                      ? chatInfo.otherUsersList.first
                                      : null,
                                  chatRef: chatInfo.chatRecord.reference,
                                ),
                              ),
                            ),
                            lastChatText: chatInfo.chatPreviewMessage(),
                            lastChatTime: listViewChatsRecord.lastMessageTime,
                            seen: listViewChatsRecord.lastMessageSeenBy!
                                .contains(currentUserReference),
                            title: chatInfo.chatPreviewTitle(),
                            userProfilePic: chatInfo.chatPreviewPic(),
                            color: Color(0xFFEEF0F5),
                            unreadColor: Colors.blue,
                            titleTextStyle: GoogleFonts.getFont(
                              'DM Sans',
                              color: Colors.black,
                              fontWeight: FontWeight.bold,
                              fontSize: 14.0,
                            ),
                            dateTextStyle: GoogleFonts.getFont(
                              'DM Sans',
                              color: Color(0x73000000),
                              fontWeight: FontWeight.normal,
                              fontSize: 14.0,
                            ),
                            previewTextStyle: GoogleFonts.getFont(
                              'DM Sans',
                              color: Color(0x73000000),
                              fontWeight: FontWeight.normal,
                              fontSize: 14.0,
                            ),
                            contentPadding: EdgeInsetsDirectional.fromSTEB(
                                3.0, 3.0, 3.0, 3.0),
                            borderRadius: BorderRadius.circular(0.0),
                          );
                        },
                      );
                    },
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
