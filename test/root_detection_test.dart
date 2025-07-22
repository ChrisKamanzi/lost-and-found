import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:jailbreak_root_detection/jailbreak_root_detection.dart';
import 'package:lost_and_found/pages/services/root_detection.dart';

class MockJailbreakRootDetection extends Mock
    implements JailbreakRootDetection {}

void main() {
  late MockJailbreakRootDetection mockDetection;

  setUp(() {
    mockDetection = MockJailbreakRootDetection();
  });

  test('returns true when device is jailbroken', () async {
    when(() => mockDetection.isJailBroken).thenAnswer((_) async => true);
    when(() => mockDetection.isRealDevice).thenAnswer((_) async => true);
    when(() => mockDetection.isNotTrust).thenAnswer((_) async => false);

    final result = await DeviceSecurity.isDeviceCompromised(
      //detection: mockDetection,
      showLogs: true,
    );
    expect(result, isTrue);
  });

  test('returns true when device is not real', () async {
    when(() => mockDetection.isJailBroken).thenAnswer((_) async => false);
    when(() => mockDetection.isRealDevice).thenAnswer((_) async => false);
    when(() => mockDetection.isNotTrust).thenAnswer((_) async => false);

    final result = await DeviceSecurity.isDeviceCompromised(
      //detection: mockDetection,
      showLogs: true,
    );
    expect(result, isTrue);
  });

  test('returns true when device is not trusted', () async {
    when(() => mockDetection.isJailBroken).thenAnswer((_) async => false);
    when(() => mockDetection.isRealDevice).thenAnswer((_) async => true);
    when(() => mockDetection.isNotTrust).thenAnswer((_) async => true);

    final result = await DeviceSecurity.isDeviceCompromised(
      //detection: mockDetection,
      showLogs: true,
    );
    expect(result, isTrue);
  });

  test('returns false when device is secure', () async {
    when(() => mockDetection.isJailBroken).thenAnswer((_) async => false);
    when(() => mockDetection.isRealDevice).thenAnswer((_) async => true);
    when(() => mockDetection.isNotTrust).thenAnswer((_) async => false);

    final result = await DeviceSecurity.isDeviceCompromised(
     // detection: mockDetection,
     showLogs: true,
    );
    expect(result, isFalse);
  });

  test('returns null when exception is thrown', () async {
    when(
      () => mockDetection.isJailBroken,
    ).thenThrow(Exception('Unexpected error'));
    when(() => mockDetection.isRealDevice).thenAnswer((_) async => true);
    when(() => mockDetection.isNotTrust).thenAnswer((_) async => false);

    final result = await DeviceSecurity.isDeviceCompromised(
     // detection: mockDetection,
    showLogs: true,
    );
    expect(result, isNull);
  });
}
