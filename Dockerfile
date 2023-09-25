# Build stage for first application
FROM golang:1.20 AS build-first
WORKDIR /app
COPY cmd/batch/first .
RUN GOOS=linux GOARCH=amd64 go build -o first-batch ./main.go

# Build stage for second application
FROM golang:1.20 AS build-second
WORKDIR /app
COPY cmd/batch/second .
RUN GOOS=linux GOARCH=amd64 go build -o second-batch ./main.go

# Build stage for third application
FROM golang:1.20 AS build-third
WORKDIR /app
COPY cmd/batch/third .
RUN GOOS=linux GOARCH=amd64 go build -o third-batch ./main.go

# Build stage for fourth application
FROM golang:1.20 AS build-fourth
WORKDIR /app
COPY cmd/batch/fourth .
RUN GOOS=linux GOARCH=amd64 go build -o fourth-batch ./main.go

# Build stage for fifth application
FROM golang:1.20 AS build-fifth
WORKDIR /app
COPY cmd/batch/fifth .
RUN GOOS=linux GOARCH=amd64 go build -o fifth-batch ./main.go

# Final image for first application
FROM debian:buster AS final-first
COPY --from=build-first /app/first-batch /first-app

# Final image for second application
FROM debian:buster AS final-second
COPY --from=build-second /app/second-batch /second-app

# Final image for third application
FROM debian:buster AS final-third
COPY --from=build-third /app/third-batch /third-app

# Final image for fourth application
FROM debian:buster AS final-fourth
COPY --from=build-fourth /app/fourth-batch /fourth-app

# Final image for fifth application
FROM debian:buster AS final-fifth
COPY --from=build-fifth /app/fifth-batch /fifth-app