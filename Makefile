.PHONY: build

DATE=$(shell date +"%Y%m%d")
GIT_COMMIT=$(shell git rev-parse --short HEAD)
TAG="v${DATE}-${GIT_COMMIT}"

build: tide status-reconciler hook plank sinker deck

tide:
	docker build --build-arg CMP_NAME=tide -t pi-tide:${TAG} .

status-reconciler:
	docker build --build-arg CMP_NAME=status-reconciler -t pi-status-reconciler:${TAG} .

hook:
	docker build --build-arg CMP_NAME=hook -t pi-hook:${TAG} .

plank:
	docker build --build-arg CMP_NAME=plank -t pi-plank:${TAG} .

sinker:
	docker build --build-arg CMP_NAME=sinker -t pi-sinker:${TAG} .

deck:
	docker build --build-arg CMP_NAME=deck -t pi-deck:${TAG} .