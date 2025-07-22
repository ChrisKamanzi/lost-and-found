import 'package:flutter/cupertino.dart';
import 'package:http_certificate_pinning/http_certificate_pinning.dart';

class CertificatePinning {
  static Future<bool?> checkServerCertificate({
    bool showLogs = false,
    required String serverURL,
    required List<String> allowedFingerprints,
    Map<String, String>? headers,
    final int? timeout,
  }) async {
    try {
      await HttpCertificatePinning.check(
        serverURL: serverURL,
        headerHttp: headers,
        sha: SHA.SHA256,
        allowedSHAFingerprints: allowedFingerprints,
        timeout: timeout,
      );
      if (showLogs) debugPrint('Certificate matches');
      return true;
    } catch (e) {
      if (showLogs) debugPrint('Certificate pinning failed: $e');
      throw Exception("Certificate pinning failed");
    }
  }
}
