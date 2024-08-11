{
  description = "Example Darwin system flake";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixpkgs-unstable";
    nix-darwin.url = "github:LnL7/nix-darwin";
    nix-darwin.inputs.nixpkgs.follows = "nixpkgs";
    nix-homebrew.url = "github:zhaofengli-wip/nix-homebrew";
    homebrew-core = {
      url = "github:homebrew/homebrew-core";
      flake = false;
    };
    homebrew-cask = {
      url = "github:homebrew/homebrew-cask";
      flake = false;
    };
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    homebrew-bundle = {
      url = "github:homebrew/homebrew-bundle";
      flake = false;
    };
  };

  outputs = inputs@{ self, nix-darwin, nixpkgs, home-manager, nix-homebrew
    , homebrew-core, homebrew-cask, homebrew-bundle }:
    let
      configuration = { pkgs, ... }: {
        # List packages installed in system profile. To search by name, run:
        # $ nix-env -qaP | grep wget
        environment.systemPackages = [
          pkgs.stow
          pkgs.btop
          pkgs.curl
          pkgs.git
          pkgs.jq
          pkgs.lazygit
          pkgs.neovim
          pkgs.nixfmt
          pkgs.wget
          pkgs.yq
          pkgs.starship
          pkgs.zsh
        ];

        # Auto upgrade nix package and the daemon service.
        services.nix-daemon.enable = true;
        # nix.package = pkgs.nix;

        # Necessary for using flakes on this system.
        nix.settings.experimental-features = "nix-command flakes";

        # Create /etc/zshrc that loads the nix-darwin environment.
        programs.zsh.enable = true; # default shell on catalina

        # Set Git commit hash for darwin-version.
        system.configurationRevision = self.rev or self.dirtyRev or null;

        # Used for backwards compatibility, please read the changelog before changing.
        # $ darwin-rebuild changelog
        system.stateVersion = 4;

        # The platform the configuration will be used on.
        nixpkgs.hostPlatform = "aarch64-darwin";

        system.defaults = {
          finder.AppleShowAllFiles = true;
          finder.FXPreferredViewStyle = "Nlsv";
          finder.ShowPathbar = true;
          finder.ShowStatusBar = true;
          NSGlobalDomain."com.apple.mouse.tapBehavior" = 1;
          dock.autohide = true;
          dock.mru-spaces = false;
          finder.AppleShowAllExtensions = true;
          loginwindow.LoginwindowText = "cultofleda";
          screencapture.location = "~/Pictures/Screenshots";
          screensaver.askForPasswordDelay = 10;
          menuExtraClock.ShowSeconds = true;
        };

        system.keyboard = {
          enableKeyMapping = true;
          remapCapsLockToEscape = true;
        };

        security.pam = { enableSudoTouchIdAuth = true; };

        # Homebrew needs to be installed on its own!
        homebrew.enable = true;
        homebrew.casks = [
          "google-chrome"
          "bitwarden"
          "font-jetbrains-mono-nerd-font"
          "raycast"
          "wezterm"
        ];
        homebrew.brews = [ 
          "bitwarden-cli"
        ];
      };
    in {
      # Build darwin flake using:
      # $ darwin-rebuild build --flake .#Arturs-MacBook-Pro
      darwinConfigurations."Arturs-MacBook-Pro" = nix-darwin.lib.darwinSystem {
        system = "aarch64-darwin";
        modules = [
          configuration
          nix-homebrew.darwinModules.nix-homebrew
          {
            nix-homebrew = {
              # Install Homebrew under the default prefix
              enable = true;
              # Apple Silicon Only: Also install Homebrew under the default Intel prefix for Rosetta 2
              enableRosetta = true;
              # User owning the Homebrew prefix
              user = "cultofleda";
              # Optional: Declarative tap management
              taps = {
                "homebrew/homebrew-bundle" = homebrew-bundle;
                "homebrew/homebrew-cask" = homebrew-cask;
                "homebrew/homebrew-core" = homebrew-core;
              };
              # Optional: Enable fully-declarative tap management
              # With mutableTaps disabled, taps can no longer be added imperatively with `brew tap`.
              mutableTaps = false;
            };
          }
        ];
      };

      # Expose the package set, including overlays, for convenience.
      darwinPackages = self.darwinConfigurations."Arturs-MacBook-Pro".pkgs;
    };
}
