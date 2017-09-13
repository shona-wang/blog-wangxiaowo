//# sourceURL=waterfall.js 
/**
 * jquery waterfall
 * @author wangxiaowo
 * @update 2016-10-13
 * @version 1.0
 * @parameters
 *     itemClass: the brick element class
 *     spacingWidth: the brick element horizontal spacing
 *     spacingHeight: the brick element vertical spacing
 *     minColCount: min columns
 *     resizeable: trigger positionAll() when browser window is resized
 *     itemAlign: the alignment of the brick element ( e.q. [center|left] )
 *     isFadeIn: fadeIn effect on loading
 *     send: callback when ajax loaded, two parameters ( success, end )
 */
(function ($, window, document, Math, undefined) {
    var $window = $(window),
        pluginName = "waterfall",
        defaults = {
            itemClass: "waterfall-item", // the brick element class
            spacingWidth: 10, // the brick element horizontal spacing
            spacingHeight: 10, // the brick element vertical spacing
            minColCount: 2, // min columns
            resizeable: false, // trigger positionAll() when browser window is resized
            itemAlign: "center", // the alignment of the brick element ( e.q. [center|left] )
            isFadeIn: true, // fadeIn effect on loading
            send: null // callback when ajax loaded, two parameters ( success, end )
        };
    var Waterfall = function (self, options) {
        this.$self = $(self);
        this.options = $.extend({},defaults,options);
        this.ajaxLoading = false; // is ajax loading
        this.colHeightArray = []; // height of each columns
        this._init();
    };
    Waterfall.prototype = {
        _init: function () {
            var $this = this;
            $this._positionAll();
            $window.on("scroll",function(){
                 $this._doScroll();
            });
            if (this.options.resizeable) {
                $window.on('resize', function () {
                    $this._positionAll();
                });
            }
        },
        _positionAll: function () {
            var $this = this,//this Waterfall
                $item = $(this.options.itemClass),
                minHeight,
                minIndex;
            $this._getColumnCount();
            $this.colHeightArray = [];
            $item.each(function (index, el) {
                $(this).css('position', "absolute");//this $("box")[0]
                if (index < $this.cols) {
                    $(this).css({
                        "top": 0,
                        "left": $this.leftOffset + index * $this.itemWidth + index * $this.options.spacingWidth
                    });
                    $this.colHeightArray.push($(this).outerHeight());
                } else {
                    minHeight = Math.min.apply(null, $this.colHeightArray);//Math.min($this.colHeightArray)
                    minIndex = $.inArray(minHeight, $this.colHeightArray);//返回$this.colHeightArray数组中值为minHeight的索引
                    var centerWidth = ($(document).width()-$this.$self.width())/2;
                    $(this).css({
                        "top": minHeight + $this.options.spacingHeight,
                        "left": $item.eq(minIndex).offset().left-centerWidth
                    });
                    $this.colHeightArray[minIndex] += $(this).outerHeight() + $this.options.spacingHeight;
                }
                if ($this.options.isFadeIn) {
                    $(this).animate({"opacity": 1}, 300);
                }
            });
            this.$self.css("height", Math.max.apply(null, $this.colHeightArray));
        },
        _getColumnCount: function () {
            var parentWidth = this.$self.width(),
                $item = $(this.options.itemClass),
                itemWidth = $item.eq(0).outerWidth(),
                iCol = Math.floor(parentWidth / (itemWidth + this.options.spacingWidth)),
                realWidth = 0,
                leftOffset = 0;
            iCol = iCol > this.options.minColCount ? iCol : this.options.minColCount;
            realWidth = iCol * itemWidth;
            if (parentWidth > realWidth) {
                leftOffset = Math.floor((parentWidth - realWidth - iCol * this.options.spacingWidth) / 2);
            }
            this.itemWidth = itemWidth;
            this.cols = iCol;
            this.leftOffset = this.options.itemAlign == "center" ? leftOffset : 0;
        },
        _doScroll: function () {
            var $this = this,
                scrollTimer;
            if(scrollTimer){
                clearTimeout(scrollTimer);
            }
            scrollTimer = setTimeout(function(){
                var $last = $($this.options.itemClass).last(),
                    scrollTop = $window.scrollTop() + $window.height();
                if(!$this.ajaxLoading && scrollTop > $last.offset().top + $last.outerHeight()/2){
                    $this.ajaxLoading = true;
                    $this.options.send && $this.options.send(
                        function() {
                            $this._positionAll();
                        },
                        function() {
                            $this.ajaxLoading = false;
                        }
                    );
                }
            },100);
        }
    };
    $.fn[pluginName] = function (options) {
        this.each(function (index, el) {
            if (!$.data(this, "plugin-" + pluginName)) {
                $.data(this, "plugin-" + pluginName, new Waterfall(this, options));
            }
        });
        return this;
    };
})(jQuery, window, document, Math);