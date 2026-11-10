{ config, ... }:

{
  wayland.windowManager.mango = {
    enable = true;

    settings = {
      xkb_rules_layout = "us,ru";
      xkb_rules_options = "grp:caps_toggle";
      repeat_delay = 200;
      repeat_rate = 50;
      numlockon = 1;

      disable_trackpad = 0;
      trackpad_accel_speed = 0.7;
      trackpad_accel_profile = 1;

      monitorrule = [ ];

      env = [
        "ELECTRON_OZONE_PLATFORM_HINT,wayland"
        "XDG_CURRENT_DESKTOP,mango"
      ];
      xwayland_persistence = 1;

      exec-once = [
        "noctalia"
        "xwayland-satellite"
        "udiskie --automount --notify"
      ];

      borderpx = 2;
      focuscolor = "0x${config.lib.stylix.colors.base0E}ff";
      overlaycolor = "0x${config.lib.stylix.colors.base0D}ff";
      bordercolor = "0x${config.lib.stylix.colors.base02}ff";
      urgentcolor = "0x${config.lib.stylix.colors.base08}ff";
      maximizescreencolor = "0x${config.lib.stylix.colors.base0E}ff";

      gappih = 10;
      gappiv = 10;
      gappoh = 10;
      gappov = 10;

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
      fadein_begin_opacity = 0.4;
      fadeout_begin_opacity = 0.9;
      zoom_initial_ratio = 0.8;
      zoom_end_ratio = 0.8;

      animation_duration_open = 400;
      animation_duration_close = 300;
      animation_duration_move = 450;
      animation_duration_tag = 350;

      animation_curve_open = "0.16,1.0,0.3,1.0";
      animation_curve_close = "0.4,0.0,0.6,1.0";
      animation_curve_move = "0.22,1.0,0.36,1.0";
      animation_curve_tag = "0.22,1.0,0.36,1.0";
      animation_curve_focus = "0.22,1.0,0.36,1.0";
      animation_curve_opafadein = "0.16,1.0,0.3,1.0";
      animation_curve_opafadeout = "0.4,0.0,0.6,1.0";

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
      dwindle_hsplit = 1;
      dwindle_vsplit = 1;
      dwindle_drop_simple_split = 1;
      dwindle_manual_split = 2;

      overviewgappi = 5;
      overviewgappo = 10;
      focus_on_activate = 1;
      sloppyfocus = 1;
      warpcursor = 1;
      axis_bind_apply_timeout = 10;
      no_border_when_single = 1;

      windowrule = [
        "appid:^pavucontrol$,isfloating:1"
        "appid:^dev.noctalia.Noctalia$,isfloating:1"
        "appid:^imv$,isfloating:1"
        "appid:^mpv$,isfloating:1"
        "appid:^file-roller$,isfloating:1"
        "appid:^org.gnome.FileRoller$,isfloating:1"
        "appid:^xdg-desktop-portal-gtk$,isfloating:1"
        "title:^Open File$,isfloating:1"
        "title:^Save File$,isfloating:1"
        "title:^Confirm to replace files$,isfloating:1"
      ];

      tagrule = [
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
        "SUPER,o,toggleoverview"
        "SUPER,TAB,overcircle,next"
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
        "SUPER,minus,spawn,mmsg -d switch_proportion_preset"
        "SUPER,equal,spawn,mmsg -d switch_proportion_preset"
        "SUPER+SHIFT,r,setkeymode,resize"
        "SUPER,bracketleft,scroller_stack,left"
        "SUPER,bracketright,scroller_stack,right"
        "SUPER,e,setlayout,tile"
        "SUPER,w,setlayout,scroller"
        "SUPER,s,setlayout,grid"
        "SUPER,a,setlayout,monocle"
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

      keymode = {
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
}
