import '../constant/app_urls.dart';
import '../entity/server_entity.dart';
import '../utils/http_util.dart';

class ServerService {
  Future<List<ServerEntity>> server() {
    return HttpUtil.instance.get(AppUrls.server).then((result) {
      return serverEntityFromList(result['data']);
    });
  }
}
