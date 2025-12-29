# Connectivity info for Linux VM
NIXADDR ?= 192.168.2.130
NIXPORT ?= 22
NIXUSER ?= eugene

# Connectivity info for Desktop
DESKTOPADDR ?= 192.168.1.235
DESKTOPPORT ?= 22
DESKTOPUSER ?= eugene

# Get the path to this Makefile and directory
MAKEFILE_DIR := $(patsubst %/,%,$(dir $(abspath $(lastword $(MAKEFILE_LIST)))))

# The name of the nixosConfiguration in the flake
NIXNAME ?= vm-aarch64

# Export variables for scripts to use
export NIXADDR NIXPORT NIXUSER DESKTOPADDR DESKTOPPORT DESKTOPUSER NIXNAME MAKEFILE_DIR

# Local NixOS commands
switch:
	sudo NIXPKGS_ALLOW_UNFREE=1 NIXPKGS_ALLOW_UNSUPPORTED_SYSTEM=1 nixos-rebuild switch --impure --flake ".#${NIXNAME}"

test:
	sudo NIXPKGS_ALLOW_UNFREE=1 NIXPKGS_ALLOW_UNSUPPORTED_SYSTEM=1 nixos-rebuild test --impure --flake ".#$(NIXNAME)"

# Secrets management
.PHONY: secrets/backup
secrets/backup:
	@./scripts/secrets/backup.sh

.PHONY: secrets/restore
secrets/restore:
	@./scripts/secrets/restore.sh

# VM targets
vm/bootstrap0:
	@./scripts/vm/bootstrap0.sh

vm/bootstrap:
	@./scripts/vm/bootstrap.sh

vm/reboot:
	@./scripts/vm/reboot.sh

vm/update:
	@./scripts/vm/update.sh

vm/secrets:
	@./scripts/vm/secrets.sh

vm/copy:
	@./scripts/vm/copy.sh

vm/switch:
	@./scripts/vm/switch.sh

# Desktop targets
desktop/update:
	@./scripts/desktop/update.sh

desktop/reboot:
	@./scripts/desktop/reboot.sh

desktop/secrets:
	@./scripts/desktop/secrets.sh

desktop/copy:
	@./scripts/desktop/copy.sh

desktop/switch:
	@./scripts/desktop/switch.sh

# Mac update
mac/update:
	sudo nix run nix-darwin -- switch --flake .#macbook

# Format Nix files
fmt:
	find . -name '*.nix' -type f -exec nixfmt -w 120 {} \;
