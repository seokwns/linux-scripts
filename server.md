## server
매번 ssh 연결을 위해 ip와 username, password를 입력하는 번거로움을 없애주는 스크립트 입니다.

## 사용법
### 준비사항
1. 스크립트 내 `FOLDER_PATH`를 자신이 원하는 경로로 변경합니다.
2. 빠른 스크립트 사용을 위해 bashrc(혹은 zshrc)에서 PATH에 해당 스크립트 위치를 추가합니다.

### 명령어
#### `server add`
1. 명령어를 입력하면 서버 연결 정보를 입력하는 화면이 나타납니다.
2. 안내에 맞게 입력합니다.

#### `server delete`
1. 명령어를 입력하면 추가된 서버 목록이 나타납니다.
2. 삭제할 서버의 번호를 입력합니다.

#### `server connect`
1. 명령어를 입력하면 추가된 서버 목록이 나타납니다.
2. 연결할 서버의 번호를 입력합니다.

## 변경로그
- 2024.05.04: 스크립트 최초 생성 (commit)[https://github.com/seokwns/linux-scripts/commit/96b8f3f30ade7ec8ac4ae000bae84db997f1761c]
- 2024.05.04: 파일명 및 권한 수정 (commit)[https://github.com/seokwns/linux-scripts/commit/8a839a6343eb0461a3984e0999a6b737211b1221]
