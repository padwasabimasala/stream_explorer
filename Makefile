run: build
	docker run -p 3000:3000 --env PGPASSWORD --env PGHOST --env PGUSER --env PGDATABASE stream_explorer

build:
	docker build -t stream_explorer .
