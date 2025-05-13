import 'package:flutter_test/flutter_test.dart';
import 'package:lost_and_found/constant/api.dart';
import 'package:lost_and_found/models/lost_found_model.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:dio/dio.dart';
import 'mockDio.mocks.dart';

@GenerateMocks([Dio])
void main() {
  late MockDio mockDio;

  setUp(() {
    mockDio = MockDio();
    when(mockDio.options).thenReturn(BaseOptions());
  });

  test('fetchItems returns list of LostFound items', () async {
    SharedPreferences.setMockInitialValues({'authToken': 'test-token'});

    final responsePayload = {
      'items': [
        {
          'id': '1',
          'title': 'Phone',
          'imagePath': 'image.jpg',
          'location': {'district': 'Kigali'},
          'postType': 'Lost',
          'postedAt': '2 days ago',
        },
      ],
    };

    when(mockDio.get(any, options: anyNamed('options'))).thenAnswer(
      (_) async => Response(
        data: responsePayload,
        statusCode: 200,
        requestOptions: RequestOptions(path: ''),
      ),
    );
    final dio = mockDio;
    final prefs = await SharedPreferences.getInstance();
    final token = prefs.getString('authToken');
    dio.options.headers = {
      'Authorization': 'Bearer $token',
      'Content-Type': 'application/json',
    };
    final response = await dio.get('$apiUrl/items');
    final data = response.data['items'] as List<dynamic>;
    final items = data.map((e) => LostFound.fromJson(e)).toList();

    expect(items, isA<List<LostFound>>());
    expect(items.first.title, 'Phone');
  }
  );
}
