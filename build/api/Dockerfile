FROM golang:1.20 AS build-api
WORKDIR /app
COPY go.mod go.sum ./
RUN go mod download
COPY .. ./
RUN GOOS=linux GOARCH=amd64 go build -o api ./cmd/api

FROM debian:buster AS final-api
COPY --from=build-api /app/api /app/api
# バイナリに実行権限を付与
RUN chmod +x /app/api
WORKDIR /app
CMD ["./api"]