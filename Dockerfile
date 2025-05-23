FROM golang:1.21-alpine as builder

WORKDIR /app
COPY go.mod go.sum ./
RUN go mod download

COPY . .

RUN CGO_ENABLED=0 GOOS=linux go build -o /fizzbuzz .

FROM gcr.io/distroless/static

COPY --from=builder /fizzbuzz /fizzbuzz

CMD ["/fizzbuzz", "serve"]
