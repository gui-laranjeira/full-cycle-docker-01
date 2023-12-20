FROM golang:1.21 as builder

WORKDIR /app

COPY . .

RUN go build -v -o main -ldflags "-s -w" main.go

# Distroless image para dimunir o tamanho
FROM scratch as final

WORKDIR /
COPY --from=builder --chmod=777 /app /app

ENTRYPOINT [ "/app/main" ]