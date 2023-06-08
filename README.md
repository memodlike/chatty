# Chatty : Clean architecture with MVVM

```yaml
dependencies:

  cupertino_icons: ^1.0.2
  retrofit: ^3.0.1+1
  analyzer: ^5.2.0
  dio: ^4.0.6
  dartz: ^0.10.1
  internet_connection_checker: ^1.0.0+1
  pretty_dio_logger: ^1.2.0-beta-1
  freezed_annotation: ^2.2.0
  json_annotation: ^4.7.0
  flutter_bloc: ^8.1.1
  equatable: ^2.0.5
  get_it: ^7.2.0
  flutter_staggered_grid_view: ^0.6.2
  cached_network_image: ^3.2.3
  share_plus: ^6.3.0
  shimmer: ^2.0.0
  flutter_chatgpt_api: ^1.1.0

dev_dependencies:
  flutter_lints: ^2.0.0

  retrofit_generator: ^4.0.1
  build_runner: ^2.1.11
  json_serializable: ^6.2.0
```

### Folder Structure
Here is the core folder structure which flutter provides.

```
flutter-app/
|- android
|- build
|- ios
|- lib
    |- app/
    |- core/
    |- features/
    |- main
```

Here is the folder structure we have been using in this project

```
lib/app/
       |- app/
       |- base_usecase/
       |- constant/
       |- di/
       |- extension/

lib/core/
       |- error/
       |- network/
       |- widgets/
       |- utils/
            |- assets
            |- routes
            |- strings
            |- values
            
lib/features/
       |- splash/
       |- home/
       |- image_generation/
       |- text_completion/
       |- chat/  
       
 lib/features/image_generation/
       |- data/
       |- domain/
       |- presentation/       
       
data/
       |- data_source/
       |- model/
            |- mapper/
            |- responses/
       |- repository/

domain/
       |- entities/
       |- repository/
       |- usecase/

presentation/
       |- cubit/
       |- pages/
       |- widgets/

  lib/features/text_completion/
       |- data/
       |- domain/
       |- presentation/

data/
       |- data_source/
       |- model/
            |- mapper/
            |- responses/
       |- repository/

domain/
       |- entities/
       |- repository/
       |- usecase/

presentation/
       |- cubit/
       |- pages/
       |- widgets/
```

# code

- lib/app/app.dart

