import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:home/data/data_source/grocery_db.dart';
import 'package:home/domain/entities/product.dart';
import 'package:meta/meta.dart';
part 'home_event.dart';
part 'home_state.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  HomeBloc() : super(HomeInitial()) {
    on<HomeInitialEvent>(
      homeInitialEvent);
    on<HomeProductWishListButtonClickEvent>(
      homeProductWishListButtonClickEvent);
    on<HomeProductCartButtonClickEvent>(
      homeProductCartButtonClickEvent);
    on<HomeWishListButtonNavigationEvent>(
      homeWishListButtonNavigationEvent);
    on<HomeCartButtonNavigationEvent>(
      homeCartButtonNavigationEvent);
    }
  Future<void> homeInitialEvent(HomeInitialEvent event, Emitter<HomeState> emit) async {
    emit(HomeLoadingState());
    await Future.delayed(Duration(seconds: 3));
    emit(
      HomeLoadedSuccessState(product: GroceryData.groceryProduct
      .map((e) => ProductEntities(
        id: e['id'], 
        name: e['name'], 
        description: e['description'], 
        price: e['price'], 
        imageUrl: e['imageUrl']),)
      .toList()));
  }
  FutureOr<void> homeProductWishListButtonClickEvent(
    HomeProductWishListButtonClickEvent event, Emitter<HomeState> emit) {
      print('WL product clicked');
  }

  FutureOr<void> homeProductCartButtonClickEvent(
    HomeProductCartButtonClickEvent event, Emitter<HomeState> emit) {
      print('Cart product clicked');
  }

  FutureOr<void> homeCartButtonNavigationEvent(
    HomeCartButtonNavigationEvent event, Emitter<HomeState> emit) {
      print('Cart navigate clicked');
      emit(HomeNavigateToCartPageActionState());
  }

  FutureOr<void> homeWishListButtonNavigationEvent(
    HomeWishListButtonNavigationEvent event, Emitter<HomeState> emit) {
      print('WL navigate clicked');
      emit(HomeNavigateToWishlistPageActionState());
  }

  
}

