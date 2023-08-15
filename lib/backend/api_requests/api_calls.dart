import 'dart:convert';
import 'dart:typed_data';

import '../../flutter_flow/flutter_flow_util.dart';

import 'api_manager.dart';

export 'api_manager.dart' show ApiCallResponse;

const _kPrivateApiFunctionName = 'ffPrivateApiCall';

/// Start Bulario API Group Code

class BularioAPIGroup {
  static String baseUrl = 'https://bula.vercel.app';
  static Map<String, String> headers = {};
  static PesquisarCall pesquisarCall = PesquisarCall();
  static RetornarMedicamentoCall retornarMedicamentoCall =
      RetornarMedicamentoCall();
}

class PesquisarCall {
  Future<ApiCallResponse> call({
    String? nome = '',
  }) {
    return ApiManager.instance.makeApiCall(
      callName: 'Pesquisar',
      apiUrl: '${BularioAPIGroup.baseUrl}/pesquisar',
      callType: ApiCallType.GET,
      headers: {
        ...BularioAPIGroup.headers,
      },
      params: {
        'nome': nome,
      },
      returnBody: true,
      encodeBodyUtf8: false,
      decodeUtf8: false,
      cache: false,
    );
  }
}

class RetornarMedicamentoCall {
  Future<ApiCallResponse> call({
    String? numProcesso = '',
  }) {
    return ApiManager.instance.makeApiCall(
      callName: 'Retornar Medicamento',
      apiUrl: '${BularioAPIGroup.baseUrl}/medicamento/${numProcesso}',
      callType: ApiCallType.GET,
      headers: {
        ...BularioAPIGroup.headers,
      },
      params: {},
      returnBody: true,
      encodeBodyUtf8: false,
      decodeUtf8: false,
      cache: false,
    );
  }
}

/// End Bulario API Group Code

class ApiPagingParams {
  int nextPageNumber = 0;
  int numItems = 0;
  dynamic lastResponse;

  ApiPagingParams({
    required this.nextPageNumber,
    required this.numItems,
    required this.lastResponse,
  });

  @override
  String toString() =>
      'PagingParams(nextPageNumber: $nextPageNumber, numItems: $numItems, lastResponse: $lastResponse,)';
}

String _serializeList(List? list) {
  list ??= <String>[];
  try {
    return json.encode(list);
  } catch (_) {
    return '[]';
  }
}

String _serializeJson(dynamic jsonVar, [bool isList = false]) {
  jsonVar ??= (isList ? [] : {});
  try {
    return json.encode(jsonVar);
  } catch (_) {
    return isList ? '[]' : '{}';
  }
}
