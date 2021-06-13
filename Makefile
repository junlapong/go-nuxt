APP_NAME=go-nuxt

GO_BUILD_ENV := CGO_ENABLED=0 GOOS=linux GOARCH=amd64
DOCKER_BUILD=$(shell pwd)/.docker_build
DOCKER_CMD=$(DOCKER_BUILD)/$(APP_NAME)

$(DOCKER_CMD): clean
	mkdir -p $(DOCKER_BUILD)
	$(GO_BUILD_ENV) go build -v -o $(DOCKER_CMD) .

clean:
	rm -rf $(DOCKER_BUILD)

heroku: $(DOCKER_CMD)
	heroku container:push web


###############################################################################

# build: clear
# 	@cd ui && yarn && yarn generate && cd -
# 	@go build -o bin/$(APP_NAME)

# clear:
# 	@rm -rf ui/dist && rm -rf bin

build: clear
	@go build -o bin/$(APP_NAME)

clear:
	@rm -rf bin

run:
	@./bin/$(APP_NAME)
