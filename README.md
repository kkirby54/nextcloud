# NextCloud 로컬 개발 환경

Docker Compose를 사용한 NextCloud 로컬 개발 환경 구축 프로젝트입니다.

## 🌟 주요 특징

- **보안**: 환경변수 기반 credential 관리 (`.env` 파일)
- **간편한 설정**: 자동화된 데이터베이스 설정 스크립트
- **고성능**: Redis 캐싱 통합
- **PostgreSQL 연동**: 기존 PostgreSQL 컨테이너 재사용

## 📁 프로젝트 구조

```
.
├── docker-compose.yml          # Docker Compose 설정
├── setup-nextcloud-db.sh       # PostgreSQL 데이터베이스 설정 스크립트
├── .env.example                # 환경변수 템플릿 (공개)
├── .env                        # 실제 환경변수 (Git에서 제외됨)
├── .gitignore                  # Git 제외 파일 목록
├── NEXTCLOUD-LOCAL.md          # 상세 설치 가이드
└── README.md                   # 이 파일
```

## 🚀 빠른 시작

### 1. 환경변수 설정

```bash
# .env 파일 생성
cp .env.example .env

# .env 파일을 편집하여 credential 설정
# 최소한 다음 값들을 변경하세요:
# - POSTGRES_PASSWORD
# - NEXTCLOUD_ADMIN_PASSWORD
nano .env
```

### 2. 데이터베이스 설정

```bash
chmod +x setup-nextcloud-db.sh
./setup-nextcloud-db.sh
```

### 3. NextCloud 실행

```bash
# 네트워크가 없다면 생성
docker network create appnet

# NextCloud 시작
docker-compose up -d

# 로그 확인
docker-compose logs -f
```

### 4. 접속

브라우저에서 `http://localhost:8081`로 접속합니다.

## 📖 상세 문서

자세한 설치 가이드, 트러블슈팅, 관리 명령어는 [NEXTCLOUD-LOCAL.md](NEXTCLOUD-LOCAL.md)를 참조하세요.

## 🔒 보안 주의사항

- `.env` 파일은 절대 Git에 커밋하지 마세요 (`.gitignore`에 포함됨)
- 프로덕션 환경에서는 강력한 비밀번호를 사용하세요
- 관리자 비밀번호는 첫 로그인 후 즉시 변경하세요

## 🛠️ 기술 스택

- **NextCloud**: 29-apache
- **PostgreSQL**: 기존 `pg-local` 컨테이너 사용
- **Redis**: 7-alpine (캐싱)
- **Docker & Docker Compose**: 컨테이너 오케스트레이션

## 📝 라이선스

이 프로젝트는 개인 학습 및 개발 목적으로 사용됩니다.

## 🤝 기여

이슈나 개선 제안은 언제든 환영합니다!

