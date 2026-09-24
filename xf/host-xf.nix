# Edit this configuration file to define what should be installed on
# your system. Help is available in the configuration.nix(5) man page, on
# https://search.nixos.org/options and in the NixOS manual (`nixos-help`).

{ config, pkgs, inputs, ... }:

{
  imports =
    [ # Include the results of the hardware scan.
      inputs.dms.nixosModules.default
      inputs.dms-plugin-registry.nixosModules.default
      ./hardware-configuration.nix
      ./waybar/waybar.nix
      ./waybar/waybar-style.nix
      ./waybar/waybar-controls.nix
      ./hyprland/hyprland.nix
      ./hyprland/fuzzel.nix
      ./hyprland/hyprpaper.nix
      ./hyprland/hypr-appearance.nix
      ./hyprland/hypr-input.nix
      ./hyprland/hypr-rules.nix
      ./hyprland/mako.nix
      ./git-credentials/git-credentials.nix

    ];

  # Use the systemd-boot EFI boot loader.
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  ##GPU DRIVERS
  services.xserver.videoDrivers = [ "nvidia" "amdgpu" ];

  hardware.graphics = {
    enable = true;
    enable32Bit = true;
  };

  hardware.nvidia = {
    modesetting.enable = true;
    open = true;
    package = config.boot.kernelPackages.nvidiaPackages.stable;   # ? CHANGE: stable not latest
  };

   # NVIDIA power management fixes
  boot.kernelParams = [
    "nvidia.NVreg_PreserveVideoMemoryAllocations=1"
    "nvidia.NVreg_TemporaryFilePath=/var/tmp"
    "nvidia-drm.modeset=1"
    "pci=pcie_bus_safe"
    "pcie_aspm=off"
  ];


  networking.hostName = "xf";

  # Networking + Firewall
  networking.networkmanager.enable = true;
  networking.firewall = {
    enable = true;
    allowedTCPPorts = [ ];
    allowedUDPPorts = [ ];
    checkReversePath = false;   # required for Proton VPN
  };

  # Timezone + locale
  time.timeZone = "America/Chicago";
  i18n.defaultLocale = "en_US.UTF-8";
  i18n.extraLocaleSettings = {
    LC_ADDRESS = "en_US.UTF-8";
    LC_IDENTIFICATION = "en_US.UTF-8";
    LC_MEASUREMENT = "en_US.UTF-8";
    LC_MONETARY = "en_US.UTF-8";
    LC_NAME = "en_US.UTF-8";
    LC_NUMERIC = "en_US.UTF-8";
    LC_PAPER = "en_US.UTF-8";
    LC_TELEPHONE = "en_US.UTF-8";
    LC_TIME = "en_US.UTF-8";
  };

  # X11 + Display Manager
  services.xserver.enable = true;
  services.displayManager.sddm.enable = true;
  services.displayManager.sddm.wayland.enable = true;

  # GTK + portal setup
  programs.dconf.enable = true;
  xdg.portal = {
    enable = true;
    extraPortals = [
      pkgs.xdg-desktop-portal-hyprland
      pkgs.xdg-desktop-portal-gtk   # file dialogs + color scheme for GTK apps
    ];
  };

  # Keyboard layout
  services.xserver.xkb = {
    layout = "us";
    variant = "";
  };

  # Audio with pipewire and pulse audio
  services.pulseaudio.enable = false;
  security.rtkit.enable = true;
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
  };


  # User account
  users.users."xf" = {
    isNormalUser = true;
    description = "xander";
    extraGroups = [ "networkmanager" "wheel" "input"];
    packages = with pkgs;
    [
      kdePackages.kate
      thunar
      kitty
      discord
      wine64
      wine
      winetricks
      btop
      unstable.teamspeak6-client
      yubikey-manager
      fastfetch
      neovim
      hyprlock
      waybar
      hyprpaper
      fuzzel
      brightnessctl
      playerctl
      nerd-fonts.jetbrains-mono
      mako
      libnotify
      pavucontrol
      networkmanagerapplet
      blueman
      colloid-gtk-theme
      papirus-icon-theme
      unstable.proton-pass
      unstable.protonmail-desktop
      unstable.proton-vpn
      unstable.proton-authenticator-bin
      bibata-cursors
      polkit_gnome
      gparted
      git
      lufus
      mpv
      usbimager
      r2modman
      grim
      wl-clipboard
      imagemagick
      cava
      unstable.quickshell
      yt-dlp
      mpvpaper
      ffmpeg
      zip
      libinput
      python3
      pulseaudio
      qt6.qtwebsockets
      satty
      unzip
      pam_u2f
      ntfs3g
      thunar-archive-plugin

    ];
  };




  # Programs
  programs.firefox.enable = true;
  programs.gnome-disks.enable = true;
  programs.steam.enable = true;
  programs.hyprland.enable = true;
  programs.hyprland.xwayland.enable = true;
  programs.waybar.enable = true;
  programs.alvr.enable = true;
  programs.alvr.openFirewall = true;

  # DankMaterialShell
  programs.dank-material-shell = {
    enable = true;

    plugins = {
    dockerManager.enable = true;
    };
  };


  # Services
  services.gvfs.enable = true;
  services.udisks2.enable = true;
  services.dbus.packages = [ pkgs.gvfs ];

  # Polkit broadened rule for all udisks2 actions
  security.polkit.enable = true;
  security.polkit.extraConfig = ''
    polkit.addRule(function(action, subject) {
      if (action.id.indexOf("org.freedesktop.udisks2") === 0) {
        return polkit.Result.YES;
      }
    });
  '';


#  # drive mounts
#  fileSystems."/mnt/storage" = {
#    device = "/dev/disk/by-uuid/c0b78bce-5607-4ebd-b39e-df72e37b148f";
#    fsType = "ext4";
#    options = [ "defaults" "nofail" ];
#  };

#  fileSystems."/mnt/steam" = {
#    device = "/dev/disk/by-uuid/6a37767f-da40-4dd8-adfc-652963957793";
#    fsType = "ext4";
#    options = [ "defaults" "nofail" ];
#  };



  # Allow unfree packages
  nixpkgs.config.allowUnfree = true;

  # SSH (commented ? enable if needed)
  # services.openssh.enable = true;

  # Star Citizen
  programs.rsi-launcher = {
    enable = true;
    preCommands = ''
      export DXVK_HUD=compiler;
    '';
  };

  # Sysctl tweaks for Star Citizen
  boot.kernel.sysctl = {
    "vm.max_map_count" = 1048576;
    "fs.file-max" = 524288;
  };

  # Nix settings ? MERGED INTO ONE BLOCK
  nix.settings = {
    max-jobs = "auto";
    cores = 0;

    experimental-features = [ "nix-command" "flakes" ];

    substituters = [ "https://nix-citizen.cachix.org" ];
    trusted-public-keys = [ "nix-citizen.cachix.org-1:lPMkWc2X8XD4/7YPEEwXKKBg+SVbYTVrAaLA2wQTKCo=" ];
  };

  system.stateVersion = "26.05";
}
