# Edit this configuration file to define what should be installed on
# your system. Help is available in the configuration.nix(5) man page, on
# https://search.nixos.org/options and in the NixOS manual (`nixos-help`).
#
# This configuration replaces the previous Ansible playbook
# (../desktop.yml + ../roles/*) used to provision this desktop. Each
# section below is annotated with the Ansible role(s) it replaces.

{ config, lib, pkgs, ... }:
{
  nixpkgs.config.allowUnfree = true;

  imports =
    [ # Include the results of the hardware scan.
      ./hardware-configuration.nix
      ./base.nix
    ];

  # Use the systemd-boot EFI boot loader.
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  # Use latest kernel.
  boot.kernelPackages = pkgs.linuxPackages_latest;

  networking.hostName = "chimay"; # Define your hostname.

  # Configure network connections interactively with nmcli or nmtui.
  networking.networkmanager.enable = true;

  # Graphical login screen (Wayland)
  services.displayManager.gdm.enable = true;

  # Set your time zone.
  time.timeZone = "Europe/Paris";

  nix.settings.experimental-features = [ "nix-command" "flakes" ];

  ##############################################################################
  # roles/plymouth: boot splash
  ##############################################################################
  boot.plymouth.enable = true;
  boot.kernelParams = [ "quiet" "splash" ];

  ##############################################################################
  # roles/sensors: lm_sensors package (facts baked into i3status.conf above,
  # for this host's k10temp/amdgpu hwmon paths)
  ##############################################################################
  services.fwupd.enable = true; # roles/misc-base "fwupd"

  # roles/misc-base "unattended-upgrades": closest NixOS analog.
  system.autoUpgrade.enable = true;

  # roles/misc-desktop "docker.io"
  virtualisation.docker.enable = true;

  users.groups.kakwa = { gid = 1001; };

  users.users.kakwa = {
    isNormalUser = true;
    uid = 1001;
    description = "Kakwa";
    group = "kakwa";
    shell = pkgs.zsh;
    extraGroups = [
      "cdrom" "floppy" "audio" "dip" "video" "plugdev" "users" "render"
      "netdev" "docker" "wheel" # wheel == sudo group on NixOS
    ];
  };

  system.stateVersion = "26.05"; # Did you read the comment?

}
