# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page:wq
# and in the NixOS manual (accessible by running ‘nixos-help’).

{ config, pkgs, ... }:

{
  imports =
    [ # Include the results of the hardware scan.
      ./hardware-configuration.nix
      <home-manager/nixos>
    ];

  # Bootloader.
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;
  boot.loader.efi.efiSysMountPoint = "/boot/efi";

  boot.kernelParams = [ "psmouse.synaptics_intertouch=0" ];

  networking.hostName = "nixos"; # Define your hostname.
  # networking.wireless.enable = true;  # Enables wireless support via wpa_supplicant.

  # Configure network proxy if necessary
  # networking.proxy.default = "http://user:password@proxy:port/";
  # networking.proxy.noProxy = "127.0.0.1,localhost,internal.domain";

  # Enable networking
  networking.networkmanager.enable = true;

  # Set your time zone.
  time.timeZone = "America/Sao_Paulo";

  # Select internationalisation properties.
  i18n.defaultLocale = "en_US.UTF-8";

  i18n.extraLocaleSettings = {
    LC_ADDRESS = "pt_BR.UTF-8";
    LC_IDENTIFICATION = "pt_BR.UTF-8";
    LC_MEASUREMENT = "pt_BR.UTF-8";
    LC_MONETARY = "pt_BR.UTF-8";
    LC_NAME = "pt_BR.UTF-8";
    LC_NUMERIC = "pt_BR.UTF-8";
    LC_PAPER = "pt_BR.UTF-8";
    LC_TELEPHONE = "pt_BR.UTF-8";
    LC_TIME = "pt_BR.UTF-8";
  };

  # Enable the KDE Plasma Desktop Environment.
  # services.xserver.displayManager.sddm.enable = true;
  # services.xserver.desktopManager.plasma5.enable = true;

  environment.pathsToLink = [ "/libexec" ]; # links /libexec from derivations to /run/current-system/sw 

  programs.hyprland = {
	enable = true;
	xwayland.enable = true;
	nvidiaPatches = true;
  };

  services.xserver = {
    enable = true;

    desktopManager = {
      xterm.enable = false;
    };

    displayManager = {
      defaultSession = "hyprland";
    };

#    windowManager.i3 = {
#     enable = true;
#      extraPackages = with pkgs; [
#        dmenu #application launcher most people use
#        i3lock #default i3 screen locker
#     ];
#    };

  };
  
  # Configure keymap in X11
  services.xserver = {
    layout = "br";
    xkbVariant = "";
  };

  # Configure console keymap
  console.keyMap = "br-abnt2";

  hardware.opengl.driSupport32Bit = true;

  # Enable CUPS to print documents.
  services.printing.enable = true;

  # Enable sound with pipewire.
  sound.enable = true;
  hardware.pulseaudio.enable = false;
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

  services.mpd = {
    enable = true;
    musicDirectory = "/home/sophia/Music/";
    extraConfig = ''
      audio_output {
        type "pipewire"
        name "My PipeWire"
      }
    '';

    # Optional:
    network.listenAddress = "any"; # if you want to allow non-localhost connections
    startWhenNeeded = true; # systemd feature: only start MPD service upon connection to its socket
  };

  # Enable touchpad support (enabled default in most desktopManager).
  # services.xserver.libinput.enable = true;

  # Define a user account. Don't forget to set a password with ‘passwd’.
  users.users.sophia = {
    isNormalUser = true;
    shell = pkgs.fish;
    description = "Sophia";
    extraGroups = [ "networkmanager" "wheel" ];
    packages = with pkgs; [
      firefox
      kate
    #  thunderbird
    ];
  };

  programs.noisetorch.enable = true;

  # Allow unfree packages
  nixpkgs.config.allowUnfree = true;

  # Enable OpenTabletDriver
  hardware.opentabletdriver.enable = true;

  # List packages installed in system profile. To search, run:
  # $ nix search wget
  environment.systemPackages = with pkgs; [
  #  vim # Do not forget to add an editor to edit configuration.nix! The Nano editor is also installed by default.
  #  wget
  pkgs.jetbrains.rider
  pkgs.jetbrains.goland
  pkgs.godot
  pkgs.obsidian
  pkgs.vlc  
  pkgs.xfce.thunar
  pkgs.ncmpcpp
  pkgs.gimp  

  pkgs.go
  pkgs.rustup
  pkgs.python39  

  pkgs.libgccjit
  pkgs.gcc49
  pkgs.gcc_multi
  pkgs.clang_15
  pkgs.binutils

  pkgs.htop
  pkgs.ranger
  pkgs.gh  
  pkgs.feh
  pkgs.ripgrep
  pkgs.neovim
  pkgs.scrot
  pkgs.xclip
 
  pkgs.eww

  pkgs.qemu
  ];

fonts.fonts = with pkgs; [
  meslo-lgs-nf
  nerdfonts
];

programs.fish.enable = true;

  # Some programs need SUID wrappers, can be configured further or are
  # started in user sessions.
  # programs.mtr.enable = true;
  # programs.gnupg.agent = {
  #   enable = true;
  #   enableSSHSupport = true;
  # };

  # List services that you want to enable:

  # Enable the OpenSSH daemon.
  # services.openssh.enable = true;

  # Open ports in the firewall.
  # networking.firewall.allowedTCPPorts = [ ... ];
  # networking.firewall.allowedUDPPorts = [ ... ];
  # Or disable the firewall altogether.
  # networking.firewall.enable = false;

  # This value determines the NixOS release from which the default
  # settings for stateful data, like file locations and database versions
  # on your system were taken. It‘s perfectly fine and recommended to leave
  # this value at the release version of the first install of this system.
  # Before changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  system.stateVersion = "22.11"; # Did you read the comment?

  home-manager.users.sophia = { pkgs, ... }: {

    home.stateVersion = "22.11";

    home.packages = with pkgs; [ 
 
      oh-my-posh     
      kitty
      git
            
    ];

    programs.oh-my-posh = {
      enable = true;
    };

    programs.git = {
      enable = true;
      userEmail = "";
      userName = "MintzyG";
    };

  };

}