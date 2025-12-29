{ config, lib, pkgs, modulesPath, ... }:

{
  imports =
    [ (modulesPath + "/profiles/qemu-guest.nix")
    ];

  boot.initrd.availableKernelModules = [ "ahci" "virtio_pci" "xhci_pci" "virtio_scsi" "sr_mod" "virtio_blk" ];
  boot.initrd.kernelModules = [ ];
  boot.kernelModules = [ "kvm-amd" ];
  boot.extraModulePackages = [ ];

  boot.initrd.luks.devices = {
	luksroot = {
		device = "/dev/disk/by-label/cryptroot";
		allowDiscards = true;
	};
	luksdata = {
		device = "/dev/disk/by-label/cryptdata";
		allowDiscards = true;
	};
  };

  fileSystems = {
	"/" = {
		label = "nixos";
		fsType = "btrfs";
		options = [ "subvol=@" "compress=zstd" ];
	};
	"/nix" = {
		label = "nixos";
		fsType = "btrfs";
		options = [ "subvol=@nix" "compress=zstd" "noatime" ];
	};
	"/persist" = {
		label = "nixos";
		fsType = "btrfs";
		options = [ "subvol=@persist" "compress=zstd" ];
	};
	"/var/log" = {
		label = "nixos";
		fsType = "btrfs";
		options = [ "subvol=@log" "compress=zstd" ];
	};
	"/swap" = {
		label = "nixos";
		fsType = "btrfs";
		options = [ "subvol=@swap" ];
	};
  };

  fileSystems = {
	"/home" = {
		label = "data";
		fsType = "btrfs";
		options = [ "subvol=@home" "compress=zstd" ];
	};
  };

  fileSystems = {
	"/boot" = {
		label = "boot";
		fsType = "ext4";
	};
	"/boot/efi" = {
		label = "EFI";
		fsType = "vfat";
      		options = [ "fmask=0077" "dmask=0077" ];
	};
  };

  swapDevices = [{
	device = "/swap/swapfile";
	size = 4*1024; # creates a 4GB swap file
  }];

  nixpkgs.hostPlatform = lib.mkDefault "x86_64-linux";
}
