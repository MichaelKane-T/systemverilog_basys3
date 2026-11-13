# Include this file after defining MODULE_NAME, REPO_PATH, and SV_FILES.
.DEFAULT_GOAL := synth
.PHONY: synth implement build open_synth_checkpoint open_implement_checkpoint

RESOURCE_DIR := $(abspath $(REPO_PATH)/resources)
SOURCE_PATHS := $(abspath $(SV_FILES))
XDC_FILE ?= basys3.xdc
XDC_ABS := $(abspath $(XDC_FILE))

synth: work/synth.dcp

work:
	mkdir -p work

work/synth.dcp: $(SV_FILES) $(XDC_FILE) $(RESOURCE_DIR)/synth.tcl $(RESOURCE_DIR)/basys3.mk Makefile | work
	@test -n "$(MODULE_NAME)" || { echo "Error: MODULE_NAME not set"; exit 1; }
	@test -n "$(REPO_PATH)" || { echo "Error: REPO_PATH not set"; exit 1; }
	@test -n "$(SV_FILES)" || { echo "Error: SV_FILES not set"; exit 1; }
	cd work && env MODULE_NAME="$(MODULE_NAME)" SV_FILES="$(SOURCE_PATHS)" XDC_PATH="$(XDC_ABS)" SYNTH_PARAMS="$(foreach PARAM,$(SYNTH_PARAMS),-generic $(PARAM))" vivado -mode batch -source "$(RESOURCE_DIR)/synth.tcl" -log synth.log -nojournal -notrace

implement: work/implement.dcp work/design.bit

# A missing bitstream must also trigger implementation.
work/design.bit: work/implement.dcp
	@test -f "$@" || { cd work && vivado -mode batch -source "$(RESOURCE_DIR)/implement.tcl" -log implement.log -nojournal -notrace; }

work/implement.dcp: work/synth.dcp $(RESOURCE_DIR)/implement.tcl
	cd work && vivado -mode batch -source "$(RESOURCE_DIR)/implement.tcl" -log implement.log -nojournal -notrace

build: implement

open_synth_checkpoint: work/synth.dcp
	cd work && vivado synth.dcp -notrace -nojournal

open_implement_checkpoint: work/implement.dcp
	cd work && vivado implement.dcp -notrace -nojournal
