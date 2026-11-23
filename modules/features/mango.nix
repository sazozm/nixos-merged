{ config, ... }:

let
  nixos = { ... }: {
    programs.mango.enable = true;
    programs.xwayland.enable = true;
  };

  home =
    { config, ... }:
    {
      wayland.windowManager.mango = {
        enable = true;

        settings = {
          xkb_rules_layout = "us,ru";
          xkb_rules_options = "grp:caps_toggle";
          repeat_delay = 200;
          repeat_rate = 50;
          numlock_on = 1;

          disable_trackpad = 0;
          trackpad_accel_speed = 0.7;
          trackpad_accel_profile = 1;

          monitor_rule = [ ];

          env = [
            "ELECTRON_OZONE_PLATFORM_HINT,wayland"
            "XDG_CURRENT_DESKTOP,mango"
          ];
          xwayland_persistence = 1;

          exec_once = [
            "noctalia"
            "xwayland-satellite"
            "udiskie --automount --notify"
          ];

          border_px = 2;
          focus_color = "0x${config.lib.stylix.colors.base0E}ff";
          overlay_color = "0x${config.lib.stylix.colors.base0D}ff";
          border_color = "0x${config.lib.stylix.colors.base02}ff";
          urgent_color = "0x${config.lib.stylix.colors.base08}ff";
          maximized_screen_color = "0x${config.lib.stylix.colors.base0E}ff";

          gap_inner_horizontal = 10;
          gap_inner_vertical = 10;
          gap_outer_horizontal = 10;
          gap_outer_vertical = 10;

          border_radius = 0;
          no_radius_when_single = 0;
          focused_opacity = 1.0;
          unfocused_opacity = 0.96;

          blur = 1;
          blur_layer = 1;
          blur_optimized = 1;
          blur_params_radius = 6;
          blur_params_num_passes = 2;
          blur_params_noise = 0.02;
          blur_params_brightness = 0.9;
          blur_params_contrast = 0.9;
          blur_params_saturation = 1.0;

          cursor_theme = config.stylix.cursor.name;
          cursor_size = config.stylix.cursor.size;

          shadows = 0;

          animations = 1;
          layer_animations = 1;

          animation_type_open = "zoom";
          animation_type_close = "zoom";
          layer_animation_type_open = "slide";
          layer_animation_type_close = "fade";

          animation_fade_in = 1;
          animation_fade_out = 1;
          fade_in_begin_opacity = 0.4;
          fade_out_begin_opacity = 0.9;

          zoom_initial_ratio = 0.8;
          zoom_end_ratio = 0.8;

          animation_duration_open = 400;
          animation_duration_close = 300;
          animation_duration_move = 450;
          animation_duration_tag = 350;

          animation_curve_open = "0.16,1.0,0.3,1";
          animation_curve_close = "0.4,0.0,0.6,1";
          animation_curve_move = "0.22,1.0,0.36,1";
          animation_curve_tag = "0.22,1.0,0.36,1";
          animation_curve_focus = "0.22,1.0,0.36,1";
          animation_curve_opacity_fade_in = "0.16,1.0,0.3,1";
          animation_curve_opacity_fade_out = "0.4,0.0,0.6,1";

          tag_animation_direction = 1;

          circle_layout = "scroller,tile,grid,center_tile";

          scroller_structs = 0;
          scroller_proportion_preset = "0.6666667,0.5,0.33333,1";
          scroller_default_proportion = 0.5;
          scroller_default_proportion_single = 1;
          scroller_focus_center = 0;
          scroller_prefer_center = 0;
          scroller_prefer_overspread = 1;
          scroller_ignore_proportion_single = 1;

          dwindle_split_ratio = 0.5;
          dwindle_smart_split = 0;
          dwindle_horizontal_split = 1;
          dwindle_vertical_split = 1;
          dwindle_drop_simple_split = 1;
          dwindle_manual_split = 2;

          overview_gap_inner = 5;
          overview_gap_outer = 10;

          workspace_overview_border_width = 2;
          workspace_overview_gap = 10;
          workspace_overview_scroll_direction = "vertical";
          workspace_overview_focused_dim_opacity = 0.0;
          workspace_overview_unfocused_dim_opacity = 0.25;
          animation_duration_workspace_overview_open = 260;
          animation_duration_workspace_overview_close = 260;
          animation_duration_workspace_overview_move = 382;
          animation_curve_workspace_overview_open = "0.16,1.0,0.3,1";
          animation_curve_workspace_overview_close = "0.4,0.0,0.6,1";
          animation_curve_workspace_overview_move = "0.26,0.99,0.26,1";

          focus_on_activate = 1;
          sloppy_focus = 1;
          warp_cursor = 1;

          axis_bind_apply_timeout = 10;
          no_border_when_single = 1;

          window_rule = [
            "app_id:^pavucontrol$,is_floating:1"
            "app_id:^dev.noctalia.Noctalia$,is_floating:1"
            "app_id:^imv$,is_floating:1"
            "app_id:^mpv$,is_floating:1"
            "app_id:^file-roller$,is_floating:1"
            "app_id:^org.gnome.FileRoller$,is_floating:1"
            "app_id:^xdg-desktop-portal-gtk$,is_floating:1"
            "title:^Open File$,is_floating:1"
            "title:^Save File$,is_floating:1"
            "title:^Confirm to replace files$,is_floating:1"
          ];

          tag_rule = [
            "id:1,layout_name:scroller"
            "id:2,layout_name:scroller"
            "id:3,layout_name:scroller"
            "id:4,layout_name:scroller"
            "id:5,layout_name:scroller"
            "id:6,layout_name:scroller"
            "id:7,layout_name:scroller"
            "id:8,layout_name:scroller"
            "id:9,layout_name:scroller"
          ];

          bind = [
            "SUPER+SHIFT,e,quit"
            "SUPER+SHIFT,p,reload_config"
            "SUPER,slash,spawn,wlr-which-key"
            "SUPER,o,toggleoverview"
            "SUPER,TAB,overcircle,next"
            "SUPER+CTRL,TAB,toggleworkspaceoverview,scroll_occupied"
            "SUPER,q,killclient"
            "SUPER,v,togglefloating"
            "SUPER+SHIFT,TAB,focuslast"
            "SUPER,f,togglemaximizescreen"
            "SUPER+SHIFT,f,togglefullscreen"
            "SUPER+CTRL,h,movewin,-30,0"
            "SUPER+CTRL,l,movewin,+30,0"
            "SUPER+CTRL,k,movewin,0,-30"
            "SUPER+CTRL,j,movewin,0,+30"
            "SUPER+ALT,h,resizewin,-30 0"
            "SUPER+ALT,l,resizewin,+30 0"
            "SUPER+ALT,k,resizewin,0 -30"
            "SUPER+ALT,j,resizewin,0 +30"
            "SUPER,h,focusdir,left"
            "SUPER,j,focusdir,down"
            "SUPER,k,focusdir,up"
            "SUPER,l,focusdir,right"
            "SUPER+SHIFT,h,exchange_client,left"
            "SUPER+SHIFT,j,exchange_client,down"
            "SUPER+SHIFT,k,exchange_client,up"
            "SUPER+SHIFT,l,exchange_client,right"
            "SUPER+CTRL+SHIFT,h,focusmon,left"
            "SUPER+CTRL+SHIFT,j,focusmon,down"
            "SUPER+CTRL+SHIFT,k,focusmon,up"
            "SUPER+CTRL+SHIFT,l,focusmon,right"
            "SUPER,1,view,1"
            "SUPER,2,view,2"
            "SUPER,3,view,3"
            "SUPER,4,view,4"
            "SUPER,5,view,5"
            "SUPER,6,view,6"
            "SUPER,7,view,7"
            "SUPER,8,view,8"
            "SUPER,9,view,9"
            "SUPER+SHIFT,1,tag,1"
            "SUPER+SHIFT,2,tag,2"
            "SUPER+SHIFT,3,tag,3"
            "SUPER+SHIFT,4,tag,4"
            "SUPER+SHIFT,5,tag,5"
            "SUPER+SHIFT,6,tag,6"
            "SUPER+SHIFT,7,tag,7"
            "SUPER+SHIFT,8,tag,8"
            "SUPER+SHIFT,9,tag,9"
            "SUPER,u,viewtoright"
            "SUPER,i,viewtoleft"
            "SUPER+SHIFT,u,tagtoright"
            "SUPER+SHIFT,i,tagtoleft"
            "SUPER,r,switch_proportion_preset"
            "SUPER+SHIFT,r,setkeymode,resize"
            "SUPER,bracketleft,scroller_stack,left"
            "SUPER,bracketright,scroller_stack,right"
            "SUPER,e,setlayout,tile"
            "SUPER,w,setlayout,scroller"
            "SUPER,s,setlayout,grid"
            "SUPER,a,setlayout,monocle"
          ];
          bindn = [
            "SUPER,d,spawn,noctalia msg panel-toggle launcher"
            "SUPER+SHIFT,v,spawn,noctalia msg panel-toggle clipboard"
            "SUPER,b,spawn,noctalia msg panel-toggle control-center"
            "SUPER,comma,spawn,noctalia msg settings-toggle"
            "SUPER,x,spawn,noctalia msg panel-toggle session"
            "SUPER+SHIFT,x,spawn,noctalia msg session lock"
            "SUPER+SHIFT,w,spawn,noctalia msg panel-toggle wallpaper"
            "SUPER+SHIFT,t,spawn,system-theme-switcher"
            "SUPER,t,spawn,kitty"
            "NONE,Print,spawn,noctalia msg screenshot-fullscreen"
            "SHIFT,Print,spawn,noctalia msg screenshot-region"
            "CTRL,Print,spawn,noctalia msg screenshot-fullscreen pick"
            "SUPER,Print,spawn,noctalia msg screenshot-annotate"
            "ALT,Print,spawn,noctalia msg screenshot-fullscreen all"
            "SUPER,minus,spawn,mmsg -d switch_proportion_preset"
            "SUPER,equal,spawn,mmsg -d switch_proportion_preset"
          ];

          bindl = [
            "NONE,XF86AudioRaiseVolume,spawn,noctalia msg volume-up"
            "NONE,XF86AudioLowerVolume,spawn,noctalia msg volume-down"
            "NONE,XF86AudioMute,spawn,noctalia msg volume-mute"
            "NONE,XF86AudioMicMute,spawn,wpctl set-mute @DEFAULT_AUDIO_SOURCE@ toggle"
            "NONE,XF86MonBrightnessUp,spawn,noctalia msg brightness-up"
            "NONE,XF86MonBrightnessDown,spawn,noctalia msg brightness-down"
            "NONE,XF86AudioPlay,spawn,noctalia msg media toggle"
            "NONE,XF86AudioNext,spawn,noctalia msg media next"
            "NONE,XF86AudioPrev,spawn,noctalia msg media previous"
          ];

          mousebind = [
            "SUPER,btn_left,moveresize,curmove"
            "SUPER,btn_right,moveresize,curresize"
          ];

          axisbind = [
            "SUPER,DOWN,viewtoright"
            "SUPER,UP,viewtoleft"
            "SUPER+SHIFT,DOWN,tagtoright"
            "SUPER+SHIFT,UP,tagtoleft"
          ];

          key_mode = {
            resize = {
              bind = [
                "NONE,h,resizewin,-30,0"
                "NONE,l,resizewin,+30,0"
                "NONE,k,resizewin,0,-30"
                "NONE,j,resizewin,0,+30"
                "NONE,Escape,setkeymode,default"
                "NONE,Return,setkeymode,default"
              ];
            };
          };
        };
      };
    };
in
{
  config.flake.nixosModules.mango = nixos;
  config.dendrite.nixos = nixos;
  config.dendrite.home = home;
}
