import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../const_config/color_config.dart';
import '../../const_config/const_config.dart';
import '../../const_config/text_config.dart';
import '../../services/product/product_provider.dart';
import '../global_widgets/custome_image_network_card.dart';

class BnbSearchBar extends StatefulWidget {
  const BnbSearchBar({super.key});

  @override
  State<BnbSearchBar> createState() => _BnbSearchBarState();
}

class _BnbSearchBarState extends State<BnbSearchBar> {
  final TextEditingController _searchController = TextEditingController();
  final FocusNode _focusNode = FocusNode();
  final OverlayPortalController _tooltipController = OverlayPortalController();
  final _link = LayerLink();

  @override
  void initState() {
    super.initState();
    _searchController.addListener(_onSearchChanged);
    _focusNode.addListener(_onFocusChanged);
  }

  @override
  void dispose() {
    _searchController.removeListener(_onSearchChanged);
    _searchController.dispose();
    _focusNode.removeListener(_onFocusChanged);
    _focusNode.dispose();
    super.dispose();
  }

  void _onSearchChanged() {
    final productProvider = Provider.of<ProductProvider>(
        context, listen: false);
    productProvider.filterProducts(_searchController.text);
    if (_searchController.text.isNotEmpty) {
      _tooltipController.show();
    } else {
      _tooltipController.hide();
    }
  }

  void _onFocusChanged() {
    if (!_focusNode.hasFocus) {
      Future.delayed(const Duration(milliseconds: 100), () {
        if (!_focusNode.hasFocus) {
          _tooltipController.hide();
        }
      });
    }
  }

