FROM alpine/git:latest AS checkout

RUN git clone https://github.com/kubernetes/test-infra /workspace/test-infra

FROM golang:alpine AS builder
ARG CMP_NAME

COPY --from=checkout /workspace/test-infra /workspace/test-infra
WORKDIR /workspace/test-infra/prow

RUN echo "${CMP_NAME}"

RUN GOOS=linux GOARCH=arm GOARM=5 go build -ldflags="-w -s" -o /workspace/release/${CMP_NAME} cmd/${CMP_NAME}/

FROM scratch
ARG CMP_NAME

COPY --from=builder /workspace/release/${CMP_NAME} /workspace/${CMP_NAME}

ENTRYPOINT [ "/workspace/${CMP_NAME}" ]
