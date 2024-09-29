{
  imports = with builtins;
    map (fn: ./${fn})
      (filter (fn: fn != "default.nix") (attrNames (readDir ./.)));
}
{
  nixpkgs = {
    config = {
      allowUnfree = true;
    };
  };
}