  void _hideTooltip() {
    _tooltipController.hide();
    _focusNode.unfocus();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery
        .of(context)
        .size;
    final productProvider = Provider.of<ProductProvider>(context);
    return GestureDetector(
      onTap: () => _hideTooltip(),
      child: CompositedTransformTarget(
        link: _link,
        child: OverlayPortal(
          controller: _tooltipController,
          overlayChildBuilder: (BuildContext context) {
            return CompositedTransformFollower(
              link: _link,
              targetAnchor: Alignment.bottomLeft,
              child: Align(
                alignment: AlignmentDirectional.topStart,
                child: Material(
                  elevation: 5,
                  shadowColor: Colors.black26,
                  color: MyColor.white,
                  borderRadius: const BorderRadius.vertical(
                      top: Radius.circular(5.0), bottom: Radius.circular(10.0)),
                  child: SizedBox(
                    width: size.width > 500 ? size.width / 3 : size.width / 1.3,
                    height: productProvider.filteredProducts.length < 7
                        ? productProvider.filteredProducts.length * 70
                        : 6 * 65, // Constrain max height
                    child: ListView.builder(
                      itemCount: productProvider.filteredProducts.length,
                      itemBuilder: (context, index) {
                        final product = productProvider.filteredProducts[index];

                        return /// for large screen
                          size.width > 1000 ? ListTile(
                          leading: CustomImageNetworkCard(
                            imageHeight: 50,
                            imageWidth: 50,
                            imagePath: '$baseImageUrlProduct/${product
                                .firstImage}',
                          ),
                          title: Text(
                            product.productFirstVariantName,
                            style: TextDesign().bnbCardTitleTextMobile,
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                          ),
                          subtitle: product.isDiscounted == 1
                              ? Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Text(
                                '৳ ${product.price}',
                                style: TextDesign()
                                    .bnbCardTitleTextMobile
                                    .copyWith(
                                    decoration: TextDecoration.lineThrough,
                                    decorationColor: MyColor.red,
                                    color: MyColor.red),
                                maxLines: 2,
                                overflow: TextOverflow.ellipsis,
                              ),
                              const SizedBox(
                                width: 10,
                              ),
                              Text(
                                '৳ ${product.discountPrice}',
                                style: TextDesign().bnbCardTitleTextMobile,
                                maxLines: 2,
                                overflow: TextOverflow.ellipsis,
                              ),
                            ],
                          )
                              : Text(
                            '৳ ${product.discountPrice}',
                            style: TextDesign().bnbCardTitleTextMobile,
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                          ),
                          trailing: product.isNew == 1
                              ? Image.asset(
                            "assets/images/home/new_arrival.png",
                            height: 75,
                            width: 75,
                          )
                              : product.isRecommended == 1
                              ? Image.asset(
                            "assets/images/star.png",
                            height: 75,
                            width: 75,
                          )
                              : const SizedBox.shrink(),
                          onTap: () {
                            Navigator.of(context).pushNamed(
                                '/productDetailsScreen', arguments: {
                              'id': product.productId,
                            });
                            _searchController.clear();
                            productProvider.clearFilteredProducts();
                            _hideTooltip();
                          },
                        )
                          /// for medium screen
                            : size.width > 500 ? ListTile(
                          leading: CustomImageNetworkCard(
                            imageHeight: 20,
                            imageWidth: 20,
                            imagePath: '$baseImageUrlProduct/${product
                                .firstImage}',
                          ),
                          title: Text(
                            product.productFirstVariantName,
                            style: TextDesign().bnbCardTitleTextMobile,
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                          ),
                          subtitle: product.isDiscounted == 1
                              ? Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Text(
                                '৳ ${product.price}',
                                style: TextDesign()
                                    .bnbCardTitleTextMobile
                                    .copyWith(
                                    decoration: TextDecoration.lineThrough,
                                    decorationColor: MyColor.red,
                                    color: MyColor.red),
                                maxLines: 2,
                                overflow: TextOverflow.ellipsis,
                              ),
                              const SizedBox(
                                width: 10,
                              ),
                              Text(
                                '৳ ${product.discountPrice}',
                                style: TextDesign().bnbCardTitleTextMobile,
                                maxLines: 2,
                                overflow: TextOverflow.ellipsis,
                              ),
                            ],
                          )
                              : Text(
                            '৳ ${product.discountPrice}',
                            style: TextDesign().bnbCardTitleTextMobile,
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                          ),
                          onTap: () {
                            Navigator.of(context).pushNamed(
                                '/productDetailsScreen', arguments: {
                              'id': product.productId,
                            });
                            _searchController.clear();
                            productProvider.clearFilteredProducts();
                            _hideTooltip();
                          },
                        )
                          /// for small screen
                            : ListTile(
                          leading: CustomImageNetworkCard(
                            imageHeight: 30,
                            imageWidth: 30,
                            imagePath: '$baseImageUrlProduct/${product
                                .firstImage}',
                          ),
                          title: Text(
                            product.productFirstVariantName,
                            style: TextDesign().bnbCardTitleTextMobile,
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                          ),
                          subtitle: product.isDiscounted == 1
                              ? Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Text(
                                '৳ ${product.price}',
                                style: TextDesign()
                                    .bnbCardTitleTextMobile
                                    .copyWith(
                                    decoration: TextDecoration.lineThrough,
                                    decorationColor: MyColor.red,
                                    color: MyColor.red),
                                maxLines: 2,
                                overflow: TextOverflow.ellipsis,
                              ),
                              const SizedBox(
                                width: 10,
                              ),
                              Text(
                                '৳ ${product.discountPrice}',
                                style: TextDesign().bnbCardTitleTextMobile,
                                maxLines: 2,
                                overflow: TextOverflow.ellipsis,
                              ),
                            ],
                          )
                              : Text(
                            '৳ ${product.discountPrice}',
                            style: TextDesign().bnbCardTitleTextMobile,
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                          ),
                          trailing: product.isNew == 1
                              ? Image.asset(
                            "assets/images/home/new_arrival.png",
                            height: 40,
                            width: 40,
                          )
                              : product.isRecommended == 1
                              ? Image.asset(
                            "assets/images/star.png",
                            height: 40,
                            width: 40,
                          )
                              : const SizedBox.shrink(),
                          onTap: () {
                            Navigator.of(context).pushNamed(
                                '/productDetailsScreen', arguments: {
                              'id': product.productId,
                            });
                            _searchController.clear();
                            productProvider.clearFilteredProducts();
                            _hideTooltip();
                          },
                        );

                      },
                    ),
                  ),
                ),
              ),
            );
          },
          child: Material(
            borderRadius: BorderRadius.circular(25.0),
            color: MyColor.bnbScaffold,
            child: SizedBox(
              height: 50,
              width: size.width / 3,
              child: Row(
                children: [
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.only(left: 15.0),
                      child: TextField(
                        controller: _searchController,
                        focusNode: _focusNode,
                        textAlign: TextAlign.left,
                        decoration: const InputDecoration(
                          hintText: 'Search',
                          border: InputBorder.none,
                        ),
                      ),
                    ),
                  ),
                  const Padding(
                    padding: EdgeInsets.all(8.0),
                    child: Icon(
                      Icons.search,
                      color: Colors.grey,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
