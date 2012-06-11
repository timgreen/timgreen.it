goog.provide('it.timgreen.toc.TableOfContent');
goog.provide('it.timgreen.toc.TableOfContentItem');

goog.require('goog.Disposable');
goog.require('goog.array');
goog.require('goog.dom');


/**
 * Table of content.
 *
 * @constructor
 * @extends {goog.Disposable}
 *
 * @param {Element} el the main content area to generate table of content.
 */
it.timgreen.toc.TableOfContent = function(el) {
  goog.base(this);
  this.el_ = el;
  this.generate_();
};
goog.inherits(it.timgreen.toc.TableOfContent, goog.Disposable);


/**
 * Generate table of content from main content area.
 *
 * Will look into chirdren of given element, find out all <h?> with attr "id".
 *
 * @private
 */
it.timgreen.toc.TableOfContent.prototype.generate_ = function() {
  var list = [];
  goog.array.forEach(this.el_.children, function(el) {
    switch (el.tagName) {
      case 'H1':
      case 'H2':
      case 'H3':
      case 'H4':
      case 'H5':
      case 'H6':
        if (el.id) {
          var item = new it.timgreen.toc.TableOfContentItem(el);
          list.push(item);
          this.registerDisposable(item);
        }
        break;
    }
  }, this);
  this.list_ = list;
};


/**
 * Return table of content item.
 *
 * @return {Array.<it.timgreen.toc.TableOfContentItem>} table of content item.
 */
it.timgreen.toc.TableOfContent.prototype.getList = function() {
  return this.list_;
};


/**
 * @override
 * @protected
 */
it.timgreen.toc.TableOfContent.prototype.disposeInternal = function() {
  goog.base(this, 'disposeInternal');
  delete this.el_;
  delete this.list_;
}


/**
 * Table of content item.
 *
 * @constructor
 * @extends {goog.Disposable}
 *
 * @param {Element} el the header for table of content item.
 */
it.timgreen.toc.TableOfContentItem = function(el) {
  this.h_ = el;
  this.title_ = goog.dom.getTextContent(el);
  this.archor_ = el.id;
  this.level_ = el.tagName[1] - '0';
};
goog.inherits(it.timgreen.toc.TableOfContentItem, goog.Disposable);


/**
 * Return header item.
 *
 * @return {Element} header.
 */
it.timgreen.toc.TableOfContentItem.prototype.getHeader = function() {
  return this.h_;
};


/**
 * Return title.
 *
 * @return {string} title.
 */
it.timgreen.toc.TableOfContentItem.prototype.getTitle = function() {
  return this.title_;
};


/**
 * Return archor.
 *
 * @return {string} archor.
 */
it.timgreen.toc.TableOfContentItem.prototype.getArchor = function() {
  return this.archor_;
};


/**
 * Return level.
 *
 * @return {number} level.
 */
it.timgreen.toc.TableOfContentItem.prototype.getLevel = function() {
  return this.level_;
};


/**
 * @override
 * @protected
 */
it.timgreen.toc.TableOfContentItem.prototype.disposeInternal = function() {
  goog.base(this, 'disposeInternal');
  delete this.h_;
}

