import 'package:fe/core/theme/app_palette.dart'; // Giữ nguyên import
import 'package:flutter/material.dart';
import 'package:getwidget/getwidget.dart';
import 'package:table_calendar/table_calendar.dart';

class MealPlannerPage extends StatefulWidget {
  const MealPlannerPage({super.key});

  @override
  State<MealPlannerPage> createState() => _MealPlannerPageState();
}

class _MealPlannerPageState extends State<MealPlannerPage> {
  DateTime _focusedDay = DateTime.now();
  DateTime? _selectedDay;

  // THAY ĐỔI 1: Cập nhật cấu trúc dữ liệu
  // Lưu trữ một DANH SÁCH món ăn (List<String>) cho mỗi bữa, thay vì một món (String)
  final Map<DateTime, Map<String, List<String>>> mealPlans = {};

  @override
  void initState() {
    super.initState();
    _selectedDay = _focusedDay;
  }

  bool _isSameDay(DateTime a, DateTime b) =>
      a.year == b.year && a.month == b.month && a.day == b.day;

  // (Hàm này giữ nguyên, không thay đổi)
  void _showSuggestionModal() {
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.white,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (_) => Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Text(
              "🍳 Gợi ý món ăn từ thực phẩm hiện có",
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 10),
            GFListTile(
              titleText: "Canh bí đỏ + Thịt kho trứng",
              subTitleText: "Tận dụng trứng và thịt còn lại",
              icon: const Icon(Icons.add_circle_outline),
            ),
            GFListTile(
              titleText: "Mì xào rau cải + Trứng chiên",
              subTitleText: "Tiêu thụ rau cải trong tủ lạnh",
              icon: const Icon(Icons.add_circle_outline),
            ),
          ],
        ),
      ),
    );
  }

  // HÀM MỚI: Dialog CRUD để quản lý danh sách món ăn
  // Đây là trung tâm của yêu cầu CRUD
  Future<List<String>?> _showEditMealListDialog(
      String mealType, List<String>? currentMeals) {
    final TextEditingController controller = TextEditingController();
    // Tạo một bản sao để chỉnh sửa mà không ảnh hưởng đến state gốc
    List<String> tempMeals = List.from(currentMeals ?? []);

    return showDialog<List<String>>(
      context: context,
      builder: (context) {
        // Sử dụng StatefulBuilder để dialog có thể tự cập nhật state (thêm/xóa)
        return StatefulBuilder(
          builder: (context, setDialogState) {
            
            // Hàm để hiển thị dialog chỉnh sửa một món ăn (CRUD - Update)
            void showEditItemDialog(int index) async {
              final itemController = TextEditingController(text: tempMeals[index]);
              final updatedItem = await showDialog<String>(
                context: context,
                builder: (_) => AlertDialog(
                  title: const Text("Chỉnh sửa món"),
                  content: TextField(
                    controller: itemController,
                    decoration: const InputDecoration(labelText: "Tên món ăn..."),
                  ),
                  actions: [
                    TextButton(onPressed: () => Navigator.pop(context), child: const Text("Hủy")),
                    TextButton(onPressed: () => Navigator.pop(context, itemController.text), child: const Text("Lưu")),
                  ],
                ),
              );

              if (updatedItem != null && updatedItem.isNotEmpty) {
                setDialogState(() {
                  tempMeals[index] = updatedItem;
                });
              }
            }

            return AlertDialog(
              title: Text("Chỉnh sửa $mealType"),
              content: SizedBox(
                width: double.maxFinite,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    // --- CRUD: Create (Thêm) ---
                    Row(
                      children: [
                        Expanded(
                          child: TextField(
                            controller: controller,
                            decoration: const InputDecoration(
                                labelText: "Nhập món ăn..."),
                          ),
                        ),
                        IconButton(
                          icon: const Icon(Icons.add_circle, color: AppPalette.darkColor),
                          onPressed: () {
                            if (controller.text.isNotEmpty) {
                              setDialogState(() {
                                tempMeals.add(controller.text);
                                controller.clear();
                              });
                            }
                          },
                        ),
                      ],
                    ),
                    const SizedBox(height: 10),
                    // --- CRUD: Read (Hiển thị) ---
                    Expanded(
                      child: ListView.builder(
                        shrinkWrap: true,
                        itemCount: tempMeals.length,
                        itemBuilder: (context, index) {
                          final item = tempMeals[index];
                          return GFListTile(
                            titleText: item,
                            // --- CRUD: Update (Sửa) ---
                            onTap: () => showEditItemDialog(index),
                            // --- CRUD: Delete (Xóa) ---
                            icon: IconButton(
                              icon: const Icon(Icons.delete_outline, color: Colors.red),
                              onPressed: () {
                                setDialogState(() {
                                  tempMeals.removeAt(index);
                                });
                              },
                            ),
                          );
                        },
                      ),
                    ),
                  ],
                ),
              ),
              actions: [
                TextButton(
                  onPressed: () => Navigator.pop(context, null), // Hủy
                  child: const Text("Hủy"),
                ),
                TextButton(
                  onPressed: () => Navigator.pop(context, tempMeals), // Lưu
                  child: const Text("Lưu"),
                ),
              ],
            );
          },
        );
      },
    );
  }

  // THAY ĐỔI 2: Cập nhật _buildMealCard để hiển thị danh sách
  Widget _buildMealCard(String title, List<String>? meals) {
    return GFCard(
      title: GFListTile(titleText: title),
      content: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Kiểm tra nếu danh sách rỗng hoặc null
          if (meals == null || meals.isEmpty)
            const Text(
              "Chưa có kế hoạch",
              style: TextStyle(fontSize: 16),
            )
          else
            // Render danh sách món ăn
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: meals
                  .map((item) => Padding(
                        padding: const EdgeInsets.only(bottom: 4.0),
                        child: Text(
                          "• $item", // Thêm dấu • cho đẹp
                          style: const TextStyle(fontSize: 16),
                        ),
                      ))
                  .toList(),
            ),
          const SizedBox(height: 10),
          GFButton(
            onPressed: () async {
              // Gọi dialog CRUD mới
              final updatedList = await _showEditMealListDialog(title, meals);

              if (updatedList != null && _selectedDay != null) {
                setState(() {
                  // Lưu danh sách mới vào state
                  mealPlans[_selectedDay!] ??= {};
                  mealPlans[_selectedDay!]![title] = updatedList;
                });
              }
            },
            text: "Chỉnh sửa",
            color: AppPalette.darkColor,
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    // Lấy danh sách (List<String>) của ngày đã chọn
    final selectedPlans = mealPlans[_selectedDay ?? DateTime.now()];

    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Lịch bữa ăn",
          style: TextStyle(color: AppPalette.backgroundColor, fontWeight: FontWeight.bold),
        ),
        backgroundColor: AppPalette.darkColor,
      ),
      body: Column(
        children: [
          // 🗓️ Lịch tháng (Không thay đổi)
          TableCalendar(
            focusedDay: _focusedDay,
            firstDay: DateTime(2020),
            lastDay: DateTime(2030),
            startingDayOfWeek: StartingDayOfWeek.monday,
            calendarFormat: CalendarFormat.month,
            selectedDayPredicate: (day) =>
                _isSameDay(day, _selectedDay ?? _focusedDay),
            calendarStyle: CalendarStyle(
              todayDecoration: BoxDecoration(
                color: AppPalette.borderColor,
                shape: BoxShape.circle,
              ),
              selectedDecoration: BoxDecoration(
                color: AppPalette.darkColor,
                shape: BoxShape.circle,
              ),
              markerDecoration: const BoxDecoration(
                color: AppPalette.gradient2,
                shape: BoxShape.circle,
              ),
            ),
            headerStyle: HeaderStyle(
              titleCentered: true,
              formatButtonVisible: false,
              leftChevronIcon: const Icon(
                Icons.chevron_left,
                color: AppPalette.darkColor,
              ),
              rightChevronIcon: const Icon(
                Icons.chevron_right,
                color: AppPalette.darkColor,
              ),
            ),
            eventLoader: (day) {
              // (Logic này vẫn đúng)
              return mealPlans.keys.any((d) => _isSameDay(d, day))
                  ? ["Có kế hoạch"]
                  : [];
            },
            onDaySelected: (selected, focused) {
              setState(() {
                _selectedDay = selected;
                _focusedDay = focused;
              });
            },
          ),

          const SizedBox(height: 10),

          // Khi chọn ngày → hiển thị phần chi tiết
          Expanded(
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(16),
              child: _selectedDay == null
                  ? const Center(child: Text("Chọn một ngày để xem kế hoạch"))
                  : Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Kế hoạch ngày ${_selectedDay!.day}/${_selectedDay!.month}/${_selectedDay!.year}",
                          style: const TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(height: 10),
                        
                        // THAY ĐỔI 3: Truyền List<String>? vào card
                        _buildMealCard(
                          "Bữa sáng",
                          selectedPlans?["Bữa sáng"], // Truyền List<String>?
                        ),
                        _buildMealCard(
                          "Bữa trưa",
                          selectedPlans?["Bữa trưa"], // Truyền List<String>?
                        ),
                        _buildMealCard(
                          "Bữa tối",
                          selectedPlans?["Bữa tối"], // Truyền List<String>?
                        ),
                      ],
                    ),
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: AppPalette.darkColor,
        onPressed: _showSuggestionModal,
        child: const Icon(Icons.lightbulb_outline, color: Colors.white),
      ),
    );
  }
}