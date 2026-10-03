# MathLingo - Flutter Prototype 🦉

Bản mẫu (Prototype) giao diện và luồng nghiệp vụ tương tác hoàn chỉnh cho ứng dụng **MathLingo** (Nền tảng học Toán cấp 1 tương tác kết hợp Gamification Duolingo và gia sư Socratic AI), được xây dựng chính xác theo hệ thống thiết kế **UI/UX Stitch** (`projects/8155338991770445385` - *Tactile Gamified EdTech*).

---

## 🎨 Hệ Thống Thiết Kế & Nhận Diện (Follow Stitch Design Tokens)

- **Ngôn ngữ thiết kế:** *Tactile Gamified Skeuomorphism* kết hợp *Friendly High-Contrast EdTech*.
- **Nút bấm 3D xúc giác (`TactileButton`):** Hiệu ứng nút đồ chơi nổi với gờ đổ bóng dày (4px solid bottom rail), khi ấn nhấn xuống 3px (`translateY(3px)`), tạo cảm giác xúc giác cơ học chân thực.
- **Bảng màu chủ đạo:**
  - **Màu nền bề mặt (`#FCF8FF`):** Nền gốm trắng mát, chống lóa mắt cho trẻ.
  - **Xanh lá Emerald (`#10B981` / `#006C49`, bóng `#00422B`):** Tiến trình bài học, đáp án chính xác, hành động tiếp tục.
  - **Vàng Hổ Phách Sao (`#FEA619` / `#855300`, bóng `#684000`):** Điểm thưởng sao, rương báu, chuỗi streak.
  - **Đỏ Năng Lượng Tim (`#FF7A73` / `#B91A24`, bóng `#79000E`):** Năng lượng 5 tim, cảnh báo lỗi, phục hồi sinh lực.
  - **Tím Socratic (`#6366F1`, bóng `#4F46E5`):** Gia sư AI Cú Mathy gợi mở tư duy, không giải hộ.
- **Typography:**
  - Tiêu đề & Chữ số: **Rubik** (chunky, bo tròn thân thiện, hiển thị số toán học sắc nét).
  - Thân bài & Hướng dẫn: **Nunito Sans** (dễ đọc, thoáng chữ cho lứa tuổi tiểu học và phụ huynh).

---

## 🚀 4 Luồng Nghiệp Vụ Cơ Bản Sẵn Sàng Demo

### 1. Thanh Kệ Tiền Tệ & Chọn Hồ Sơ (Currency Shelf & Profiles)
- **Chuỗi Lửa 🔥 (Streak):** 7 ngày liên tục.
- **Sao Vàng ⭐ (Stars):** 340 sao tích lũy.
- **Năng Lượng Tim ❤️ (Hearts):** 5/5 tim. Làm sai bài tập bị trừ 1 tim.
- **Chuyển Đổi Hồ Sơ Bé:** Chuyển đổi giữa **Minh Khôi (Lớp 3)**, **Bé Bin (Lớp 1)**, **Bé Na (Lớp 2)**.
- **Hộp thoại Nạp Nhanh Tim (Quick Refill):** Cho phép nạp đầy 5 tim ngay trong lúc demo.

