CARGO_TARGET_DIR ?= target
CARGO_TARGET ?= x86_64-unknown-linux-gnu
PKG_BASE_NAME ?= rust-web-prometheus-example-${CARGO_TARGET}

IMAGE_NAME ?= ghcr.io/pando85/rust-web-prometheus-example
IMAGE_VERSION ?= latest

.DEFAULT: help
.PHONY: help
help:	## Show this help menu.
	@echo "Usage: make [TARGET ...]"
	@echo ""
	@@egrep -h "#[#]" $(MAKEFILE_LIST) | sed -e 's/\\$$//' | awk 'BEGIN {FS = "[:=].*?#[#] "}; {printf "\033[36m%-20s\033[0m %s\n", $$1, $$2}'
	@echo ""

.PHONY: build
build:	## compile rust-web-prometheus-example
build:
	cargo build --release

.PHONY: lint
lint:	## lint code
lint:
	cargo clippy --locked --all-targets --all-features -- -D warnings
	cargo fmt -- --check

.PHONY: release
release:	## generate binary
	cargo build --release --all-features --target ${CARGO_TARGET}
	@echo Released in $(CARGO_TARGET_DIR)/$(CARGO_TARGET)/release/rust-web-prometheus-example

.PHONY: image
image:	## build image
	docker buildx build \
		--build-arg "CARGO_TARGET_DIR=$(CARGO_TARGET_DIR)" \
		--load \
		-t $(IMAGE_NAME):$(IMAGE_VERSION) \
		.

.PHONY: push-image
push-image:	## push image
push-image: image
	docker buildx build \
		--build-arg "CARGO_TARGET_DIR=$(CARGO_TARGET_DIR)" \
		--push \
		-t $(IMAGE_NAME):$(IMAGE_VERSION) \
		.

.PHONY: run
run:	## run image
run: image
	docker run --init -it -p 8080:8080 $(IMAGE_NAME):$(IMAGE_VERSION)
