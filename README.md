# 🎨 VNize-Assets

> **Kho lưu trữ tài nguyên đa phương tiện tĩnh & CDN phân phối hình ảnh biểu trưng (Game Logos) cho hệ sinh thái VNize Launcher và VNize Studio.**

[![GitHub Release](https://img.shields.io/github/v/release/jangnguyen1st/VNize-Assets?color=0284c7&label=VNize%20Launcher&style=flat-square)](https://github.com/jangnguyen1st/VNize-Assets/releases)
[![Repo Status](https://img.shields.io/badge/Status-Active%20CDN-10b981?style=flat-square)](https://github.com/jangnguyen1st/VNize-Assets)
[![Ecosystem](https://img.shields.io/badge/Ecosystem-VNize%20Studio-38bdf8?style=flat-square)](https://github.com/jangnguyen1st/VNize-Studio.Dev)

---

## 🌟 Tổng Quan

**VNize-Assets** đóng vai trò là mạng phân phối nội dung tĩnh (**Content Delivery Network - CDN**) công khai cho toàn bộ hệ thống VNize:

1. **Lưu trữ Logo Game (`/logos`):** Cung cấp đường dẫn ảnh trực tiếp (Raw GitHub / Statically / jsDelivr) phục vụ hiển thị banner, logo tựa game trên giao diện **VNize Launcher** của người chơi.
2. **Kênh phát hành Launcher Releases:** Phân phối các bản đóng gói cài đặt chính thức của **VNize Launcher** (`VNize Launcher.exe`) thông qua GitHub Releases.
3. **Tự động hóa đồng bộ (Auto-Sync Pipeline):** Tích hợp trực tiếp với phân hệ **Tab 3: Assets & Mật khẩu** trên **VNize Studio (Dev & Builder)** và script điều phối `update_assets_git.bat`.

---

## 📂 Cấu Trúc Kho Lưu Trữ

```text
VNize-Assets/
├── logos/                          # Thư mục gốc chứa ảnh biểu trưng game
│   ├── logo_Pathogenic.png
│   ├── logo_Absolum.png
│   ├── logo_FrozenShip.png
│   └── ...                         # Quy chuẩn: logo_{TenGame}.png (PNG 24-bit / Alpha)
├── update_assets_git.bat           # Script tự động thêm, commit và đẩy assets lên Git
└── README.md                       # Tài liệu hướng dẫn hệ thống
```

---

## 📐 Quy Chuẩn Tệp Ảnh Logo

Để giao diện **VNize Launcher** hiển thị tối ưu nhất trên các độ phân giải màn hình, mọi tệp ảnh đẩy vào kho cần tuân thủ:

| Tiêu chuẩn                 | Yêu cầu kỹ thuật                                                              |
| :------------------------- | :---------------------------------------------------------------------------- |
| **Định dạng**              | `.png` (khuyến nghị có kênh trong suốt Transparent Alpha)                     |
| **Quy ước đặt tên**        | `logo_{GameID_Hoac_TenGame}.png` _(Không dấu tiếng Việt, không khoảng trắng)_ |
| **Kích thước khuyến nghị** | Tối thiểu `512x512` px (tỷ lệ 1:1) hoặc banner ngang tỷ lệ chuẩn `16:9`       |
| **Dung lượng**             | Khuyến khích tối ưu nén dưới **500 KB** để client tải tức thì                 |

---

## 🔗 Cấu Trúc URL Trực Tiếp (CDN Links)

Sau khi đẩy ảnh lên nhánh `main`, bạn có thể truy xuất hình ảnh trực tiếp qua các cấu trúc URL sau để cấu hình vào trường `url-logo` trên cơ sở dữ liệu Firebase Firestore:

### 1. Đường dẫn GitHub Raw trực tiếp

```text
https://raw.githubusercontent.com/jangnguyen1st/VNize-Assets/main/logos/logo_{TenGame}.png
```

### 2. Đường dẫn qua Statically CDN (Tăng tốc độ tải tại Việt Nam)

```text
https://cdn.statically.io/gh/jangnguyen1st/VNize-Assets/main/logos/logo_{TenGame}.png
```

### 3. Đường dẫn qua jsDelivr

```text
https://cdn.jsdelivr.net/gh/jangnguyen1st/VNize-Assets@main/logos/logo_{TenGame}.png
```

---

## 🚀 Quy Trình Cập Nhật Assets

### Cách 1: Tự động qua VNize Studio (Khuyên dùng)

1. Khởi chạy **VNize Studio (Dev & Builder)**.
2. Điều hướng đến **Tab 3: Assets Git & Mật Khẩu**.
3. Kéo thả file ảnh vào ô nạp Logo. Hệ thống sẽ tự chuẩn hóa tên tệp thành `logo_{TenGame}.png`.
4. Nhấn nút **Đồng Bộ Git Assets**. Hệ thống sẽ tự copy ảnh vào `VNize-Assets/logos/` và kích hoạt script đẩy code lên GitHub hoàn toàn tự động.

### Cách 2: Chạy script thủ công

1. Chép ảnh đã chuẩn hóa vào thư mục `logos/`.
2. Chạy tệp tin:

   ```cmd
   update_assets_git.bat
   ```

3. Nhập ghi chú commit (hoặc nhấn `Enter` để dùng mặc định `Update game logos`). Script sẽ tự động chạy quy trình:
   `git add .` $\rightarrow$ `git commit` $\rightarrow$ `git pull --rebase` $\rightarrow$ `git push origin main`.

---

## 📦 Phát Hành Bản Cài Đặt (Launcher Releases)

Mục [Releases](https://github.com/jangnguyen1st/VNize-Assets/releases) của repo này được sử dụng làm kênh phân phối chính thức tệp cài đặt cho người chơi:

- **Phiên bản hiện tại:** `v1.0.1` (`VNize Launcher.exe`).
- Client có thể kiểm tra cập nhật phiên bản mới trực tiếp từ document `launcher/version` trên Cloud Firestore và dẫn link tải về release tại đây.

---

## 🛡️ Giấy Phép & Nhận Diện

- **Hệ sinh thái:** Thuộc dự án **VNize Studio & VNize Launcher**.
- **Đơn vị quản trị:** [jangnguyen1st](https://github.com/jangnguyen1st).
- **Mục đích:** Lưu trữ nội bộ và phân phối tài nguyên công khai phi lợi nhuận cho cộng đồng game Việt ngữ.
