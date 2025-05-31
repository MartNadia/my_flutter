import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Карта городов',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const MapScreen(),
    );
  }
}

class MapScreen extends StatefulWidget {
  const MapScreen({super.key});

  @override
  State<MapScreen> createState() => _MapScreenState();
}

class _MapScreenState extends State<MapScreen> {
  final MapController _mapController = MapController();
  
  final Map<String, LatLng> _cities = {
    'Москва': const LatLng(55.7558, 37.6173),
    'Санкт-Петербург': const LatLng(59.9343, 30.3351),
    'Новосибирск': const LatLng(55.0084, 82.9357),
    'Екатеринбург': const LatLng(56.8389, 60.6057),
    'Казань': const LatLng(55.7961, 49.1064),
    'Воронеж': const LatLng(51.6606, 39.2006),
    'Нижний Новгород': const LatLng(56.3266, 44.0065),
  };
  
  String _selectedCity = 'Нижний Новгород';

  void _moveToCity(LatLng point) {
    _mapController.move(point, 12.0);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Выберите город'),
        centerTitle: true,
        backgroundColor: const Color.fromARGB(255, 39, 92, 176),
        actions: [
          Container(
            margin: const EdgeInsets.only(right: 16),
            decoration: BoxDecoration(
              color: const Color.fromARGB(255, 125, 171, 243),
              borderRadius: BorderRadius.circular(8),
            ),
            padding: const EdgeInsets.symmetric(horizontal: 12),
            child: DropdownButton<String>(
              value: _selectedCity,
              dropdownColor: const Color.fromARGB(255, 125, 171, 243),
              style: const TextStyle(
                color: Colors.white,
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
              underline: Container(), // Убираем стандартное подчеркивание
              icon: const Icon(Icons.arrow_drop_down, color: Colors.white),
              items: _cities.keys.map((String city) {
                return DropdownMenuItem<String>(
                  value: city,
                  child: Text(city),
                );
              }).toList(),
              onChanged: (String? newValue) {
                if (newValue != null) {
                  setState(() {
                    _selectedCity = newValue;
                  });
                  _moveToCity(_cities[newValue]!);
                }
              },
            ),
          ),
        ],
      ),
      body: FlutterMap(
        mapController: _mapController,
        options: MapOptions(
          initialCenter: _cities[_selectedCity]!,
          initialZoom: 12.0,
        ),
        children: [
          TileLayer(
            urlTemplate: 'https://tile.openstreetmap.org/{z}/{x}/{y}.png',
            userAgentPackageName: 'com.example.app',
          ),
          MarkerLayer(
            markers: [
              Marker(
                point: _cities[_selectedCity]!,
                width: 80,
                height: 80,
                child: const Icon(
                  Icons.location_on,
                  color: Colors.red,
                  size: 40,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}