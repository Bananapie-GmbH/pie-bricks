import 'package:shopper/shopper.dart';

class {{name.pascalCase()}} extends IShopperPlugin {

  {{#withApi}}
  final api = useApi();
  {{/withApi}}

  {{name.pascalCase()}}._();
  static final instance = {{name.pascalCase()}}._();

  factory {{name.pascalCase()}}() {
    return instance;
  }

  @override
  Future<void> initialize(
    ShopperContext context, {
    bool debug = false,
  }) async {
    // todo set shopname
  }

}

{{name.pascalCase()}} use{{name.pascalCase()}}() {
  return {{name.pascalCase()}}();
}
