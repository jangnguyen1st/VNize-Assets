@echo off
chcp 65001 >nul
setlocal EnableDelayedExpansion
title [VNize-Assets] Git Auto Push Tool
color 0B

:: Luôn trỏ đúng về thư mục chứa file .bat này
cd /d "%~dp0"

echo =======================================================
echo           TỰ ĐỘNG ĐẨY DỮ LIỆU LÊN GITHUB
echo =======================================================
echo.

:: Kiểm tra xem đây có phải thư mục Git không
git rev-parse --is-inside-work-tree >nul 2>&1
if %ERRORLEVEL% NEQ 0 (
    color 0C
    echo ❌ Thư mục hiện tại không phải là kho lưu trữ Git!
    pause
    exit /b 1
)

:: Tự động lấy tên nhánh hiện tại (main / master / ...)
for /f "delims=" %%i in ('git branch --show-current') do set "current_branch=%%i"
if "!current_branch!"=="" set "current_branch=main"

:: 1. Kiểm tra trạng thái Git
echo [1/5] Kiểm tra các tệp tin thay đổi (Nhánh: !current_branch!)...
git status -s
echo.

:: 2. Nhập nội dung commit (An toàn với dấu ngoặc kép & ký tự đặc biệt)
set "commit_msg="
set /p "commit_msg=>> Nhập ghi chú commit (Nhấn Enter để dùng mặc định 'Update VNize assets'): "
if "!commit_msg!"=="" (
    set "commit_msg=Update VNize assets"
) else (
    :: Thoát ký tự ngoặc kép nếu người dùng lỡ nhập
    set "commit_msg=!commit_msg:"='!"
)

echo.
echo [2/5] Đang thêm các tệp tin mới (git add)...
git add .

echo.
echo [3/5] Đang tạo commit: "!commit_msg!"...
git diff --cached --quiet
if %ERRORLEVEL% EQU 0 (
    echo [i] Không có thay đổi mới nào để commit. Chuyển sang đồng bộ...
) else (
    git commit -m "!commit_msg!"
    if !ERRORLEVEL! NEQ 0 (
        color 0C
        echo ❌ Tạo commit thất bại!
        pause
        exit /b !ERRORLEVEL!
    )
)

echo.
echo [4/5] Đang đồng bộ dữ liệu mới nhất từ GitHub (git pull --rebase)...
git pull --rebase origin !current_branch!
if %ERRORLEVEL% NEQ 0 (
    color 0C
    echo.
    echo =======================================================
    echo   ❌ XUNG ĐỘT DỮ LIỆU HOẶC KHÔNG THỂ KÉO CODE VỀ!
    echo =======================================================
    pause
    exit /b %ERRORLEVEL%
)

echo.
echo [5/5] Đang đẩy lên nhánh !current_branch! (git push)...
git push origin !current_branch!

echo.
if %ERRORLEVEL% EQU 0 (
    color 0A
    echo =======================================================
    echo      🎉 ĐÃ ĐẨY LÊN GITHUB THÀNH CÔNG!
    echo =======================================================
) else (
    color 0C
    echo =======================================================
    echo      ❌ CÓ LỖI XẢY RA TRONG QUÁ TRÌNH PUSH!
    echo =======================================================
)

echo.
pause