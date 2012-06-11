goog.provide('it.timgreen.launcher.BaseLauncher');



/**
 * BaseLauncher, all launcher should inherits this.
 *
 * @constructor
 */
it.timgreen.launcher.BaseLauncher = function() {
};


/**
 * Return true if should init this module.
 *
 * @param {string} id the need check element id.
 *
 * @return {boolean} if init launcher.
 */
it.timgreen.launcher.BaseLauncher.prototype.shouldInit = function(id) {
  return Boolean(goog.dom.getElement(id));
};
