abstract class Routes {
  Routes._();

  static const home = '/';
  static const collection = '/collection';
  static const productDetail = '/product/:id';
  static const findYourFit = '/find-your-fit';
  static const lookbook = '/lookbook';
  static const about = '/about';
  static const bag = '/bag';
  static const contact = '/contact';

  static String productDetailPath(String id) => '/product/$id';
}
