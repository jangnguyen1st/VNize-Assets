@echo off
chcp 65001 >nul
title [VNize-Assets] Git Auto Push Tool
color 0B

echo =======================================================
echo          TỰ ĐỘNG ĐẨY ẢNH LOGO LÊN GITHUB
echo =======================================================
echo.

:: 1. Kiểm tra trạng thái Git
echo [1/4] Kiểm tra các tệp tin thay đổi...
git status -s
echo.

:: 2. Nhập nội dung commit (hoặc dùng mặc định nếu để trống)
set "commit_msg="
set /p commit_msg=">> Nhập ghi chú commit (Nhấn Enter để dùng mặc định 'Update game logos'): "
if "%commit_msg%"=="" set "commit_msg=Update game logos"

echo.
echo [2/4] Đang thêm các tệp tin mới (git add)...
git add .

echo.
echo [3/4] Đang tạo commit: "%commit_msg%"...
git commit -m "%commit_msg%"

echo.
echo [4/4] Đang đẩy lên nhánh main (git push)...
git push origin main

echo.
if %ERRORLEVEL% EQU 0 (
    color 0A
    echo =======================================================
    echo    🎉 ĐÃ ĐẨY ẢNH LÊN GITHUB THÀNH CÔNG!
    echo =======================================================
) else (
    color 0C
    echo =======================================================
    echo    ❌ CÓ LỖI XẢY RA TRONG QUÁ TRÌNH PUSH!
    echo =======================================================
)

echo.
pause