/*! Things v0.0.0 | (c) Hatio, Lab. | MIT License */
(function webpackUniversalModuleDefinition(root, factory) {
	if(typeof exports === 'object' && typeof module === 'object')
		module.exports = factory(require("_"));
	else if(typeof define === 'function' && define.amd)
		define(["_"], factory);
	else if(typeof exports === 'object')
		exports["things"] = factory(require("_"));
	else
		root["things"] = factory(root["_"]);
})(this, function(__WEBPACK_EXTERNAL_MODULE_14__) {
return /******/ (function(modules) { // webpackBootstrap
/******/ 	// The module cache
/******/ 	var installedModules = {};
/******/
/******/ 	// The require function
/******/ 	function __webpack_require__(moduleId) {
/******/
/******/ 		// Check if module is in cache
/******/ 		if(installedModules[moduleId])
/******/ 			return installedModules[moduleId].exports;
/******/
/******/ 		// Create a new module (and put it into the cache)
/******/ 		var module = installedModules[moduleId] = {
/******/ 			exports: {},
/******/ 			id: moduleId,
/******/ 			loaded: false
/******/ 		};
/******/
/******/ 		// Execute the module function
/******/ 		modules[moduleId].call(module.exports, module, module.exports, __webpack_require__);
/******/
/******/ 		// Flag the module as loaded
/******/ 		module.loaded = true;
/******/
/******/ 		// Return the exports of the module
/******/ 		return module.exports;
/******/ 	}
/******/
/******/
/******/ 	// expose the modules object (__webpack_modules__)
/******/ 	__webpack_require__.m = modules;
/******/
/******/ 	// expose the module cache
/******/ 	__webpack_require__.c = installedModules;
/******/
/******/ 	// __webpack_public_path__
/******/ 	__webpack_require__.p = "";
/******/
/******/ 	// Load entry module and return exports
/******/ 	return __webpack_require__(0);
/******/ })
/************************************************************************/
/******/ ([
/* 0 */
/***/ function(module, exports, __webpack_require__) {

var __WEBPACK_AMD_DEFINE_ARRAY__, __WEBPACK_AMD_DEFINE_RESULT__;!(__WEBPACK_AMD_DEFINE_ARRAY__ = [__webpack_require__(1)], __WEBPACK_AMD_DEFINE_RESULT__ = (function(Controller) {
  'use strict';
  var stages;
  stages = [];
  return {
    create: function(options) {
      var stage;
      stage = new Controller(options).getStage();
      stages.push(stage);
      return stage;
    },
    destroy: function(stage) {
      var idx;
      idx = stages.indexOf(stage);
      if (idx > -1) {
        stages.splice(idx, 1);
      }
      return stage.dispose();
    },
    stages: function() {
      return stages;
    }
  };
}.apply(null, __WEBPACK_AMD_DEFINE_ARRAY__)), __WEBPACK_AMD_DEFINE_RESULT__ !== undefined && (module.exports = __WEBPACK_AMD_DEFINE_RESULT__));


/***/ },
/* 1 */
/***/ function(module, exports, __webpack_require__) {

var __WEBPACK_AMD_DEFINE_ARRAY__, __WEBPACK_AMD_DEFINE_RESULT__;!(__WEBPACK_AMD_DEFINE_ARRAY__ = [__webpack_require__(3), __webpack_require__(2), __webpack_require__(4), __webpack_require__(5), __webpack_require__(6), __webpack_require__(7), __webpack_require__(8), __webpack_require__(9), __webpack_require__(10), __webpack_require__(11), __webpack_require__(12), __webpack_require__(13)], __WEBPACK_AMD_DEFINE_RESULT__ = (function(_, Global, Component, ComponentRegistry, ComponentSelector, ComponentFactory, EventEngine, MouseEventEngine, TouchEventEngine, ExportsManager, CommandManager, ControllerHandler) {
  'use strict';
  var Controller;
  Component.include({
    setController: function(controller) {
      return this.controller = controller;
    },
    getController: function() {
      return this.controller;
    },
    getStage: function() {
      return this.controller.getStage();
    },
    setSpec: function(spec) {
      return this.spec = spec;
    },
    getSpec: function() {
      return this.spec;
    },
    build: function(model, container) {
      return this.controller.build(model, container || this);
    },
    require: function(plugin) {
      if (!this.controller) {
        throw new Error('controller not initialized');
      }
      return this.controller.require(plugin);
    },
    select: function(selector, target) {
      if (!this.controller) {
        throw new Error('controller not initialized');
      }
      return this.controller.select(selector, target);
    },
    abs: function(v) {
      var container, rel;
      rel = this.get(v) || 0;
      container = this.getContainer();
      if (container) {
        rel += container.abs(v) || 0;
      }
      return rel;
    },
    debug: function(category, text) {
      return this.require('debug-layer').debug(category, text);
    }
  });
  Controller = (function() {
    function Controller(options) {
      this.options = _.clone(options);
      this.exports = {};
      this.exportsManager = new ExportsManager(this);
      this.commandManager = new CommandManager();
      this.componentRegistry = new ComponentRegistry;
      this.componentRegistry.setRegisterCallback(function(spec) {
        return this.exportsManager["import"](spec.type, spec.exports);
      }, this);
      this.componentRegistry.setUnregisterCallback(function(spec) {
        return this.exportsManager.remove(spec.type);
      }, this);
      this.eventEngine = new EventEngine;
      this.componentFactory = new ComponentFactory(this.componentRegistry, this);
      this.stage = this.componentFactory.createModel(options);
      this.eventEngine.setRoot(this.stage);
      if (this.stage.event_map) {
        this.eventEngine.add(this.stage, this.stage.event_map(), this.stage);
      }
      this.eventEngine.add(this, ControllerHandler, this);
      this.componentFactory.setupDescendant(this.stage);
      if (!Global.mobile) {
        this.mouseEvent = new MouseEventEngine(this.stage);
      }
      this.touchEvent = new TouchEventEngine(this.stage);
    }

    Controller.prototype.setStage = function(stage) {
      return this.stage = stage;
    };

    Controller.prototype.getStage = function() {
      return this.stage;
    };

    Controller.prototype.build = function(model, onto_container) {
      return this.componentFactory.build(model, onto_container);
    };

    Controller.prototype.select = function(selector, root) {
      return ComponentSelector.select(selector, root || this.stage);
    };

    Controller.prototype["import"] = function(type, exports, binder) {
      return this.exportsManager["import"](type, exports, binder);
    };

    Controller.prototype.require = function(type) {
      return this.exportsManager.require(type);
    };

    Controller.prototype.dispose = function() {
      this.componentFactory.dispose();
      this.comandManager.dispose();
      this.eventEngine.dispose();
      this.componentRegistry.dispose();
      if (this.mouseEvent) {
        this.mouseEvent.dispose();
      }
      this.touchEvent.dispose();
      return this.exportsManager.dispose();
    };

    return Controller;

  })();
  return Controller;
}.apply(null, __WEBPACK_AMD_DEFINE_ARRAY__)), __WEBPACK_AMD_DEFINE_RESULT__ !== undefined && (module.exports = __WEBPACK_AMD_DEFINE_RESULT__));


/***/ },
/* 2 */
/***/ function(module, exports, __webpack_require__) {

var __WEBPACK_AMD_DEFINE_ARRAY__, __WEBPACK_AMD_DEFINE_RESULT__;!(__WEBPACK_AMD_DEFINE_ARRAY__ = [], __WEBPACK_AMD_DEFINE_RESULT__ = (function() {
  var Global;
  Global = {
    version: '@@version',
    listenClickTap: false,
    inDblClickWindow: false,
    enableTrace: false,
    traceArrMax: 100,
    dblClickWindow: 400,
    pixelRatio: void 0,
    dragDistance: 0,
    angleDeg: true,
    showWarnings: true,
    Filters: {},
    isDragging: function() {
      var dd;
      dd = things.DD;
      if (!dd) {
        return false;
      }
      return dd.isDragging;
    },
    isDragReady: function() {
      var dd;
      dd = things.DD;
      if (!dd) {
        return false;
      }
      return !!dd.node;
    },
    _parseUA: function(userAgent) {
      var ieMobile, match, mobile, ua;
      ua = userAgent.toLowerCase();
      match = /(chrome)[ \/]([\w.]+)/.exec(ua) || /(webkit)[ \/]([\w.]+)/.exec(ua) || /(opera)(?:.*version|)[ \/]([\w.]+)/.exec(ua) || /(msie) ([\w.]+)/.exec(ua) || ua.indexOf('compatible') < 0 && /(mozilla)(?:.*? rv:([\w.]+)|)/.exec(ua) || [];
      mobile = !!(userAgent.match(/Android|BlackBerry|iPhone|iPad|iPod|Opera Mini|IEMobile/i));
      ieMobile = !!(userAgent.match(/IEMobile/i));
      return {
        browser: match[1] || '',
        version: match[2] || '0',
        mobile: mobile,
        ieMobile: ieMobile
      };
    },
    UA: void 0
  };
  Global.UA = Global._parseUA((navigator && navigator.userAgent) || '');
  console.log('UA', Global.UA);
  return Global;
}.apply(null, __WEBPACK_AMD_DEFINE_ARRAY__)), __WEBPACK_AMD_DEFINE_RESULT__ !== undefined && (module.exports = __WEBPACK_AMD_DEFINE_RESULT__));


/***/ },
/* 3 */
/***/ function(module, exports, __webpack_require__) {

var __WEBPACK_AMD_DEFINE_ARRAY__, __WEBPACK_AMD_DEFINE_RESULT__;!(__WEBPACK_AMD_DEFINE_ARRAY__ = [__webpack_require__(14)], __WEBPACK_AMD_DEFINE_RESULT__ = (function(_) {
  'use strict';
  return _;
}.apply(null, __WEBPACK_AMD_DEFINE_ARRAY__)), __WEBPACK_AMD_DEFINE_RESULT__ !== undefined && (module.exports = __WEBPACK_AMD_DEFINE_RESULT__));


/***/ },
/* 4 */
/***/ function(module, exports, __webpack_require__) {

var __WEBPACK_AMD_DEFINE_ARRAY__, __WEBPACK_AMD_DEFINE_RESULT__;var __hasProp = {}.hasOwnProperty,
  __extends = function(child, parent) { for (var key in parent) { if (__hasProp.call(parent, key)) child[key] = parent[key]; } function ctor() { this.constructor = child; } ctor.prototype = parent.prototype; child.prototype = new ctor(); child.__super__ = parent.prototype; return child; };

!(__WEBPACK_AMD_DEFINE_ARRAY__ = [__webpack_require__(15), __webpack_require__(19), __webpack_require__(20), __webpack_require__(21), __webpack_require__(22)], __WEBPACK_AMD_DEFINE_RESULT__ = (function(Module, WithProperty, WithLifeCycle, WithEvent, Serializable) {
  "use strict";
  var Component;
  return Component = (function(_super) {
    __extends(Component, _super);

    Component.include(WithProperty);

    Component.include(WithLifeCycle);

    Component.include(WithEvent);

    function Component(type, container) {
      this.type = type;
      this.container = container;
    }

    Component.prototype.getType = function() {
      return this.type;
    };

    Component.prototype.dispose = function() {
      return this.setContainer(null);
    };

    Component.prototype.getContainer = function() {
      return this.container;
    };

    Component.prototype.setContainer = function(container) {
      if (container === this.container) {
        return;
      }
      if (this.container) {
        this.container.remove(this);
      }
      this.container = container;
      if (this.container) {
        return this.container.add(this);
      }
    };

    Component.prototype.moveAt = function(index) {
      if (!this.getContainer()) {
        return;
      }
      return this.container.moveChildAt(index, this);
    };

    Component.prototype.moveForward = function() {
      if (!this.getContainer()) {
        return;
      }
      return this.container.moveChildForward(this);
    };

    Component.prototype.moveBackward = function() {
      if (!this.getContainer()) {
        return;
      }
      return this.container.moveChildBackward(this);
    };

    Component.prototype.moveToFront = function() {
      if (!this.getContainer()) {
        return;
      }
      return this.container.moveChildToFront(this);
    };

    Component.prototype.moveToBack = function() {
      if (!this.getContainer()) {
        return;
      }
      return this.container.moveChildToBack(this);
    };

    return Component;

  })(Module);
}.apply(null, __WEBPACK_AMD_DEFINE_ARRAY__)), __WEBPACK_AMD_DEFINE_RESULT__ !== undefined && (module.exports = __WEBPACK_AMD_DEFINE_RESULT__));


/***/ },
/* 5 */
/***/ function(module, exports, __webpack_require__) {

var __WEBPACK_AMD_DEFINE_ARRAY__, __WEBPACK_AMD_DEFINE_RESULT__;var __hasProp = {}.hasOwnProperty;

!(__WEBPACK_AMD_DEFINE_ARRAY__ = [__webpack_require__(3)], __WEBPACK_AMD_DEFINE_RESULT__ = (function(_) {
  'use strict';
  var ComponentRegistry;
  return ComponentRegistry = (function() {
    function ComponentRegistry() {
      this.componentSpecs = {};
    }

    ComponentRegistry.prototype.dispose = function() {
      var keys, type, _i, _len, _results;
      keys = Object.keys(this.componentSpecs);
      _results = [];
      for (_i = 0, _len = keys.length; _i < _len; _i++) {
        type = keys[_i];
        _results.push(this.unregister(type));
      }
      return _results;
    };

    ComponentRegistry.prototype.setRegisterCallback = function(callback, context) {
      return this.callback_register = typeof callback === 'function' ? callback.bind(context) : void 0;
    };

    ComponentRegistry.prototype.setUnregisterCallback = function(callback, context) {
      return this.callback_unregister = typeof callback === 'function' ? callback.bind(context) : void 0;
    };

    ComponentRegistry.prototype.register = function(klass) {
      var depspec, i, name, props, _i, _len, _ref, _ref1;
      if (this.componentSpecs[klass.spec.type]) {
        return;
      }
      if (klass.spec.dependencies) {
        _ref = klass.spec.dependencies;
        for (name in _ref) {
          depspec = _ref[name];
          this.register(depspec);
        }
      }
      if (klass.spec.properties instanceof Array) {
        props = {};
        _ref1 = klass.spec.properties;
        for (_i = 0, _len = _ref1.length; _i < _len; _i++) {
          i = _ref1[_i];
          _.merge(props, i);
        }
        klass.spec.properties = props;
      }
      this.componentSpecs[klass.spec.type] = klass;
      if (this.callback_register) {
        return this.callback_register(klass.spec);
      }
    };

    ComponentRegistry.prototype.unregister = function(type) {
      var spec;
      spec = this.componentSpecs[type];
      if (!spec) {
        return;
      }
      delete this.componentSpecs[type];
      if (this.callback_unregister) {
        this.callback_unregister(spec);
      }
      return spec;
    };

    ComponentRegistry.prototype.forEach = function(fn, context) {
      var name, spec, _ref, _results;
      _ref = this.componentSpecs;
      _results = [];
      for (name in _ref) {
        if (!__hasProp.call(_ref, name)) continue;
        spec = _ref[name];
        _results.push(fn.call(context, name, spec));
      }
      return _results;
    };

    ComponentRegistry.prototype.list = function(filter) {
      return Object.keys(this.componentSpecs).map(function(key) {
        return this.componentSpecs[key];
      }, this);
    };

    ComponentRegistry.prototype.get = function(type) {
      var spec;
      spec = this.componentSpecs[type];
      if (spec) {
        return _.clone(this.componentSpecs[type]);
      } else {
        return null;
      }
    };

    return ComponentRegistry;

  })();
}.apply(null, __WEBPACK_AMD_DEFINE_ARRAY__)), __WEBPACK_AMD_DEFINE_RESULT__ !== undefined && (module.exports = __WEBPACK_AMD_DEFINE_RESULT__));


/***/ },
/* 6 */
/***/ function(module, exports, __webpack_require__) {

var __WEBPACK_AMD_DEFINE_ARRAY__, __WEBPACK_AMD_DEFINE_RESULT__;!(__WEBPACK_AMD_DEFINE_ARRAY__ = [__webpack_require__(4), __webpack_require__(16)], __WEBPACK_AMD_DEFINE_RESULT__ = (function(Component, Container) {
  "use strict";
  var match, match_by_id, match_by_name, match_by_special, match_by_type, select, select_recurse;
  match_by_id = function(selector, component, listener, root) {
    return (selector.substr(1)) === component.get('id');
  };
  match_by_name = function(selector, component, listener, root) {
    return (selector.substr(1)) === component.get('name');
  };
  match_by_special = function(selector, component, listener, root) {
    switch (selector) {
      case '(all)':
        return true;
      case '(self)':
        return listener === component;
      case '(root)':
        return root === component;
      default:
        return false;
    }
  };
  match_by_type = function(selector, component, listener, root) {
    return (selector === 'all') || (selector === component.type);
  };
  match = function(selector, component, listener, root) {
    if (selector === '(all)') {
      return true;
    }
    switch (selector.charAt(0)) {
      case '#':
        return match_by_id(selector, component, listener, root);
      case '.':
        return match_by_name(selector, component, listener, root);
      case '(':
        return match_by_special(selector, component, listener, root);
      default:
        return match_by_type(selector, component, listener, root);
    }
  };
  select_recurse = function(matcher, selector, component, listener, root, result) {
    if (matcher(selector, component, listener, root)) {
      result.push(component);
    }
    if (component instanceof Container) {
      component.forEach(function(child) {
        return select_recurse(matcher, selector, child, listener, root, result);
      });
    }
    return result;
  };
  select = function(selector, component, listener) {
    var matcher;
    if (selector === '(root)') {
      return [component];
    }
    if (selector === '(self)') {
      return [listener];
    }
    matcher = (function() {
      switch (selector.charAt(0)) {
        case '#':
          return match_by_id;
        case '.':
          return match_by_name;
        case '(':
          return match_by_special;
        default:
          return match_by_type;
      }
    })();
    return select_recurse(matcher, selector, component, listener, component, []);
  };
  return {
    select: select,
    match: match
  };
}.apply(null, __WEBPACK_AMD_DEFINE_ARRAY__)), __WEBPACK_AMD_DEFINE_RESULT__ !== undefined && (module.exports = __WEBPACK_AMD_DEFINE_RESULT__));


/***/ },
/* 7 */
/***/ function(module, exports, __webpack_require__) {

var __WEBPACK_AMD_DEFINE_ARRAY__, __WEBPACK_AMD_DEFINE_RESULT__;!(__WEBPACK_AMD_DEFINE_ARRAY__ = [__webpack_require__(3)], __WEBPACK_AMD_DEFINE_RESULT__ = (function(_) {
  'use strict';
  var ComponentFactory;
  return ComponentFactory = (function() {
    function ComponentFactory(componentRegistry, controller) {
      this.componentRegistry = componentRegistry;
      this.controller = controller;
    }

    ComponentFactory.prototype.dispose = function() {
      this.componentRegistry = null;
      return this.controller = null;
    };

    ComponentFactory.prototype.build = function(model, onto_container) {
      var component;
      component = this.createModel(model);
      if (onto_container) {
        onto_container.add(component);
      }
      this.setupDescendant(component, model.components);
      if (component.setup) {
        component.setup(model);
      }
      return component;
    };

    ComponentFactory.prototype.createModel = function(model) {
      var component, depspec, deptype, klass, _ref;
      if (model.dependencies) {
        _ref = model.dependencies;
        for (deptype in _ref) {
          depspec = _ref[deptype];
          this.componentRegistry.register(depspec);
        }
      }
      klass = this.componentRegistry.get(model.type);
      if (!klass) {
        throw new Error('module (' + model.type + ') is not registered yet.');
      }
      if (!model.attrs) {
        model.attrs = {};
      }
      if (!model.attrs.hasOwnProperty('id')) {
        model.attrs.id = _.uniqueId();
      }
      component = new klass(model.type).initialize(model.attrs, klass.spec.properties);
      component.setController(this.controller);
      if (component.init) {
        component.init(model);
      }
      return component;
    };

    ComponentFactory.prototype.setupDescendant = function(container, components) {
      var c, klass, spec, _i, _j, _len, _len1, _ref;
      klass = this.componentRegistry.get(container.type);
      spec = klass.spec;
      if (spec.components) {
        _ref = spec.components;
        for (_i = 0, _len = _ref.length; _i < _len; _i++) {
          c = _ref[_i];
          this.build(c, container);
        }
      }
      if (components) {
        for (_j = 0, _len1 = components.length; _j < _len1; _j++) {
          c = components[_j];
          this.build(c, container);
        }
      }
      return container;
    };

    return ComponentFactory;

  })();
}.apply(null, __WEBPACK_AMD_DEFINE_ARRAY__)), __WEBPACK_AMD_DEFINE_RESULT__ !== undefined && (module.exports = __WEBPACK_AMD_DEFINE_RESULT__));


/***/ },
/* 8 */
/***/ function(module, exports, __webpack_require__) {

var __WEBPACK_AMD_DEFINE_ARRAY__, __WEBPACK_AMD_DEFINE_RESULT__;var __hasProp = {}.hasOwnProperty;

!(__WEBPACK_AMD_DEFINE_ARRAY__ = [__webpack_require__(3), __webpack_require__(17), __webpack_require__(6)], __WEBPACK_AMD_DEFINE_RESULT__ = (function(_, EventPump, ComponentSelector) {
  "use strict";
  var EventEngine;
  EventEngine = (function() {
    function EventEngine(root) {
      this.eventMaps = [];
      this.setRoot(root);
    }

    EventEngine.prototype.setRoot = function(root) {
      return this.root = root;
    };

    EventEngine.prototype.stop = function() {
      var item, _i, _len, _ref, _results;
      _ref = this.eventMaps;
      _results = [];
      for (_i = 0, _len = _ref.length; _i < _len; _i++) {
        item = _ref[_i];
        _results.push(item.eventPump.stop());
      }
      return _results;
    };

    EventEngine.prototype.add = function(listener, handlerMaps, context) {
      var eventPump, handlerMap, handlers, selector, target, targets, value, variable, _i, _len, _results;
      if (!this.root) {
        return;
      }
      if (!(handlerMaps instanceof Array)) {
        this.add(listener, [handlerMaps], context);
        return;
      }
      _results = [];
      for (_i = 0, _len = handlerMaps.length; _i < _len; _i++) {
        handlerMap = handlerMaps[_i];
        _results.push((function() {
          var _results1;
          _results1 = [];
          for (selector in handlerMap) {
            if (!__hasProp.call(handlerMap, selector)) continue;
            handlers = handlerMap[selector];
            if (selector.indexOf('?') === 0) {
              variable = selector.substr(1);
              value = listener.get(variable);
              if (value) {
                selector = value;
              } else {
                console.log("EventEngine#add", "variable " + selector + " is not evaluated on listener");
                continue;
              }
            }
            targets = ComponentSelector.select(selector, this.root, listener);
            _results1.push((function() {
              var _j, _len1, _results2;
              _results2 = [];
              for (_j = 0, _len1 = targets.length; _j < _len1; _j++) {
                target = targets[_j];
                eventPump = new EventPump(target);
                eventPump.on(listener, handlers);
                eventPump.start(context);
                _results2.push(this.eventMaps.push({
                  eventPump: eventPump,
                  listener: listener,
                  handlerMap: handlerMap,
                  target: target
                }));
              }
              return _results2;
            }).call(this));
          }
          return _results1;
        }).call(this));
      }
      return _results;
    };

    EventEngine.prototype.remove = function(listener, handlerMap) {
      var index, item, maps, _i, _len, _results;
      maps = _.clone(this.eventMaps);
      _results = [];
      for (index = _i = 0, _len = maps.length; _i < _len; index = ++_i) {
        item = maps[index];
        if (item.listener === listener && (!handlerMap || item.handlerMap === handlerMap)) {
          this.eventMaps.splice(index, 1);
          _results.push(item.eventPump.dispose());
        } else {
          _results.push(void 0);
        }
      }
      return _results;
    };

    EventEngine.prototype.clear = function() {
      var eventMap, maps, _i, _len;
      maps = _.clone(this.eventMaps);
      for (_i = 0, _len = maps.length; _i < _len; _i++) {
        eventMap = maps[_i];
        eventMap.eventPump.dispose();
      }
      return this.eventMaps = [];
    };

    EventEngine.prototype.dispose = function() {
      this.stop();
      return this.clear();
    };

    return EventEngine;

  })();
  return EventEngine;
}.apply(null, __WEBPACK_AMD_DEFINE_ARRAY__)), __WEBPACK_AMD_DEFINE_RESULT__ !== undefined && (module.exports = __WEBPACK_AMD_DEFINE_RESULT__));


/***/ },
/* 9 */
/***/ function(module, exports, __webpack_require__) {

var __WEBPACK_AMD_DEFINE_ARRAY__, __WEBPACK_AMD_DEFINE_RESULT__;!(__WEBPACK_AMD_DEFINE_ARRAY__ = [__webpack_require__(18), __webpack_require__(23)], __WEBPACK_AMD_DEFINE_RESULT__ = (function(DragAndDrop, PointEvent) {
  "use strict";
  var MouseEventEngine, oncontextmenu, onmousedown, onmouseenter, onmouseleave, onmousemove, onmouseup;
  onmousedown = function(e) {
    var position;
    position = this.stage.point(e);
    this.captured = this.stage.capture(position);
    this.click_target = this.captured;
    DragAndDrop.draggable = true;
    PointEvent.mousedown(this.captured, e, position);
    if (e.preventDefault) {
      return e.preventDefault();
    }
  };
  onmouseup = function(e) {
    var dbl_click_detected, position, self;
    position = this.stage.point(e);
    this.captured = this.stage.capture(position);
    dbl_click_detected = false;
    if (this.listening_dbl_click) {
      dbl_click_detected = true;
      this.listening_dbl_click = false;
    } else {
      this.listening_dbl_click = true;
    }
    self = this;
    setTimeout(function() {
      return self.listening_dbl_click = false;
    }, 500);
    if (this.captured && !DragAndDrop.dragging) {
      PointEvent.mouseup(this.captured, e, position);
      if (this.click_target && this.captured === this.click_target) {
        PointEvent.click(this.captured, e, position);
        if (dbl_click_detected) {
          PointEvent.doubleclick(this.captured, e, position);
          this.listening_dbl_click = false;
        }
      }
    }
    this.click_target = null;
    if (e.preventDefault) {
      return e.preventDefault();
    }
  };
  onmousemove = function(e) {
    var component, lastCaptured, newAscendant, oldAscendant, position;
    if ((typeof e.webkitMovementX !== 'undefined' || typeof e.webkitMovementY !== 'undefined') && e.webkitMovementY === 0 && e.webkitMovementX === 0) {
      return;
    }
    position = this.stage.point(e);
    lastCaptured = this.captured;
    this.captured = this.stage.capture(position);
    if (!DragAndDrop.dragging) {
      if (this.captured) {
        PointEvent.mousemove(this.captured, e, position);
      }
      if (this.captured !== lastCaptured) {
        newAscendant = [this.captured];
        if (this.captured) {
          while (component = (component || this.captured).getContainer()) {
            newAscendant.unshift(component);
          }
        }
        oldAscendant = [lastCaptured];
        if (lastCaptured) {
          while (component = (component || lastCaptured).getContainer()) {
            oldAscendant.unshift(component);
          }
        }
        while (oldAscendant[0] === newAscendant[0]) {
          oldAscendant.shift();
          newAscendant.shift();
        }
        while (component = oldAscendant.pop()) {
          PointEvent.mouseout(component, e, position);
        }
        while (component = newAscendant.shift()) {
          PointEvent.mouseover(component, e, position);
        }
      }
    }
    if (DragAndDrop.draggable && this.captured) {
      DragAndDrop.drag(this.captured, e, position);
    }
    if (e.preventDefault) {
      return e.preventDefault();
    }
  };
  onmouseleave = function(e) {
    var component, oldAscendant, position;
    if (this.dragging) {
      return;
    }
    if (this.captured) {
      position = this.stage.point(e);
      component = this.captured;
      oldAscendant = [this.captured];
      while (component = component.getContainer()) {
        oldAscendant.unshift(component);
      }
      while (component = oldAscendant.pop()) {
        PointEvent.mouseout(component, e, position);
      }
    }
    return this.captured = null;
  };
  onmouseenter = function(e) {};
  oncontextmenu = function(e) {
    var position;
    e.preventDefault();
    position = this.stage.point(e);
    this.captured = this.stage.capture(position);
    return PointEvent.contextmenu(this.captured, e, position);
  };
  return MouseEventEngine = (function() {
    function MouseEventEngine(stage) {
      this.stage = stage;
      this.onmousemove = onmousemove.bind(this);
      this.onmouseleave = onmouseleave.bind(this);
      this.onmouseenter = onmouseenter.bind(this);
      this.onmouseup = onmouseup.bind(this);
      this.onmousedown = onmousedown.bind(this);
      this.oncontextmenu = oncontextmenu.bind(this);
      this.stage.html_container.addEventListener('mousemove', this.onmousemove);
      this.stage.html_container.addEventListener('mouseleave', this.onmouseleave);
      this.stage.html_container.addEventListener('mouseenter', this.onmouseenter);
      this.stage.html_container.addEventListener('mouseup', this.onmouseup);
      this.stage.html_container.addEventListener('mousedown', this.onmousedown);
      this.stage.html_container.addEventListener('contextmenu', this.oncontextmenu);
      this;
    }

    MouseEventEngine.prototype.dispose = function() {
      this.stage.html_container.removeEventListener('mousemove', this.onmousemove);
      this.stage.html_container.removeEventListener('mouseleave', this.onmouseleave);
      this.stage.html_container.removeEventListener('mouseenter', this.onmouseenter);
      this.stage.html_container.removeEventListener('mouseup', this.onmouseup);
      this.stage.html_container.removeEventListener('mousedown', this.onmousedown);
      return this.stage.html_container.removeEventListener('contextmenu', this.oncontextmenu);
    };

    return MouseEventEngine;

  })();
}.apply(null, __WEBPACK_AMD_DEFINE_ARRAY__)), __WEBPACK_AMD_DEFINE_RESULT__ !== undefined && (module.exports = __WEBPACK_AMD_DEFINE_RESULT__));


/***/ },
/* 10 */
/***/ function(module, exports, __webpack_require__) {

var __WEBPACK_AMD_DEFINE_ARRAY__, __WEBPACK_AMD_DEFINE_RESULT__;!(__WEBPACK_AMD_DEFINE_ARRAY__ = [__webpack_require__(23), __webpack_require__(18)], __WEBPACK_AMD_DEFINE_RESULT__ = (function(PointEvent, DragAndDrop) {
  "use strict";
  var TouchEventEngine, ontouchend, ontouchmove, ontouchstart;
  ontouchstart = function(e) {
    var position, self, target;
    position = this.stage.point(e);
    target = this.stage.capture(position);
    this.tap_target = target;
    self = this;
    this.longtouch_triggered = false;
    this.longtouch_timer = setTimeout(function() {
      self.longtouch_timer = null;
      if (target) {
        PointEvent.longtouch(target, e, position);
      }
      return self.longtouch_triggered = true;
    }, 500);
    PointEvent.touchstart(target, e, position);
    if (e.preventDefault) {
      return e.preventDefault();
    }
  };
  ontouchend = function(e) {
    var dbl_click_detected, position, self, target;
    position = this.stage.point(e);
    target = this.stage.capture(position);
    if (this.longtouch_timer) {
      clearTimeout(this.longtouch_timer);
      this.longtouch_timer = null;
    }
    dbl_click_detected = false;
    if (this.listening_dbl_click) {
      dbl_click_detected = true;
      this.listening_dbl_click = false;
    } else {
      this.listening_dbl_click = true;
    }
    self = this;
    setTimeout(function() {
      return self.listening_dbl_click = false;
    }, 500);
    if (target && !DragAndDrop.dragging) {
      PointEvent.touchend(target, e, position);
      if (this.tap_target && target === this.tap_target) {
        PointEvent.tap(target, e, position);
        if (dbl_click_detected) {
          PointEvent.doubletap(target, e, position);
          this.listening_dbl_click = false;
        }
      }
    }
    this.tap_target = null;
    if (e.preventDefault) {
      return e.preventDefault();
    }
  };
  ontouchmove = function(e) {
    var position, target;
    position = this.stage.point(e);
    if (this.longtouch_timer && DragAndDrop.dragging) {
      clearTimeout(this.longtouch_timer);
      this.longtouch_timer = null;
    } else if (this.longtouch_triggered) {
      if (e.preventDefault) {
        e.preventDefault();
      }
      return;
    }
    target = this.stage.capture(position);
    if (!DragAndDrop.dragging && target) {
      PointEvent.touchmove(target, e, position);
      if (e.preventDefault) {
        e.preventDefault();
      }
    }
    DragAndDrop.drag(target, e, position);
    if (e.preventDefault) {
      return e.preventDefault();
    }
  };
  return TouchEventEngine = (function() {
    function TouchEventEngine(stage) {
      this.stage = stage;
      this.ontouchstart = ontouchstart.bind(this);
      this.ontouchmove = ontouchmove.bind(this);
      this.ontouchend = ontouchend.bind(this);
      this.stage.html_container.addEventListener('touchstart', this.ontouchstart);
      this.stage.html_container.addEventListener('touchmove', this.ontouchmove);
      this.stage.html_container.addEventListener('touchend', this.ontouchend);
      this;
    }

    TouchEventEngine.prototype.dispose = function() {
      this.stage.html_container.removeEventListener('touchstart', this.ontouchstart);
      this.stage.html_container.removeEventListener('touchmove', this.ontouchmove);
      return this.stage.html_container.removeEventListener('touchend', this.ontouchend);
    };

    return TouchEventEngine;

  })();
}.apply(null, __WEBPACK_AMD_DEFINE_ARRAY__)), __WEBPACK_AMD_DEFINE_RESULT__ !== undefined && (module.exports = __WEBPACK_AMD_DEFINE_RESULT__));


/***/ },
/* 11 */
/***/ function(module, exports, __webpack_require__) {

var __WEBPACK_AMD_DEFINE_ARRAY__, __WEBPACK_AMD_DEFINE_RESULT__;!(__WEBPACK_AMD_DEFINE_ARRAY__ = [], __WEBPACK_AMD_DEFINE_RESULT__ = (function() {
  "use strict";
  var ExportManager;
  return ExportManager = (function() {
    function ExportManager(binder) {
      this.binder = binder;
      this.exports = {};
    }

    ExportManager.prototype.dispose = function() {
      var key, keys, _i, _len, _results;
      keys = Object.keys(this.exports);
      _results = [];
      for (_i = 0, _len = keys.length; _i < _len; _i++) {
        key = keys[_i];
        _results.push(this.remove(key));
      }
      return _results;
    };

    ExportManager.prototype["import"] = function(key, exports, binder) {
      var k, v, _exports;
      if (!exports) {
        return;
      }
      _exports = {};
      for (k in exports) {
        v = exports[k];
        if (v instanceof Function) {
          _exports[k] = v.bind(binder || this.binder);
        } else {
          _exports[k] = v;
        }
      }
      return this.exports[key] = _exports;
    };

    ExportManager.prototype.remove = function(key) {
      return delete this.exports[key];
    };

    ExportManager.prototype.require = function(key) {
      return this.exports[key];
    };

    return ExportManager;

  })();
}.apply(null, __WEBPACK_AMD_DEFINE_ARRAY__)), __WEBPACK_AMD_DEFINE_RESULT__ !== undefined && (module.exports = __WEBPACK_AMD_DEFINE_RESULT__));


/***/ },
/* 12 */
/***/ function(module, exports, __webpack_require__) {

var __WEBPACK_AMD_DEFINE_ARRAY__, __WEBPACK_AMD_DEFINE_RESULT__;!(__WEBPACK_AMD_DEFINE_ARRAY__ = [__webpack_require__(24)], __WEBPACK_AMD_DEFINE_RESULT__ = (function(Command) {
  'use strict';
  var CommandManager;
  CommandManager = (function() {
    function CommandManager(params) {
      this.reset();
    }

    CommandManager.prototype.dispose = function() {
      return this.reset();
    };

    CommandManager.prototype.execute = function(command) {
      if (!command instanceof Command) {
        return;
      }
      command.execute();
      this.exq.push(command);
      return this.uxq = [];
    };

    CommandManager.prototype.undo = function() {
      var command;
      command = this.exq.pop();
      if (command) {
        command.unexecute();
        return this.uxq.push(command);
      }
    };

    CommandManager.prototype.redo = function() {
      var command;
      command = this.uxq.pop();
      if (command) {
        command.execute();
        return this.exq.push(command);
      }
    };

    CommandManager.prototype.undoable = function() {
      return this.exq.length > 0;
    };

    CommandManager.prototype.redoable = function() {
      return this.uxq.length > 0;
    };

    CommandManager.prototype.reset = function() {
      this.exq = [];
      return this.uxq = [];
    };

    return CommandManager;

  })();
  return CommandManager;
}.apply(null, __WEBPACK_AMD_DEFINE_ARRAY__)), __WEBPACK_AMD_DEFINE_RESULT__ !== undefined && (module.exports = __WEBPACK_AMD_DEFINE_RESULT__));


/***/ },
/* 13 */
/***/ function(module, exports, __webpack_require__) {

var __WEBPACK_AMD_DEFINE_ARRAY__, __WEBPACK_AMD_DEFINE_RESULT__;!(__WEBPACK_AMD_DEFINE_ARRAY__ = [], __WEBPACK_AMD_DEFINE_RESULT__ = (function() {
  'use strict';
  var onadd, onremove;
  onadd = function(container, component, index, e) {
    var maps;
    if (!component.event_map) {
      return;
    }
    maps = component.event_map();
    return this.eventEngine.add(component, maps, component);
  };
  onremove = function(container, component) {
    return this.eventEngine.remove(component);
  };
  return {
    '(root)': {
      '(all)': {
        'add': onadd,
        'remove': onremove
      }
    }
  };
}.apply(null, __WEBPACK_AMD_DEFINE_ARRAY__)), __WEBPACK_AMD_DEFINE_RESULT__ !== undefined && (module.exports = __WEBPACK_AMD_DEFINE_RESULT__));


/***/ },
/* 14 */
/***/ function(module, exports, __webpack_require__) {

module.exports = __WEBPACK_EXTERNAL_MODULE_14__;

/***/ },
/* 15 */
/***/ function(module, exports, __webpack_require__) {

var __WEBPACK_AMD_DEFINE_ARRAY__, __WEBPACK_AMD_DEFINE_RESULT__;var __indexOf = [].indexOf || function(item) { for (var i = 0, l = this.length; i < l; i++) { if (i in this && this[i] === item) return i; } return -1; };

!(__WEBPACK_AMD_DEFINE_ARRAY__ = [], __WEBPACK_AMD_DEFINE_RESULT__ = (function() {
  'use strict';
  var Module, moduleKeywords;
  moduleKeywords = ['extended', 'included'];
  Module = (function() {
    function Module() {}

    Module.extend = function(obj) {
      var key, value, _ref;
      for (key in obj) {
        value = obj[key];
        if (!(__indexOf.call(moduleKeywords, key) < 0)) {
          continue;
        }
        console.log(key, value);
        this[key] = value;
      }
      if ((_ref = obj.extended) != null) {
        _ref.apply(this);
      }
      return this;
    };

    Module.include = function(obj) {
      var key, value, _ref;
      for (key in obj) {
        value = obj[key];
        if (__indexOf.call(moduleKeywords, key) < 0) {
          this.prototype[key] = value;
        }
      }
      if ((_ref = obj.included) != null) {
        _ref.apply(this);
      }
      return this;
    };

    return Module;

  })();
  return Module;
}.apply(null, __WEBPACK_AMD_DEFINE_ARRAY__)), __WEBPACK_AMD_DEFINE_RESULT__ !== undefined && (module.exports = __WEBPACK_AMD_DEFINE_RESULT__));


/***/ },
/* 16 */
/***/ function(module, exports, __webpack_require__) {

var __WEBPACK_AMD_DEFINE_ARRAY__, __WEBPACK_AMD_DEFINE_RESULT__;var __hasProp = {}.hasOwnProperty,
  __extends = function(child, parent) { for (var key in parent) { if (__hasProp.call(parent, key)) child[key] = parent[key]; } function ctor() { this.constructor = child; } ctor.prototype = parent.prototype; child.prototype = new ctor(); child.__super__ = parent.prototype; return child; };

!(__WEBPACK_AMD_DEFINE_ARRAY__ = [__webpack_require__(3), __webpack_require__(4), __webpack_require__(25)], __WEBPACK_AMD_DEFINE_RESULT__ = (function(_, Component, ComponentEvent) {
  "use strict";
  var Container, EMPTY, add, add_component, forEach, getAt, indexOf, moveChildAt, moveChildBackward, moveChildForward, moveChildToBack, moveChildToFront, remove, removeAll, remove_component, size;
  EMPTY = [];
  add_component = function(container, component) {
    var containable, index, oldContainer;
    containable = component instanceof Component;
    if (containable) {
      oldContainer = component.getContainer();
      if (oldContainer) {
        if (container === oldContainer) {
          return;
        }
        remove_component(container, component);
      }
    }
    index = (container.__components__.push(component)) - 1;
    if (containable) {
      component.setContainer(container);
    }
    ComponentEvent.add(container, container, component, index);
    if (!containable) {
      return;
    }
    component.delegate_on(container);
    return ComponentEvent.added(component, container, component, index);
  };
  remove_component = function(container, component) {
    var containable, idx;
    containable = component instanceof Component;
    idx = container.__components__.indexOf(component);
    if (idx === -1) {
      return;
    }
    if (idx > -1) {
      container.__components__.splice(idx, 1);
    }
    if (containable) {
      component.setContainer(null);
    }
    ComponentEvent.remove(container, container, component);
    if (!(component instanceof Component)) {
      return;
    }
    ComponentEvent.removed(component, container, component);
    return component.delegate_off(container);
  };
  add = function(comp) {
    var i, _i, _len;
    this.__components__ || (this.__components__ = []);
    if (!(comp instanceof Array)) {
      return add.call(this, [comp]);
    }
    for (_i = 0, _len = comp.length; _i < _len; _i++) {
      i = comp[_i];
      add_component(this, i);
    }
    return this;
  };
  remove = function(comp) {
    var i, _i, _len;
    if (!(comp instanceof Array)) {
      return remove.call(this, [comp]);
    }
    if (!this.__components__) {
      return;
    }
    for (_i = 0, _len = comp.length; _i < _len; _i++) {
      i = comp[_i];
      remove_component(this, i);
    }
    return this;
  };
  removeAll = function() {
    return this.remove(_.clone(this.__components__));
  };
  getAt = function(index) {
    if (this.__components__) {
      return this.__components__[index];
    }
  };
  forEach = function(fn, context) {
    if (!this.__components__) {
      return;
    }
    return this.__components__.forEach(fn, context);
  };
  indexOf = function(item) {
    return (this.__components__ || EMPTY).indexOf(item);
  };
  size = function() {
    return (this.__components__ || EMPTY).length;
  };
  moveChildAt = function(index, child) {
    var head, oldIndex, tail;
    oldIndex = this.indexOf(child);
    if (oldIndex === -1) {
      return;
    }
    head = this.__components__.splice(0, oldIndex);
    tail = this.__components__.splice(1);
    this.__components__ = head.concat(tail);
    index = Math.max(0, index);
    index = Math.min(index, this.__components__.length);
    head = this.__components__.splice(0, index);
    return this.__components__ = head.concat(child, this.__components__);
  };
  moveChildForward = function(child) {
    var index;
    index = this.indexOf(child);
    if ((index === -1) || (index === this.size() - 1)) {
      return;
    }
    this.__components__[index] = this.__components__[index + 1];
    return this.__components__[index + 1] = child;
  };
  moveChildBackward = function(child) {
    var index;
    index = this.indexOf(child);
    if (index === -1 || index === 0) {
      return;
    }
    this.__components__[index] = this.__components__[index - 1];
    return this.__components__[index - 1] = child;
  };
  moveChildToFront = function(child) {
    var head, index, tail;
    index = this.indexOf(child);
    if (index === -1 || (index === this.size() - 1)) {
      return;
    }
    head = this.__components__.splice(0, index);
    tail = this.__components__.splice(1);
    return this.__components__ = head.concat(tail, this.__components__);
  };
  moveChildToBack = function(child) {
    var head, index, tail;
    index = this.indexOf(child);
    if (index === -1 || index === 0) {
      return;
    }
    head = this.__components__.splice(0, index);
    tail = this.__components__.splice(1);
    return this.__components__ = this.__components__.concat(head, tail);
  };
  Container = (function(_super) {
    __extends(Container, _super);

    function Container(type) {
      Container.__super__.constructor.call(this, type);
    }

    Container.prototype.dispose = function() {
      var children, component, _i, _len;
      if (this.__components__) {
        children = _.clone(this.__components__);
        for (_i = 0, _len = children.length; _i < _len; _i++) {
          component = children[_i];
          component.dispose();
        }
        this.__components__ = null;
      }
      return Container.__super__.dispose.call(this);
    };

    Container.prototype.add = add;

    Container.prototype.remove = remove;

    Container.prototype.removeAll = removeAll;

    Container.prototype.size = size;

    Container.prototype.getAt = getAt;

    Container.prototype.indexOf = indexOf;

    Container.prototype.forEach = forEach;

    Container.prototype.moveChildAt = moveChildAt;

    Container.prototype.moveChildForward = moveChildForward;

    Container.prototype.moveChildBackward = moveChildBackward;

    Container.prototype.moveChildToFront = moveChildToFront;

    Container.prototype.moveChildToBack = moveChildToBack;

    return Container;

  })(Component);
  return Container;
}.apply(null, __WEBPACK_AMD_DEFINE_ARRAY__)), __WEBPACK_AMD_DEFINE_RESULT__ !== undefined && (module.exports = __WEBPACK_AMD_DEFINE_RESULT__));


/***/ },
/* 17 */
/***/ function(module, exports, __webpack_require__) {

var __WEBPACK_AMD_DEFINE_ARRAY__, __WEBPACK_AMD_DEFINE_RESULT__;var __hasProp = {}.hasOwnProperty;

!(__WEBPACK_AMD_DEFINE_ARRAY__ = [__webpack_require__(3), __webpack_require__(6)], __WEBPACK_AMD_DEFINE_RESULT__ = (function(dou, ComponentSelector) {
  "use strict";
  var EventPump, control, event_handler_fn;
  control = function(root, listener, handlers, event, args) {
    var event_map, event_name, handler, selector, _results;
    _results = [];
    for (selector in handlers) {
      if (!__hasProp.call(handlers, selector)) continue;
      event_map = handlers[selector];
      if (ComponentSelector.match(selector, event.origin, listener, root)) {
        _results.push((function() {
          var _results1;
          _results1 = [];
          for (event_name in event_map) {
            if (!__hasProp.call(event_map, event_name)) continue;
            handler = event_map[event_name];
            if (!(event_name === event.name)) {
              continue;
            }
            event.listener = listener;
            _results1.push(handler.apply(this, args));
          }
          return _results1;
        }).call(this));
      }
    }
    return _results;
  };
  event_handler_fn = function() {
    var args, e, eventPump, item, _i, _len, _ref, _results;
    args = arguments;
    e = args[args.length - 1];
    eventPump = this.eventPump;
    _ref = eventPump.listeners;
    _results = [];
    for (_i = 0, _len = _ref.length; _i < _len; _i++) {
      item = _ref[_i];
      _results.push(control.call(this.context, eventPump.deliverer, item.listener, item.clonedHandlers, e, args));
    }
    return _results;
  };
  EventPump = (function() {
    function EventPump(deliverer) {
      this.setDeliverer(deliverer);
      this.listeners = [];
    }

    EventPump.prototype.setDeliverer = function(deliverer) {
      return this.deliverer = deliverer;
    };

    EventPump.prototype.start = function(context) {
      return this.deliverer.on('all', event_handler_fn, {
        context: context || null,
        eventPump: this
      });
    };

    EventPump.prototype.stop = function() {
      return this.deliverer.off('all', event_handler_fn);
    };

    EventPump.prototype.on = function(listener, handlers) {
      var clonedHandlers, handler, selector, selectors, value, variable, _i, _len;
      clonedHandlers = _.clone(handlers);
      selectors = Object.keys(clonedHandlers);
      for (_i = 0, _len = selectors.length; _i < _len; _i++) {
        selector = selectors[_i];
        if (!(selector.indexOf('?') === 0)) {
          continue;
        }
        handler = clonedHandlers[selector];
        variable = selector.substr(1);
        value = listener.get(variable);
        delete clonedHandlers[selector];
        if (value) {
          clonedHandlers[value] = handler;
        } else {
          console.log("EventPump#on", "variable " + selector + " is not evaluated on listener");
        }
      }
      return this.listeners.push({
        listener: listener,
        handlers: handlers,
        clonedHandlers: clonedHandlers
      });
    };

    EventPump.prototype.off = function(listener, handlers) {
      var index, item, _i, _len, _ref, _results;
      _ref = this.listeners;
      _results = [];
      for (index = _i = 0, _len = _ref.length; _i < _len; index = ++_i) {
        item = _ref[index];
        if (item.listener === listener && (!handlers || item.handlers === handlers)) {
          _results.push(this.listeners.splice(index, 1));
        } else {
          _results.push(void 0);
        }
      }
      return _results;
    };

    EventPump.prototype.clear = function() {
      return this.listeners = [];
    };

    EventPump.prototype.dispose = function() {
      this.stop();
      return this.clear();
    };

    return EventPump;

  })();
  return EventPump;
}.apply(null, __WEBPACK_AMD_DEFINE_ARRAY__)), __WEBPACK_AMD_DEFINE_RESULT__ !== undefined && (module.exports = __WEBPACK_AMD_DEFINE_RESULT__));


/***/ },
/* 18 */
/***/ function(module, exports, __webpack_require__) {

var __WEBPACK_AMD_DEFINE_ARRAY__, __WEBPACK_AMD_DEFINE_RESULT__;!(__WEBPACK_AMD_DEFINE_ARRAY__ = [__webpack_require__(23)], __WEBPACK_AMD_DEFINE_RESULT__ = (function(PointEvent) {
  var DragAndDrop, onafter_mouseup, onbefore_mouseup;
  onbefore_mouseup = function(e) {};
  onafter_mouseup = function(e) {
    var position, target;
    DragAndDrop.dragging = false;
    target = DragAndDrop.target;
    if (target) {
      position = target.getStage().point(e);
      PointEvent.dragend(DragAndDrop.target, e, position);
    }
    delete DragAndDrop.target;
    return DragAndDrop.cleanup();
  };
  DragAndDrop = {
    draggable: false,
    dragging: false,
    target: null,
    drag_end_target: null,
    start_point: null,
    last_point: null,
    cutoff: 4,
    cleanup: function() {
      this.target = null;
      this.drag_end_target = null;
      this.start_point = null;
      this.last_point = null;
      this.dragging = false;
      return this.draggable = false;
    },
    drag: function(target, e, position) {
      var distance;
      if (!this.start_point) {
        this.start_point = position;
      }
      if (!this.dragging && target.get('draggable')) {
        if (e.touches !== void 0) {
          distance = Math.max(Math.abs(position.x - this.start_point.x), Math.abs(position.y - this.start_point.y));
          if (distance < this.cutoff) {
            return;
          }
        }
        this.dragging = true;
        this.target = target;
        PointEvent.dragstart(target, e, this.start_point);
      }
      if (this.dragging) {
        this.last_point = position;
        return PointEvent.drag(this.target, e, position);
      }
    }
  };
  document.addEventListener('mouseup', onbefore_mouseup, true);
  document.addEventListener('touchend', onbefore_mouseup, true);
  document.addEventListener('mouseup', onafter_mouseup, false);
  document.addEventListener('touchend', onafter_mouseup, false);
  return DragAndDrop;
}.apply(null, __WEBPACK_AMD_DEFINE_ARRAY__)), __WEBPACK_AMD_DEFINE_RESULT__ !== undefined && (module.exports = __WEBPACK_AMD_DEFINE_RESULT__));


/***/ },
/* 19 */
/***/ function(module, exports, __webpack_require__) {

var __WEBPACK_AMD_DEFINE_ARRAY__, __WEBPACK_AMD_DEFINE_RESULT__;var __hasProp = {}.hasOwnProperty;

!(__WEBPACK_AMD_DEFINE_ARRAY__ = [__webpack_require__(3)], __WEBPACK_AMD_DEFINE_RESULT__ = (function(_) {
  "use strict";
  var WithProperty;
  return WithProperty = {
    silentSet: function(key, val) {
      var after, attrs, before, _ref;
      if (!key) {
        return this;
      }
      if (arguments.length > 1 && typeof arguments[0] === 'string') {
        attrs = {};
        attrs[key] = val;
        return this.silentSet(attrs);
      }
      this.attrs || (this.attrs = {});
      attrs = key;
      after = {};
      before = _.clone(this.attrs);
      _.assign(this.attrs, attrs);
      _ref = this.attrs;
      for (key in _ref) {
        if (!__hasProp.call(_ref, key)) continue;
        val = _ref[key];
        if (val !== before[key]) {
          after[key] = val;
        } else {
          delete before[key];
        }
      }
      return this;
    },
    set: function(key, val) {
      var after, attrs, before, _ref;
      if (!key) {
        return this;
      }
      if (arguments.length > 1 && typeof arguments[0] === 'string') {
        attrs = {};
        attrs[key] = val;
        return this.set(attrs);
      }
      this.attrs || (this.attrs = {});
      attrs = key;
      after = {};
      before = _.clone(this.attrs);
      _.assign(this.attrs, attrs);
      _ref = this.attrs;
      for (key in _ref) {
        if (!__hasProp.call(_ref, key)) continue;
        val = _ref[key];
        if (val !== before[key]) {
          after[key] = val;
        } else {
          delete before[key];
        }
      }
      if (Object.keys(after).length !== 0) {
        this.trigger('change', this, before, after);
      }
      return this;
    },
    get: function(attr) {
      var attr_spec;
      if (this.attrs && this.attrs.hasOwnProperty(attr)) {
        return this.attrs[attr];
      }
      if (!this.property_spec) {
        return;
      }
      attr_spec = this.property_spec[attr];
      if (attr_spec) {
        return attr_spec["default"];
      }
    },
    getAll: function() {
      if (this.attrs) {
        return _.clone(this.attrs);
      } else {
        return {};
      }
    }
  };
}.apply(null, __WEBPACK_AMD_DEFINE_ARRAY__)), __WEBPACK_AMD_DEFINE_RESULT__ !== undefined && (module.exports = __WEBPACK_AMD_DEFINE_RESULT__));


/***/ },
/* 20 */
/***/ function(module, exports, __webpack_require__) {

var __WEBPACK_AMD_DEFINE_ARRAY__, __WEBPACK_AMD_DEFINE_RESULT__;!(__WEBPACK_AMD_DEFINE_ARRAY__ = [], __WEBPACK_AMD_DEFINE_RESULT__ = (function() {
  "use strict";
  var WithLifeCycle;
  return WithLifeCycle = {
    initialize: function(attrs, property_spec) {
      this.attrs = attrs;
      this.property_spec = property_spec;
      return this;
    },
    dispose: function() {}
  };
}.apply(null, __WEBPACK_AMD_DEFINE_ARRAY__)), __WEBPACK_AMD_DEFINE_RESULT__ !== undefined && (module.exports = __WEBPACK_AMD_DEFINE_RESULT__));


/***/ },
/* 21 */
/***/ function(module, exports, __webpack_require__) {

var __WEBPACK_AMD_DEFINE_ARRAY__, __WEBPACK_AMD_DEFINE_RESULT__;!(__WEBPACK_AMD_DEFINE_ARRAY__ = [__webpack_require__(3), __webpack_require__(26)], __WEBPACK_AMD_DEFINE_RESULT__ = (function(_, Collection) {
  "use strict";
  var WithEvent, delegateEvents, eventSplitter, eventsApi, implementation, listenMethods, method, triggerEvents;
  WithEvent = {
    on: function(name, callback, context) {
      var events;
      if (!eventsApi(this, 'on', name, [callback, context]) || !callback) {
        return this;
      }
      this._listeners || (this._listeners = {});
      events = this._listeners[name] || (this._listeners[name] = []);
      events.push({
        callback: callback,
        context: context,
        ctx: context || this
      });
      return this;
    },
    once: function(name, callback, context) {
      var once, self;
      if (!eventsApi(this, 'once', name, [callback, context]) || !callback) {
        return this;
      }
      self = this;
      once = _.once(function() {
        self.off(name, once);
        return callback.apply(this, arguments);
      });
      once._callback = callback;
      return this.on(name, once, context);
    },
    off: function(name, callback, context) {
      var ev, events, i, j, names, retain, _i, _j, _len, _len1;
      if (!this._listeners || !eventsApi(this, 'off', name, [callback, context])) {
        return this;
      }
      if (!name && !callback && !context) {
        this._listeners = void 0;
        return this;
      }
      names = name ? [name] : Object.keys(this._listeners);
      for (i = _i = 0, _len = names.length; _i < _len; i = ++_i) {
        name = names[i];
        if ((events = this._listeners[name])) {
          this._listeners[name] = retain = [];
          if (callback || context) {
            for (j = _j = 0, _len1 = events.length; _j < _len1; j = ++_j) {
              ev = events[j];
              if ((callback && callback !== ev.callback && callback !== ev.callback._callback) || (context && context !== ev.context)) {
                retain.push(ev);
              }
            }
          }
          if (!retain.length) {
            delete this._listeners[name];
          }
        }
      }
      return this;
    },
    delegate_on: function(delegator) {
      this._delegators || (this._delegators = new Collection.List());
      this._delegators.append(delegator);
      return this;
    },
    delegate_off: function(delegator) {
      if (!this._delegators) {
        return this;
      }
      this._delegators.remove(delegator);
      return this;
    },
    delegate: function() {
      var event, listeners, listenersForAll;
      if (this._delegators && this._delegators.size() > 0) {
        delegateEvents(this._delegators, arguments);
      }
      if (!this._listeners) {
        return this;
      }
      event = arguments[arguments.length - 1];
      event.deliverer = this;
      listeners = this._listeners[event.name];
      listenersForAll = this._listeners.all;
      if (listeners) {
        triggerEvents(listeners, arguments);
      }
      if (listenersForAll) {
        triggerEvents(listenersForAll, arguments);
      }
      return this;
    },
    trigger: function(name) {
      var args, listeners, listenersForAll;
      args = [].slice.call(arguments, 1);
      args.push({
        origin: this,
        name: name,
        deliverer: this
      });
      if (this._delegators && this._delegators.size() > 0) {
        delegateEvents(this._delegators, args);
      }
      if (!this._listeners) {
        return this;
      }
      if (!eventsApi(this, 'trigger', name, args)) {
        return this;
      }
      listeners = this._listeners[name];
      listenersForAll = this._listeners.all;
      if (listeners) {
        triggerEvents(listeners, args);
      }
      if (listenersForAll) {
        triggerEvents(listenersForAll, args);
      }
      return this;
    },
    stopListening: function(obj, name, callback) {
      var id, listeningTo, remove;
      listeningTo = this._listeningTo;
      if (!listeningTo) {
        return this;
      }
      remove = !name && !callback;
      if (!callback && typeof name === 'object') {
        callback = this;
      }
      if (obj) {
        (listeningTo = {})[obj._listenId] = obj;
      }
      for (id in listeningTo) {
        obj = listeningTo[id];
        obj.off(name, callback, this);
        if (remove || _.isEmpty(obj._events)) {
          delete this._listeningTo[id];
        }
      }
      return this;
    }
  };
  eventSplitter = /\s+/;
  eventsApi = function(obj, action, name, rest) {
    var key, names, val, _i, _len;
    if (!name) {
      return true;
    }
    if (typeof name === 'object') {
      for (key in name) {
        val = name[key];
        obj[action].apply(obj, [key, val].concat(rest));
      }
      return false;
    }
    if (eventSplitter.test(name)) {
      names = name.split(eventSplitter);
      for (_i = 0, _len = names.length; _i < _len; _i++) {
        val = names[_i];
        obj[action].apply(obj, [val].concat(rest));
      }
      return false;
    }
    return true;
  };
  triggerEvents = function(listeners, args) {
    var ev, _i, _len, _results;
    _results = [];
    for (_i = 0, _len = listeners.length; _i < _len; _i++) {
      ev = listeners[_i];
      _results.push(ev.callback.apply(ev.ctx, args));
    }
    return _results;
  };
  delegateEvents = function(delegators, args) {
    return delegators.forEach(function(delegator) {
      return WithEvent.delegate.apply(delegator, args);
    });
  };
  listenMethods = {
    listenTo: 'on',
    listenToOnce: 'once'
  };
  for (method in listenMethods) {
    implementation = listenMethods[method];
    WithEvent[method] = function(obj, name, callback) {
      var id, listeningTo;
      listeningTo = this._listeningTo || (this._listeningTo = {});
      id = obj._listenId || (obj._listenId = _.uniqueId('l'));
      listeningTo[id] = obj;
      if (!callback && typeof name === 'object') {
        callback = this;
      }
      obj[implementation](name, callback, this);
      return this;
    };
  }
  return WithEvent;
}.apply(null, __WEBPACK_AMD_DEFINE_ARRAY__)), __WEBPACK_AMD_DEFINE_RESULT__ !== undefined && (module.exports = __WEBPACK_AMD_DEFINE_RESULT__));


/***/ },
/* 22 */
/***/ function(module, exports, __webpack_require__) {

var __WEBPACK_AMD_DEFINE_ARRAY__, __WEBPACK_AMD_DEFINE_RESULT__;!(__WEBPACK_AMD_DEFINE_ARRAY__ = [], __WEBPACK_AMD_DEFINE_RESULT__ = (function() {
  "use strict";
  var Serializable;
  return Serializable = {
    serialize: function() {
      return ["type: " + this.name, "id: " + this.id, "props: " + (JSON.stringify(this.attrs))].join(',');
    },
    deserialize: function() {}
  };
}.apply(null, __WEBPACK_AMD_DEFINE_ARRAY__)), __WEBPACK_AMD_DEFINE_RESULT__ !== undefined && (module.exports = __WEBPACK_AMD_DEFINE_RESULT__));


/***/ },
/* 23 */
/***/ function(module, exports, __webpack_require__) {

var __WEBPACK_AMD_DEFINE_ARRAY__, __WEBPACK_AMD_DEFINE_RESULT__;!(__WEBPACK_AMD_DEFINE_ARRAY__ = [__webpack_require__(3)], __WEBPACK_AMD_DEFINE_RESULT__ = (function(_) {
  'use strict';
  var event_fn, event_types, trigger;
  trigger = function(target, type, origin, position) {
    var e, stage;
    if (!position) {
      stage = target.getStage();
      position = stage.point(origin);
    }
    e = {
      origin: origin,
      type: type,
      target: target,
      offsetX: position.x,
      offsetY: position.y
    };
    return target.trigger(e.type, e);
  };
  event_fn = function(type) {
    return function(target, origin, position) {
      return trigger(target, type, origin, position);
    };
  };
  event_types = ['mousemove', 'mousedown', 'mouseup', 'click', 'doubleclick', 'contextmenu', 'mouseover', 'mouseout', 'dragstart', 'drag', 'dragend', 'touchstart', 'touchmove', 'touchend', 'longtouch', 'tap', 'doubletap'];
  return _.reduce(event_types, function(result, event_type) {
    result[event_type] = event_fn(event_type);
    return result;
  }, {});
}.apply(null, __WEBPACK_AMD_DEFINE_ARRAY__)), __WEBPACK_AMD_DEFINE_RESULT__ !== undefined && (module.exports = __WEBPACK_AMD_DEFINE_RESULT__));


/***/ },
/* 24 */
/***/ function(module, exports, __webpack_require__) {

var __WEBPACK_AMD_DEFINE_ARRAY__, __WEBPACK_AMD_DEFINE_RESULT__;!(__WEBPACK_AMD_DEFINE_ARRAY__ = [__webpack_require__(3)], __WEBPACK_AMD_DEFINE_RESULT__ = (function(_) {
  'use strict';
  var Command;
  Command = (function() {
    function Command(params) {
      this.params = _.clone(params);
    }

    Command.prototype.execute = function() {};

    Command.prototype.unexecute = function() {};

    return Command;

  })();
  return Command;
}.apply(null, __WEBPACK_AMD_DEFINE_ARRAY__)), __WEBPACK_AMD_DEFINE_RESULT__ !== undefined && (module.exports = __WEBPACK_AMD_DEFINE_RESULT__));


/***/ },
/* 25 */
/***/ function(module, exports, __webpack_require__) {

var __WEBPACK_AMD_DEFINE_ARRAY__, __WEBPACK_AMD_DEFINE_RESULT__;!(__WEBPACK_AMD_DEFINE_ARRAY__ = [], __WEBPACK_AMD_DEFINE_RESULT__ = (function() {
  'use strict';
  var add, added, remove, removed;
  add = function(target, container, component, index) {
    return target.trigger('add', container, component, index);
  };
  added = function(target, container, component, index) {
    return target.trigger('added', container, component, index);
  };
  remove = function(target, container, component) {
    return target.trigger('remove', container, component);
  };
  removed = function(target, container, component) {
    return target.trigger('removed', container, component);
  };
  return {
    add: add,
    added: added,
    remove: remove,
    removed: removed
  };
}.apply(null, __WEBPACK_AMD_DEFINE_ARRAY__)), __WEBPACK_AMD_DEFINE_RESULT__ !== undefined && (module.exports = __WEBPACK_AMD_DEFINE_RESULT__));


/***/ },
/* 26 */
/***/ function(module, exports, __webpack_require__) {

var __WEBPACK_AMD_DEFINE_ARRAY__, __WEBPACK_AMD_DEFINE_RESULT__;var __hasProp = {}.hasOwnProperty;

!(__WEBPACK_AMD_DEFINE_ARRAY__ = [], __WEBPACK_AMD_DEFINE_RESULT__ = (function() {
  "use strict";
  var Collection, List, Stack, list, stack;
  list = {
    insertAt: function(index, item) {
      if (!this.__collection__) {
        return this;
      }
      index = this.__collection__.indexOf(item);
      if (this.__collection__.indexOf(item) === -1) {
        this.__collection__.splice(index, 0, item);
      }
      return this;
    },
    append: function(item) {
      this.__collection__ || (this.__collection__ = []);
      if (this.__collection__.indexOf(item) === -1) {
        this.__collection__.push(item);
      }
      return this;
    },
    prepend: function(item) {
      this.__collection__ || (this.__collection__ = []);
      if (this.__collection__.indexOf(item) === -1) {
        this.__collection__.unshift(item);
      }
      return this;
    },
    remove: function(item) {
      var idx;
      if (!this.__collection__) {
        return this;
      }
      idx = this.__collection__.indexOf(item);
      if (idx > -1) {
        this.__collection__.splice(idx, 1);
      }
      return this;
    },
    getAt: function(index) {
      if (this.__collection__) {
        return this.__collection__[index];
      }
    },
    forEach: function(fn, context) {
      if (!this.__collection__) {
        return this;
      }
      return this.__collection__.forEach(fn, context);
    },
    indexOf: function(item) {
      return (this.__collection__ || []).indexOf(item);
    },
    size: function() {
      return (this.__collection__ || []).length;
    },
    clear: function() {
      return this.__collection__ = [];
    },
    moveForward: function(item) {
      var index;
      index = this.indexOf(item);
      if (index === -1 || index === 0) {
        return;
      }
      this.__collection__[index] = this.__collection__[index - 1];
      return this.__collection__[index - 1] = item;
    },
    moveBackward: function(item) {
      var index;
      index = this.indexOf(item);
      if ((index === -1) || (index === this.size() - 1)) {
        return;
      }
      this.__collection__[index] = this.__collection__[index + 1];
      return this.__collection__[index + 1] = item;
    },
    moveToHead: function(item) {
      var head, index, tail;
      index = this.indexOf(item);
      if (index === -1 || index === 0) {
        return;
      }
      head = this.__collection__.splice(0, index);
      tail = this.__collection__.splice(1);
      return this.__collection__ = this.__collection__.concat(head, tail);
    },
    moveToTail: function(item) {
      var head, index, tail;
      index = this.indexOf(item);
      if (index === -1 || (index === this.size() - 1)) {
        return;
      }
      head = this.__collection__.splice(0, index);
      tail = this.__collection__.splice(1);
      return this.__collection__ = head.concat(tail, this.__collection__);
    }
  };
  stack = {
    push: function(item) {
      throw new Error('Not Implemented Yet');
    },
    pop: function() {
      throw new Error('Not Implemented Yet');
    }
  };
  List = function() {};
  List.prototype = list;
  Stack = function() {};
  Stack.prototype = stack;
  return Collection = {
    List: List,
    Stack: Stack,
    withList: function() {
      var k, v, _results;
      _results = [];
      for (k in list) {
        if (!__hasProp.call(list, k)) continue;
        v = list[k];
        _results.push(this[k] = v);
      }
      return _results;
    },
    withStack: function() {
      var k, v, _results;
      _results = [];
      for (k in stack) {
        if (!__hasProp.call(stack, k)) continue;
        v = stack[k];
        _results.push(this[k] = v);
      }
      return _results;
    }
  };
}.apply(null, __WEBPACK_AMD_DEFINE_ARRAY__)), __WEBPACK_AMD_DEFINE_RESULT__ !== undefined && (module.exports = __WEBPACK_AMD_DEFINE_RESULT__));


/***/ }
/******/ ])
})
