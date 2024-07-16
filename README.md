# rust-web-prometheus-example

An example of using Prometheus metrics in a Rust web service.

## Overview

This project demonstrates how to create a simple web server in Rust using the `warp` and `tokio` crates, with integrated Prometheus metrics for monitoring.

## Getting Started

To run the project, ensure you have Rust installed. If not, install it from [rustup.rs](https://rustup.rs/).

### Build and Run

Use the commands in the `Makefile` to build and run the project.

```bash
# Build the project
make build

# Run the server
make run
```

The server will start on `http://localhost:8080`.

### Endpoints

- `GET /` - Returns "Well done!"
- `GET /some` - Example endpoint that increments an incoming request counter
- `GET /metrics` - Exposes Prometheus metrics
- `GET /ws/:id` - WebSocket endpoint for real-time connections

## Logging

The project uses `env_logger` for logging. Configure the log level via the `RUST_LOG` environment variable:

```bash
export RUST_LOG=info
```

## Metrics

Prometheus metrics included:

- `incoming_requests` - Counter for incoming requests
- `connected_clients` - Gauge for active WebSocket connections
- `response_code` - CounterVec for response codes
- `response_time` - HistogramVec for response times

## Dependencies

- [warp](https://crates.io/crates/warp)
- [tokio](https://crates.io/crates/tokio)
- [prometheus](https://crates.io/crates/prometheus)
- [lazy_static](https://crates.io/crates/lazy_static)
- [futures](https://crates.io/crates/futures)
- [rand](https://crates.io/crates/rand)
- [log](https://crates.io/crates/log)
- [env_logger](https://crates.io/crates/env_logger)
