all:
	@echo '"make build" to build docker image'

build:
	docker build -t instapaper-to-evernote .
