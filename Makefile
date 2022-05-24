PORT ?= 3000

run: build
	docker run -p $(PORT):$(PORT) --env PGPASSWORD --env PGHOST --env PGUSER --env PGDATABASE --env PORT stream_explorer

build:
	docker build -t stream_explorer .
