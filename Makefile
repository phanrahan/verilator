CFLAGS = -Wno-undefined-bool-conversion

NAME = main

all:
	verilator -Wno-fatal -cc $(NAME).v --trace --exe ../main.cpp -CFLAGS "$(CFLAGS)"
	@echo '#include "V$(NAME).h"'                       >main.cpp
	@echo '#include "verilated.h"' >>main.cpp
	@echo 'int main(int argc, char **argv, char **env) {' >>main.cpp
	@echo 'Verilated::commandArgs(argc, argv);' >>main.cpp
	@echo 'V$(NAME)* top = new V$(NAME);' >>main.cpp
	@echo 'while (!Verilated::gotFinish()) { top->eval(); }' >>main.cpp
	@echo 'delete top;' >>main.cpp
	@echo 'exit(0);' >>main.cpp
	@echo '}' >>main.cpp
	make -C obj_dir -f V$(NAME).mk

clean:
	rm -rf obj_dir main.cpp data.vcd
