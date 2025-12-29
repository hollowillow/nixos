{ pkgs, lib, ... }: {

	imports = [
		./system/fonts.nix
		./system/grub.nix
		./system/hyprland.nix
		./network/proxy.nix
	];

	modules.fonts.enable = lib.mkDefault true;
	modules.grub.enable = lib.mkDefault true;

}
