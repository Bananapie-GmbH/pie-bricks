


class {{name.pascalCase()}}Service extends IShopperService {

  {{name.pascalCase()}}._();
  static final instance = {{name.pascalCase()}}._();

  factory {{name.pascalCase()}}() {
    return instance;
  }

}

{{name.pascalCase()}} use{{name.pascalCase()}}() {
  return {{name.pascalCase()}}();
}
