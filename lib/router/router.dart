import 'package:fluro/fluro.dart';
import 'route_handlers.dart';
import 'routes.dart';

class AppRouter {
  static final FluroRouter router = FluroRouter();

  static void setupRouter() {
    router.define(
      Routes.home,
      handler: homeHandler,
      transitionType: TransitionType.fadeIn,
    );

    router.define(
      Routes.search,
      handler: searchHandler,
      transitionType: TransitionType.fadeIn,
    );

    router.define(
      Routes.category,
      handler: categoryHandler,
      transitionType: TransitionType.fadeIn,
    );

    router.define(
      Routes.categoryResult,
      handler: categoryResultHandler,
      transitionType: TransitionType.fadeIn,
    );

    // router.define(
    //   Routes.detail,
    //   handler: detailHandler,
    //   transitionType: TransitionType.cupertino,
    // );
  }
}