### 2. Bản Đồ Học Tập MathLingo (Learning Journey Map - Stitch Screen 1)
- **Banner Chương:** Lớp 3 • Tuần 4, *Chương 2: Phép nhân & Thừa số kỳ thú*, Tiến độ 12/24 ⭐, Chế độ tải offline.
- **Thẻ Nhiệm Vụ Hàng Ngày:** *Hoàn thành 2 bài toán bảng nhân 3* (+40 XP).
- **Đường Mòn Học Tập Uốn Lượn (Sinuous Path):**
  - **Node 1 (Đã xong):** 1. Bảng nhân 3 (3 sao ⭐⭐⭐).
  - **Node 2 (Đã xong):** 2. Đếm nhảy thừa số (2 sao ⭐⭐).
  - **Node 3 (Đang mở - ACTIVE):** *Bài 3: Thừa số & Tích* kèm bóng thoại Cú Mathy nhún nhảy `"Cùng làm bài kéo thả nào! 🎯"`, hiệu ứng vòng sáng tỏa nhịp đập, nút `BẮT ĐẦU` to bản mở màn hình làm bài tập.
  - **Node 4 (Rương Báu):** Rương kho báu mở khóa nhận +50 Ngọc.
  - **Node 5 & 6 (Khóa):** Luyện tập và Đố vui chia kẹo.
  - **Node 7 (Trùm Chương):** Thử thách Trùm Chương 2 với vương miện danh giá 👑.
  - **Phân cách Chương 3:** Mở khóa Chương 3 - Phép chia bí ẩn.
- **Nút Hành Động Nổi (Floating FAB):**
  - **Hỏi Cú giải toán ✨:** Mô phỏng AI Camera chụp ảnh đề bài sách giáo khoa và phân tích Socratic.
  - **Hạng Vàng 🏆:** Top 3 giải đấu tuần (420đ).

### 3. Màn Hình Làm Bài Kéo Thả & Cú Socratic (Interactive Lesson - Stitch Screen 2)
- **Thanh tiến độ bài học:** 3/10 câu hỏi, hiển thị tim còn lại.
- **Bóng thoại Cú Socratic AI:** Hướng dẫn đề bài trực quan. Nút *Hỏi Cú Vọ 💡* mở gợi ý tư duy từng bước mà không giải hộ đáp án.
- **Minh họa Toán học Trực quan:** 4 giỏ mây chứa các quả táo chín đỏ sinh động.
- **Khung Phép Tính:** `[ 4 ] (Số giỏ) × [ 3 ] (Số táo/giỏ) = [ ? ] (Tổng quả)`.
- **Kho Số Chọn Lựa 3D:** Các thẻ số nổi `12`, `7`, `15`, `6`, `4`, `3`. Bấm chọn hoặc xóa linh hoạt.
- **Kiểm Tra Đáp Án & Phản Hồi Xúc Giác:**
  - **Chọn đúng (12):** Bottom Sheet màu xanh Mint ăn mừng *“Chính xác tuyệt vời!”*, giải thích chi tiết `4 × 3 = 12`, hoàn thành bài học và mở khóa node tiếp theo trên bản đồ.
  - **Chọn sai (khác 12):** Bottom Sheet màu đỏ dịu *“Chưa hoàn toàn đúng rồi!”*, trừ 1 tim và gợi ý đếm lại táo.

### 4. Vườn Hồi Phục & Tủ Đồ Linh Vật (Recovery Garden - Stitch Screen 3)
- **Tab 1: Vườn Hồi Phục (Recovery Garden):**
  - Bộ đếm thời gian hồi tim (12:45).
  - Nhiệm vụ thư giãn không tính điểm phạt: *Tưới cây Bảng Nhân 2* (Đã xong), *Bắt sâu Phép Trừ* (+2 Tim), *Ghép hoa Phân Số* (+2 Tim). Bấm vào làm bài để hồi tim tức thì!
- **Tab 2: Tủ Đồ Cú Vọ (Wardrobe & Shop):**
  - Bục vinh danh 3D của Cú Mathy.
  - Cửa hàng trang phục độc quyền: Mũ Cử Nhân 🎓, Kính Thần Đồng 👓, Áo Choàng Siêu Nhân 🦸, Cúp Vương Miện 👑.

