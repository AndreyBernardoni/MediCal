import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'appbar_register_model.dart';
export 'appbar_register_model.dart';

class AppbarRegisterWidget extends StatefulWidget {
  const AppbarRegisterWidget({
    Key? key,
    required this.title,
    this.icon,
  }) : super(key: key);

  final String? title;
  final Widget? icon;

  @override
  _AppbarRegisterWidgetState createState() => _AppbarRegisterWidgetState();
}

class _AppbarRegisterWidgetState extends State<AppbarRegisterWidget> {
  late AppbarRegisterModel _model;

  @override
  void setState(VoidCallback callback) {
    super.setState(callback);
    _model.onUpdate();
  }

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => AppbarRegisterModel());
  }

  @override
  void dispose() {
    _model.maybeDispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    context.watch<FFAppState>();

    return Row(
      mainAxisSize: MainAxisSize.max,
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Container(
          height: 100.0,
          decoration: BoxDecoration(
            color: FlutterFlowTheme.of(context).white,
          ),
          child: Row(
            mainAxisSize: MainAxisSize.max,
            children: [
              Image.asset(
                'assets/images/logo.png',
                width: 66.0,
                height: 100.0,
                fit: BoxFit.cover,
              ),
              Text(
                widget.title!,
                style: FlutterFlowTheme.of(context).bodyMedium.override(
                      fontFamily: 'Montserrat',
                      useGoogleFonts: GoogleFonts.asMap().containsKey(
                          FlutterFlowTheme.of(context).bodyMediumFamily),
                    ),
              ),
            ],
          ),
        ),
        if (widget.icon != null)
          Padding(
            padding: EdgeInsetsDirectional.fromSTEB(0.0, 0.0, 16.0, 0.0),
            child: InkWell(
              splashColor: Colors.transparent,
              focusColor: Colors.transparent,
              hoverColor: Colors.transparent,
              highlightColor: Colors.transparent,
              onTap: () async {
                await showDialog(
                  context: context,
                  builder: (alertDialogContext) {
                    return AlertDialog(
                      title: Text('Continue seu Cadastro'),
                      content: Text('Nos diga se você é um idoso ou cuidador!'),
                      actions: [
                        TextButton(
                          onPressed: () => Navigator.pop(alertDialogContext),
                          child: Text('Continuar'),
                        ),
                      ],
                    );
                  },
                );
              },
              child: widget.icon!,
            ),
          ),
      ],
    );
  }
}
