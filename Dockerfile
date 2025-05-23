FROM golang:1.21-alpine as builder

WORKDIR /app

COPY go.mod go.sum ./
RUN go mod download

COPY . .
RUN go build -o /fizzbuzz .

FROM scratch
COPY --from=builder /fizzbuzz /fizzbuzz

CMD ["/fizzbuzz", "serve"]