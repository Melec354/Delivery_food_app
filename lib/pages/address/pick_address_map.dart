import 'package:flutter/material.dart';
import 'package:food_app/base/custom_buttom.dart';
import 'package:food_app/controllers/location_controller.dart';
import 'package:food_app/pages/address/widgets/search_location_dialogue_page.dart';
import 'package:food_app/routes/route_helper.dart';
import 'package:food_app/utils/colors.dart';
import 'package:food_app/utils/dimensions.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class PickAddressMap extends StatefulWidget {
  final bool fromSignup;
  final bool fromAddress;
  final String contactPersonName;
  final String contactPersonNumber;
  final GoogleMapController? googleMapController;
  const PickAddressMap(
      {super.key,
      required this.fromSignup,
      required this.fromAddress,
      this.googleMapController,
      required this.contactPersonName,
      required this.contactPersonNumber});

  @override
  State<PickAddressMap> createState() => _PickAddressMapState();
}

class _PickAddressMapState extends State<PickAddressMap> {
  late LatLng _initialPosition;
  late GoogleMapController _googleMapController;
  late CameraPosition _cameraPosition;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    if (Get.find<LocationController>().addressList.isEmpty) {
      _initialPosition = LatLng(51.1030107, 17.0339951);
      _cameraPosition =
          CameraPosition(target: LatLng(51.1030107, 17.0339951), zoom: 18);
    } else {
      if (Get.find<LocationController>().addressList.isNotEmpty) {
        Map<dynamic, dynamic> getAddress =
            Get.find<LocationController>().getAddress;
        String latitude = getAddress['latitude'];
        String longitude = getAddress['longitude'];
        _initialPosition =
            LatLng(double.parse(latitude), double.parse(longitude));
        _cameraPosition = CameraPosition(target: _initialPosition, zoom: 18);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return GetBuilder<LocationController>(builder: (locationController) {
      return Scaffold(
        body: SafeArea(
          child: Center(
            child: SizedBox(
              width: double.maxFinite,
              child: Stack(children: [
                GoogleMap(
                  zoomControlsEnabled: false,
                  compassEnabled: false,
                  indoorViewEnabled: true,
                  mapToolbarEnabled: false,
                  myLocationEnabled: true,
                  initialCameraPosition:
                      CameraPosition(target: _initialPosition, zoom: 18),
                  onCameraMove: (cameraPosition) {
                    _cameraPosition = cameraPosition;
                  },
                  onCameraIdle: () {
                    Get.find<LocationController>()
                        .updatePosition(_cameraPosition, false);
                    locationController.updatePosition(_cameraPosition, true);
                  },
                  onMapCreated: (mapController) {
                    _googleMapController = mapController;
                  },
                ),
                Center(
                  child: !locationController.loading
                      ? Image.asset(
                          'assets/image/pick_marker.png',
                          height: Dimensions.height45,
                          width: Dimensions.width20 * 2.5,
                        )
                      : const CircularProgressIndicator(),
                ),
                Positioned(
                  top: Dimensions.height45,
                  left: Dimensions.width20,
                  right: Dimensions.width20,
                  child: InkWell(
                    onTap: () => Get.dialog(
                        LocationDialogue(mapController: _googleMapController)),
                    child: Container(
                      padding:
                          EdgeInsets.symmetric(horizontal: Dimensions.width10),
                      height: Dimensions.height45,
                      decoration: BoxDecoration(
                          color: AppColors.mainColor,
                          borderRadius:
                              BorderRadius.circular(Dimensions.radius20 / 2)),
                      child: Row(children: [
                        Icon(Icons.location_on,
                            size: Dimensions.height30,
                            color: AppColors.yellowColor),
                        Expanded(
                            child: Text(
                          locationController.pickPlacemark.name ?? '',
                          style: const TextStyle(color: Colors.white),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        )),
                        SizedBox(
                          width: Dimensions.width10,
                        ),
                        Icon(Icons.search,
                            size: 25, color: AppColors.yellowColor)
                      ]),
                    ),
                  ),
                ),
                Positioned(
                    bottom: Dimensions.height45,
                    left: Dimensions.width20,
                    right: Dimensions.width20,
                    child: locationController.isLoading
                        ? const Center(
                            child: CircularProgressIndicator(),
                          )
                        : CustomButtom(
                            buttonText: locationController.inZone
                                ? widget.fromAddress
                                    ? 'Pick address'
                                    : 'Pick location'
                                : 'Service is not available in your area',
                            onPressed: (locationController.buttonDisabled ||
                                    locationController.loading)
                                ? null
                                : () {
                                    if (locationController
                                                .pickPosition.latitude !=
                                            0 &&
                                        locationController.pickPlacemark.name !=
                                            null) {
                                      if (widget.fromAddress) {
                                        if (widget.googleMapController !=
                                            null) {
                                          locationController.setAddAddressData(
                                              widget.contactPersonName,
                                              widget.contactPersonNumber);
                                          widget.googleMapController?.moveCamera(
                                              CameraUpdate.newCameraPosition(
                                                  CameraPosition(
                                                      target: LatLng(
                                                          locationController
                                                              .pickPosition
                                                              .latitude,
                                                          locationController
                                                              .pickPosition
                                                              .longitude))));
                                        }
                                        Get.toNamed(
                                            RouteHelper.getAddressPage());
                                      }
                                    }
                                  },
                          ))
              ]),
            ),
          ),
        ),
      );
    });
  }
}
