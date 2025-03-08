final: prev: {
  kitty = prev.kitty.overrideAttrs (old: rec {
    pname = "kitty";
    version = "0.40.0";
    format = "other";

    src = prev.fetchFromGitHub {
      owner = "kovidgoyal";
      repo = "kitty";
      tag = "v${version}";
      hash = "";
    };

    goModules =
      (prev.buildGo123Module {
        pname = "kitty-go-modules";
        inherit src version;
        vendorHash = "";
      }).goModules;
  });
}
