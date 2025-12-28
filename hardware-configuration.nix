{ config, lib, pkgs, modulesPath, ... }:

{
  imports =
    [ (modulesPath + "/profiles/qemu-guest.nix")
    ];

  boot.initrd.availableKernelModules = [ "ahci" "virtio_pci" "xhci_pci" "virtio_scsi" "sr_mod" "virtio_blk" ];
  boot.initrd.kernelModules = [ "dm-snapshot" ];
  boot.kernelModules = [ "kvm-amd" ];
  boot.extraModulePackages = [ ];

  boot.initrd.luks.devices = {
    luksroot = {
      device = "/dev/disk/by-label/crypt"; # rename to cryptroot
      preLVM = true;
      allowDiscards = true;
    };
    luksdata = {
      device = "/dev/disk/by-label/cryptdata";
      preLVM = true;
      allowDiscards = true;
    };
  };
  
  fileSystems = { # define mounts for root subvolumes
  	"/" = {
		label = "nixos"; # /dev/vg/root
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
  };

  fileSystems = { # define mounts for data subvolumes
  	"/home/hollowillow/media" = {
		label = "data";
		fsType = "btrfs";
		options = [ "subvol=@media" "compress=zstd" "uid=1000" "gid=988" ];
	};
  	"/home/hollowillow/games" = {
		label = "data";
		fsType = "btrfs";
		options = [ "subvol=@games" "compress=zstd" "uid=1000" "gid=988" ];
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
		
  swapDevices =
    [ { device = "/dev/vg/swap"; }
    ];

  nixpkgs.hostPlatform = lib.mkDefault "x86_64-linux";
}
