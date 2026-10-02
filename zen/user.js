// SSO
user_pref("network.negotiate-auth.trusted-uris", ".redhat.com");

// DNS: IPv6 fails over VPN (wt0 tunnel), consider removing when VPN is fixed
user_pref("network.dns.preferIPv4", true);

user_pref("plain_text.wrap_long_lines", false);
user_pref("zen.urlbar.behavior", "normal");
user_pref("browser.sessionstore.restore_on_demand", false);
user_pref("browser.tabs.splitView.enabled", false);
user_pref("toolkit.tabbox.switchByScrolling", true);
user_pref("zen.splitView.enable-tab-drop", false);
user_pref("zen.view.sidebar-expanded", false);
