goog.provide('it.timgreen.toc.TocScrollbarModule');

goog.require('goog.dom');
goog.require('it.timgreen.launcher.PageModule');
goog.require('it.timgreen.toc.TocScrollbar');



/**
 * Toc scrollbar module.
 *
 * Enable toc scrollbar on blog article page.
 *
 * @constructor
 * @extends {it.timgreen.launcher.PageModule}
 */
it.timgreen.toc.TocScrollbarModule = function() {
  goog.base(this, 'blog-article');
};
goog.inherits(it.timgreen.toc.TocScrollbarModule, it.timgreen.launcher.PageModule);


/**
 * Init Module.
 *
 * @param {Object} jsonData json data.
 *
 * @override
 */
it.timgreen.toc.TocScrollbarModule.prototype.initModule = function(jsonData) {
  var content = goog.dom.getElement('content');
  var container = goog.dom.getElement('scrollbar-toc');
  new it.timgreen.toc.TocScrollbar(container, content);
};
