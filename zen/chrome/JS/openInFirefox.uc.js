// ==UserScript==
// @name           Open in Firefox
// @description    Adds context menu item and Glance button to open links in Firefox
// ==/UserScript==

(function() {
  function xdgOpen(url) {
    if (!url) return;
    let process = Cc["@mozilla.org/process/util;1"].createInstance(Ci.nsIProcess);
    let file = Cc["@mozilla.org/file/local;1"].createInstance(Ci.nsIFile);
    file.initWithPath("/usr/bin/xdg-open");
    process.init(file);
    process.run(false, [url], 1);
  }

  // Context menu item
  const menuId = "context-openinfirefox";
  document.getElementById("contentAreaContextMenu").addEventListener("popupshowing", function() {
    let item = document.getElementById(menuId);
    if (!item) {
      let refItem = document.getElementById("context-openlinkintab");
      item = document.createXULElement("menuitem");
      item.id = menuId;
      item.setAttribute("label", "Open Link in Firefox");
      item.addEventListener("command", () => xdgOpen(gContextMenu.linkURL));
      refItem.parentNode.insertBefore(item, refItem.nextSibling);
    }
    item.hidden = !gContextMenu.onLink;
  });

  // Glance sidebar button — inject into live DOM when Glance panels appear
  let observer = new MutationObserver(mutations => {
    for (let mutation of mutations) {
      for (let node of mutation.addedNodes) {
        if (!(node instanceof Element)) continue;
        let containers = node.matches?.(".zen-glance-sidebar-container")
          ? [node]
          : [...(node.querySelectorAll?.(".zen-glance-sidebar-container") || [])];
        for (let container of containers) {
          if (container.querySelector(".zen-glance-sidebar-firefox")) continue;
          let btn = document.createXULElement("toolbarbutton", {is: "toolbarbutton"});
          btn.className = "zen-glance-sidebar-firefox toolbarbutton-1";
          btn.setAttribute("tooltiptext", "Open in Firefox");
          // Manually create inner structure since createXULElement doesn't auto-populate it
          let icon = document.createXULElement("image");
          icon.className = "toolbarbutton-icon";
          icon.setAttribute("src", "chrome://browser/skin/zen-icons/open.svg");
          icon.style.cssText = "-moz-context-properties: fill, fill-opacity !important; fill: currentColor !important;";
          let label = document.createXULElement("label");
          label.className = "toolbarbutton-text";
          label.setAttribute("crop", "end");
          label.setAttribute("flex", "1");
          btn.appendChild(icon);
          btn.appendChild(label);
          btn.addEventListener("click", () => {
            let browser = gBrowser.selectedBrowser;
            if (browser) xdgOpen(browser.currentURI.spec);
            document.getElementById("cmd_zenGlanceClose").doCommand();
          });
          container.appendChild(btn);
        }
      }
    }
  });
  observer.observe(document.documentElement, { childList: true, subtree: true });
})();
