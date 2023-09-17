FROM golang:1.20 AS builder

WORKDIR /app

COPY . .

# Linuxとamd64向けに明示的にクロスコンパイル
RUN GOOS=linux GOARCH=amd64 go build -o second-batch ./main.go

# 実際の実行環境用の新しいステージを開始
FROM debian:buster-slim

# ビルドしたバイナリを前のステージからコピー
COPY --from=builder /app/second-batch /app/second-batch

# バイナリに実行権限を付与
RUN chmod +x /app/second-batch

WORKDIR /app
CMD ["./second-batch"]