```dart
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../core/utils/routes_manager.dart';
import '../features/02_image_generation/presentation/cubit/image_generation_cubit.dart';
import '../features/03_text_completion/presentation/cubit/text_completion_cubit.dart';
import 'di.dart';

class MyApp extends StatefulWidget {
  const MyApp._internal();
  static const MyApp _instance = MyApp._internal();
  factory MyApp() => _instance;
  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
        providers: [
          BlocProvider<ImageGenerationCubit>(
            create: (_) => instance<ImageGenerationCubit>(),
          ),
          BlocProvider<TextCompletionCubit>(
            create: (_) => instance<TextCompletionCubit>(),
          ),
        ],
        child: MaterialApp(
          debugShowCheckedModeBanner: false,
          theme: ThemeData(brightness: Brightness.dark),
          onGenerateRoute: RouteGenerator.getRoute,
          initialRoute: Routes.splashRoute,
        ));
  }
}
```
- lib/app/base_usecase.dart
```dart
import 'package:dartz/dartz.dart';

import '../../core/error/failure.dart';

abstract class BaseUseCase<In, Out> {
  Future<Either<Failure, Out>> execute(In input);
}

```
- lib/app/constants.dart
```dart
// ignore_for_file: constant_identifier_names

import 'package:flutter/material.dart';

class Constants {
  static const String baseUrl = "https://api.openai.com/v1";
  static const String endPointImage = "/images/generations";
  static const String endPointText = "/completions";
  static const int apiTimeOut = 60000;
  static const String OPEN_AI_KEY =
      "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";
  static const String empty = "";
  static const int zero = 0;

  static final glowBoxShadow = [
    BoxShadow(
      color: Colors.black.withOpacity(.4),
      blurRadius: 6.0,
      spreadRadius: 3.0,
      offset: const Offset(
        0.0,
        3.0,
      ),
    ),
  ];

  static const darkColor = Color.fromRGBO(48, 48, 48, 1);

  static const String CLEARANCE_TOKEN =
      "HcM4KHJPHJn9qQh.VBTUqIwnYZo_wq4CfKz1rcla53g-1672471456-0-1-eaa6b392.d5df18bd.bda7ec72-160";
  static const String SESSION_TOKEN =
      "eyJhbGciOiJkaXIiLCJlbmMiOiJBMjU2R0NNIn0..1fauGkX74yeXleSf.bQwwUNh4dKV1U-HDvlKqfqihTO_iaWtGQeSxH0lHzT6sbUaXY1jd3-aXOi6mo9TMktuAK-PT1HxRNVq5nKIoV8I5oRW58639EY8Vn5BsI2rcA3atS8jVyXgrQttvAyCtJI-YaJ1neebTsbACS7mS1zpfyvFOvk6zuE8fNg5mcvd0ItJZbN9x5TAUStoV8mwgxE1UZHGwTQCvR333w2Vb1FmdkU6g3mrMP9W_Oj8RpE96T8gKQ_T-Sw7hvDIUCQ3oyoTxXmd--CdEnbsVlWrzdVLM17nv-mTKM6vWaTu81DUq_m54G7vWo-b3zFYB3t1iFG3gjeuZxo8Dz6C2baCXUSEnTGsYy9f5kLPiC8iJMt_ItPjr3-I5YnZCKVzLp_XIOMQ5adpAmXku2MBznx827pXpwnC0JzFU51PxeSVWQtP6uNrWED_wTYsBsFyjjHx_smheXWLHbAa1UZjbWIze2WAUTZC0BwFCXkc6opQev-YiKoXsn4mkAT49Jp32Q_h34XULgnbLuTuwg_4pMwO2aWkTLXsJpqRog2UygXPveVQAT_aCY6G6jMg-DeKFdOZmz0lh_k6HGR36rrpnhzXS-QBIrM_t1e8BCc6vGOcuMfQKtshXZAuhM2fJ2ftElrW6WCgfgPeHVxakjXRMvay04fb85rep91IFoFWshgKfI5CK9TJpHhdGuB9WsFDIhNETtSiYo_qF4vh9yWaSFCutBO5eRJzcovPJ4BPhjlSROEv70gHnRPqoJFyTpj8t7MYKRoXAbapfRjf-BoFL8pKoyrzUGdrATFlXgVFXT5mlktLWEjaemlYuUOysMzZqNq4ihnqr0RiBoNaIl8fAZi6xE2k0O85siacJmz0rd6z4hX4UXV9ZkeqT88A98Mz-bUweu-XearTxfg9IZuDJZngc95FHd4n3Po_eOTjBzB5RgNGOWE3ftaB7lwJiyZhlB0zXmiAkAL7pCJTnLVWNKpT7zqqajtj_D9d6YIGBLu3wGw64DX8ZWLbcK4hiruVS2Ggews_3pTjKjxUmDocEicQ9ViR2s8awEXdFmdHBy4WmuVKL6NDtNHqo-RlBg-WaJWcrcywl20XuHUFOQFZX2nWhqmB-BiFP5FCWmpNP8_niaEdBZfGBAwblhXhUbBbbCIq_zIRhHTjGngDRjB56IwWQPkNQ9W2AUuFb4hqXUNgnY-3EUB3kTbmdtUewguZIRlLLFSBlObTCgcGojSc2HGaiBCD55rFF7S4Sr-1EeK-IgL0dh3exHZyTEivn-KRMeqMkZmXBDuenVsAwFkSUoGxRK6Aa6ONG5WICDqEV8tIhhayKixAia4wQSpfIiToOV4zr1KNs6c5s7EbQN0droZJmV9IRFHGk2HBZV_jvCVpQJ5_OrRheEZY8wfFaOOM6L1f2zqBSHkUKtpkNA584-32hPk5uAc_I1PW0h2bOVnJKKGVKxPBXY_qLRx3vJwLhr9U_AzhGwlYIGy1mLep1joOW_5SjHV9G7Ggc1ABV1wa0huV00Fc__qCkDUgH9TlOODc7qO6hfetyNS5K_mnpX_IirkAK6blsqmHbHhofYG3eWH8oYi2zFMVV0FbFp1RetJbgbthJNk4fBIDuVhjXl6IBRZlHsG8oJ7FKiOz5Wml0UojhVP6Z7EQK6ODL6J0zTzQM5MT2HiPFe7K63mM4KKUpPoTeHmjckXmk_joHI47T333VY1XMvEfrTwStN0iWRkl_k5toLipbqVd5z98Y9HHW3KiHTXnmzxdNjVNnzGSSypCtIttwz5vs_mN4o4R0etq6HLef5SCfQSs2EZM0zvGBFRZL9GmV9e5g35oHpZtKXUCZBrgsYq65jyg2J2Y6mzGyGjRD6PntQN9MKnEwH8l1JaE7Nd2V4nEjN9al0HvzZn_Rkns_E_iRsKoSi4irROZH0Vex2Xk2R28fWt8yVUPL1fvWbmHVakGXl0yj_pHLkj_zyiM9uAMmQuA4loT8exLgLLQ7jGy4JUdVUxGpBw9WJyUzmV_J6zdyJmJw5LqWG989dXR6CfI556wfqwku5vuQNmfRBOBV7FnieC3nJGlOvKbTqJcNcpC3raF9Bxo1jONl5x1vDHvfZPNo1bF6JrWp3qeBELMNVRk5nzxUpnEqIht4mnWMAzE82djoQn_M7g25a2DXf1AEuLO4xXOkJPbduqn8-r8xZ6SBrS7KxnrbS7xxsSXHGCcGvNACUekgHWtcfsI7IxIjrfB_xoUARuFRF6ndHRf8xm8Mev8MwjzVTmIzxHHP0bni73ZMB0PbcJsYXj6OQ1uqV-v1elFZVLcQdHkvd2ngZdR8jI6bbyAH7-6xlZxxaHAeakT3GeTCwFUdc2Bhd5pfT6Ca_SToCGWxEkOW.Q9Dv6RNAcGFukE8xQU6Jtg";
}

```
- lib/app/di.dart
```dart
import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';

import '../core/network/app_api.dart';
import '../core/network/dio_factory.dart';
import '../core/network/network_info.dart';
import '../features/02_image_generation/data/datasources/remote_datasources.dart';
import '../features/02_image_generation/data/repositories/repository_impl.dart';
import '../features/02_image_generation/domain/repositories/repository.dart';
import '../features/02_image_generation/domain/usecases/get_generate_image.dart';
import '../features/02_image_generation/presentation/cubit/image_generation_cubit.dart';
import '../features/03_text_completion/data/datasources/remote_datasources.dart';
import '../features/03_text_completion/data/repositories/repository_impl.dart';
import '../features/03_text_completion/domain/repositories/repository.dart';
import '../features/03_text_completion/domain/usecases/get_text_completion_usecase.dart';
import '../features/03_text_completion/presentation/cubit/text_completion_cubit.dart';

final instance = GetIt.instance;

Future<void> initAppModule() async {
  // network info
  instance.registerLazySingleton<NetworkInfo>(
      () => NetworkInfoImpl(InternetConnectionChecker()));

  // dio factory
  instance.registerLazySingleton<DioFactory>(() => DioFactory());

  Dio dio = await instance<DioFactory>().getDio();
  //app service client
  instance.registerLazySingleton<AppServiceClient>(() => AppServiceClient(dio));

// -------------------- Image Generation--------------------
  // remote data source
  instance.registerLazySingleton<ImageRemoteDataSource>(
      () => ImageRemoteDataSourceImpl(instance<AppServiceClient>()));

  // repository
  instance.registerLazySingleton<ImageRepository>(() => ImageRepositoryImpl(
        instance<ImageRemoteDataSource>(),
        instance<NetworkInfo>(),
      ));

  instance.registerLazySingleton<ImageGenerationUseCase>(
      () => ImageGenerationUseCase(instance()));
  //Futures bloc
  instance.registerLazySingleton<ImageGenerationCubit>(
    () => ImageGenerationCubit(
      imageGenerationUseCase: instance(),
    ),
  );

  // -------------------- Image Generation--------------------
  // remote data source
  instance.registerLazySingleton<TextCompletionRemoteDataSource>(
      () => TextCompletionRemoteDataSourceImpl(instance<AppServiceClient>()));

  // repository
  instance.registerLazySingleton<TextCompletionRepository>(
      () => TextCompletionRepositoryImpl(
            instance<TextCompletionRemoteDataSource>(),
            instance<NetworkInfo>(),
          ));

  instance.registerLazySingleton<TextCompletionUseCase>(
      () => TextCompletionUseCase(instance()));
  //Futures bloc
  instance.registerLazySingleton<TextCompletionCubit>(
    () => TextCompletionCubit(
      textCompletionUseCase: instance(),
    ),
  );
}

```
- lib/app/extensions.dart
```dart
import 'constants.dart';

extension NonNullString on String? {
  String orEmpty() {
    if (this == null) {
      return Constants.empty;
    } else {
      return this!;
    }
  }
}

extension NonNullInteger on int? {
  int orZero() {
    if (this == null) {
      return Constants.zero;
    } else {
      return this!;
    }
  }
}

extension NonNullNum on num? {
  num orZero() {
    if (this == null) {
      return Constants.zero;
    } else {
      return this!;
    }
  }
}

```
- core/error/error_handler.dart
```dart
// ignore_for_file: constant_identifier_names, non_constant_identifier_names

import 'package:dio/dio.dart';

import '../utils/strings_manager.dart';
import 'failure.dart';


class ErrorHandler implements Exception {
  late Failure failure;

  ErrorHandler.handle(dynamic error) {
    if (error is DioError) {
      // dio error so its an error from response of the API or from dio itself
      failure = _handleError(error);
    } else {
      // default error
      failure = DataSource.DEFAULT.getFailure();
    }
  }
}

Failure _handleError(DioError error) {
  switch (error.type) {
    case DioErrorType.connectTimeout:
      return DataSource.CONNECT_TIMEOUT.getFailure();
    case DioErrorType.sendTimeout:
      return DataSource.SEND_TIMEOUT.getFailure();
    case DioErrorType.receiveTimeout:
      return DataSource.RECEIVE_TIMEOUT.getFailure();
    case DioErrorType.response:
      if (error.response != null &&
          error.response?.statusCode != null &&
          error.response?.statusMessage != null) {
        return Failure(error.response?.statusCode ?? 0,
            error.response?.statusMessage ?? "");
      } else {
        return DataSource.DEFAULT.getFailure();
      }
    case DioErrorType.cancel:
      return DataSource.CANCEL.getFailure();
    case DioErrorType.other:
      return DataSource.DEFAULT.getFailure();
  }
}

enum DataSource {
  SUCCESS,
  NO_CONTENT,
  BAD_REQUEST,
  FORBIDDEN,
  UNAUTHORIZED,
  NOT_FOUND,
  INTERNAL_SERVER_ERROR,
  CONNECT_TIMEOUT,
  CANCEL,
  RECEIVE_TIMEOUT,
  SEND_TIMEOUT,
  CACHE_ERROR,
  NO_INTERNET_CONNECTION,
  DEFAULT
}

extension DataSourceExtension on DataSource {
  Failure getFailure() {
    switch (this) {
      case DataSource.SUCCESS:
        return Failure(ResponseCode.SUCCESS, ResponseMessage.SUCCESS);
      case DataSource.NO_CONTENT:
        return Failure(ResponseCode.NO_CONTENT, ResponseMessage.NO_CONTENT);
      case DataSource.BAD_REQUEST:
        return Failure(ResponseCode.BAD_REQUEST, ResponseMessage.BAD_REQUEST);
      case DataSource.FORBIDDEN:
        return Failure(ResponseCode.FORBIDDEN, ResponseMessage.FORBIDDEN);
      case DataSource.UNAUTHORIZED:
        return Failure(ResponseCode.UNAUTHORIZED, ResponseMessage.UNAUTHORIZED);
      case DataSource.NOT_FOUND:
        return Failure(ResponseCode.NOT_FOUND, ResponseMessage.NOT_FOUND);
      case DataSource.INTERNAL_SERVER_ERROR:
        return Failure(ResponseCode.INTERNAL_SERVER_ERROR,
            ResponseMessage.INTERNAL_SERVER_ERROR);
      case DataSource.CONNECT_TIMEOUT:
        return Failure(
            ResponseCode.CONNECT_TIMEOUT, ResponseMessage.CONNECT_TIMEOUT);
      case DataSource.CANCEL:
        return Failure(ResponseCode.CANCEL, ResponseMessage.CANCEL);
      case DataSource.RECEIVE_TIMEOUT:
        return Failure(
            ResponseCode.RECEIVE_TIMEOUT, ResponseMessage.RECEIVE_TIMEOUT);
      case DataSource.SEND_TIMEOUT:
        return Failure(ResponseCode.SEND_TIMEOUT, ResponseMessage.SEND_TIMEOUT);
      case DataSource.CACHE_ERROR:
        return Failure(ResponseCode.CACHE_ERROR, ResponseMessage.CACHE_ERROR);
      case DataSource.NO_INTERNET_CONNECTION:
        return Failure(ResponseCode.NO_INTERNET_CONNECTION,
            ResponseMessage.NO_INTERNET_CONNECTION);
      case DataSource.DEFAULT:
        return Failure(ResponseCode.DEFAULT, ResponseMessage.DEFAULT);
    }
  }
}

class ResponseCode {
  static const int SUCCESS = 200; // success with data
  static const int NO_CONTENT = 201; // success with no data (no content)
  static const int BAD_REQUEST = 400; // failure, API rejected request
  static const int UNAUTHORIZED = 401; // failure, user is not authorized
  static const int FORBIDDEN = 403; //  failure, API rejected request
  static const int INTERNAL_SERVER_ERROR = 500; // failure, crash in server side
  static const int NOT_FOUND = 404; // failure, not found

  // local status code
  static const int CONNECT_TIMEOUT = -1;
  static const int CANCEL = -2;
  static const int RECEIVE_TIMEOUT = -3;
  static const int SEND_TIMEOUT = -4;
  static const int CACHE_ERROR = -5;
  static const int NO_INTERNET_CONNECTION = -6;
  static const int DEFAULT = -7;
}

class ResponseMessage {
  static  String SUCCESS = AppStrings.success; // success with data
  static  String NO_CONTENT =
      AppStrings.noContent; // success with no data (no content)
  static  String BAD_REQUEST =
      AppStrings.badRequestError; // failure, API rejected request
  static  String UNAUTHORIZED =
      AppStrings.unauthorizedError; // failure, user is not authorized
  static  String FORBIDDEN =
      AppStrings.forbiddenError; //  failure, API rejected request
  static  String INTERNAL_SERVER_ERROR =
      AppStrings.internalServerError; // failure, crash in server side
  static  String NOT_FOUND =
      AppStrings.notFoundError; // failure, crash in server side

  // local status code
  static  String CONNECT_TIMEOUT = AppStrings.timeoutError;
  static  String CANCEL = AppStrings.defaultError;
  static  String RECEIVE_TIMEOUT = AppStrings.timeoutError;
  static  String SEND_TIMEOUT = AppStrings.timeoutError;
  static  String CACHE_ERROR = AppStrings.cacheError;
  static  String NO_INTERNET_CONNECTION = AppStrings.noInternetError;
  static  String DEFAULT = AppStrings.defaultError;
}
```
- core/error/failure.dart
```dart
class Failure {
  int code;
  String message;
  Failure(this.code, this.message);
}
```
- core/network/app_api.dart
```dart
import 'package:dio/dio.dart';
import 'package:retrofit/http.dart';

import '../../app/constants.dart';
import '../../features/02_image_generation/data/model/responses/responses.dart';
import '../../features/03_text_completion/data/models/responses/responses.dart';


part 'app_api.g.dart';

@RestApi(baseUrl: Constants.baseUrl)
abstract class AppServiceClient {
  factory AppServiceClient(Dio dio, {String baseUrl}) = _AppServiceClient;

  @POST(Constants.endPointImage)
  Future<ImageDataResponse> getGenerateImages(
    @Field("prompt") String prompt,
    @Field("n") int number,
    @Field("size") String size,
  );
  
  @POST(Constants.endPointText)
  Future<TextCompletionResponse> getTextCompletion(
    @Field("model") String model,
    @Field("max_tokens") int maxTokens,

    @Field("prompt") String promptText,
  );
}
```
- core/network/app_api.g.dart
```dart
// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'app_api.dart';

// **************************************************************************
// RetrofitGenerator
// **************************************************************************

// ignore_for_file: unnecessary_brace_in_string_interps,no_leading_underscores_for_local_identifiers

class _AppServiceClient implements AppServiceClient {
  _AppServiceClient(
    this._dio, {
    this.baseUrl,
  }) {
    baseUrl ??= 'https://api.openai.com/v1';
  }

  final Dio _dio;

  String? baseUrl;

  @override
  Future<ImageDataResponse> getGenerateImages(
    prompt,
    number,
    size,
  ) async {
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    final _headers = <String, dynamic>{};
    final _data = {
      'prompt': prompt,
      'n': number,
      'size': size,
    };
    final _result = await _dio
        .fetch<Map<String, dynamic>>(_setStreamType<ImageDataResponse>(Options(
      method: 'POST',
      headers: _headers,
      extra: _extra,
    )
            .compose(
              _dio.options,
              '/images/generations',
              queryParameters: queryParameters,
              data: _data,
            )
            .copyWith(baseUrl: baseUrl ?? _dio.options.baseUrl)));
    final value = ImageDataResponse.fromJson(_result.data!);
    return value;
  }

  @override
  Future<TextCompletionResponse> getTextCompletion(
    model,
    maxTokens,
    promptText,
  ) async {
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    final _headers = <String, dynamic>{};
    final _data = {
      'model': model,
      'max_tokens': maxTokens,
      'prompt': promptText,
    };
    final _result = await _dio.fetch<Map<String, dynamic>>(
        _setStreamType<TextCompletionResponse>(Options(
      method: 'POST',
      headers: _headers,
      extra: _extra,
    )
            .compose(
              _dio.options,
              '/completions',
              queryParameters: queryParameters,
              data: _data,
            )
            .copyWith(baseUrl: baseUrl ?? _dio.options.baseUrl)));
    final value = TextCompletionResponse.fromJson(_result.data!);
    return value;
  }

  RequestOptions _setStreamType<T>(RequestOptions requestOptions) {
    if (T != dynamic &&
        !(requestOptions.responseType == ResponseType.bytes ||
            requestOptions.responseType == ResponseType.stream)) {
      if (T == String) {
        requestOptions.responseType = ResponseType.plain;
      } else {
        requestOptions.responseType = ResponseType.json;
      }
    }
    return requestOptions;
  }
}
```
- core/network/dio_factory.dart
```dart
// ignore_for_file: constant_identifier_names

import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';

import '../../app/constants.dart';

const String APPLICATION_JSON = "application/json";
const String CONTENT_TYPE = "content-type";
const String ACCEPT = "accept";
const String AUTHORIZATION = "authorization";

class DioFactory {
  Future<Dio> getDio() async {
    Dio dio = Dio();

    Map<String, String> headers = {
      CONTENT_TYPE: APPLICATION_JSON,
      ACCEPT: APPLICATION_JSON,
      AUTHORIZATION: "Bearer ${Constants.OPEN_AI_KEY}",
    };

    dio.options = BaseOptions(
      baseUrl: Constants.baseUrl,
      headers: headers,
      receiveTimeout: Constants.apiTimeOut,
      sendTimeout: Constants.apiTimeOut,
    );

    if (!kReleaseMode) {
      // its debug mode so print app logs
      dio.interceptors.add(
        PrettyDioLogger(
          requestHeader: true,
          requestBody: true,
          responseHeader: true,
        ),
      );
    }
    return dio;
  }
}
```
- core/network/network_info.dart
```dart
import 'package:internet_connection_checker/internet_connection_checker.dart';

abstract class NetworkInfo {
  Future<bool> get isConnected;
}

class NetworkInfoImpl implements NetworkInfo {
  final InternetConnectionChecker _internetConnectionChecker;

  NetworkInfoImpl(this._internetConnectionChecker);

  @override
  Future<bool> get isConnected => _internetConnectionChecker.hasConnection;
}


```
- core/utils/assets_manager.dart
```dart
// ignore_for_file: constant_identifier_names

const String IMAGE_PATH = 'assets/images';

class ImageAssets {
  static const String appLogo = '$IMAGE_PATH/Chatty_logo.png';
  static const String loading = '$IMAGE_PATH/loading.gif';
  static const String openAiAvatar = '$IMAGE_PATH/open-ai-avatar.png';
}

```
- core/utils/routes_manager.dart
```dart
import 'package:flutter/material.dart';

import '../../features/03_text_completion/presentation/pages/text_completion_page.dart';
import '../../features/04_chat/chat.dart';
import '../../features/01_home/home_page.dart';
import '../../features/02_image_generation/presentation/pages/image_generation_page.dart';
import '../../features/00_splash/splash_screen.dart';
import 'strings_manager.dart';

class Routes {
  static const String splashRoute = '/';
  static const String homeRoute = '/home';
  static const String imageRoute = '/image';
  static const String textRoute = '/text';
  static const String chatRoute = '/chat';
}

class RouteGenerator {
  static Route<dynamic> getRoute(RouteSettings settings) {
    switch (settings.name) {
      case Routes.splashRoute:
        return MaterialPageRoute(
          builder: (_) => const SplashScreen(),
        );
        case Routes.homeRoute:
        return MaterialPageRoute(
          builder: (_) => const HomePage(),
        );
        case Routes.imageRoute:
        return MaterialPageRoute(
          builder: (_) => const ImageGenerationPage(),
        );
                case Routes.textRoute:
        return MaterialPageRoute(
          builder: (_) => const TextCompletionPage(),
        );
        case Routes.chatRoute:
        return MaterialPageRoute(
          builder: (_) => const ChatPage(),
        );

      
      default:
        return unDefinedRoute();
    }
  }

  static Route<dynamic> unDefinedRoute() {
    return MaterialPageRoute(
      builder: (_) => Scaffold(
        appBar: AppBar(
          title: const Text(
            AppStrings.noRouteFound,
          ),
        ),
        body: const Center(
          child: Text(
            AppStrings.noRouteFound,
          ),
        ),
      ),
    );
  }
}
```
- core/utils/strings_manager.dart
```dart
class AppStrings {
  static const noRouteFound = "Маршрут не найден";
  static const imageGeneration = "Генерация изображения";
  static const textCompletion = "Генерация текста";
  // error handler
  static const String success = "success";
  static const String badRequestError = "bad_request_error";
  static const String noContent = "no_content";
  static const String forbiddenError = "forbidden_error";
  static const String unauthorizedError = "unauthorized_error";
  static const String notFoundError = "not_found_error";
  static const String conflictError = "conflict_error";
  static const String internalServerError = "internal_server_error";
  static const String unknownError = "unknown_error";
  static const String timeoutError = "timeout_error";
  static const String defaultError = "default_error";
  static const String cacheError = "cache_error";
  static const String noInternetError = "no_internet_error";
}
```
- core/utils/values_manager.dart
```dart
class AppMargin {
  static const double m8 = 8.0;
  static const double m12 = 12.0;
  static const double m14 = 14.0;
  static const double m16 = 16.0;
  static const double m18 = 18.0;
  static const double m20 = 20.0;
}

class AppPadding {
  static const double p2 = 2.0;
  static const double p8 = 8.0;
  static const double p12 = 12.0;
  static const double p14 = 14.0;
  static const double p16 = 16.0;
  static const double p18 = 18.0;
  static const double p20 = 20.0;
  static const double p28 = 28.0;
  static const double p60 = 60.0;
  static const double p100 = 100.0;
}

class AppSize {
  static const double s0 = 0;
  static const double s1 = 1;
  static const double s1_5 = 1.5;
  static const double s2 = 2;
  static const double s4 = 4.0;
  static const double s8 = 8.0;
  static const double s10 = 10.0;
  static const double s14 = 14.0;
  static const double s16 = 16.0;
  static const double s18 = 18.0;
  static const double s20 = 20.0;
  static const double s30 = 30.0;
  static const double s40 = 40.0;
  static const double s50 = 50.0;
  static const double s60 = 60.0;
  static const double s100 = 100.0;
  static const double s150 = 150.0;
  static const double s130 = 130.0;
  static const double s220 = 220.0;
  static const double s350 = 350.0;
}
```
- core/widgets/loading_widgets.dart
```dart
import 'package:flutter/material.dart';

import '../utils/assets_manager.dart';
import '../utils/values_manager.dart';

class LoadingWidget extends StatelessWidget {
  const LoadingWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: SizedBox(
        width: AppSize.s350,
        height: AppSize.s350,
        child: Image.asset(ImageAssets.loading),
      ),
    );
  }
}
```
- core/widgets/search_text_field_widget.dart
```dart


import 'package:flutter/material.dart';

class SearchTextFieldWidget extends StatelessWidget {
  final TextEditingController? textEditingController;
  final VoidCallback? onTap;

  const SearchTextFieldWidget({
    Key? key,
    this.textEditingController,
    this.onTap,
  }) : super(key: key);


  @override
  Widget build(BuildContext context) {
    return _searchTextField();
  }

  Widget _searchTextField() {
    return Container(
      margin: const EdgeInsets.only(bottom: 10, left: 4, right: 4),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          Expanded(
            child: Container(
              decoration: BoxDecoration(
                  borderRadius: const BorderRadius.all(Radius.circular(10)),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(.2),
                      offset: const Offset(0.0, 0.50),
                      spreadRadius: 1,
                      blurRadius: 1,
                    )
                  ]),
              child: Column(
                children: [
                  Row(
                    children: [
                      const SizedBox(
                        width: 20,
                      ),
                      Expanded(
                        child: ConstrainedBox(
                          constraints: const BoxConstraints(maxHeight: 60),
                          child: Scrollbar(
                            child: TextField(
                              style: const TextStyle(fontSize: 14),
                              controller: textEditingController,
                              maxLines: null,
                              decoration: const InputDecoration(
                                  border: InputBorder.none,
                                  hintText: "Open AI Waiting for your query..."),
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(
                        width: 15,
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(
            width: 5,
          ),
          InkWell(
            onTap: textEditingController!.text.isEmpty
                ? null
                : onTap,
            child: Container(
              decoration: BoxDecoration(
                  color: textEditingController!.text.isEmpty
                      ? Colors.green.withOpacity(.4)
                      : Colors.green,
                  borderRadius: BorderRadius.circular(40)),
              padding: const EdgeInsets.all(10),
              child: const Icon(
                Icons.send,
                color: Colors.white,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
```
- lib/features/00_splash/splash_screen.dart
```dart
import 'package:flutter/material.dart';

import '../../core/utils/assets_manager.dart';
import '../../core/utils/routes_manager.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({
    Key? key,
  }) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;
  bool _isComplete = false;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 2),
    );
    _animation = Tween<double>(begin: 0, end: 1).animate(_controller)
      ..addStatusListener((status) {
        if (status == AnimationStatus.completed && !_isComplete) {
          _isComplete = true;
          Navigator.pushReplacementNamed(context, Routes.homeRoute);
        }
      });
    _controller.forward();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: AnimatedBuilder(
        animation: _animation,
        builder: (context, child) {
          return Center(
            child: Transform.rotate(
              angle: _animation.value * 2 * 3.14,
              child: Image.asset(
                ImageAssets.openAiAvatar,
                fit: BoxFit.contain,
              ),
            ),
          );
        },
      ),
    );
  }
}
```
- lib/features/01_home/home_page.dart
```dart
import 'package:chat_gpt/core/utils/values_manager.dart';
import 'package:flutter/material.dart';

import '../../core/utils/assets_manager.dart';
import '../../core/utils/routes_manager.dart';
import '../../core/utils/strings_manager.dart';
import 'widgets/home_button_widget.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromARGB(255, 137, 121, 78),
      body: Container(
        padding: const EdgeInsets.all(AppPadding.p20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Column(
              children: [
                const SizedBox(
                  height: AppSize.s10,
                ),
              ],
            ),
            Column(
              children: [
                const SizedBox(
                  height: AppSize.s150,
                  child: Text(
                    "Chatty",
                    style: TextStyle(
                        fontWeight: FontWeight.bold, height: 2, fontSize: 40),
                  ),
                ),
                Image.asset(ImageAssets.appLogo),
              ],
            ),
            Column(
              children: [
                HomeButtonWidget(
                  textData: AppStrings.imageGeneration,
                  iconData: Icons.image_outlined,
                  onTap: () {
                    Navigator.pushNamed(context, Routes.imageRoute);
                  },
                ),
                const SizedBox(
                  height: AppSize.s30,
                ),
                HomeButtonWidget(
                  textData: AppStrings.textCompletion,
                  iconData: Icons.title,
                  onTap: () {
                    Navigator.pushNamed(context, Routes.textRoute);
                  },
                ),
              ],
            ),
            const Text(
              "Chatty by memodlike",
              style: TextStyle(color: Colors.grey),
            ),
          ],
        ),
      ),
    );
  }
}
```
- lib/features/01_home/widgets/home_button_widget.dart
```dart
import 'package:flutter/material.dart';

import '../../../app/constants.dart';

class HomeButtonWidget extends StatelessWidget {
  final String textData;
  final IconData iconData;
  final VoidCallback? onTap;
  const HomeButtonWidget(
      {Key? key, required this.textData, this.onTap, required this.iconData})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        height: 110,
        width: double.infinity,
        alignment: Alignment.centerLeft,
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
        decoration: BoxDecoration(
          color: Color.fromARGB(60, 0, 0, 0),
          borderRadius: BorderRadius.circular(210),
          boxShadow: Constants.glowBoxShadow,
        ),
        child: Row(
          children: [
            Icon(
              iconData,
              size: 50,
            ),
            const SizedBox(
              width: 10,
            ),
            Text(
              textData,
              style: const TextStyle(
                  color: Colors.white,
                  fontSize: 18,
                  fontWeight: FontWeight.w600),
            ),
          ],
        ),
      ),
    );
  }
}
```
- lib/features/02_image_generation/data/datasources/remote_datasources.dart
```dart
import '../../../../core/network/app_api.dart';
import '../model/responses/responses.dart';

abstract class ImageRemoteDataSource {
  Future<ImageDataResponse> getGenerateImages(String query);
}

class ImageRemoteDataSourceImpl implements ImageRemoteDataSource {
  final AppServiceClient _appServiceClient;

  ImageRemoteDataSourceImpl(this._appServiceClient);

  @override
  Future<ImageDataResponse> getGenerateImages(String query) async {
    return await _appServiceClient.getGenerateImages(
      query,
      10,
      '256x256',
    );
  }
}


 // ['256x256', '512x512', '1024x1024']
```
- lib/features/02_image_generation/data/model/mapper/mapper.dart
```dart
import 'package:chat_gpt/app/extensions.dart';

import '../../../../../../app/constants.dart';
import '../../../domain/entities/image.dart';
import '../responses/responses.dart';

extension ImageUrlResponseMapper on ImageUrlResponse? {
  ImageUrl toDomain() {
    return ImageUrl(this?.url.orEmpty() ?? Constants.empty);
  }
}

extension ImageDataResponseMapper on ImageDataResponse? {
  ImageModel toDomain() {
    List<ImageUrl> imagesUrl =
        (this?.data?.map((imageUrlResponse) => imageUrlResponse.toDomain()) ??
                const Iterable.empty())
            .cast<ImageUrl>()
            .toList();

    return ImageModel(
      this?.created.orZero() ?? Constants.zero,
      imagesUrl,
    );
  }
}
```
- lib/features/02_image_generation/data/model/responses/responses.dart
```dart
import 'package:json_annotation/json_annotation.dart';

part 'responses.g.dart';

//json_serializable
@JsonSerializable()
class ImageDataResponse {

  @JsonKey(name: "created")
  num? created;
  @JsonKey(name: "data")
  List<ImageUrlResponse>? data;

  ImageDataResponse(this.created, this.data);

  // toJson
  Map<String, dynamic> toJson() => _$ImageDataResponseToJson(this);

//fromJson
  factory ImageDataResponse.fromJson(Map<String, dynamic> json) =>
      _$ImageDataResponseFromJson(json);
}


@JsonSerializable()
class ImageUrlResponse {

  @JsonKey(name: 'url')
  String? url;


  ImageUrlResponse(this.url);

  // toJson
  Map<String, dynamic> toJson() => _$ImageUrlResponseToJson(this);

//fromJson
  factory ImageUrlResponse.fromJson(Map<String, dynamic> json) =>
      _$ImageUrlResponseFromJson(json);
}

```
- lib/features/02_image_generation/data/model/responses/responses.g.dart
```dart
// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'responses.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ImageDataResponse _$ImageDataResponseFromJson(Map<String, dynamic> json) =>
    ImageDataResponse(
      json['created'] as num?,
      (json['data'] as List<dynamic>?)
          ?.map((e) => ImageUrlResponse.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$ImageDataResponseToJson(ImageDataResponse instance) =>
    <String, dynamic>{
      'created': instance.created,
      'data': instance.data,
    };

ImageUrlResponse _$ImageUrlResponseFromJson(Map<String, dynamic> json) =>
    ImageUrlResponse(
      json['url'] as String?,
    );

Map<String, dynamic> _$ImageUrlResponseToJson(ImageUrlResponse instance) =>
    <String, dynamic>{
      'url': instance.url,
    };

```
- lib/features/02_image_generation/data/repositories/repository_impl.dart
```dart

import 'package:chat_gpt/features/02_image_generation/data/model/mapper/mapper.dart';
import 'package:dartz/dartz.dart';



import '../../../../core/error/error_handler.dart';
import '../../../../core/error/failure.dart';
import '../../../../core/network/network_info.dart';
import '../../domain/entities/image.dart';
import '../../domain/repositories/repository.dart';
import '../datasources/remote_datasources.dart';

class ImageRepositoryImpl implements ImageRepository {
  final ImageRemoteDataSource _remoteDataSource;

  final NetworkInfo _networkInfo;
  ImageRepositoryImpl(
    this._remoteDataSource,
    this._networkInfo,
  );

  @override
  Future<Either<Failure, ImageModel>> getGenerateImages(String query) async {
    if (await _networkInfo.isConnected) {
      final response = await _remoteDataSource.getGenerateImages(query);

      try {
        return Right(response.toDomain());
      } catch (error) {
        return Left(ErrorHandler.handle(error).failure);
      }
    } else {
      return Left(DataSource.NO_INTERNET_CONNECTION.getFailure());
    }
  }
}

```
- lib/features/02_image_generation/domain/entities/image.dart
```dart
class ImageUrl {
  String url;

  ImageUrl(
    this.url,
  );
}

class ImageModel {
  num created;
  List<ImageUrl> imageUrl;

  ImageModel(
    this.created,
    this.imageUrl,
  );
}

```
- lib/features/02_image_generation/domain/repositories/repository.dart
```dart
import '../../../../core/error/failure.dart';
import '../entities/image.dart';
import 'package:dartz/dartz.dart';

abstract class ImageRepository {
  Future<Either<Failure, ImageModel>> getGenerateImages(String query);
}

```
- lib/features/02_image_generation/domain/usecases/get_generate_image.dart
```dart
import 'package:dartz/dartz.dart';

import '../../../../app/base_usecase.dart';
import '../../../../core/error/failure.dart';
import '../entities/image.dart';
import '../repositories/repository.dart';

class ImageGenerationUseCase implements BaseUseCase<String, ImageModel> {
  final ImageRepository _repository;

  ImageGenerationUseCase(this._repository);

  @override
  Future<Either<Failure, ImageModel>> execute(String input) async {
    return await _repository.getGenerateImages(input);
  }
}
```
- lib/features/02_image_generation/presentation/cubit/image_generation_cubit.dart
```dart
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../domain/entities/image.dart';
import '../../domain/usecases/get_generate_image.dart';

part 'image_generation_state.dart';

class ImageGenerationCubit extends Cubit<ImageGenerationState> {
  final ImageGenerationUseCase imageGenerationUseCase;
  ImageGenerationCubit({required this.imageGenerationUseCase})
      : super(
          ImageGenerationInitial(),
        );

  Future<void> imagesGenerate({required String query}) async {
    emit(
      ImageGenerationLoading(),
    );
    (await imageGenerationUseCase.execute(query)).fold(
      (failure) => {
        emit(
          ImageGenerationFailure(errorMsg: failure.message),
        ),
      },
      (data) {
        emit(
          ImageGenerationLoaded(imageGenerationModelData: data),
        );
      },
    );
  }
}

```
- lib/features/02_image_generation/presentation/cubit/image_generation_state.dart
```dart
part of 'image_generation_cubit.dart';

abstract class ImageGenerationState extends Equatable {
  const ImageGenerationState();
}

class ImageGenerationInitial extends ImageGenerationState {
  @override
  List<Object> get props => [];
}

class ImageGenerationLoading extends ImageGenerationState {
  @override
  List<Object> get props => [];
}

class ImageGenerationLoaded extends ImageGenerationState {
  final ImageModel imageGenerationModelData;

  const ImageGenerationLoaded({required this.imageGenerationModelData});
  @override
  List<Object> get props => [];
}

class ImageGenerationFailure extends ImageGenerationState {
  final String? errorMsg;

  const ImageGenerationFailure({this.errorMsg});
  @override
  List<Object> get props => [];
}
```
- lib/features/02_image_generation/presentation/pages/image_generation_page.dart
```dart
import 'package:chat_gpt/core/utils/strings_manager.dart';
import 'package:chat_gpt/core/utils/values_manager.dart';
import 'package:chat_gpt/features/02_image_generation/presentation/pages/widget/generated_image_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/widgets/loading_widget.dart';
import '../../../../core/widgets/search_text_field_widget.dart';
import '../cubit/image_generation_cubit.dart';

class ImageGenerationPage extends StatefulWidget {
  const ImageGenerationPage({Key? key}) : super(key: key);

  @override
  State<ImageGenerationPage> createState() => _ImageGenerationPageState();
}

class _ImageGenerationPageState extends State<ImageGenerationPage> {
  final TextEditingController _searchTextController = TextEditingController();

  @override
  void initState() {
    _searchTextController.addListener(() {
      setState(() {});
    });
    super.initState();
  }

  @override
  void dispose() {
    _searchTextController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromARGB(255, 137, 121, 78),
      appBar: AppBar(
        backgroundColor: Color.fromARGB(255, 137, 121, 78),
        title: Text(AppStrings.imageGeneration.split("-")[0]),
      ),
      body: Center(
        child: Column(
          children: [
            Expanded(
                child: BlocBuilder<ImageGenerationCubit, ImageGenerationState>(
              builder: (context, imageGenerationState) {
                if (imageGenerationState is ImageGenerationLoading) {
                  return const LoadingWidget();
                }

                if (imageGenerationState is ImageGenerationLoaded) {
                  return GeneratedImageWidget(
                    imageGenerationModelData:
                        imageGenerationState.imageGenerationModelData,
                  );
                }

                return const Center(
                  child: Text(
                    AppStrings.imageGeneration,
                    style: TextStyle(fontSize: 20, color: Colors.grey),
                  ),
                );
              },
            )),
            SearchTextFieldWidget(
              textEditingController: _searchTextController,
              onTap: () {
                BlocProvider.of<ImageGenerationCubit>(context)
                    .imagesGenerate(
                      query: _searchTextController.text,
                    )
                    .then((value) => _clearTextField);
              },
            ),
            const SizedBox(
              height: AppSize.s20,
            ),
          ],
        ),
      ),
    );
  }

  void _clearTextField() {
    setState(
      () {
        _searchTextController.clear();
      },
    );
  }
}

```
- lib/features/02_image_generation/presentation/pages/widget/generated_image_widget.dart
```dart
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:shimmer/shimmer.dart';

import '../../../../../core/utils/values_manager.dart';
import '../../../domain/entities/image.dart';

class GeneratedImageWidget extends StatelessWidget {
  final ImageModel imageGenerationModelData;
  const GeneratedImageWidget(
      {super.key, required this.imageGenerationModelData});

  @override
  Widget build(BuildContext context) {
    return MasonryGridView.builder(
      gridDelegate: const SliverSimpleGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
      ),
      mainAxisSpacing: 3,
      crossAxisSpacing: 3,
      itemCount: imageGenerationModelData.imageUrl.length,
      itemBuilder: (context, index) {
        final generatedImage = imageGenerationModelData.imageUrl[index];

        return Card(
          child: CachedNetworkImage(
            imageUrl: generatedImage.url,
            fit: BoxFit.cover,
            progressIndicatorBuilder: (context, url, downloadProgress) =>
                SizedBox(
              height: AppSize.s150,
              width: AppSize.s150,
              child: Shimmer.fromColors(
                baseColor: Colors.grey.withOpacity(.3),
                highlightColor: Colors.grey,
                child: Container(
                  height: AppSize.s220,
                  width: AppSize.s130,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(4),
                  ),
                ),
              ),
            ),
            errorWidget: (context, url, error) => const Icon(Icons.error),
          ),
        );
      },
    );
  }
}

```
- lib/features/03_text_completion/data/datasources/remote_datasources.dart
```dart
// Импортируем файл app_api.dart из папки core/network
import '../../../../core/network/app_api.dart';

// Импортируем модели ответов из папки models/responses
import '../models/responses/responses.dart';

// Определяем абстрактный класс TextCompletionRemoteDataSource
abstract class TextCompletionRemoteDataSource {
// Определяем функцию getTextCompletion, которая будет возвращать объект типа TextCompletionResponse и принимать строку query в качестве параметра
Future<TextCompletionResponse> getTextCompletion(String query);
}

// Определяем класс TextCompletionRemoteDataSourceImpl, который реализует интерфейс TextCompletionRemoteDataSource
class TextCompletionRemoteDataSourceImpl implements TextCompletionRemoteDataSource {
// Определяем приватное поле _appServiceClient типа AppServiceClient
final AppServiceClient _appServiceClient;

// Определяем конструктор класса TextCompletionRemoteDataSourceImpl, который принимает объект типа AppServiceClient и сохраняет его в приватном поле _appServiceClient
TextCompletionRemoteDataSourceImpl(this._appServiceClient);

// Реализуем метод getTextCompletion из интерфейса TextCompletionRemoteDataSource, который будет вызывать метод getTextCompletion из объекта _appServiceClient с заданными параметрами и возвращать результат в виде объекта типа TextCompletionResponse
@override
Future<TextCompletionResponse> getTextCompletion(String query) async {
return await _appServiceClient.getTextCompletion(
"text-davinci-003",
2000,
query,
);
}
}
```
- lib/features/03_text_completion/data/models/mapper/mapper.dart
```dart
import 'package:chat_gpt/app/constants.dart';
import 'package:chat_gpt/app/extensions.dart';
import 'package:chat_gpt/features/03_text_completion/domain/entities/text_completion_model.dart';

import '../responses/responses.dart';

extension ChoicesTextCompletionResponseMapper
    on ChoicesTextCompletionResponse? {
  ChoicesTextCompletionModel toDomain() {
    return ChoicesTextCompletionModel(
      this?.text.orEmpty() ?? Constants.empty,
      this?.index.orZero() ?? Constants.zero,
      this?.finishReason.orEmpty() ?? Constants.empty,
    );
  }
}

extension TextCompletionResponseMapper on TextCompletionResponse? {
  TextCompletionModel toDomain() {
    List<ChoicesTextCompletionModel> choices = (this?.choices?.map(
                  (choicesTextCompletionResponse) =>
                      choicesTextCompletionResponse.toDomain(),
                ) ??
            const Iterable.empty())
        .cast<ChoicesTextCompletionModel>()
        .toList();

    return TextCompletionModel(
      this?.created.orZero() ?? Constants.zero,
      choices,
    );
  }
}

```
- lib/features/03_text_completion/data/models/responses/responses.dart
```dart
import 'package:json_annotation/json_annotation.dart';

part 'responses.g.dart';

//json_serializable

@JsonSerializable()
class ChoicesTextCompletionResponse {
  @JsonKey(name: 'text')
  String? text;
  @JsonKey(name: 'index')
  num? index;
  @JsonKey(name: 'finish_reason')
  String? finishReason;

  ChoicesTextCompletionResponse(
    this.text,
    this.index,
    this.finishReason,
  );

  // toJson
  Map<String, dynamic> toJson() => _$ChoicesTextCompletionResponseToJson(this);

//fromJson
  factory ChoicesTextCompletionResponse.fromJson(Map<String, dynamic> json) =>
      _$ChoicesTextCompletionResponseFromJson(json);
}

@JsonSerializable()
class TextCompletionResponse {
  @JsonKey(name: "created")
  num? created;

  @JsonKey(name: "choices")
  List<ChoicesTextCompletionResponse>? choices;

  TextCompletionResponse(
    this.created,
    this.choices,
  );

  // toJson
  Map<String, dynamic> toJson() => _$TextCompletionResponseToJson(this);

//fromJson
  factory TextCompletionResponse.fromJson(Map<String, dynamic> json) =>
      _$TextCompletionResponseFromJson(json);
}

```
- lib/features/03_text_completion/data/models/responses/responses.g.dart
```dart
// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'responses.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ChoicesTextCompletionResponse _$ChoicesTextCompletionResponseFromJson(
        Map<String, dynamic> json) =>
    ChoicesTextCompletionResponse(
      json['text'] as String?,
      json['index'] as num?,
      json['finish_reason'] as String?,
    );

Map<String, dynamic> _$ChoicesTextCompletionResponseToJson(
        ChoicesTextCompletionResponse instance) =>
    <String, dynamic>{
      'text': instance.text,
      'index': instance.index,
      'finish_reason': instance.finishReason,
    };

TextCompletionResponse _$TextCompletionResponseFromJson(
        Map<String, dynamic> json) =>
    TextCompletionResponse(
      json['created'] as num?,
      (json['choices'] as List<dynamic>?)
          ?.map((e) =>
              ChoicesTextCompletionResponse.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$TextCompletionResponseToJson(
        TextCompletionResponse instance) =>
    <String, dynamic>{
      'created': instance.created,
      'choices': instance.choices,
    };

```
- lib/features/03_text_completion/data/repositories/repository_impl.dart
```dart
import 'package:chat_gpt/features/03_text_completion/data/models/mapper/mapper.dart';
import 'package:dartz/dartz.dart';

import 'package:chat_gpt/features/03_text_completion/domain/entities/text_completion_model.dart';

import 'package:chat_gpt/core/error/failure.dart';

import '../../../../core/error/error_handler.dart';
import '../../../../core/network/network_info.dart';
import '../../domain/repositories/repository.dart';
import '../datasources/remote_datasources.dart';

class TextCompletionRepositoryImpl implements TextCompletionRepository {
  final TextCompletionRemoteDataSource _remoteDataSource;

  final NetworkInfo _networkInfo;
  TextCompletionRepositoryImpl(
    this._remoteDataSource,
    this._networkInfo,
  );

  @override
  Future<Either<Failure, TextCompletionModel>> getTextCompletion(
      String query) async {
    if (await _networkInfo.isConnected) {
      final response = await _remoteDataSource.getTextCompletion(query);

      try {
        return Right(response.toDomain());
      } catch (error) {
        return Left(ErrorHandler.handle(error).failure);
      }
    } else {
      return Left(DataSource.NO_INTERNET_CONNECTION.getFailure());
    }
  }
}

```
- lib/features/03_text_completion/domain/entities/text_completion_model.dart
```dart
class ChoicesTextCompletionModel {
  String text;
  num index;
  String finishReason;

  ChoicesTextCompletionModel(
    this.text,
    this.index,
    this.finishReason,
  );
}

class TextCompletionModel {
  num created;
  List<ChoicesTextCompletionModel> choices;

  TextCompletionModel(
    this.created,
    this.choices,
  );
}

```
- lib/features/03_text_completion/domain/repositories/repository.dart
```dart
import 'package:chat_gpt/features/03_text_completion/domain/entities/text_completion_model.dart';
import 'package:dartz/dartz.dart';

import '../../../../core/error/failure.dart';

abstract class TextCompletionRepository {
  Future<Either<Failure, TextCompletionModel>> getTextCompletion(String query);
}

```
- lib/features/03_text_completion/domain/usecases/get_text_completion_usecase.dart
```dart
import 'package:chat_gpt/features/03_text_completion/domain/entities/text_completion_model.dart';
import 'package:dartz/dartz.dart';

import '../../../../app/base_usecase.dart';
import '../../../../core/error/failure.dart';
import '../repositories/repository.dart';

class TextCompletionUseCase implements BaseUseCase<String, TextCompletionModel> {
  final TextCompletionRepository _repository;

  TextCompletionUseCase(this._repository);

  @override
  Future<Either<Failure, TextCompletionModel>> execute(String input) async {
    return await _repository.getTextCompletion(input);
  }
}
```
- lib/features/03_text_completion/presentation/cubit/text_completion_cubit.dart
```dart
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../domain/entities/text_completion_model.dart';
import '../../domain/usecases/get_text_completion_usecase.dart';

part 'text_completion_state.dart';

class TextCompletionCubit extends Cubit<TextCompletionState> {
  final TextCompletionUseCase textCompletionUseCase;
  TextCompletionCubit({required this.textCompletionUseCase})
      : super(TextCompletionInitial());

  Future<void> textCompletion({required String query}) async {
    emit(
      TextCompletionLoading(),
    );
    (await textCompletionUseCase.execute(query)).fold(
      (failure) => {
        emit(
          TextCompletionFailure(errorMsg: failure.message),
        ),
      },
      (data) {
        emit(
          TextCompletionLoaded(textCompletionModelData: data),
        );
      },
    );
  }
}

```
- lib/features/03_text_completion/presentation/cubit/text_completion_state.dart
```dart
part of 'text_completion_cubit.dart';

abstract class TextCompletionState extends Equatable {
  const TextCompletionState();
}

class TextCompletionInitial extends TextCompletionState {
  @override
  List<Object> get props => [];
}

class TextCompletionLoading extends TextCompletionState {
  @override
  List<Object> get props => [];
}

class TextCompletionLoaded extends TextCompletionState {
  final TextCompletionModel textCompletionModelData;

  const TextCompletionLoaded({required this.textCompletionModelData});
  @override
  List<Object> get props => [];
}

class TextCompletionFailure extends TextCompletionState {
  final String? errorMsg;

  const TextCompletionFailure({this.errorMsg});
  @override
  List<Object> get props => [];
}

```
- lib/features/03_text_completion/presentation/pages/text_completion_page.dart
```dart
import 'package:flutter/material.dart';

import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/utils/strings_manager.dart';
import '../../../../core/utils/values_manager.dart';
import '../../../../core/widgets/loading_widget.dart';
import '../../../../core/widgets/search_text_field_widget.dart';
import '../cubit/text_completion_cubit.dart';
import '../widget/text_completion_widget.dart';

class TextCompletionPage extends StatefulWidget {
  const TextCompletionPage({Key? key}) : super(key: key);

  @override
  State<TextCompletionPage> createState() => _TextCompletionPageState();
}

class _TextCompletionPageState extends State<TextCompletionPage> {
  final TextEditingController _searchTextController = TextEditingController();

  @override
  void initState() {
    _searchTextController.addListener(() {
      setState(() {});
    });
    super.initState();
  }

  @override
  void dispose() {
    _searchTextController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromARGB(255, 137, 121, 78),
      appBar: AppBar(
        backgroundColor: Color.fromARGB(255, 137, 121, 78),
        title: Text(AppStrings.textCompletion.split("-")[0]),
      ),
      body: Center(
        child: Column(
          children: [
            Expanded(
              child: BlocBuilder<TextCompletionCubit, TextCompletionState>(
                builder: (context, textCompletionState) {
                  if (textCompletionState is TextCompletionLoading) {
                    return const LoadingWidget();
                  }
                  if (textCompletionState is TextCompletionLoaded) {
                    final choicesData =
                        textCompletionState.textCompletionModelData.choices;

                    return TextCompletionWidget(
                      choicesData: choicesData,
                    );
                  }
                  return const Center(
                    child: Text(
                      AppStrings.textCompletion,
                      style: TextStyle(fontSize: 20, color: Colors.grey),
                    ),
                  );
                },
              ),
            ),
            SearchTextFieldWidget(
              textEditingController: _searchTextController,
              onTap: () {
                BlocProvider.of<TextCompletionCubit>(context)
                    .textCompletion(query: _searchTextController.text)
                    .then(
                      (value) => _clearTextField(),
                    );
              },
            ),
            const SizedBox(
              height: AppSize.s20,
            ),
          ],
        ),
      ),
    );
  }

  void _clearTextField() {
    setState(
      () {
        _searchTextController.clear();
      },
    );
  }
}

```
- lib/features/03_text_completion/presentation/widget/text_completion_widget.dart
```dart
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:share_plus/share_plus.dart';

import '../../../../core/utils/values_manager.dart';
import '../../domain/entities/text_completion_model.dart';

class TextCompletionWidget extends StatelessWidget {
  final List<ChoicesTextCompletionModel> choicesData;
  const TextCompletionWidget({super.key, required this.choicesData});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: choicesData.length,
      itemBuilder: (BuildContext context, int index) {
        final textData = choicesData[index];
        return Card(
          color: Color.fromARGB(255, 108, 95, 61),
          child: Padding(
            padding: const EdgeInsets.all(AppPadding.p14),
            child: Column(
              children: [
                Text(
                  textData.text,
                  style: const TextStyle(fontSize: 18),
                ),
                const SizedBox(
                  height: AppSize.s30,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    InkWell(
                        onTap: () {
                          Share.share(textData.text);
                        },
                        child: const Icon(Icons.share, size: 35)),
                    InkWell(
                      onTap: () {
                        Clipboard.setData(ClipboardData(text: textData.text));
                      },
                      child: const Icon(
                        Icons.copy,
                        size: 35,
                      ),
                    ),
                  ],
                ),
                const SizedBox(
                  height: AppSize.s10,
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}

```
- lib/main.dart
```dart
import 'package:flutter/material.dart';

import 'app/app.dart';
import 'app/di.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await initAppModule();
  runApp( MyApp());
}

```
- lib/features/04_chat/chat_message_widget.dart
```dart
import 'package:flutter/material.dart';
import 'package:flutter_chatgpt_api/flutter_chatgpt_api.dart';

import 'chat.dart';

class ChatMessageWidget extends StatelessWidget {
  const ChatMessageWidget(
      {super.key, required this.text, required this.chatMessageType});

  final String text;
  final ChatMessageType chatMessageType;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 10.0),
      padding: const EdgeInsets.all(16),
      color: chatMessageType == ChatMessageType.bot
          ? botBackgroundColor
          : backgroundColor,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          chatMessageType == ChatMessageType.bot
              ? Container(
                  margin: const EdgeInsets.only(right: 16.0),
                  child: CircleAvatar(
                    backgroundColor: const Color.fromRGBO(16, 163, 127, 1),
                    child: Image.asset(
                      'assets/bot.png',
                      color: Colors.white,
                      scale: 1.5,
                    ),
                  ),
                )
              : Container(
                  margin: const EdgeInsets.only(right: 16.0),
                  child: const CircleAvatar(
                    child: Icon(
                      Icons.person,
                    ),
                  ),
                ),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Container(
                  padding: const EdgeInsets.all(8.0),
                  decoration: const BoxDecoration(
                    borderRadius: BorderRadius.all(
                      Radius.circular(8.0),
                    ),
                  ),
                  child: Text(
                    text,
                    style: Theme.of(context)
                        .textTheme
                        .bodyLarge
                        ?.copyWith(color: Colors.white),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

```
- lib/features/04_chat/chat.dart
```dart
import 'package:flutter/material.dart';
import 'package:flutter_chatgpt_api/flutter_chatgpt_api.dart';

import '../../app/constants.dart';
import 'chat_message_widget.dart';

const backgroundColor = Color(0xff343541);
const botBackgroundColor = Color(0xff444654);

class ChatPage extends StatefulWidget {
  const ChatPage({super.key});

  @override
  State<ChatPage> createState() => _ChatPageState();
}

class _ChatPageState extends State<ChatPage> {
  final _textController = TextEditingController();
  final _scrollController = ScrollController();
  final List<ChatMessage> _messages = [];
  late ChatGPTApi _api;

  String? _parentMessageId;
  String? _conversationId;
  late bool isLoading;

  @override
  void initState() {
    super.initState();
    _api = ChatGPTApi(
      sessionToken: Constants.SESSION_TOKEN,
      clearanceToken: Constants.CLEARANCE_TOKEN,
    );
    isLoading = false;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 100,
        title: const Padding(
          padding: EdgeInsets.all(8.0),
          child: Text(
            'Flutter ChatGPT API ',
            maxLines: 2,
            textAlign: TextAlign.center,
          ),
        ),
        backgroundColor: botBackgroundColor,
      ),
      backgroundColor: backgroundColor,
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              child: _buildList(),
            ),
            Visibility(
              visible: isLoading,
              child: const Padding(
                padding: EdgeInsets.all(8.0),
                child: CircularProgressIndicator(
                  color: Colors.white,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                children: [
                  _buildInput(),
                  _buildSubmit(),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSubmit() {
    return Visibility(
      visible: !isLoading,
      child: Container(
        color: botBackgroundColor,
        child: IconButton(
          icon: const Icon(
            Icons.send_rounded,
            color: Color.fromRGBO(142, 142, 160, 1),
          ),
          onPressed: () async {
            setState(
              () {
                _messages.add(
                  ChatMessage(
                    text: _textController.text,
                    chatMessageType: ChatMessageType.user,
                  ),
                );
                isLoading = true;
              },
            );
            var input = _textController.text;
            _textController.clear();
            Future.delayed(const Duration(milliseconds: 50))
                .then((_) => _scrollDown());
            var newMessage = await _api.sendMessage(
              input,
              conversationId: _conversationId,
              parentMessageId: _parentMessageId,
            );
            setState(() {
              _conversationId = newMessage.conversationId;
              _parentMessageId = newMessage.messageId;
              isLoading = false;
              _messages.add(
                ChatMessage(
                  text: newMessage.message,
                  chatMessageType: ChatMessageType.bot,
                ),
              );
            });
            _textController.clear();
            Future.delayed(const Duration(milliseconds: 50))
                .then((_) => _scrollDown());
          },
        ),
      ),
    );
  }

  Expanded _buildInput() {
    return Expanded(
      child: TextField(
        textCapitalization: TextCapitalization.sentences,
        style: const TextStyle(color: Colors.white),
        controller: _textController,
        decoration: const InputDecoration(
          fillColor: botBackgroundColor,
          filled: true,
          border: InputBorder.none,
          focusedBorder: InputBorder.none,
          enabledBorder: InputBorder.none,
          errorBorder: InputBorder.none,
          disabledBorder: InputBorder.none,
        ),
      ),
    );
  }

  ListView _buildList() {
    return ListView.builder(
      controller: _scrollController,
      itemCount: _messages.length,
      itemBuilder: (context, index) {
        var message = _messages[index];
        return ChatMessageWidget(
          text: message.text,
          chatMessageType: message.chatMessageType,
        );
      },
    );
  }

  void _scrollDown() {
    _scrollController.animateTo(
      _scrollController.position.maxScrollExtent,
      duration: const Duration(milliseconds: 300),
      curve: Curves.easeOut,
    );
  }
}
```

# chatty
