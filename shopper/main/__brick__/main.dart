import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:shopper/shopper.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

void main() async {
  await dotenv.load(
      fileName: kDebugMode ? ".env.development" : ".env.production");
  final contextId = dotenv.get("SHOPPER_API_KEY", fallback: "");

  Shopper(
    contextId: contextId,
    router: AppRouter(
      authGuard: AuthGuard(),
    ),
    blocProviders: [
      BlocProvider<ShopperBottomNavigationCubit>(
        create: (context) => ShopperBottomNavigationCubit(),
      ),
      BlocProvider<FavoriteCubit>(
        create: (BuildContext context) => FavoriteCubit(),
      ),
      BlocProvider<CartCubit>(
        create: (BuildContext context) => CartCubit(
          customNavList: context.shopperContext.collectionNavigation,
        ),
      ),
      BlocProvider<ProfileCubit>(
        create: (BuildContext context) => ProfileCubit(),
      ),
    ],
    bottomNavigationItems: [
      ShopperBottombarNavigationItem(
        pageBuilder: (context, data) => HomeScreen(),
        title: "Home",
        iconBuilder: (context, isSelected) => Icon(
          isSelected ? Icons.home : Icons.home_outlined,
        ),
      ),
      ShopperBottombarNavigationItem(
        pageBuilder: (context, data) => DiscoveryScreen(
          metaCollectionId: data,
        ),
        title: "Discovery",
        iconBuilder: (context, isSelected) => const Icon(
          Icons.search,
        ),
      ),
      ShopperBottombarNavigationItem(
        pageBuilder: (context, data) => const FavoriteScreen(),
        title: "Favorite",
        iconBuilder: (context, isSelected) =>
            BlocBuilder<FavoriteCubit, FavoriteState>(
          builder: (context, state) {
            return SizedBox(
              height: 43,
              width: 44,
              child: Stack(
                children: [
                  Align(
                    alignment: Alignment.center,
                    child: Icon(
                      isSelected ? Icons.favorite : Icons.favorite_border,
                    ),
                  ),
                  Align(
                    alignment: Alignment.topRight,
                    child: Visibility(
                      visible: (state.favoriteVariantIdList?.length ?? 0) > 0,
                      child: Container(
                        height: 19,
                        width: 19,
                        decoration: const BoxDecoration(
                          color: Colors.red,
                          shape: BoxShape.circle,
                        ),
                        child: Center(
                          child: Text(
                            (state.favoriteVariantIdList?.length ?? 0)
                                .toString(),
                            style: ShopperFont.ROBOTO_REGULAR_W400_12.copyWith(
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            );
          },
        ),
      ),
      ShopperBottombarNavigationItem(
        pageBuilder: (context, data) => const CartScreen(),
        title: "Cart",
        iconBuilder: (context, isSelected) => BlocBuilder<CartCubit, CartState>(
          builder: (context, state) {
            return SizedBox(
              height: 43,
              width: 44,
              child: Stack(
                children: [
                  Align(
                    alignment: Alignment.center,
                    child: Icon(
                      isSelected
                          ? Icons.shopping_bag
                          : Icons.shopping_bag_outlined,
                    ),
                  ),
                  Align(
                    alignment: Alignment.topRight,
                    child: Visibility(
                      visible: (state.numberOfProduct ?? 0) > 0,
                      child: Container(
                        height: 19,
                        width: 19,
                        decoration: const BoxDecoration(
                          color: Colors.red,
                          shape: BoxShape.circle,
                        ),
                        child: Center(
                          child: Text(
                            (state.numberOfProduct ?? 0).toString(),
                            style: ShopperFont.ROBOTO_REGULAR_W400_12.copyWith(
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            );
          },
        ),
      ),
      ShopperBottombarNavigationItem(
        pageBuilder: (context, data) => ProfileScreen(
          onLogout: () => {},
        ),
        title: "Profile",
        iconBuilder: (context, isSelected) => Icon(
          isSelected ? Icons.person : Icons.person_outline,
        ),
      ),
    ],
    plugins: [
      useShopifyGraphqlClient(),
      useReviewsIO(),
    ],
  ).run();
}
