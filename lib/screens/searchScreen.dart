// import 'package:flutter/material.dart';
// import 'package:flutter_riverpod/flutter_riverpod.dart';

// import 'package:hamro_electronics/src/features/product/screen/widgets/productItem.dart';

// import '../src/features/product/controller/productController.dart';
// import '../src/features/product/model/product.dart';

// class SearchScreen extends ConsumerWidget {
//   static const routeName = '/search-page';
//   const SearchScreen({super.key});

//   @override
//   Widget build(BuildContext context, ref) {
//     Size size = MediaQuery.of(context).size;
//     String name = ModalRoute.of(context)!.settings.arguments as String;

//     List<Product> products =
//         ref.watch(productProvider.notifier).searchProduct(name);
//     return Scaffold(
//       appBar: AppBar(
//         centerTitle: true,
//         automaticallyImplyLeading: false,
//         leading: IconButton(
//           icon: Icon(
//             Icons.arrow_back_ios,
//             color: Colors.indigo,
//             size: Theme.of(context).textTheme.headline6!.fontSize,
//           ),
//           onPressed: () => Navigator.of(context).pop(),
//         ),
//         title: Text(
//           'Search Page',
//           style: Theme.of(context).textTheme.headline5!.copyWith(
//                 fontWeight: FontWeight.w500,
//                 color: Colors.indigo,
//               ),
//         ),
//         backgroundColor: Theme.of(context).scaffoldBackgroundColor,
//         elevation: 0,
//       ),
//       body: SafeArea(
//         child: Padding(
//           padding: EdgeInsets.symmetric(horizontal: size.width * 0.03),
//           child: Column(
//             children: [
//               SizedBox(
//                 height: size.height * 0.82,
//                 child: GridView.builder(
//                   itemBuilder: (ctx, i) {
//                     return ProductItem(
//                       id: products[i].id,
//                       discountedPrice: products[i].discountedprice,
//                       name: products[i].name,
//                       photopath: products[i].photopath1,
//                       price: products[i].price,
//                       rating: products[i].rating ?? 0.0,
//                       ratingNumber: products[i].ratingNumber,
//                     );
//                   },
//                   itemCount: products.length,
//                   shrinkWrap: true,
//                   gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
//                     crossAxisCount: 2,
//                     childAspectRatio: 0.59,
//                   ),
//                 ),
//               )
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }
