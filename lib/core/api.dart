import 'package:dio/dio.dart';

const kBaseUrl = 'https://api.themoviedb.org/3';
const kServerError = 'Failed to connect to the server. Try again later.';
const kApiKey =
    'eyJhbGciOiJIUzI1NiJ9.eyJhdWQiOiJhNWJkZmE4NDUxYmIzMDY2NDA4ZTk3MjhkY2EwODFjOCIsInN1YiI6IjY0OWI3YjQyOTYzODY0MDBhZTdjODg1MyIsInNjb3BlcyI6WyJhcGlfcmVhZCJdLCJ2ZXJzaW9uIjoxfQ.JHwugphY3KBq_7krDAGeJysQS51E2cvb2Le7s82THqQ';
final kDioOption = BaseOptions(
  baseUrl: kBaseUrl,
  connectTimeout: const Duration(milliseconds: 5000),
  receiveTimeout: const Duration(milliseconds: 5000),
  contentType: 'application/json;charset=utf-8',
  headers: {'Authorization': 'Bearer $kApiKey'},
);
