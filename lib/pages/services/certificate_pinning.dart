import 'package:flutter/cupertino.dart';
import 'package:http_certificate_pinning/http_certificate_pinning.dart';

class CertificatePinning {
  static Future<bool?> checkServerCertificate({
    required String serverURL,
    required List<String> allowedFingerprints,
    Map<String, String>? headers,
    required int timeout,

  }) async {
    try {
      await HttpCertificatePinning.check(
        serverURL: serverURL,
        headerHttp: headers,
        sha: SHA.SHA256,
        allowedSHAFingerprints: allowedFingerprints,
        timeout: timeout,
      );
      debugPrint('Certificate matches');
      return true;
    } catch (e) {
      debugPrint('Certificate pinning failed: $e');
      return null;
    }
  }
}
