{
  lib,
  stdenvNoCC,
  fetchFromGitea,
  libinput,
  wayland,
  wlroots,
  libxkbcommon,
  wayland-protocols,
  pkg-config,
  libxcb,
  xwayland,
  xcbutilwm,
  libX11,
  enableXWayland ? true,
}:
let
  pname = "dwl";
  version = "v0.7";
in
stdenvNoCC.mkDerivation (finalAttrs: {

  src = fetchFromGitea {
    domain = "codeberg.org";
    owner = "dwl";
    repo = "dwl";
    rev = "v${finalAttrs.version}";
    hash = "sha256-7SoCITrbMrlfL4Z4hVyPpjB9RrrjLXHP9C5t1DVXBBA=";
  };

  sourceRoot = ".";

  buildInputs =
    [
      libinput
      libxcb
      libxkbcommon
      wayland
      wlroots
    ]
    ++ lib.optionals enableXWayland [
      libX11
      xwayland
      xcbutilwm
    ];

  nativeBuildInputs = [
    wayland-protocols
    pkg-config
  ];

  installPhase = ''
    runHook preInstall

    mkdir -p $out/share/fonts/truetype
    cp *.ttf $out/share/fonts/truetype

    runHook postInstall
  '';

  meta = with lib; {
    description = "Font based on Sarasa Term SC font.";
    longDescription = "Sarasa Term SC Nerd font is based on Sarasa Term SC font. Nerd fonts 
    patch program is modified, Nerd fonts is merged into Sarasa Term SC by this program, 
    and then some post-processing is done to form the final font. 

    This font is especially suitable for Simplified Chinese users to use in terminal or code editor.";
    homepage = "https://github.com/laishulu/Sarasa-Term-SC-Nerd";
    license = licenses.ofl;
    maintainers = with maintainers; [ mkenkel ];
    platforms = platforms.all;
  };
})
