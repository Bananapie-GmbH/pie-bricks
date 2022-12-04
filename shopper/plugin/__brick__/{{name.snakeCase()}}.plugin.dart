import 'package:shopper/src/core/interfaces/shopper_plugin.dart';
{{#withApi}}
import 'package:shopper/src/core/api/shopper_api.dart';
{{/withApi}}

class {{name.pascalCase()}} extends IShopperPlugin {

  {{#withApi}}
  final api = useApi();
  {{/withApi}}

  {{name.pascalCase()}}._();
  static final instance = {{name.pascalCase()}}._();

  factory {{name.pascalCase()}}() {
    return instance;
  }

}

{{name.pascalCase()}} use{{name.pascalCase()}}() {
  return {{name.pascalCase()}}();
}
