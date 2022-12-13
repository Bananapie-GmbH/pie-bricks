import 'package:shopper/shopper.dart';

class {{name.pascalCase()}}Service extends IShopperService {

  {{#withApi}}
  final api = useApi();
  {{/withApi}}

  {{name.pascalCase()}}Service._();
  static final instance = {{name.pascalCase()}}Service._();

  factory {{name.pascalCase()}}Service() {
    return instance;
  }

}

{{name.pascalCase()}}Service use{{name.pascalCase()}}() {
  return {{name.pascalCase()}}Service();
}
