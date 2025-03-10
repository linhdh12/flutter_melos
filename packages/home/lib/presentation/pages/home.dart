
import 'package:cart/presentation/pages/cart.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:home/presentation/widget/product_widget.dart';
import 'package:wishlist/presentation/pages/wishlist.dart';


import '../bloc/home_bloc.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  void initState() {
    homeBloc.add(HomeInitialEvent());
    super.initState();
  }
  final HomeBloc homeBloc = HomeBloc();
  @override
  Widget build(BuildContext context) {
   return BlocConsumer<HomeBloc, HomeState>(
        bloc: homeBloc,
        listenWhen: (previous, current) => current is HomeActionState,
        buildWhen: (previous, current) => current is !HomeActionState,
        listener: (context, state) {
            if(state is HomeNavigateToCartPageActionState){
              Navigator.push(context, MaterialPageRoute(builder: (context) => CartPage()));
            }
            if(state is HomeNavigateToWishlistPageActionState){
              Navigator.push(context, MaterialPageRoute(builder: (context) => WishListPage()));
            }
        },
      builder: (context, state) {
        switch (state.runtimeType) {
          case HomeLoadingState:           
            return Scaffold(
              body: Center(
              child: CircularProgressIndicator(),
            ));
          case HomeLoadedSuccessState:     
          final successState = state as HomeLoadedSuccessState;      
            return Scaffold(
              appBar: AppBar(
                  title: Text('Grocery Store'),
                  actions: [
                      IconButton(onPressed: (){
                          homeBloc.add(HomeWishListButtonNavigationEvent());                        
                      }, icon: Icon(Icons.favorite_outline)),
                      IconButton(onPressed: (){
                          homeBloc.add(HomeCartButtonNavigationEvent());
                      }, icon: Icon(Icons.shopping_bag_outlined))
                  ],
              ),
              body: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  SizedBox(height: 20),
                  Text(
                    'Product List',
                    style: TextStyle(
                      fontSize: 24,  
                      fontWeight: FontWeight.bold, 
                    ),
                  ),
                  SizedBox(height: 12),
                  Text('We offer fresh, high-quality crops grown sustainably for the best taste and nutrition.'),
                  SizedBox(height: 30),
                  Expanded(
                  child: GridView.builder(
                    padding: EdgeInsets.symmetric(horizontal: 20.0), // Thêm padding để căn chỉnh lề
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 4, // Số cột
                      crossAxisSpacing: 15, // Khoảng cách giữa các cột
                      mainAxisSpacing: 20, // Khoảng cách giữa các hàng
                      childAspectRatio: 0.7, // Tỷ lệ chiều rộng/chiều cao của mỗi item
                    ),
                    itemCount: successState.product.length,
                    itemBuilder: (context, index) {
                      return ProductWidget(productEntities: successState.product[index]);
                    },
                  ),
                ),
                  SizedBox(height: 20),
                  Text('')
                ],
              ),
            );
          case HomeErrorState:
            return Scaffold(body: Center(child: Text('Error'),),);
          default: 
            return SizedBox();
        }
      },
    );
  }
}


