FROM golang:1.21 as builder

WORKDIR /app

COPY . .

RUN go build -v -o main main.go

# Distroless image para dimunir o tamanho
FROM  gcr.io/distroless/static-debian11 as final

WORKDIR /
COPY --from=builder --chmod=777 /app /app

ENTRYPOINT [ "/app/main" ]