# Makefile to help with deck creation
# usage make new deck=<NAME> title=<TITLE>
new:
	mkdir ./decks/$(deck)
	cp -r ./assets/_templates/remarkjs/* ./decks/$(deck)/.
	echo "# $(title)" > ./decks./$(deck)/README.md


validate-all:
	pre-commit install
	pre-commit run -a

present-all:
	python3 -m http.server
