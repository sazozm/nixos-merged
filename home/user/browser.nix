{ config, pkgs, ... }:

{
  programs.firefox = {
    enable = true;
    profiles.default = {
      isDefault = true;

      settings = {
        "toolkit.legacyUserProfileCustomizations.stylesheets" = true;
        "svg.context-properties.content.enabled" = true;
        "browser.theme.content-theme" = 0;
        "browser.theme.toolbar-theme" = 0;
      };

      userChrome = ''
        :root {
          --tab-border-radius: 0px !important;
          --toolbarbutton-border-radius: 0px !important;
          --urlbar-border-radius: 0px !important;
          --arrowpanel-border-radius: 0px !important;
          --panel-border-radius: 0px !important;
          --button-border-radius: 0px !important;
          --menuitem-border-radius: 0px !important;
          --toolbarbutton-inner-padding: 8px !important;

          --border-radius-small: 0px !important;
          --border-radius-medium: 0px !important;
          --border-radius-large: 0px !important;
          --border-radius-circle: 0px !important;
          --border-radius-rounded: 0px !important;
        }

        .tab-background,
        .tabbrowser-tab .tab-stack,
        .tab-content,
        .tab-background::before,
        .tab-background::after,
        .tab-group-label,
        .tab-group-line,
        #tabbrowser-arrowscrollbox .tabbrowser-tab {
          border-radius: 0 !important;
        }

        .tab-background {
          margin-block: 0 !important;
          border: 1px solid transparent !important;
        }

        .tab-background[selected] {
          border-color: color-mix(in srgb, currentColor 25%, transparent) !important;
          box-shadow: none !important;
        }

        #tabbrowser-tabs {
          --tab-block-margin: 0px !important;
        }

        #urlbar,
        #urlbar-background,
        #urlbar-input-container,
        #searchbar,
        .searchbar-textbox,
        #urlbar .urlbarView,
        .urlbarView-row,
        .urlbarView-row-inner,
        .urlbarView-button,
        #urlbar-results {
          border-radius: 0 !important;
        }

        #urlbar-background {
          border: 1px solid color-mix(in srgb, currentColor 25%, transparent) !important;
          box-shadow: none !important;
        }

        #urlbar[focused] > #urlbar-background,
        #urlbar[open] > #urlbar-background {
          border-color: var(--focus-outline-color, currentColor) !important;
        }

        #identity-box,
        #tracking-protection-icon-container,
        #identity-icon-box,
        #permissions-granted-icon,
        .urlbar-page-action,
        #star-button-box,
        .identity-box-button,
        .urlbar-input-container .urlbar-icon,
        #userContext-icons,
        #urlbar-label-box,
        .searchmode-switcher,
        .urlbar-searchmode-button {
          border-radius: 0 !important;
        }

        toolbarbutton,
        .toolbarbutton-1,
        .toolbarbutton-icon,
        .toolbarbutton-badge,
        .toolbarbutton-badge-stack,
        .bookmark-item,
        #PlacesToolbarItems > .bookmark-item,
        #nav-bar-overflow-button,
        #unified-extensions-button,
        .unified-extensions-item,
        .subviewbutton {
          border-radius: 0 !important;
        }

        #nav-bar .toolbarbutton-1 > .toolbarbutton-icon,
        #TabsToolbar .toolbarbutton-1 > .toolbarbutton-icon {
          border-radius: 0 !important;
        }

        panel,
        menupopup,
        .panel-arrowcontent,
        .panel-subview-body,
        .panel-viewcontainer,
        .panel-viewstack,
        panelview,
        menupopup > menu,
        menupopup > menuitem,
        menuitem,
        menu,
        tooltip,
        #appMenu-popup,
        #customizationui-widget-panel,
        #unified-extensions-panel,
        .popup-notification-primary-button,
        .popup-notification-secondary-button,
        .panel-footer button,
        button.footer-button {
          border-radius: 0 !important;
        }

        menupopup,
        panel {
          --panel-border-radius: 0px !important;
          --arrowpanel-border-radius: 0px !important;
        }

        .panel-arrow,
        .panel-arrowbox {
          display: none !important;
        }

        input,
        textarea,
        button,
        .button,
        checkbox,
        radio,
        menulist,
        html|input,
        html|button,
        html|textarea,
        html|select {
          border-radius: 0 !important;
        }

        #sidebar-box,
        #sidebar-header,
        #sidebar-main,
        #sidebar,
        .sidebar-panel,
        .sidebar-placesTree {
          border-radius: 0 !important;
        }

        #tabbrowser-tabpanels,
        #tabbrowser-tabbox,
        .browserContainer,
        .browserStack,
        #appcontent,
        #browser,
        #browser > *,
        browser[type="content"],
        .deck-selected {
          border-radius: 0 !important;
        }

        #tabbrowser-tabpanels {
          box-shadow: none !important;
        }

        #nav-bar,
        #TabsToolbar,
        #PersonalToolbar,
        #titlebar,
        #navigator-toolbox {
          border-radius: 0 !important;
        }

        #navigator-toolbox {
          border-bottom: 1px solid color-mix(in srgb, currentColor 20%, transparent) !important;
        }

        scrollbar,
        scrollbar thumb,
        scrollcorner {
          border-radius: 0 !important;
        }

        notification-message,
        .notificationbox-stack,
        .messageText,
        .infobar,
        message-bar {
          border-radius: 0 !important;
        }

      '';

    };
  };

  programs.firefox.profiles.default.extensions.force = true;

  stylix.targets.firefox = {
    enable = true;
    profileNames = [ "default" ];
    colorTheme.enable = true;
  };

  programs.chromium = {
    enable = true;
  };
}
