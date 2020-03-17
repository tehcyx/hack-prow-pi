.PHONY: build

DATE=$(shell date +"%Y%m%d")
GIT_COMMIT=$(shell git rev-parse --short HEAD)
TAG="v${DATE}-${GIT_COMMIT}"

build: build-tide build-status-reconciler build-hook build-plank build-sinker build-deck build-horologium

tag: tag-tide tag-status-reconciler tag-hook tag-plank tag-sinker tag-deck tag-horologium

push: push-tide push-status-reconciler push-hook push-plank push-sinker push-deck push-horologium

tide: build-tide tag-tide
status-reconciler: build-status-reconciler tag-status-reconciler
hook: build-hook tag-hook
plank: build-plank tag-plank
sinker: build-sinker tag-sinker
deck: build-deck tag-deck
horologium: build-horologium tag-horologium

build-tide:
	docker build --build-arg CMP_NAME=tide -t pi-tide:${TAG} .

build-status-reconciler:
	docker build --build-arg CMP_NAME=status-reconciler -t pi-status-reconciler:${TAG} .

build-hook:
	docker build --build-arg CMP_NAME=hook -t pi-hook:${TAG} .

build-plank:
	docker build --build-arg CMP_NAME=plank -t pi-plank:${TAG} .

build-sinker:
	docker build --build-arg CMP_NAME=sinker -t pi-sinker:${TAG} .

build-deck:
	docker build --build-arg CMP_NAME=deck -t pi-deck:${TAG} .

build-horologium:
	docker build --build-arg CMP_NAME=horologium -t pi-horologium:${TAG} .

tag-tide:
	docker tag "pi-tide:${TAG}" docker.pkg.github.com/tehcyx/hack-prow-pi/pi-tide:latest
	docker tag "pi-tide:${TAG}" "docker.pkg.github.com/tehcyx/hack-prow-pi/pi-tide:${TAG}"

tag-status-reconciler:  
	docker tag "pi-status-reconciler:${TAG}" docker.pkg.github.com/tehcyx/hack-prow-pi/pi-status-reconciler:latest
	docker tag "pi-status-reconciler:${TAG}" "docker.pkg.github.com/tehcyx/hack-prow-pi/pi-status-reconciler:${TAG}"

tag-hook:
	docker tag "pi-hook:${TAG}" docker.pkg.github.com/tehcyx/hack-prow-pi/pi-hook:latest
	docker tag "pi-hook:${TAG}" "docker.pkg.github.com/tehcyx/hack-prow-pi/pi-hook:${TAG}"

tag-plank:
	docker tag "pi-plank:${TAG}" docker.pkg.github.com/tehcyx/hack-prow-pi/pi-plank:latest
	docker tag "pi-plank:${TAG}" "docker.pkg.github.com/tehcyx/hack-prow-pi/pi-plank:${TAG}"

tag-sinker:
	docker tag "pi-sinker:${TAG}" docker.pkg.github.com/tehcyx/hack-prow-pi/pi-sinker:latest
	docker tag "pi-sinker:${TAG}" "docker.pkg.github.com/tehcyx/hack-prow-pi/pi-sinker:${TAG}"

tag-deck:
	docker tag "pi-deck:${TAG}" docker.pkg.github.com/tehcyx/hack-prow-pi/pi-deck:latest
	docker tag "pi-deck:${TAG}" "docker.pkg.github.com/tehcyx/hack-prow-pi/pi-deck:${TAG}"

tag-horologium:
	docker tag "pi-horologium:${TAG}" docker.pkg.github.com/tehcyx/hack-prow-pi/pi-horologium:latest
	docker tag "pi-horologium:${TAG}" "docker.pkg.github.com/tehcyx/hack-prow-pi/pi-horologium:${TAG}"

push-tide:
	docker push docker.pkg.github.com/tehcyx/hack-prow-pi/pi-tide:latest
	docker push "docker.pkg.github.com/tehcyx/hack-prow-pi/pi-tide:${TAG}"

push-status-reconciler:
	docker push docker.pkg.github.com/tehcyx/hack-prow-pi/pi-status-reconciler:latest
	docker push "docker.pkg.github.com/tehcyx/hack-prow-pi/pi-status-reconciler:${TAG}"

push-hook:        
	docker push docker.pkg.github.com/tehcyx/hack-prow-pi/pi-hook:latest
	docker push "docker.pkg.github.com/tehcyx/hack-prow-pi/pi-hook:${TAG}"

push-plank:
	docker push docker.pkg.github.com/tehcyx/hack-prow-pi/pi-plank:latest
	docker push "docker.pkg.github.com/tehcyx/hack-prow-pi/pi-plank:${TAG}"

push-sinker:
	docker push docker.pkg.github.com/tehcyx/hack-prow-pi/pi-sinker:latest
	docker push "docker.pkg.github.com/tehcyx/hack-prow-pi/pi-sinker:${TAG}"

push-deck:
	docker push docker.pkg.github.com/tehcyx/hack-prow-pi/pi-deck:latest
	docker push "docker.pkg.github.com/tehcyx/hack-prow-pi/pi-deck:${TAG}"

push-horologium:
	docker push docker.pkg.github.com/tehcyx/hack-prow-pi/pi-horologium:latest
	docker push "docker.pkg.github.com/tehcyx/hack-prow-pi/pi-horologium:${TAG}"

starter:
	./create-starter.sh ${TAG}

clean:
	rm -rf artifact/