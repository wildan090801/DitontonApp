import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:tv/domain/usecases/remove_watchlist_tv.dart';

import '../../../test/dummy_data/dummy_objects.dart';
import '../../../../core/test/helpers/test_helper.mocks.dart';

void main() {
  late RemoveTvWatchlist usecase;
  late MockTvRepository mockTvRepository;

  setUp(() {
    mockTvRepository = MockTvRepository();
    usecase = RemoveTvWatchlist(mockTvRepository);
  });

  test('should remove watchlist tv from repository', () async {
    // arrange
    when(mockTvRepository.removeWatchlist(testTvDetail))
        .thenAnswer((_) async => const Right('Removed from watchlist'));
    // act
    final result = await usecase.execute(testTvDetail);
    // assert
    verify(mockTvRepository.removeWatchlist(testTvDetail));
    expect(result, const Right('Removed from watchlist'));
  });
}
