# Services

Each folder here is one service. CI discovers services by their `Makefile` and runs
`make lint`, `make test` and `make build` in each. A service's folder name is its name in
`compose.yaml` and the `service` field of its logs.
