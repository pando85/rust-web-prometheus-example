ARG BASE_IMAGE=rust:1.79.0
FROM ${BASE_IMAGE} AS builder
LABEL mantainer pando855@gmail.com

WORKDIR /usr/src/rust-web-prometheus-example
COPY . .
RUN cargo build --release --bin rust-web-prometheus-example

FROM debian:bookworm-20230904-slim
LABEL mantainer pando855@gmail.com

COPY --from=builder /usr/src/rust-web-prometheus-example/target/release/rust-web-prometheus-example /bin/rust-web-prometheus-example

ENTRYPOINT [ "/bin/rust-web-prometheus-example" ]
