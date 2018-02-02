default: build
MAKEFLAGS += --silent
SHELL:=/bin/bash -eux
IMAGE = crazybus/logrotate

build:
	docker build -t ${IMAGE} .

run: build
	docker run \
		--rm \
		-ti \
		-v $$(pwd)/example/logrotate.conf:/etc/logrotate.conf \
		-v $$(pwd)/example/crontab:/etc/crontabs/root \
		-v $$(pwd)/example/log:/log \
		${IMAGE}

rotate: build
	docker run \
		--rm \
		-ti \
		-v $$(pwd)/example/logrotate.conf:/etc/logrotate.conf \
		-v $$(pwd)/example/crontab:/etc/crontabs/root \
		-v $$(pwd)/example/log:/log \
		${IMAGE} \
		/usr/sbin/logrotate -d /etc/logrotate.conf

logs: build
	docker run \
		--rm \
		-ti \
		-v $$(pwd)/example/log:/log \
		${IMAGE} \
	    dd if=/dev/zero of=/log/audit.log bs=2048 count=2048
