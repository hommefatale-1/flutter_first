import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:geocoding/geocoding.dart';

void main() => runApp(TestMap());

class TestMap extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: MapScreen(),
    );
  }
}

class MapScreen extends StatefulWidget {
  @override
  _MapScreenState createState() => _MapScreenState();
}

class _MapScreenState extends State<MapScreen> {
  late GoogleMapController mapCtrl;
  LatLng? _initPosition;
  Set<Marker> _marker = {};
  TextEditingController _searchCtl = TextEditingController();

  @override
  void initState() {
    super.initState();
    //현재 위치를 가져오는 메서드 호출
    _getCurrentLocation();
  }

  Future<void> _getCurrentLocation() async {
    //위치 권한 요청
    LocationPermission permission = await Geolocator.requestPermission();
    //현재 위치 가져오기
    Position position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high);
    //현재 위치를 변수에 저장하고,  마커를 추가
    setState(() {
      _initPosition = LatLng(position.latitude, position.longitude);
      _marker.add(
        Marker(
          markerId: MarkerId('1'),
          position: _initPosition!,
          icon: BitmapDescriptor.defaultMarker,
          infoWindow: InfoWindow(title: '현재위치'),
        )
      );
    });
  }

  Future<void> _searchLocation(String query) async {
    if (mapCtrl != null) {
      // Geocoding API를 사용하여 검색어를 위경도 좌표로 변환
      List<Location> locations = await locationFromAddress(query);
      if (locations.isNotEmpty) {
        // 변환된 좌표 중 첫 번째 위치를 사용하여 마커를 추가
        Location location = locations.first;
        setState(() {
          _marker.clear();
          _marker.add(
            Marker(
              markerId: MarkerId('search'),
              // 위도(latitude)와 경도(longitude) 값으로 설정
              position: LatLng(location.latitude, location.longitude),
              //정보 창을 설정
              infoWindow: InfoWindow(title: '검색한 위치'),
            ),
          );
          // 검색한 위치로 카메라 이동
          mapCtrl.animateCamera(
            CameraUpdate.newLatLngZoom(
              LatLng(location.latitude, location.longitude),
              14.0,
            ),
          );
        });
      }
    }
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
       title: TextField(
         controller: _searchCtl,
         decoration: InputDecoration(
             labelText: '검색할 장소 입력',
             suffixIcon: IconButton(
                 onPressed: () {
                   _searchLocation(_searchCtl.text);
                 },
                 icon: Icon(Icons.search)
             )
         ),
       ),
      ),
      body: _initPosition == null
      //현재 위치가 null이면 로딩 중을 표시
          ? Center(
        child: CircularProgressIndicator(),
      )
      //GoogleMap 위젯들 통해 지도 표시
          : GoogleMap(
        onMapCreated: (controller) {
          setState(() {
            mapCtrl = controller;
          });
        },
        //초기 카메라 위치 설정
        initialCameraPosition: CameraPosition(
          target: _initPosition!,
          zoom: 14,
        ),
        //마커 설정
        markers: _marker,
      ),
    );
  }
}