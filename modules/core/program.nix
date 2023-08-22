{ ... }:
{
  services = {
    gnome.gnome-keyring.enable = true;
  };

  programs = {
    nix-ld.enable = true;
    fish.enable = true;
    neovim.enable = true;
    light.enable = true;
    dconf.enable = true;
    git = {
      enable = true;
      config = {
        init = {
          defaultBranch = "main";
        };
        push = {
          autoSetupRemote = true;
        };
      };
    };
  };
}
