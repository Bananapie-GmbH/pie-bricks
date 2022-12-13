import 'package:auto_route/auto_route.dart';
import 'package:shopper/shopper.dart';
import 'package:flutter/material.dart';
part '{{name.snakeCase()}}.router.gr.dart';

@MaterialAutoRouter(
  replaceInRouteName: 'Page,Route',
  routes: [
    AutoRoute(
      page: LoginWrapperPage,
      children: [
        AutoRoute(
          page: RegisterPage,
        ),
        AutoRoute(
          page: LoginPage,
        ),
        AutoRoute(
          initial: true,
          page: LoginRegisterPage,
        ),
      ],
    ),
    AutoRoute(
        initial: true,
        {{#useAuthGuard}}
        guards: [AuthGuard],
        {{/useAuthGuard}}
        page: HomeWrapperPage,
        children: [
          AutoRoute(
            initial: true,
            page: ShopperBottomNavigationPage,
          ),
          AutoRoute(
            page: CheckoutWebViewPage,
          ),
          AutoRoute(
            page: DiscoveryCollectionPage,
            children: [
              AutoRoute(
                page: ProductDetailPage,
              ),
            ],
          ),
          AutoRoute(
            page: SearchResultPage,
            children: [
              AutoRoute(page: ProductDetailPage),
            ],
          ),
          AutoRoute(page: OrderOverviewPage, children: [
            AutoRoute(
              page: ProductDetailPage,
            ),
          ]),
          AutoRoute(page: BlogPage, children: [
            AutoRoute(
              page: ProductDetailPage,
            ),
          ]),
          AutoRoute(page: InfluencerPage, children: [
            AutoRoute(
              page: ProductDetailPage,
            ),
            AutoRoute(
              page: OutfitsDetailPage,
            ),
          ]),
          AutoRoute(page: OutfitsDetailPage, children: [
            AutoRoute(
              page: ProductDetailPage,
            ),
            AutoRoute(
              page: InfluencerPage,
            ),
          ]),
          AutoRoute(page: OutfitsFeedPage, children: [
            AutoRoute(
              page: ProductDetailPage,
            ),
            AutoRoute(
              page: OutfitsDetailPage,
            ),
            AutoRoute(
              page: InfluencerPage,
            ),
          ]),
          AutoRoute(
            page: ProductDetailPage,
          ),
          AutoRoute(page: BlogsFeedPage, children: [
            AutoRoute(
              page: ProductDetailPage,
            ),
            AutoRoute(
              page: BlogPage,
            ),
          ]),
          AutoRoute(page: InfluencerFeedPage, children: [
            AutoRoute(
              page: InfluencerPage,
            ),
          ]),
          AutoRoute(page: ProductsPage, children: [
            AutoRoute(
              page: ProductDetailPage,
            ),
          ]),
        ])
  ],
)
class {{name.pascalCase()}}Router extends _${{name.pascalCase()}}Router {

}