### 5. Cổng Phụ Huynh & Báo Cáo Phân Tích (Parent Portal - Stitch Screen 4)
- **Cổng Bảo Mật Trẻ Em (BR-01 Parent Gate):** Thử thách phép tính người lớn ngẫu nhiên (ví dụ `14 × 6 = 84`) hoặc mã PIN bảo mật `1234` kèm bàn phím số an toàn.
- **Thanh Xác Minh An Toàn:** Thông báo đã mở cổng và nút *Khóa lại* nhanh.
- **Thẻ KPI Tuần:** Thời gian học (3h 45m - Đạt chỉ tiêu), Đã hoàn thành (28 bài), Độ chính xác (89%).
- **Biểu Đồ Cột Chuyên Cần Tuần (Thứ 2 - Chủ Nhật):** Trực quan thời lượng học tập mỗi ngày so với mục tiêu 30 phút.
- **Chẩn Đoán Năng Lực Toán Học:**
  - Bảng nhân & Phép nhân (92% • Tốt)
  - Hình học & Đo chu vi (78% • Đang tiến bộ)
  - Toán có lời văn (65% • Cần hỗ trợ)
- **Lời Khuyên Sư Phạm Từ Cú Socratic:** Gợi ý phương pháp đồng hành cùng con tại nhà.
- **Cài Đặt & Giới Hạn Thông Minh:**
  - Thanh trượt giới hạn thời gian màn hình (15 - 90 phút/ngày).
  - Công tắc bật/tắt chế độ Gia sư AI Socratic.
  - Đổi mã PIN bảo mật.
- **Gói Đăng Ký MathLingo Family Premium:** Thông tin hạn sử dụng và quyền lợi 3 tài khoản.

---

## 🛠️ Cấu Trúc Mã Nguồn

```
lib/
├── core/
│   └── theme/
│       ├── app_colors.dart         # Bảng màu chuẩn Stitch Design Tokens
│       └── app_theme.dart          # Cấu hình GoogleFonts (Rubik & Nunito Sans)
├── data/
│   ├── models/
│   │   ├── kid_profile.dart        # Model hồ sơ học sinh
│   │   ├── lesson_node.dart        # Model điểm nút trên bản đồ
│   │   ├── exercise.dart           # Model bài tập kéo thả & Socratic hint
│   │   └── parent_models.dart      # Model báo cáo phụ huynh & nhiệm vụ hồi tim
│   └── mock_data.dart              # Dữ liệu mẫu chuẩn bị sẵn phục vụ demo
├── state/
│   └── app_state.dart              # Quản lý trạng thái ứng dụng tập trung (ChangeNotifier)
├── ui/
│   ├── widgets/
│   │   ├── tactile_button.dart     # Nút bấm 3D xúc giác gờ đổ bóng
│   │   └── currency_shelf_header.dart # Kệ tiền tệ Đỉnh (Streak, Sao, Tim, Avatar)
│   └── screens/
│       ├── home_scaffold.dart      # Bộ khung 4 Tab Bar điều hướng chính
│       ├── map/
│       │   └── learning_map_screen.dart # Stitch Screen 1: Bản đồ bài học
│       ├── lesson/
│       │   └── interactive_lesson_screen.dart # Stitch Screen 2: Bài học tương tác
│       ├── garden/
│       │   └── recovery_garden_screen.dart # Stitch Screen 3: Vườn hồi tim & Tủ đồ
│       ├── league/
│       │   └── league_shop_screen.dart # Bảng xếp hạng & Cửa hàng sao
│       └── parent/
│           ├── parent_gate_dialog.dart # Cổng thử thách BR-01
│           └── parent_dashboard_screen.dart # Stitch Screen 4: Báo cáo phụ huynh
└── main.dart                       # Entry point ứng dụng
```

---

## 💻 Hướng Dẫn Chạy Demo

Dự án đã vượt qua toàn bộ các kiểm thử:
- `flutter analyze`: **0 cảnh báo, 0 lỗi (No issues found!)**
- `flutter test`: **100% Passed**

### Chạy trên Trình duyệt Web (Chrome) - Khuyên dùng để demo giao diện Stitch:
```powershell
flutter run -d chrome
```

### Hoặc chạy ứng dụng Desktop Windows:
```powershell
flutter run -d windows
```