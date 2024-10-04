import '../repositories/product_details__repository.dart';

abstract class HomeScreenUseCase {
  final HomeScreenRepository homeScreenRepository;

 HomeScreenUseCase(this.homeScreenRepository);
}
