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