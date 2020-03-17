#!/usr/bin/env bash

if [ -z ${1} ]; then
    echo "parameter for container tag needed to run"
    exit 1
fi
TAG="${1}"

mkdir artifact
echo "${TAG}" > artifact/TAG

curl https://raw.githubusercontent.com/kubernetes/test-infra/master/prow/cluster/starter.yaml -o artifact/starter.yaml

sed -i -e 's;image: gcr.io/k8s-prow/hook:.*$;'"image: docker.pkg.github.com/tehcyx/hack-prow-pi/pi-hook:${TAG};g" ./artifact/starter.yaml
sed -i -e 's;image: gcr.io/k8s-prow/tide:.*$;'"image: docker.pkg.github.com/tehcyx/hack-prow-pi/pi-tide:${TAG};g" ./artifact/starter.yaml
sed -i -e 's;image: gcr.io/k8s-prow/sinker:.*$;'"image: docker.pkg.github.com/tehcyx/hack-prow-pi/pi-sinker:${TAG};g" ./artifact/starter.yaml
sed -i -e 's;image: gcr.io/k8s-prow/deck:.*$;'"image: docker.pkg.github.com/tehcyx/hack-prow-pi/pi-deck:${TAG};g" ./artifact/starter.yaml
sed -i -e 's;image: gcr.io/k8s-prow/plank:.*$;'"image: docker.pkg.github.com/tehcyx/hack-prow-pi/pi-plank:${TAG};g" ./artifact/starter.yaml
sed -i -e 's;image: gcr.io/k8s-prow/status-reconciler:.*$;'"image: docker.pkg.github.com/tehcyx/hack-prow-pi/pi-status-reconciler:${TAG};g" ./artifact/starter.yaml
sed -i -e 's;image: gcr.io/k8s-prow/horologium:.*$;'"image: docker.pkg.github.com/tehcyx/hack-prow-pi/pi-horologium:${TAG};g" ./artifact/starter.yaml