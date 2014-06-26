# ==========================================
# Copyright 2014 Hatio, Lab.
# Licensed under The MIT License
# http://opensource.org/licenses/MIT
# ==========================================

define [
], (
) ->

  Global =

    version: '@@version'

    # private
    listenClickTap: false
    inDblClickWindow: false

    # configurations
    enableTrace: false
    traceArrMax: 100
    dblClickWindow: 400

    #
    # Global pixel ratio configuration. thingsJS automatically detect pixel ratio of current device.
    # But you may override such property, if you want to use your value.
    # @property
    # @default undefined
    # @memberof things
    # @example
    # things.pixelRatio = 1;
    #
    pixelRatio: undefined

    #
    # Drag distance property. If you start to drag a node you may want to wait until pointer is moved to some distance from start point,
    # only then start dragging.
    # @property
    # @default 0
    # @memberof things
    # @example
    # things.dragDistance = 10;
    #
    dragDistance : 0

    #
    # Use degree values for angle properties. You may set this property to false if you want to use radiant values.
    # @property
    # @default true
    # @memberof things
    # @example
    # node.rotation(45); # 45 degrees
    # things.angleDeg = false;
    # node.rotation(Math.PI / 2); # PI/2 radian
    #
    angleDeg: true

    #**
    # Show different warnings about errors or wrong API usage
    # @property
    # @default true
    # @memberof things
    # @example
    # things.showWarnings = false;
    #
    showWarnings : true

    #
    # @namespace Filters
    # @memberof things
    #
    Filters: {}

    #
    # returns whether or not drag and drop is currently active
    # @method
    # @memberof things
    #

    isDragging: ->
      dd = things.DD

      # if DD is not included with the build, then
      # drag and drop is not even possible
      return false if !dd
      # if DD is included with the build
      dd.isDragging
    #
    # returns whether or not a drag and drop operation is ready, but may
    #  not necessarily have started
    # @method
    # @memberof things
    #

    isDragReady: ->
      dd = things.DD

      # if DD is not included with the build, then
      # drag and drop is not even possible
      return false if !dd
      # if DD is included with the build
      !!dd.node;

    _parseUA: (userAgent) ->
      ua = userAgent.toLowerCase()
      # jQuery UA regex
      match = /(chrome)[ \/]([\w.]+)/.exec( ua ) ||
        /(webkit)[ \/]([\w.]+)/.exec( ua ) ||
        /(opera)(?:.*version|)[ \/]([\w.]+)/.exec( ua ) ||
        /(msie) ([\w.]+)/.exec( ua ) ||
        ua.indexOf('compatible') < 0 && /(mozilla)(?:.*? rv:([\w.]+)|)/.exec( ua ) ||
        []

      mobile = !!(userAgent.match(/Android|BlackBerry|iPhone|iPad|iPod|Opera Mini|IEMobile/i))
      ieMobile = !!(userAgent.match(/IEMobile/i))

      return {
        browser: match[ 1 ] || ''
        version: match[ 2 ] || '0'

        mobile: mobile
        ieMobile: ieMobile  # If this is true (i.e., WP8), then things touch events are executed instead of equivalent things mouse events
      }

    UA: undefined

  Global.UA = Global._parseUA((navigator && navigator.userAgent) || '')

  console.log 'UA', Global.UA

  Global
