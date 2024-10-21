{ pkgs, ... }:
{
  programs = {
    tmux = {
      enable = true;
      escapeTime = 0;
      plugins = with pkgs; [
        tmuxPlugins.vim-tmux-navigator
        tmuxPlugins.catppuccin
      ];
      # https://nix.dev/manual/nix/2.18/language/builtins.html?highlight=readFile#built-in-functions
      extraConfig = ''
        # General settings
        # set -g default-terminal "tmux-256color"
        # set -ga terminal-overrides ",*256col*:Tc"
        # set -ga terminal-overrides '*:Ss=\E[%p1%d q:Se=\E[ q'
        # set-environment -g COLORTERM "truecolor"
        ###############################################################
        set-option -g default-terminal 'screen-256color'
        set-option -g terminal-overrides ',xterm-256color:RGB'
        ###############################################################
        set -g prefix C-a
        unbind C-b
        bind-key C-a send-prefix
        # --- 

        # Set windows to start at 1
        set -g base-index 1
        setw -g pane-base-index 1
        # ---

        # Windows
        unbind %
        bind | split-window -h
        unbind '"'
        bind - split-window -v
        # ---

        # Create and list new windows
        unbind n # next-window
        bind n new-window
        unbind c
        bind c kill-window
        unbind l
        bind l choose-tree -Zw
        unbind ,
        unbind r
        bind-key r command-prompt -I "#W" "rename-window '%%'"
        # ---

        # Window selection
        unbind p # previous-window
        unbind l
        bind l next-window
        unbind h
        bind h previous-window
        # ---

        # Reload configuration file
        # unbind r
        # bind r source-file ~/.config/tmux/tmux.conf
        # Can't reload source if we're Nix-ing :)
        # ---

        # resize-panes
        set -g mouse on
        # bind -r j resize-pane -D 5
        # bind -r k resize-pane -U 5
        # bind -r l resize-pane -R 5
        # bind -r h resize-pane -L 5
        # bind -r m resize-pane -Z
        # ---

        # Vi-related settings
        set-window-option -g mode-keys vi
        bind-key -T copy-mode-vi 'v' send -X begin-selection
        bind-key -T copy-mode-vi 'y' send -X copy-selection
        unbind -T copy-mode-vi MouseDragEnd1Pane
        # ---

        # Pane sync / Mult-SSH Session Sync
        bind-key b set-window-option synchronize-panes\; display-message "synchronize-panes is now #{?pane_synchronized,on,off}"
        # ---

        # Equalize space
        unbind e
        bind e select-layout tiled
        # ---
        # Configure the catppuccin plugin
        set -g @catppuccin_flavor "macchiato"

        set -g @catppuccin_date_time_text "%I:%M%p"
        set -g @catppuccin_directory_text "#{b:pane_current_path}"
        set -g @catppuccin_status_connect_separator "no"
        set -g @catppuccin_status_fill "icon"
        set -g @catppuccin_status_left_separator  " "
        set -g @catppuccin_status_modules_left "session"
        set -g @catppuccin_status_modules_right "directory date_time"
        set -g @catppuccin_status_right_separator " "
        set -g @catppuccin_window_current_fill "number"
        set -g @catppuccin_window_current_text "#W#{?window_zoomed_flag,(),}"
        set -g @catppuccin_window_default_fill "number"
        set -g @catppuccin_window_default_text "#W"
        set -g @catppuccin_window_left_separator ""
        set -g @catppuccin_window_middle_separator " █"
        set -g @catppuccin_window_number_position "right"
        set -g @catppuccin_window_right_separator " "
        set -g @catppuccin_window_status_activity_style "none"
        set -g @catppuccin_window_status_style "rounded"

        run-shell ${pkgs.tmuxPlugins.catppuccin}/share/tmux-plugins/catppuccin/catppuccin.tmux
      '';
    };
  };
}