build:
	@cd ui && yarn && yarn generate && cd -
	@go build -o bin/app

run:
	@./bin/app
