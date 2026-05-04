#!/bin/bash

BASE="http://localhost:3001"

# Load environment variables from .env if present
if [ -f "$(dirname "$0")/.env" ]; then
  set -a
  source "$(dirname "$0")/.env"
  set +a
fi

echo "=== Creating users ==="
curl -s -X POST $BASE/users \
  -H "Content-Type: application/json" \
  -d '{"user":{"name":"Bob Smith","email":"bob@example.com"}}' | jq .

curl -s -X POST $BASE/users \
  -H "Content-Type: application/json" \
  -d '{"user":{"name":"Jane Doe","email":"jane@example.com"}}' | jq .

echo "=== Creating articles ==="
curl -s -X POST $BASE/articles \
  -H "Content-Type: application/json" \
  -d '{"article":{"title":"Getting Started with Rails","body":"Rails is a web framework.","user_id":1}}' | jq .

curl -s -X POST $BASE/articles \
  -H "Content-Type: application/json" \
  -d '{"article":{"title":"OpenTelemetry in Production","body":"Observability is critical.","user_id":2}}' | jq .

curl -s -X POST $BASE/articles \
  -H "Content-Type: application/json" \
  -d '{"article":{"title":"ClickHouse at Scale","body":"ClickHouse handles billions of rows.","user_id":1}}' | jq .

echo "=== Listing resources ==="
curl -s $BASE/users | jq .
curl -s $BASE/articles | jq .
curl -s $BASE/comments | jq .

echo "=== Single resource reads ==="
curl -s $BASE/users/1 | jq .
curl -s $BASE/articles/1 | jq .
curl -s $BASE/articles/2 | jq .

echo "=== Update ==="
curl -s -X PATCH $BASE/articles/1 \
  -H "Content-Type: application/json" \
  -d '{"article":{"title":"Getting Started with Rails — Updated"}}' | jq .

echo "=== 404 trigger ==="
curl -s $BASE/articles/999 | jq .

echo "=== Error trigger ==="
curl -s $BASE/crash | jq .

echo ""
echo "Done. Wait 5 seconds then check ClickHouse."



# echo "=== SERVICES ==="
# curl -s "http://localhost:8080/api/v1/observability/services" \
#   -H "Authorization: Bearer $TOKEN" | jq .

# echo "=== TRACES ==="
# curl -s "http://localhost:8080/api/v1/observability/traces?env=development&limit=3" \
#   -H "Authorization: Bearer $TOKEN" | jq .

# echo "=== SINGLE TRACE ==="
# TRACE_ID=$(curl -s "http://localhost:8080/api/v1/observability/traces?env=development&limit=1" \
#   -H "Authorization: Bearer $TOKEN" | jq -r '.data[0].trace_id')
# echo "Using trace_id: $TRACE_ID"
# curl -s "http://localhost:8080/api/v1/observability/traces/$TRACE_ID" \
#   -H "Authorization: Bearer $TOKEN" | jq .

# echo "=== INCIDENTS ==="
# curl -s "http://localhost:8080/api/v1/observability/incidents" \
#   -H "Authorization: Bearer $TOKEN" | jq .

# echo "=== RESOLVE INCIDENT (skip if no incidents) ==="
# INCIDENT_ID=$(curl -s "http://localhost:8080/api/v1/observability/incidents?status=open" \
#   -H "Authorization: Bearer $TOKEN" | jq -r '.data[0].id // empty')
# if [ -n "$INCIDENT_ID" ]; then
#   curl -s -X PATCH \
#     "http://localhost:8080/api/v1/observability/incidents/$INCIDENT_ID/resolve" \
#     -H "Authorization: Bearer $TOKEN" | jq .
# else
#   echo "No open incidents to resolve"
# fi