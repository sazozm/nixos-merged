{ config, ... }:
let
  c = config.lib.stylix.colors.withHashtag;
in
{
  programs.tmux = {
    enable = true;
    mouse = true;
    baseIndex = 1;
    clock24 = true;
    prefix = "C-a";
    terminal = "foot";

    extraConfig = ''
      set-option -sa terminal-overrides ",foot*:Tc"
      set-option -g renumber-windows on
      bind r source-file ~/.config/tmux/tmux.conf \; display-message "reloaded!"

      bind | split-window -h -c "#{pane_current_path}"
      bind - split-window -v -c "#{pane_current_path}"
      unbind '"'
      unbind %

      set-window-option -g mode-keys vi

      is_vim="ps -o state= -o comm= -t '#{pane_tty}' \
          | grep -iqE '^[^TXZ ]+ +(\\S+\\/)?g?(view|l?n?vim?x?|fzf)(diff)?$'"
      bind-key -n 'C-h' if-shell "$is_vim" 'send-keys C-h'  'select-pane -L'
      bind-key -n 'C-j' if-shell "$is_vim" 'send-keys C-j'  'select-pane -D'
      bind-key -n 'C-k' if-shell "$is_vim" 'send-keys C-k'  'select-pane -U'
      bind-key -n 'C-l' if-shell "$is_vim" 'send-keys C-l'  'select-pane -R'

      set-option -g status-position top
      set-option -g status-interval 5
      set-option -g status-style "bg=${c.base00},fg=${c.base04}"
      set-option -g status-left-length 30
      set-option -g status-right-length 80
      set-option -g status-left "#[bg=${c.base0E},fg=${c.base00},bold]  #S #[bg=${c.base01},fg=${c.base0E}] "
      set-option -g status-right "#[fg=${c.base0E}] #h #[fg=${c.base03}]| #[fg=${c.base05}]%Y-%m-%d #[fg=${c.base0C}]%H:%M "
      set-option -g window-status-format "#[fg=${c.base04}] #I:#W "
      set-option -g window-status-current-format "#[bg=${c.base02},fg=${c.base0E},bold] #I:#W #[default]"
      set-option -g window-status-current-style "bg=${c.base02},fg=${c.base0E}"
      set-option -g pane-border-style "fg=${c.base02}"
      set-option -g pane-active-border-style "fg=${c.base0E}"
      set-option -g message-style "bg=${c.base01},fg=${c.base05}"
      set-option -g mode-style "bg=${c.base02},fg=${c.base0E}"
      set-option -g clock-mode-colour "${c.base0E}"
    '';
  };
}
