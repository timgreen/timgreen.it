goog.provide('it.timgreen.Launcher');

goog.require('it.timgreen.launcher.BaseLauncher');
goog.require('it.timgreen.toc.TocScrollbarModule');


/**
 * Entry point.
 */
it.timgreen.Launcher.init = function() {
  /**
   * Keep modules in alphabeta order.
   * @type {Array.<it.timgreen.launcher.BaseLauncher>}
   */
  var launchers = [
    new it.timgreen.toc.TocScrollbarModule()
  ];
  goog.array.forEach(launchers, function(launcher) {
    if (!COMPILED) {
      launcher.init();
    } else {
      try {
        launcher.init();
      } catch (e) {
        // ignore
      }
    }
  });
};


goog.exportSymbol('it.timgreen.Launcher.init', it.timgreen.Launcher.init);
