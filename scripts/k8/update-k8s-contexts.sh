#!/bin/bash

# 저장할 파일 경로
CACHE_FILE=~/.kube/valid_contexts

# 사용 가능한 컨텍스트 목록 가져오기
contexts=$(kubectl config get-contexts --output=name)

valid_contexts=()

# 각 컨텍스트에 대해 접근 가능한지 체크
for ctx in $contexts; do
  if kubectl auth can-i get pods --context="$ctx" &>/dev/null; then
    valid_contexts+=("$ctx")
  fi
done

# 유효한 컨텍스트 목록 저장
printf "%s\n" "${valid_contexts[@]}" >"$CACHE_FILE"

echo "✅ Updated valid contexts in $CACHE_FILE"
