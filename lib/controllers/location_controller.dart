import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:food_app/data/api/api_checker.dart';
import 'package:food_app/data/repository/location_repository.dart';
import 'package:food_app/models/address_model.dart';
import 'package:food_app/models/response_model.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:google_maps_webservice/src/places.dart';

class LocationController extends GetxController implements GetxService {
  final LocationRepository locationRepository;

  LocationController({required this.locationRepository});
  bool _loading = false;

  late Position _position;
  late Position _pickPosition;

  Placemark _placemark = Placemark();
  Placemark _pickPlacemark = Placemark();

  Placemark get placemark => _placemark;
  Placemark get pickPlacemark => _pickPlacemark;

  List<AddressModel> _addressList = [];
  List<AddressModel> get addressList => _addressList;
  late List<AddressModel> _allAddressList;
  List<AddressModel> get allAddressList => _allAddressList;

  final List<String> _addressTypeList = ['home', 'office', 'others'];
  List<String> get addressTypeList => _addressTypeList;

  int _addressTypeIndex = 0;
  int get addressTypeIndex => _addressTypeIndex;

  late GoogleMapController _mapController;
  GoogleMapController get mapController => _mapController;

  bool _updateAddressData = true;
  bool _changeAddress = true;
  bool _changePosition = false;
  bool get loading => _loading;
  Position get position => _position;
  Position get pickPosition => _pickPosition;

  bool _isLoading = false;
  bool get isLoading => _isLoading;
  bool _inZone = false;
  bool get inZone => _inZone;
  bool _buttonDisabled = true;
  bool get buttonDisabled => _buttonDisabled;

  List<Prediction> _predictionList = [];

  void setMapController(GoogleMapController controller) {
    if (_changePosition && _mapController != null) {
      controller.moveCamera(CameraUpdate.newCameraPosition(CameraPosition(
          target: LatLng(_position.latitude, _position.longitude), zoom: 17)));
      _changePosition = false;
    }
    _mapController = controller;
  }

  void updatePosition(CameraPosition position, bool fromAdress) async {
    if (_updateAddressData) {
      _loading = true;
      update();
      try {
        if (fromAdress) {
          _position = Position(
              longitude: position.target.longitude,
              latitude: position.target.latitude,
              timestamp: DateTime.now(),
              accuracy: 1,
              altitude: 1,
              heading: 1,
              speed: 1,
              speedAccuracy: 1);
        } else {
          _pickPosition = Position(
              longitude: position.target.longitude,
              latitude: position.target.latitude,
              timestamp: DateTime.now(),
              accuracy: 1,
              altitude: 1,
              heading: 1,
              speed: 1,
              speedAccuracy: 1);
        }

        ResponseModel _responseModel = await getZone(
            position.target.latitude.toString(),
            position.target.longitude.toString(),
            false);
        _buttonDisabled = !_responseModel.isSuccess;
        if (_changeAddress) {
          String address = await getAddressFromGeocode(
              LatLng(position.target.latitude, position.target.longitude));
          fromAdress
              ? _placemark = Placemark(name: address)
              : _pickPlacemark = Placemark(name: address);
          // update();
        } else {
          _changeAddress = true;
        }
      } catch (err) {
        print(err);
      }
      _loading = false;
      update();
    } else {
      _updateAddressData = true;
    }
  }

  Future<String> getAddressFromGeocode(LatLng latLng) async {
    String _address = 'Unknow location found';
    Response response = await locationRepository.getAddressFromGeocode(latLng);
    if (response.body['status'] == 'OK') {
      _address = response.body['results'][0]['formatted_address'].toString();
    } else {
      //error
    }
    update();
    return _address;
  }

  late Map<String, dynamic> _getAddress;
  Map get getAddress => _getAddress;

  AddressModel getUserAddress() {
    late AddressModel _addressModel;
    String response = locationRepository.getUserAddress();
    try {
      _getAddress = jsonDecode(response);
      _addressModel = AddressModel.fromJson(_getAddress);
      _addressList = [];
      _allAddressList = [];
      _addressList.add(AddressModel.fromJson(_getAddress));
      _allAddressList.add(AddressModel.fromJson(_getAddress));
    } catch (err) {
      print(err);
      if (_getAddress.isNotEmpty) {
        _addressModel = AddressModel.fromJson(_getAddress);
      }
    }
    return _addressModel;
  }

  void setAddressTypeIndex(int index) {
    _addressTypeIndex = index;
    update();
  }

  Future<ResponseModel> addAddress(AddressModel addressModel) async {
    _loading = true;
    update();
    // Response response = await locationRepository.addAddress(addressModel);
    ResponseModel responseModel;
    // if (response.statusCode == 200) {
    //   await getAddressList();
    //   String message = response.body['message'];
    //   responseModel = ResponseModel(true, message);
    //   await saveUserAddress(addressModel);
    // } else {
    bool saveIsSuccess = await saveUserAddress(addressModel);
    if (saveIsSuccess) {
      responseModel = ResponseModel(true, 'Success');
    } else {
      responseModel = ResponseModel(false, 'Fail');
    }
    // }
    update();
    return responseModel;
  }

