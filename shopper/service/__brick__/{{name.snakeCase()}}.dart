import 'package:injectable/injectable.dart';


{{#isApiService}}
import 'package:shopper/src/core/api/shopper_api.dart';
import 'package:shopper/src/core/interfaces/shopper_api_service.dart';
@singleton
class {{name.pascalCase()}}Service extends IShopperApiService {
  {{name.pascalCase()}}Service(ShopperApi api) : super(api);
}

{{/isApiService}}


{{^isApiService}}

@singleton
class {{name.pascalCase()}}Service extends IShopperService {

}

{{/isApiService}}