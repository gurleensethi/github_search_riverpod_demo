import 'package:riverpod/riverpod.dart';
import 'package:riverpod_demo/data/network/network_service.dart';

final networkServiceProvider =
    StateProvider<NetworkService>((ref) => NetworkService());
