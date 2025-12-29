{ pkgs, lib, config, ... }: {

	options = {
		modules.grub.enable = lib.mkEnableOption "Enables grub module";
	};

	config = lib.mkIf config.modules.grub.enable {
		boot.loader = {
			efi = {
				canTouchEfiVariables = true;
				efiSysMountPoint = "/boot/efi";
			};
			grub = {
				enable = true;
				efiSupport = true;
				device = "nodev";
			};
		};
	};

}
