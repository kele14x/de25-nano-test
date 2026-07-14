# GNU Make helper for the DE25-Nano Quartus project on Windows.
#
# Override QUARTUS_ROOT when Quartus is installed elsewhere, for example:
#   make QUARTUS_ROOT=C:/intelFPGA_pro/26.1/quartus compile

SHELL := cmd.exe

PROJECT_DIR  := quartus
PROJECT      := de25-nano-test
REVISION     := de25_nano_test_top
QUARTUS_ROOT ?= C:/altera_pro/26.1/quartus
QUARTUS_BIN  ?= $(QUARTUS_ROOT)/bin64

QUARTUS_SH   := $(QUARTUS_BIN)/quartus_sh.exe
QUARTUS_PGM  := $(QUARTUS_BIN)/quartus_pgm.exe
JTAGCONFIG   := $(QUARTUS_BIN)/jtagconfig.exe

SOF          := $(PROJECT_DIR)/output_files/$(REVISION).sof
CABLE        ?= DE25-Nano [USB-1]
JTAG_INDEX   ?= 1

.DEFAULT_GOAL := compile

.PHONY: help compile jtag program clean

help:
	@echo Targets:
	@echo   make compile  - Compile the design and create $(SOF)
	@echo   make jtag     - List detected JTAG cables and devices
	@echo   make program  - Compile, then configure the FPGA over JTAG
	@echo   make clean    - Remove Quartus build output and database folders
	@echo.
	@echo Optional overrides:
	@echo   QUARTUS_ROOT=C:/path/to/quartus
	@echo   CABLE="DE25-Nano [USB-1]"
	@echo   JTAG_INDEX=1

compile:
	@echo [Quartus] Compiling $(PROJECT) revision $(REVISION)...
	cd /d "$(PROJECT_DIR)" && "$(QUARTUS_SH)" --flow compile "$(PROJECT)" -c "$(REVISION)"
	@if not exist "$(SOF)" (echo ERROR: Expected programming file was not generated: $(SOF) & exit /b 1)
	@echo [Quartus] Created $(SOF)

jtag:
	"$(JTAGCONFIG)"

program: compile
	@echo [Quartus] Programming JTAG device $(JTAG_INDEX) through $(CABLE)...
	cd /d "$(PROJECT_DIR)" && "$(QUARTUS_PGM)" -c "$(CABLE)" -m jtag -o "p;output_files/$(REVISION).sof@$(JTAG_INDEX)"

clean:
	@if exist "$(PROJECT_DIR)\output_files" rmdir /s /q "$(PROJECT_DIR)\output_files"
	@if exist "$(PROJECT_DIR)\db" rmdir /s /q "$(PROJECT_DIR)\db"
	@if exist "$(PROJECT_DIR)\incremental_db" rmdir /s /q "$(PROJECT_DIR)\incremental_db"
