APP_NAME ?= my-app
IMAGE    ?= my-app
TAG      ?= latest

build:
	docker build \
	  --build-arg APP_NAME=$(APP_NAME) \
	  -t $(IMAGE):$(TAG) .

run:
	docker run --rm \
	  -p 8080:8080 \
	  -v $(PWD)/data:/nqdev/data \
	  $(IMAGE):$(TAG)
