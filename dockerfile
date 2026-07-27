FROM golang:1.26.4-alpine AS base
WORKDIR /apiproject
COPY go.mod .
RUN go mod download
COPY . .
RUN go build -o main .

FROM gcr.io/distroless/base
WORKDIR /apiproject

COPY --from=base /apiproject/main .
COPY --from=base /apiproject/frontend ./frontend

EXPOSE 8001

CMD ["./main"]
