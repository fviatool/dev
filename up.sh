#!/bin/bash

# Đường dẫn làm việc và Backup
WORKDIR="/root"
BACKUP_DIR="/home"
BACKUP_FILENAME="full_backup_$(date +"%Y%m%d_%H%M%S").tar.gz"
WEB_URL="https://transfer.sh/"

# Hàm tạo backup toàn bộ hệ thống
create_full_system_backup() {
    tar -czvf "$BACKUP_DIR/$BACKUP_FILENAME" --directory=/ --exclude=proc --exclude=sys --exclude=dev/pts --exclude=backups .
}

# Hàm tải lên web và hiển thị liên kết
upload_to_web() {
    cd "$BACKUP_DIR" || exit

    # Xóa các bản sao lưu cũ để tránh ghi đè
    find . -name "full_backup_*" -type f -mtime +7 -exec rm {} \;

    # Sử dụng lệnh cURL để tải lên web
    upload_response=$(curl -s -T "$BACKUP_FILENAME" "$WEB_URL")

    if [ $? -eq 0 ]; then
        echo "Backup đã được tải lên thành công!"
        echo "Liên kết backup: $WEB_URL/$BACKUP_FILENAME"
    else
        echo "Lỗi khi tải lên web. Vui lòng kiểm tra cài đặt hoặc thử lại sau."
    fi
}

# Hàm menu
menu() {
    clear
    echo "===== MENU TẠO BACKUP VÀ TẢI LÊN WEB ====="
    echo "1. Tạo Backup Toàn Bộ Hệ Thống và Tải Lên Web"
    echo "2. Thoát"
    echo "========================================"
}

while true; do
    menu
    read -p "Chọn tùy chọn (1-2): " choice

    case $choice in
        1)
            create_full_system_backup
            upload_to_web
            ;;
        2)
            echo "Kết thúc chương trình."
            exit 0
            ;;
        *)
            echo "Lựa chọn không hợp lệ. Vui lòng chọn lại."
            ;;
    esac
done
