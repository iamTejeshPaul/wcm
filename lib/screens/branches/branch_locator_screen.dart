
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:url_launcher/url_launcher.dart';

class BranchLocatorScreen extends StatefulWidget {
  const BranchLocatorScreen({super.key});

  @override
  State<BranchLocatorScreen> createState() => _BranchLocatorScreenState();
}

class _BranchLocatorScreenState extends State<BranchLocatorScreen> {
  final Set<Marker> _markers = {};
  GoogleMapController? _mapController;

  String selectedRegion = 'All';
  String selectedDepartment = 'All';

  final List<Map<String, dynamic>> branches = [
    {
      'id': '1',
      'name': 'Central Branch',
      'position': LatLng(17.385044, 78.486671),
      'address': '123 Main Street',
      'contact': '+1234567890',
      'timing': 'Sun: 9AM-12PM',
    },
    {
      'id': '2',
      'name': 'North Branch',
      'position': LatLng(17.450000, 78.380000),
      'address': '456 North Road',
      'contact': '+0987654321',
      'timing': 'Sun: 10AM-1PM',
    },
  ];

  @override
  void initState() {
    super.initState();
    _setMarkers();
  }

  void _setMarkers() {
    for (var branch in branches) {
      _markers.add(
        Marker(
          markerId: MarkerId(branch['id']),
          position: branch['position'],
          infoWindow: InfoWindow(
            title: branch['name'],
            snippet: branch['address'],
            onTap: () {
              _showBranchInfo(branch);
            },
          ),
        ),
      );
    }
  }

  void _showBranchInfo(Map<String, dynamic> branch) {
    showModalBottomSheet(
      context: context,
      builder: (context) {
        return Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(branch['name'], style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
              const SizedBox(height: 8),
              Text('Address: ${branch['address']}'),
              Text('Timing: ${branch['timing']}'),
              const SizedBox(height: 8),
              Row(
                children: [
                  ElevatedButton.icon(
                    onPressed: () {
                      launchUrl(Uri.parse('tel:${branch['contact']}'));
                    },
                    icon: const Icon(Icons.call),
                    label: const Text('Call'),
                  ),
                  const SizedBox(width: 8),
                  ElevatedButton.icon(
                    onPressed: () {
                      launchUrl(Uri.parse('https://wa.me/${branch['contact']}'));
                    },
                    icon: const Icon(Icons.message),
                    label: const Text('WhatsApp'),
                  ),
                ],
              ),
            ],
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('WCM Branch Locator'),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              children: [
                Expanded(
                  child: DropdownButton<String>(
                    value: selectedRegion,
                    items: ['All', 'Central', 'North'].map((region) {
                      return DropdownMenuItem(
                        value: region,
                        child: Text(region),
                      );
                    }).toList(),
                    onChanged: (value) {
                      setState(() {
                        selectedRegion = value!;
                      });
                    },
                  ),
                ),
                const SizedBox(width: 8),
                Expanded(
                  child: DropdownButton<String>(
                    value: selectedDepartment,
                    items: ['All', 'Youth', 'Women'].map((dept) {
                      return DropdownMenuItem(
                        value: dept,
                        child: Text(dept),
                      );
                    }).toList(),
                    onChanged: (value) {
                      setState(() {
                        selectedDepartment = value!;
                      });
                    },
                  ),
                ),
              ],
            ),
          ),
          Expanded(
            child: GoogleMap(
              onMapCreated: (controller) {
                _mapController = controller;
              },
              initialCameraPosition: const CameraPosition(
                target: LatLng(17.385044, 78.486671),
                zoom: 12,
              ),
              markers: _markers,
            ),
          ),
        ],
      ),
    );
  }
}
