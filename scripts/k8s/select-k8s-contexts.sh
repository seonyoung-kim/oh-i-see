#!/bin/bash

CACHE_FILE=~/.kube/valid_contexts

if [[ ! -f "$CACHE_FILE" ]]; then
  echo "⚠️ No cached cluster list found. Run '~/Scripts/k8s/update_k8s_contexts.sh' first."
  exit 1
fi

selected_context=$(cat "$CACHE_FILE" | fzf --prompt="Select Kubernetes Context: ")

if [[ -n "$selected_context" ]]; then
  kubectl config use-context "$selected_context"
  echo "✅ Switched to context: $selected_context"
else
  echo "❌ No context selected."
fi
