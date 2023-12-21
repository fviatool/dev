#!/bin/bash

# Đường dẫn làm việc và Backup
WORKDIR="/root"
BACKUP_DIR="/"
BACKUP_FILENAME="full_backup_$(date +"%Y%m%d_%H%M%S").tar.gz"

# Hàm tạo backup toàn bộ hệ thống
create_full_system_backup() {
    echo "Đang tạo backup toàn bộ hệ thống..."
    tar -czvf "$BACKUP_DIR/$BACKUP_FILENAME" --directory=/ --exclude=proc --exclude=sys --exclude=dev/pts --exclude=backups .
}

# Hàm menu
menu() {
    clear
    echo "===== MENU TẠO BACKUP TOÀN BỘ HỆ THỐNG ====="
    echo "1. Tạo Backup Toàn Bộ Hệ Thống"
    echo "2. Thoát"
    echo "========================================"
}

while true; do
    menu
    read -p "Chọn tùy chọn (1-2): " choice

    case $choice in
        1)
            create_full_system_backup
            echo "Backup toàn bộ hệ thống đã được tạo: $BACKUP_DIR/$BACKUP_FILENAME"
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
