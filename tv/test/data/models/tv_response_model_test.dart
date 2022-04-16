import 'dart:convert';

import 'package:tv/data/models/tv_model.dart';
import 'package:tv/data/models/tv_response.dart';
import 'package:flutter_test/flutter_test.dart';

import '../../../../core/test/json_reader.dart';

void main() {
  const tTvModel = TvModel(
    backdropPath: "/path.jpg",
    firstAirDate: "2010-10-31",
    genreIds: [1, 2, 3, 4],
    id: 52814,
    name: "Name",
    originalName: "Original Name",
    overview: "Overview",
    popularity: 1.0,
    posterPath: "/path.jpg",
    voteAverage: 1.0,
    voteCount: 1,
  );
  const tTvResponseModel = TvResponse(tvList: <TvModel>[tTvModel]);
  group('fromJson', () {
    test('should return a valid model from JSON', () async {
      // arrange
      final Map<String, dynamic> jsonMap =
          json.decode(readJson('dummy_data/on_the_air.json'));
      // act
      final result = TvResponse.fromJson(jsonMap);
      // assert
      expect(result, tTvResponseModel);
    });
  });

  group('toJson', () {
    test('should return a JSON map containing proper data', () async {
      // arrange

      // act
      final result = tTvResponseModel.toJson();
      // assert
      final expectedJsonMap = {
        "results": [
          {
            "backdrop_path": "/path.jpg",
            "first_air_date": "2010-10-31",
            "genre_ids": [1, 2, 3, 4],
            "id": 52814,
            "name": "Name",
            "original_name": "Original Name",
            "overview": "Overview",
            "popularity": 1.0,
            "poster_path": "/path.jpg",
            "vote_average": 1.0,
            "vote_count": 1
          }
        ],
      };
      expect(result, expectedJsonMap);
    });
  });
}
