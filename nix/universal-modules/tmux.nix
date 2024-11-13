{ pkgs, ... }:
{
  programs = {
    tmux = {
      enable = true;
      escapeTime = 0;
      plugins = with pkgs; [
        tmuxPlugins.vim-tmux-navigator
      ];
      # https://nix.dev/manual/nix/2.18/language/builtins.html?highlight=readFile#built-in-functions
      extraConfig = ''
        ###############################################################
        set-option -g default-terminal 'screen-256color'
        set-option -g terminal-overrides ',xterm-256color:RGB'
        ###############################################################
        set-option -g status-position top
        set -g default-command "$SHELL"

        set -g prefix C-a
        unbind C-b
        bind-key C-a send-prefix

        set-option -g allow-passthrough on

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
      '';
    };
  };
}
