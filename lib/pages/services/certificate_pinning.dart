import 'package:flutter/cupertino.dart';
import 'package:http_certificate_pinning/http_certificate_pinning.dart';


class CertificatePinningService implements ICertificatePinningService {
  @override
  Future<bool> checkServerCertificate({
    required String serverURL,
    required List<String> allowedFingerprints,
  }) async {
    try {
      await HttpCertificatePinning.check(
        serverURL: serverURL,
        headerHttp: {},
        sha: SHA.SHA256,
        allowedSHAFingerprints: allowedFingerprints,
        timeout: 50,
      );
      debugPrint('Certificate matches');
      return true;
    } catch (e) {
      debugPrint('Certificate pinning failed: $e');
      return false;
    }
  }
}

abstract class ICertificatePinningService {
  Future<bool> checkServerCertificate({
    required String serverURL,
    required List<String> allowedFingerprints,
  });
}
