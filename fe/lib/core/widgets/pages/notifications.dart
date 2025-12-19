import 'package:flutter/material.dart';
import 'package:getwidget/getwidget.dart';
import 'package:fe/core/theme/app_palette.dart';

class NotificationsPage extends StatefulWidget {
  const NotificationsPage({super.key});

  @override
  State<NotificationsPage> createState() => _NotificationsPageState();
}

class _NotificationsPageState extends State<NotificationsPage> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  final List<Map<String, dynamic>> _notifications = [
    {
      "title": "Thực phẩm sắp hết hạn",
      "message": "Sữa tươi sẽ hết hạn sau 2 ngày. Hãy sử dụng sớm!",
      "icon": Icons.warning_amber_rounded,
      "color": Colors.orangeAccent,
      "time": "Hôm nay",
    },
    {
      "title": "Gợi ý món ăn",
      "message": "Bạn có thể nấu 'Trứng chiên thịt băm' từ nguyên liệu sẵn có.",
      "icon": Icons.restaurant_menu_rounded,
      "color": Colors.greenAccent,
      "time": "Hôm nay",
    },
    {
      "title": "Báo cáo tuần này",
      "message":
          "Bạn đã tiêu thụ 85% thực phẩm mua vào tuần này. Giảm lãng phí rất tốt!",
      "icon": Icons.bar_chart_rounded,
      "color": Colors.blueAccent,
      "time": "Hôm qua",
    },
    {
      "title": "Cảnh báo tủ lạnh",
      "message": "Nhiệt độ ngăn đá tăng bất thường. Kiểm tra lại cài đặt tủ lạnh.",
      "icon": Icons.ac_unit_rounded,
      "color": Colors.redAccent,
      "time": "3 ngày trước",
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      backgroundColor: AppPalette.backgroundColor,
      drawer: GFDrawer(
        color: AppPalette.backgroundColor,
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            const UserAccountsDrawerHeader(
              accountName: Text("An Chim To"),
              accountEmail: Text("an@example.com"),
              currentAccountPicture: GFAvatar(
                backgroundImage: AssetImage('assets/avatar.png'),
              ),
            ),
            ListTile(
              leading: const Icon(Icons.person),
              title: const Text("Thông tin cá nhân"),
              onTap: () {},
            ),
            ListTile(
              leading: const Icon(Icons.settings),
              title: const Text("Cài đặt"),
              onTap: () {},
            ),
            ListTile(
              leading: const Icon(Icons.logout),
              title: const Text("Đăng xuất"),
              onTap: () {},
            ),
          ],
        ),
      ),

      body: SafeArea(
        child: Column(
          children: [
            // --- Thanh trên cùng ---
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
              child: Row(
                children: [
                  GestureDetector(
                    onTap: () => _scaffoldKey.currentState?.openDrawer(),
                    child: const GFAvatar(
                      backgroundImage: AssetImage('assets/avatar.png'),
                      size: GFSize.LARGE,
                    ),
                  ),
                  const SizedBox(width: 12),
                  const Expanded(
                    child: Text(
                      "Thông báo",
                      style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                        color: AppPalette.darkColor,
                      ),
                    ),
                  ),
                  IconButton(
                    icon: const Icon(Icons.settings, color: AppPalette.greyColor),
                    onPressed: () {},
                  )
                ],
              ),
            ),

            const Divider(height: 1, color: Colors.grey),

            // --- Danh sách thông báo ---
            Expanded(
              child: ListView.builder(
                padding: const EdgeInsets.all(16),
                itemCount: _notifications.length,
                itemBuilder: (context, index) {
                  final n = _notifications[index];
                  return Container(
                    margin: const EdgeInsets.only(bottom: 12),
                    padding: const EdgeInsets.all(12),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(12),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey.withOpacity(0.1),
                          blurRadius: 4,
                          offset: const Offset(0, 2),
                        ),
                      ],
                    ),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        CircleAvatar(
                          backgroundColor: n["color"].withOpacity(0.2),
                          child: Icon(n["icon"], color: n["color"]),
                        ),
                        const SizedBox(width: 12),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                n["title"],
                                style: const TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                              const SizedBox(height: 4),
                              Text(
                                n["message"],
                                style: const TextStyle(
                                  fontSize: 14,
                                  color: Colors.black87,
                                ),
                              ),
                              const SizedBox(height: 6),
                              Text(
                                n["time"],
                                style: const TextStyle(
                                  fontSize: 12,
                                  color: Colors.grey,
                                ),
                              ),
                            ],
                          ),
                        ),
                        IconButton(
                          icon: const Icon(Icons.more_vert, size: 20),
                          onPressed: () {},
                        )
                      ],
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
