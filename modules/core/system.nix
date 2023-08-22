{ self, pkgs, inputs, stateVersion, ... }:
let
  zone = "Asia/Ho_Chi_Minh";
  locale = "en_US.UTF-8";
in {
  time.timeZone = zone;
  i18n.defaultLocale = locale;

  i18n.inputMethod.enabled = "fcitx5";
  i18n.inputMethod.fcitx5.addons = with pkgs; [ fcitx5-bamboo ];

  system.stateVersion = stateVersion;

  nix = {
    settings = {
      auto-optimise-store = true;
      experimental-features = [ "nix-command" "flakes" ];
    };
    gc = {
      automatic = true;
      dates = "weekly";
      options = "--delete-older-than 7d";
    };
  };

  security.pam.services = {
    swaylock = {
      text = ''
        auth include login
      '';
    };
  };

  environment.localBinInPath = true;

  environment.systemPackages = with pkgs; [
    wget
    curl
    git
  ];

  environment.variables = rec {
    EDITOR = "nvim";
    GTK_IM_MODULE = "fcitx";
    QT_IM_MODULE = "fcitx";
    XMODIFIERS = "@im=fcitx";
    SDL_IM_MODULE = "fcitx";
    GLFW_IM_MODULE = "ibus";
    TZ = zone;
  };
}
