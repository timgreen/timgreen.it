/**
 * Module Interface.
 */

goog.provide('it.timgreen.launcher.PageModule');

goog.require('goog.dom');
goog.require('it.timgreen.launcher.BaseLauncher');



/**
 * Page Module Interface.
 *
 * For modules only available on specific page.
 * If required id is existed, then init it self.
 *
 * @param {string} domId Dom id to check.
 *
 * @constructor
 * @extends {it.timgreen.launcher.BaseLauncher}
 */
it.timgreen.launcher.PageModule = function(domId) {
  /**
   * @type {string}
   * @private
   */
  this.domId_ = domId;

  goog.base(this);
};
goog.inherits(it.timgreen.launcher.PageModule, it.timgreen.launcher.BaseLauncher);


/**
 * Init.
 *
 * @param {Object=} opt_jsonData json data.
 */
it.timgreen.launcher.PageModule.prototype.init = function(opt_jsonData) {
  if (this.shouldInit(this.domId_)) {
    this.initModule(opt_jsonData || {});
  }
};


/**
 * Init Module.
 *
 * @param {Object} jsonData json data.
 *
 * @protected
 */
it.timgreen.launcher.PageModule.prototype.initModule = function(jsonData) {
  throw Error('unimplemented abstract method: initModule');
};
