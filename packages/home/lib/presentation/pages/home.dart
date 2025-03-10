
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
              body: ListView.builder(
                itemCount: successState.product.length,
                itemBuilder: (context, index){
                return ProductWidget(productEntities: successState.product[index]);
              }),
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

