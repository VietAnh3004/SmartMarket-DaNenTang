import 'package:flutter/material.dart';
import 'package:getwidget/getwidget.dart';
import 'package:intl/intl.dart';

class FridgeManagerPage extends StatefulWidget {
  const FridgeManagerPage({super.key});

  @override
  State<FridgeManagerPage> createState() => _FridgeManagerPageState();
}

class _FridgeManagerPageState extends State<FridgeManagerPage>
    with AutomaticKeepAliveClientMixin {
  final List<Map<String, dynamic>> _fridgeSections = [
    {'name': 'Top Shelf', 'icon': Icons.view_stream, 'items': 2},
    {'name': 'Middle Shelf', 'icon': Icons.layers, 'items': 3},
    {'name': 'Bottom Shelf', 'icon': Icons.table_rows, 'items': 1},
    {'name': 'Salad Drawer', 'icon': Icons.local_florist, 'items': 2},
    {'name': 'Fridge Door Shelf', 'icon': Icons.door_front_door, 'items': 4},
    {'name': 'Freezer', 'icon': Icons.ac_unit, 'items': 5},
  ];

  final List<Map<String, dynamic>> _foods = [
    {
      'name': 'Sữa tươi',
      'quantity': 2,
      'expiry': DateTime.now().add(const Duration(days: 2)),
      'location': 'Fridge Door Shelf'
    },
    {
      'name': 'Trứng gà',
      'quantity': 10,
      'expiry': DateTime.now().add(const Duration(days: 5)),
      'location': 'Top Shelf'
    },
    {
      'name': 'Rau cải',
      'quantity': 1,
      'expiry': DateTime.now().add(const Duration(days: 1)),
      'location': 'Salad Drawer'
    },
    {
      'name': 'Thịt bò',
      'quantity': 1,
      'expiry': DateTime.now().add(const Duration(days: 7)),
      'location': 'Freezer'
    },
  ];

  @override
  bool get wantKeepAlive => true;

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return Scaffold(
      appBar: AppBar(
        title: const Text("Quản lý thực phẩm trong tủ lạnh"),
        backgroundColor: Colors.blueGrey[700],
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(12),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                "🧊 Tủ lạnh của bạn",
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
              ),
              const SizedBox(height: 10),

              /// --- FridgeView ---
              GridView.count(
                crossAxisCount: 2,
                shrinkWrap: true,
                crossAxisSpacing: 10,
                mainAxisSpacing: 10,
                physics: const NeverScrollableScrollPhysics(),
                children: _fridgeSections.map((section) {
                  return Container(
                    decoration: BoxDecoration(
                      color: Colors.blueGrey[50],
                      borderRadius: BorderRadius.circular(12),
                      border: Border.all(color: Colors.blueGrey.shade200),
                    ),
                    padding: const EdgeInsets.all(12),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(section['icon'], size: 40, color: Colors.blueGrey),
                        const SizedBox(height: 8),
                        Text(
                          section['name'],
                          textAlign: TextAlign.center,
                          style: const TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 14),
                        ),
                        const SizedBox(height: 6),
                        Text(
                          "${section['items']} món",
                          style: TextStyle(
                            color: Colors.grey[600],
                            fontSize: 13,
                          ),
                        ),
                      ],
                    ),
                  );
                }).toList(),
              ),

              const SizedBox(height: 20),
              const Text(
                "🥫 Danh sách thực phẩm",
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
              ),
              const SizedBox(height: 10),

              /// --- Accordion cho từng món ăn ---
              Column(
                children: _foods.map((food) {
                  final daysLeft =
                      food['expiry'].difference(DateTime.now()).inDays;
                  final isExpiringSoon = daysLeft <= 3;

                  return GFAccordion(
                    title: food['name'],
                    textStyle: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: isExpiringSoon ? Colors.red : Colors.black,
                    ),
                    contentChild: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text("📍 Vị trí: ${food['location']}"),
                          Text("📦 Số lượng: ${food['quantity']}"),
                          Text(
                            "⏰ Hết hạn: ${DateFormat('dd/MM/yyyy').format(food['expiry'])}",
                            style: TextStyle(
                                color: isExpiringSoon
                                    ? Colors.red
                                    : Colors.grey[700]),
                          ),
                          if (isExpiringSoon)
                            const Padding(
                              padding: EdgeInsets.only(top: 4),
                              child: Text(
                                "⚠️ Sắp hết hạn! Hãy sử dụng sớm.",
                                style: TextStyle(
                                    color: Colors.red, fontWeight: FontWeight.bold),
                              ),
                            ),
                        ],
                      ),
                    ),
                  );
                }).toList(),
              ),
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.blueGrey[700],
        onPressed: () {
          // TODO: mở dialog thêm thực phẩm mới
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
