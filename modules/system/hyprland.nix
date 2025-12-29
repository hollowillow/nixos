{ pkgs, lib, config, ... }: {

	options = {
		modules.hyprland.enable = lib.mkEnableOption "Enables hyprland module";
	};

	config = lib.mkIf config.modules.hyprland.enable {
		programs.hyprland = {
			enable = true;
			# xwayland.enable = true;
		};
		programs.waybar.enable = true;
		services.getty = {
			autologinUser = "hollowillow";
			autologinOnce = true;
		};
		environment.loginShellInit = ''
			[[ "$(tty)" == /dev/tty1 ]] && hypr
		'';
		environment.systemPackages = with pkgs; [
			alacritty
			wl-clipboard
			swaybg
			dunst # altenatively mako?
			# ydotool
			# wev
		];
	};

}
