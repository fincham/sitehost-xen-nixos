{ config, pkgs, ... }: {
    # A basic NixOS configuration.nix suitable for use with SiteHost's Xen based VPS platform (https://sitehost.nz/)
    # Can be installed on to a Debian VPS either with "lustrate" or from "Rescue Mode".
    # This is totally unsupported by SiteHost but it seems to work :)
    #
    # For the "Console" to work both xen_fbfront and xen_kbdfront kernel modules will also need to be loaded.
    #
    # Michael Fincham <michael@hotplate.co.nz> 2020-04-19

    imports = [
        ./hardware-configuration.nix
    ];
    
    services.openssh.enable = true;

    networking.hostName = "nixos";
    
    networking.firewall.enable = false;
    networking.interfaces.eth0.useDHCP = false;
    networking.interfaces.eth0.ipv4.addresses = [
        {
            address = "xxx.xxx.xxx.xxx";
            prefixLength = 24;
        }
    ];
    networking.defaultGateway = "xxx.xxx.xxx.3";
    networking.nameservers = [ "120.138.18.100" "120.138.22.100" ];

    users.users.root.initialHashedPassword = "";
    services.openssh.permitRootLogin = "prohibit-password";
    users.users.root.openssh.authorizedKeys.keys = [
        "ssh-rsa AAAAB3NzaC1..."
    ];

    i18n = {
        consoleKeyMap = "us";
        defaultLocale = "en_NZ.UTF-8";
    };
    time.timeZone = "Pacific/Auckland";
    
    boot = {
        loader.grub = {
            enable = true;
            version = 1;
            extraPerEntryConfig = "root (hd1)";
            device = "nodev";
	          splashImage = null;
        };
        initrd.availableKernelModules = [ "xen_blkfront" "xen_netfront" "xen_pcifront" "xen_scsifront" ];
        initrd.kernelModules = [ "xen_blkfront" "xen_netfront" ];
        kernelParams=["root=/dev/xvda2" "console=tty1" "net.ifnames=0" "biosdevname=0"];
    };    

    system.stateVersion = "19.09";
}
