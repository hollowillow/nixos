{ config, lib, pkgs, ... }:

{
  imports = [
      ./hardware-configuration.nix
    ];

  # Use the systemd-boot EFI boot loader.
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.efiSysMountPoint = "/boot/efi";
  boot.loader.efi.canTouchEfiVariables = true;
  boot.loader.grub.useOSProber = false;

  networking.hostName = "nixos";
  networking.networkmanager.enable = true;
  # networking.proxy.default = "http://user:password@proxy:port/";
  # networking.proxy.noProxy = "127.0.0.1,localhost,internal.domain";

  time.timeZone = "Europe/Amsterdam";
  i18n.defaultLocale = "en_US.UTF-8";

  # console = {
  #   font = "Lat2-Terminus16";
  #   keyMap = "us";
  #   useXkbConfig = true; # use xkb.options in tty.
  # };

  # Enable hyprland
  programs.hyprland.enable = true;
  # programs.hyprland.xwayland.enable = true;
  programs.waybar.enable = true;

  services.getty = {
  	autologinUser = "hollowillow";
	autologinOnce = true;
  };
  environment.loginShellInit = ''
  	[[ "$(tty)" == /dev/tty1 ]] && hyprland
  '';

  # Enable sound.
  services.pulseaudio.enable = false;
  services.pipewire = {
    enable = true;
    pulse.enable = true;
  };

  users.groups.data = {};
  users.users.hollowillow = {
    isNormalUser = true;
    initialPassword = "asdf";
    extraGroups = [ "wheel" "data" ]; # Enable ‘sudo’ for the user.
    packages = with pkgs; [
      firefox
    ];
  };

  security.sudo.enable = true;

  # programs.firefox.enable = true;

  environment.systemPackages = with pkgs; [
    neovim
    git
    wget
    kitty
    alacritty
    wl-clipboard
  ];

  # Enable the OpenSSH daemon.
  # services.openssh.enable = true;

  # Open ports in the firewall.
  # networking.firewall.allowedTCPPorts = [ ... ];
  # networking.firewall.allowedUDPPorts = [ ... ];
  # Or disable the firewall altogether.
  # networking.firewall.enable = false;

  # Copy the NixOS configuration file and link it from the resulting system
  # (/run/current-system/configuration.nix). This is useful in case you
  # accidentally delete configuration.nix.
  # system.copySystemConfiguration = true;

  system.stateVersion = "25.11";
}

