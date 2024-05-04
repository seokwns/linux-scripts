#!/bin/bash

read_yaml() {
    local yaml_file="$1"
    local value="$2"
    local result=$(python3 -c "import yaml; print(yaml.safe_load(open('$yaml_file'))['$value'])")
    echo "$result"
}


FOLDER_PATH="/Users/seokjun/Documents/server"


if [ $# -eq 0 ]; then
    echo "사용법: $0 [파일명]"
    exit 1
fi

if [ "$1" == "list" ]; then
    find "$FOLDER_PATH" -name "*.yaml" -type f -exec basename {} .yaml \;
    exit 0
fi

if [ "$1" == "add" ]; then
    echo "Add a new server:"

    # 서버 세부 정보 입력 받기
    read -p "- server name: " NAME
    read -p "- ip: " IP
    read -p "- username: " USERNAME
    read -p "- password: " PASSWORD

    YAML_FILE="$FOLDER_PATH/$NAME.yaml"

    # 파일이 이미 존재하는지 확인
    if [ -f "$YAML_FILE" ]; then
        echo "이미 '$NAME' 서버가 존재합니다."
        exit 1
    fi

    # 서버 세부 정보를 파일에 저장
    echo "IP: $IP" > "$YAML_FILE"
    echo "USERNAME: $USERNAME" >> "$YAML_FILE"
    echo "PASSWORD: $PASSWORD" >> "$YAML_FILE"

    echo "'$NAME' 서버를 추가했습니다."
    exit 0
fi

if [ "$1" == "delete" ]; then
    YAML_FILES=("$FOLDER_PATH"/*.yaml)
    YAML_FILENAMES=()
    for file_path in "${YAML_FILES[@]}"; do
        filename=$(basename "$file_path")
        YAML_FILENAMES+=("${filename%.*}")
    done

    for i in "${!YAML_FILENAMES[@]}"; do
        echo "$(($i+1))) ${YAML_FILENAMES[$i]}"
    done

    read -p ">> " selection_index

    selected_index=$(($selection_index - 1))
    FILE_NAME="${YAML_FILENAMES[$selected_index]}"
    YAML_FILE="$FOLDER_PATH/$FILE_NAME.yaml"

    if [ ! -f "$YAML_FILE" ]; then
        echo "파일 '$YAML_FILE'을(를) 찾을 수 없습니다."
        exit 1
    fi

    if [ ! -f "$YAML_FILE" ]; then
        echo "서버 '$NAME'을(를) 찾을 수 없습니다."
        exit 1
    fi

    rm "$YAML_FILE"
    echo "'$FILE_NAME' 서버가 삭제되었습니다."
    exit 0
fi

if [ "$1" == "connect" ]; then

    YAML_FILES=("$FOLDER_PATH"/*.yaml)
    YAML_FILENAMES=()
    for file_path in "${YAML_FILES[@]}"; do
        filename=$(basename "$file_path")
        YAML_FILENAMES+=("${filename%.*}")
    done

    for i in "${!YAML_FILENAMES[@]}"; do
        echo "$(($i+1))) ${YAML_FILENAMES[$i]}"
    done

    read -p ">> " selection_index

    selected_index=$(($selection_index - 1))
    FILE_NAME="${YAML_FILENAMES[$selected_index]}"
    YAML_FILE="$FOLDER_PATH/$FILE_NAME.yaml"

    if [ ! -f "$YAML_FILE" ]; then
        echo "파일 '$YAML_FILE'을(를) 찾을 수 없습니다."
        exit 1
    fi

    IP=$(read_yaml "$YAML_FILE" "IP")
    USERNAME=$(read_yaml "$YAML_FILE" "USERNAME")
    PASSWORD=$(read_yaml "$YAML_FILE" "PASSWORD")

    expect -c "
    spawn ssh $USERNAME@$IP
    expect {
        \"yes/no\" { send \"yes\r\"; exp_continue }
        \"password:\" { send \"$PASSWORD\r\" }
    }
    interact"
    exit 0
fi

