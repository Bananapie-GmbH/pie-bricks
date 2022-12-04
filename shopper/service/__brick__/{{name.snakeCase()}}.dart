import 'package:shopper/src/core/interfaces/shopper_api_service.dart';

class {{name.pascalCase()}}Service extends IShopperService {

  {{name.pascalCase()}}Service._();
  static final instance = {{name.pascalCase()}}Service._();

  factory {{name.pascalCase()}}Service() {
    return instance;
  }

}

{{name.pascalCase()}}Service use{{name.pascalCase()}}() {
  return {{name.pascalCase()}}();
}
