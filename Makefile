PROJECT=ms
ELVIS=./bin/elvis
REBAR=./bin/rebar

all: deps compile

build-plt:
	@dialyzer --build_plt --output_plt ~/.$(PROJECT).plt \
		--apps erts kernel stdlib deps/*/include deps/*/ebin

check-plt:
	@dialyzer --check_plt --plt ~/.$(PROJECT).plt

clean:
	# @rm -rf deps
	@$(REBAR) clean

compile:
	@echo "Running rebar compile..."
	@$(REBAR) compile

deps:
	@echo "Running rebar update-deps..."
	@$(REBAR) update-deps

dialyzer:
	@dialyzer ebin/*.beam --plt ~/.$(PROJECT).plt -I include

doc:
	@echo "Running rebar update-deps..."
	@$(REBAR) doc

elvis:
	@$(ELVIS) rock

test: dialyzer elvis xref

xref:
	@echo "Running rebar xref..."
	@$(REBAR) xref

.PHONY: build-plt check-plt clean compile deps dialyzer doc elvis xref