  Future<void> getAddressList() async {
    // Response response = await locationRepository.getAllAddress();
    // if (response.statusCode == 200) {
    //   _addressList = [];
    //   _allAddressList = [];
    //   for (var address in (response.body as List)) {
    //     _addressList.add(AddressModel.fromJson(address));
    //     _allAddressList.add(AddressModel.fromJson(address));
    //   }
    // } else {
    _addressList = [];
    _allAddressList = [];
    String address = locationRepository.getUserAddress();
    if (address.isNotEmpty) {
      _addressList.add(AddressModel.fromJson(jsonDecode(address)));
      _allAddressList.add(AddressModel.fromJson(jsonDecode(address)));
    }
    // }
    update();
  }

  Future<bool> saveUserAddress(AddressModel addressModel) async {
    String userAddress = jsonEncode(addressModel.toJson());
    bool response = await locationRepository.saveUserAddress(userAddress);
    update();
    return response;
  }

  void clearAddressList() {
    _addressList = [];
    _allAddressList = [];
    update();
  }

  void setAddAddressData(
      String contactPersonName, String contactPersonNumber) async {
    _position = _pickPosition;
    _placemark = _pickPlacemark;
    _updateAddressData = false;
    _changeAddress = true;
    _changePosition = true;
    String address = await getAddressFromGeocode(
        LatLng(_position.latitude, _position.longitude));
    AddressModel addressModel = AddressModel(
        addressType: addressTypeList[addressTypeIndex],
        contactPersonName: contactPersonName,
        contactPersonNumder: contactPersonNumber,
        address: address,
        latitude: _position.latitude.toString(),
        longitude: _position.longitude.toString());
    _addressList = [];
    _allAddressList = [];
    _addressList.add(addressModel);
    _allAddressList.add(addressModel);
    _getAddress = addressModel.toJson();
    update();
  }

  Future<ResponseModel> getZone(String lat, String lng, bool markerLoad) async {
    late ResponseModel _responseModel;
    if (markerLoad) {
      _loading = true;
    } else {
      _isLoading = true;
    }
    update();

    Response response = await locationRepository.getZone(lat, lng);
    if (response.statusCode == 200) {
      _inZone = true;
      _responseModel = ResponseModel(true, response.body['zone_id'].toString());
    } else if (response.statusCode == 500) {
      //permission problems
      _inZone = true;
      _responseModel = ResponseModel(true, response.statusText ?? 'False');
    } else {
      _inZone = false;
      _responseModel = ResponseModel(true, response.statusText ?? 'False');
    }
    if (markerLoad) {
      _loading = false;
    } else {
      _isLoading = false;
    }
    update();
    return _responseModel;
  }

  Future<List<Prediction>> searchLocation(
      BuildContext context, String text) async {
    if (text.isNotEmpty) {
      Response response = await locationRepository.searchLocation(text);
      if (response.statusCode == 200 && response.body['status'] == 'OK') {
        _predictionList = [];
        response.body['predictions'].forEach((prediction) =>
            _predictionList.add(Prediction.fromJson(prediction)));
      } else {
        ApiChecker.checkApi(response);
      }
    }
    return _predictionList;
  }

  setLocation(String placeID, String address,
      GoogleMapController googleMapController) async {
    _loading = true;
    update();
    PlacesDetailsResponse detail;
    Response response = await locationRepository.setLocation(placeID);
    detail = PlacesDetailsResponse.fromJson(response.body);
    var geometry = detail.result.geometry;
    _pickPosition = Position(
        longitude: geometry!.location.lng,
        latitude: geometry.location.lat,
        timestamp: DateTime.now(),
        accuracy: 1,
        altitude: 1,
        heading: 1,
        speed: 1,
        speedAccuracy: 1);
    _pickPlacemark = Placemark(
      name: address,
    );
    _changeAddress = false;
    if (googleMapController != null) {
      CameraPosition cameraPosition = CameraPosition(
          target: LatLng(geometry.location.lat, geometry.location.lng),
          zoom: 17);
      googleMapController
          .animateCamera(CameraUpdate.newCameraPosition(cameraPosition));
      updatePosition(cameraPosition, false);
    }

    if (_mapController != null) {
      CameraPosition cameraPosition = CameraPosition(
          target: LatLng(geometry.location.lat, geometry.location.lng),
          zoom: 17);
      _mapController
          .animateCamera(CameraUpdate.newCameraPosition(cameraPosition));
      updatePosition(cameraPosition, false);
    }
    _loading = false;
    update();
  }
}
