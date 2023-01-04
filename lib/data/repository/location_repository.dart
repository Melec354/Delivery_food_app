import 'package:food_app/data/api/api_client.dart';
import 'package:food_app/models/address_model.dart';
import 'package:food_app/utils/app_constants.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter_platform_interface/src/types/location.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LocationRepository {
  final ApiClient apiClient;
  final SharedPreferences sharedPreferences;
  LocationRepository(
      {required this.apiClient, required this.sharedPreferences});

  Future<Response> getAddressFromGeocode(LatLng latLng) async {
    return await apiClient.getData(
        '${AppConstants.geocodeURL}?lat=${latLng.latitude}&lng=${latLng.longitude}');
  }

  String getUserAddress() {
    return sharedPreferences.getString(AppConstants.userAddress) ?? '';
  }

  Future<Response> addAddress(AddressModel addressModel) async {
    apiClient
        .updateHeader(sharedPreferences.getString(AppConstants.token) ?? '');
    return await apiClient.post(
        AppConstants.addUserAddress, addressModel.toJson());
  }

  Future<Response> getAllAddress() async {
    return await apiClient.getData(AppConstants.addressListURL);
  }

  Future<bool> saveUserAddress(String userAddress) async {
    apiClient
        .updateHeader(sharedPreferences.getString(AppConstants.token) ?? '');
    return await sharedPreferences.setString(
        AppConstants.userAddress, userAddress);
  }

  Future<Response> getZone(String lat, String lng) async {
    return await apiClient.getData('${AppConstants.zoneURL}?lat=$lat&lng=$lng');
  }

  Future<Response> searchLocation(String text) async {
    return await apiClient
        .getData('${AppConstants.searchLocationURL}?search_text=$text');
  }

  Future<Response> setLocation(String placeID) async {
    return await apiClient
        .getData('${AppConstants.placeDetailURL}?placeid=$placeID');
  }
}
