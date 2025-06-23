import 'package:http_certificate_pinning/http_certificate_pinning.dart';
import 'package:lost_and_found/stateManagment/Notifier/user_notifier.dart';

class CertificatePinningService {
  static Future<void> checkServerCertificate() async {
    try {
      final result = await HttpCertificatePinning.check(
        serverURL: apiUrl,
        headerHttp: {},
        sha: SHA.SHA256,
        allowedSHAFingerprints: [
          '02ad93ebc8c3a2502fb0d67b19bbb33851ae0f45b95be6ae63ea890ea5150fa8',
        ],
        timeout: 50,
      );
      ;
      if (result == "CONNECTION_SECURE") {
        print('Certificate is valid and matches.');
      } else {
        print('Certificate does not match.');
      }
    } catch (e) {
      print('Error during certificate pinning: $e');
    }
  }
}
