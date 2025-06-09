#!/bin/bash

KEY_PATH="$HOME/.ssh/id_ed25519"
PUB_KEY="$KEY_PATH.pub"
AUTHORIZED_KEYS="$HOME/.ssh/authorized_keys"

mkdir -p ~/.ssh
chmod 700 ~/.ssh

# 產生 SSH 金鑰（若不存在）
if [ ! -f "$KEY_PATH" ]; then
    ssh-keygen -t ed25519 -f "$KEY_PATH" -N "" -C "root@$(hostname)"
    echo "✅ SSH 金鑰已產生。"
else
    echo "⚠️ SSH 金鑰已存在：$KEY_PATH"
fi

# 添加公鑰到 authorized_keys
if ! grep -q "$(cat "$PUB_KEY")" "$AUTHORIZED_KEYS" 2>/dev/null; then
    cat "$PUB_KEY" >> "$AUTHORIZED_KEYS"
    chmod 600 "$AUTHORIZED_KEYS"
    echo "✅ 公鑰已加入 ~/.ssh/authorized_keys"
else
    echo "⚠️ 公鑰已存在於 authorized_keys"
fi

# 顯示私鑰內容
echo -e "\n🔑 請儲存以下私鑰內容（非常重要）："
echo "================== PRIVATE KEY =================="
cat "$KEY_PATH"
echo "================================================="
