import 'package:flutter/material.dart';
import 'package:getwidget/getwidget.dart';

class ShoppingAssignPage extends StatefulWidget {
  const ShoppingAssignPage({super.key});

  @override
  State<ShoppingAssignPage> createState() => _ShoppingAssignPageState();
}

class _ShoppingAssignPageState extends State<ShoppingAssignPage> with AutomaticKeepAliveClientMixin<ShoppingAssignPage> {
  final List<String> _items = [
    'Rau cải',
    'Thịt bò',
    'Sữa tươi',
    'Trứng',
    'Gạo',
  ];
  final Map<String, List<String>> _assignments = {
    'Ba': [],
    'Mẹ': [],
    'Anh': [],
    'Em': [],
  };

  @override
  bool get wantKeepAlive => true;

  @override
  Widget build(BuildContext context) {
    super.build(context); 
    return Scaffold(
      backgroundColor: Colors.grey[100],
      appBar: AppBar(
        title: const Text('Phân chia danh sách mua sắm'),
        backgroundColor: Colors.green[700],
      ),
      body: Column(
        children: [
          const SizedBox(height: 10),
          const Text(
            "Vùng chung - Các món chưa phân công",
            style: TextStyle(fontWeight: FontWeight.bold),
          ),

          /// --- Khu vực kéo món đồ chung ---
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: DragTarget<String>(
              onAccept: (item) {
                setState(() {
                  // Xóa món khỏi các thành viên
                  for (var member in _assignments.keys) {
                    _assignments[member]!.remove(item);
                  }
                  // Thêm lại vào vùng chung nếu chưa có
                  if (!_items.contains(item)) _items.add(item);
                });
              },
              builder: (context, candidateData, rejectedData) {
                return Container(
                  width: double.infinity,
                  constraints: const BoxConstraints(
                    minHeight: 120, // 👈 đảm bảo vùng đủ lớn để kéo vào
                  ),
                  padding: const EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    color: candidateData.isNotEmpty
                        ? Colors.green[50]
                        : Colors.white,
                    border: Border.all(
                      color: candidateData.isNotEmpty
                          ? Colors.green
                          : Colors.grey.shade300,
                    ),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Wrap(
                    spacing: 10,
                    runSpacing: 10,
                    children: _items.map((item) {
                      return Draggable<String>(
                        data: item,
                        feedback: Material(
                          color: Colors.transparent,
                          child: _buildChip(item, isDragging: true),
                        ),
                        childWhenDragging: _buildChip(
                          item,
                          isDragging: false,
                          opacity: 0.3,
                        ),
                        child: _buildChip(item),
                      );
                    }).toList(),
                  ),
                );
              },
            ),
          ),
          const Divider(),

          /// --- Accordion cho từng thành viên ---
          Expanded(
            child: SingleChildScrollView(
              child: Column(
                children: _assignments.keys.map((member) {
                  return GFAccordion(
                    title: member,
                    textStyle: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                    collapsedIcon: const Icon(Icons.arrow_drop_down),
                    contentChild: DragTarget<String>(
                      onAccept: (item) {
                        setState(() {
                          // Xóa item khỏi vùng chung hoặc thành viên khác
                          _items.remove(item);
                          for (var m in _assignments.keys) {
                            _assignments[m]!.remove(item);
                          }
                          // Thêm vào vùng hiện tại
                          _assignments[member]!.add(item);
                        });
                      },
                      builder: (context, candidateData, rejectedData) {
                        final assigned = _assignments[member]!;
                        return Container(
                          height: 100,
                          padding: const EdgeInsets.all(8),
                          margin: const EdgeInsets.only(bottom: 8),
                          decoration: BoxDecoration(
                            color: candidateData.isNotEmpty
                                ? Colors.green[50]
                                : Colors.white,
                            borderRadius: BorderRadius.circular(8),
                            border: Border.all(
                              color: candidateData.isNotEmpty
                                  ? Colors.green
                                  : Colors.grey.shade300,
                            ),
                          ),
                          child: assigned.isEmpty
                              ? Center(
                                  child: Text(
                                    candidateData.isNotEmpty
                                        ? "Thả vào đây!"
                                        : "Chưa có món nào",
                                    style: TextStyle(
                                      color: candidateData.isNotEmpty
                                          ? Colors.green
                                          : Colors.grey,
                                    ),
                                  ),
                                )
                              : Wrap(
                                  spacing: 8,
                                  runSpacing: 8,
                                  children: assigned.map((item) {
                                    return Draggable<String>(
                                      data: item,
                                      feedback: Material(
                                        color: Colors.transparent,
                                        child: _buildChip(
                                          item,
                                          isDragging: true,
                                        ),
                                      ),
                                      childWhenDragging: _buildChip(
                                        item,
                                        isDragging: false,
                                        opacity: 0.3,
                                      ),
                                      child: _buildChip(item),
                                    );
                                  }).toList(),
                                ),
                        );
                      },
                    ),
                  );
                }).toList(),
              ),
            ),
          ),
        ],
      ),
    );
  }

  /// --- Widget chip hiển thị món đồ ---
  Widget _buildChip(
    String label, {
    bool isDragging = false,
    double opacity = 1,
  }) {
    return Opacity(
      opacity: opacity,
      child: Chip(
        label: Text(
          label,
          style: TextStyle(
            color: isDragging ? Colors.white : Colors.green[900],
            fontWeight: FontWeight.bold,
          ),
        ),
        backgroundColor: isDragging ? Colors.green[700] : Colors.green[100],
        elevation: isDragging ? 6 : 1,
        shadowColor: Colors.greenAccent,
        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 6),
      ),
    );
  }
}
