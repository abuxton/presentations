# Makefile to help with deck creation
# usage make new deck=<NAME> title=<TITLE>
new:
	mkdir ./$(deck)
	cp -r ./assets/_templates/remarkjs/* ./$(deck)/.
	echo "# $(title)" > ./$(deck)/README.md


validate-all:
	pre-commit install
	pre-commit run -a

present-all:
	python3 -m http.server
