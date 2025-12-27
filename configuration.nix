# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).

{ config, pkgs, ... }:

{
  imports =
    [ # Include the results of the hardware scan.
      ./hardware-configuration.nix
    ];

  boot.loader.grub = {
  	enable = true;
	device = "/dev/vda";
	useOSProber = true;
  };

  networking = {
  	hostName = "nixos";
	networkmanager.enable = true;
  	# wireless.enable = true;  # Enables wireless support via wpa_supplicant.
	# proxy = { # Configure network proxy if necessary
	# 	default = "http://user:password@proxy:port/";
	#  	noProxy = "127.0.0.1,localhost,internal.domain";
	# };
  };

  # Set your time zone.
  time.timeZone = "Europe/Prague";

  # Select internationalisation properties.
  i18n.defaultLocale = "en_US.UTF-8";

  # Enable sound with pipewire.
  services.pulseaudio.enable = false;
  security.rtkit.enable = true;
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
    # If you want to use JACK applications, uncomment this
    #jack.enable = true;

    # use the example session manager (no others are packaged yet so this is enabled by default,
    # no need to redefine it in your config for now)
    #media-session.enable = true;
  };

  # Define a user account. Don't forget to set a password with ‘passwd’.
  users.users.hollowillow = {
    isNormalUser = true;
    description = "hollowillow";
    extraGroups = [ "networkmanager" "wheel" ];
    packages = with pkgs; [
    	firefox # browser
	stow
	# keepassxc # password database
	# pfetch
	# btop
	# mpv
	# steam # can be enabled as program
	# retroarch
    ];
  };

  # Allow unfree packages
  nixpkgs.config.allowUnfree = true;

  # system wide packages
  # $ nix search (package)
  environment.systemPackages = with pkgs; [
     neovim
     exfatprogs # exfat utils
     noto-fonts # character compatibility
     git # version control # can be enabled as program
  #  wget
  ];

   # security = {
   # 	sudo.enable = false;
   # 	doas.enable = true;
   # };

  # Enable Sway
  programs.sway.enable = true;

  # Enable autologin
  services.getty = {
  	autologinUser = "hollowillow";
	# autologinOnce = true;
  };

  # Autostart Sway
  environment.loginShellInit = ''
  	[[ "$(tty)" == /dev/tty1 ]] && sway
  '';

  # Enable the OpenSSH daemon.
  # services.openssh.enable = true;

  # Open ports in the firewall.
  # networking.firewall.allowedTCPPorts = [ ... ];
  # networking.firewall.allowedUDPPorts = [ ... ];
  # Or disable the firewall altogether.
  # networking.firewall.enable = false;

  # Before changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  system.stateVersion = "25.11"; # Did you read the comment?
}
