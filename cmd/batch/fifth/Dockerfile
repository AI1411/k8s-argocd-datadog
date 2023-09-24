FROM golang:1.20 AS builder

WORKDIR /app

COPY . .

# Linuxとamd64向けに明示的にクロスコンパイル
RUN GOOS=linux GOARCH=amd64 go build -o fifth-batch ./main.go

# 実際の実行環境用の新しいステージを開始
FROM debian:buster-slim

# ビルドしたバイナリを前のステージからコピー
COPY --from=builder /app/fifth-batch /app/fifth-batch

# バイナリに実行権限を付与
RUN chmod +x /app/fifth-batch

WORKDIR /app
CMD ["./fifth-batch"]