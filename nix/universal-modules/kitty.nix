{ pkgs, ... }:
{
  programs = {
    kitty = {
      package = pkgs.kitty.overrideAttrs (previousAttrs: {
        patches = previousAttrs.patches ++ [
          (pkgs.fetchpatch {
            name = "fishyfix-4f0f9b9aff427547a726fdcfde5dcd99b897570c.patch";
            url = "https://github.com/kovidgoyal/kitty/commit/4f0f9b9aff427547a726fdcfde5dcd99b897570c.patch";
            hash = "sha256-y9syEd2uFcbixHrHfAzqTF5GnQKB/kY+uRBZ5GbqjC4=";
          })
        ];
      });
      enable = true;
      font = {
        name = "Maple Mono SC NF";
        size = 16;
      };
      settings = {
        # Window layout
        window_border_width = 1;
        window_padding_width = 5;
        window_margin_width = 1;
        # Terminal Bell
        enable_audio_bell = true;
        visual_bell_duration = 0.0;
        visual_bell_color = "none";
        window_alert_on_bell = true;
        bell_on_tab = "🔔 ";
        command_on_bell = "none";
        # Cursor Trails
        cursor_trail = "10";
        cursor_trail_start_threshold = "0";
        shell_integration = "no-cursor";
        cursor_trail_decay = "0.01 0.15";
        cursor_shape = "block";
        cursor_blink = "true";
      };
      themeFile = "Jellybeans";
    };
  };
}
