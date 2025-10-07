#!/bin/bash

# NextCloud용 PostgreSQL 데이터베이스 및 사용자 생성 스크립트

# .env 파일에서 환경변수 로드
if [ -f .env ]; then
    echo "📁 .env 파일에서 설정을 불러옵니다..."
    export $(cat .env | grep -v '^#' | xargs)
else
    echo "⚠️  .env 파일이 없습니다. .env.example을 복사하여 .env 파일을 생성하세요."
    echo "   cp .env.example .env"
    exit 1
fi

# 필수 환경변수 확인
if [ -z "$POSTGRES_USER" ] || [ -z "$POSTGRES_PASSWORD" ] || [ -z "$POSTGRES_DB" ]; then
    echo "❌ 필수 환경변수가 설정되지 않았습니다."
    echo "   .env 파일에서 POSTGRES_USER, POSTGRES_PASSWORD, POSTGRES_DB를 설정하세요."
    exit 1
fi

echo "🔧 NextCloud용 PostgreSQL 데이터베이스 설정 시작..."

# 기존 postgres 컨테이너에 접속하여 DB 생성
docker exec -i ${POSTGRES_HOST:-pg-local} psql -U ${POSTGRES_ADMIN_USER:-printing_pulse} -d ${POSTGRES_ADMIN_DB:-postgres} << EOF
-- NextCloud용 사용자 생성
CREATE USER ${POSTGRES_USER} WITH PASSWORD '${POSTGRES_PASSWORD}';

-- NextCloud용 데이터베이스 생성
CREATE DATABASE ${POSTGRES_DB} OWNER ${POSTGRES_USER};

-- 권한 부여
GRANT ALL PRIVILEGES ON DATABASE ${POSTGRES_DB} TO ${POSTGRES_USER};

-- 연결 확인
\l
\du

EOF

if [ $? -eq 0 ]; then
    echo "✅ NextCloud 데이터베이스 설정 완료!"
    echo ""
    echo "📊 생성된 정보:"
    echo "  - Database: ${POSTGRES_DB}"
    echo "  - User: ${POSTGRES_USER}"
    echo "  - Password: ********** (보안을 위해 숨김)"
    echo ""
else
    echo "❌ 데이터베이스 설정 실패"
    exit 1
fi

