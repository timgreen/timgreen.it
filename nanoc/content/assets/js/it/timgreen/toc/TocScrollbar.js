goog.provide('it.timgreen.toc.TocScrollbar');

goog.require('goog.Disposable');
goog.require('goog.Timer');
goog.require('goog.array');
goog.require('goog.events');
goog.require('it.timgreen.toc.TableOfContent');



/**
 * Toc scrollbar.
 *
 * @constructor
 * @extends {goog.Disposable}
 *
 * @param {Element} container toc container.
 * @param {Element} el the main content area to generate table of content.
 */
it.timgreen.toc.TocScrollbar = function(container, el) {
  goog.base(this);
  this.container_ = container;
  this.el_ = el;
  this.init_();
  this.calcPosition_();
  this.startCheck_();
};
goog.inherits(it.timgreen.toc.TocScrollbar, goog.Disposable);


/**
 * Init.
 *
 * @private
 */
it.timgreen.toc.TocScrollbar.prototype.init_ = function() {
  this.toc_ = new it.timgreen.toc.TableOfContent(this.el_);
  goog.array.forEach(this.toc_.getList(), function(item) {
    var li = goog.dom.createElement('LI');
    li.id = 'toc-' + item.getArchor();
    var link = goog.dom.createElement('A');
    link.href = "#" + item.getArchor();
    var text = goog.dom.createElement('SPAN');
    goog.dom.setTextContent(text, item.getTitle());
    link.appendChild(text);
    li.appendChild(link);
    this.container_.appendChild(li);
  }, this);
  var maxW = goog.array.reduce(this.container_.children, function(r, v) {
    return Math.max(r, v.offsetWidth);
  }, 0);
  var lastLi = goog.dom.createElement('LI');
  lastLi.style.width = maxW + 'px';
  this.container_.appendChild(lastLi);
  goog.dom.classes.add(this.container_, goog.getCssName('fold'));
};


/**
 * Calculate the position of each item.
 *
 * @private
 */
it.timgreen.toc.TocScrollbar.prototype.calcPosition_ = function() {
  var bodyH = document.body.clientHeight;
  var vh = goog.dom.getViewportSize().height;
  if ((this.bodyH_ === bodyH) && (this.vh_ === vh)) return;
  this.bodyH_ = bodyH;
  this.vh_ = vh;
  var halfLineHeight = 16 / 2;

  goog.array.forEach(this.toc_.getList(), function(item, i) {
    var top = this.getOffsetTop_(item.getHeader()) - halfLineHeight;
    if (vh < bodyH) {
      var p = Math.min(top / bodyH * 100, 100);
    } else {
      var p = Math.min(top / vh * 100, 100);
    }
    this.container_.children[i].style.top = p + '%';
  }, this);
};


/**
 * Return el offset top.
 *
 * @param {Element} el element
 *
 * @return {number} el offset top.
 *
 * @private
 */
it.timgreen.toc.TocScrollbar.prototype.getOffsetTop_ = function(el) {
  var t = 0;
  while (el.offsetParent) {
    t += el.offsetTop;
    el = el.offsetParent;
  }
  return t;
};


/**
 * Start check.
 *
 * @private
 */
it.timgreen.toc.TocScrollbar.prototype.startCheck_ = function() {
  this.timer_ = new goog.Timer(200);
  goog.events.listen(this.timer_, goog.Timer.TICK, this.calcPosition_, false, this);
  this.timer_.start();
};


/**
 * @override
 * @protected
 */
it.timgreen.toc.TocScrollbar.prototype.disposeInternal = function() {
  goog.base(this, 'disposeInternal');
  delete this.el_;
  delete this.container_;
  this.timer_.stop();
  goog.events.unlisten(this.timer_, goog.Timer.TICK, this.calcPosition_, false, this);
  delete this.timer_;
}
