/*! Things v0.0.4 | (c) Hatio, Lab. | MIT License */
(function webpackUniversalModuleDefinition(root, factory) {
	if(typeof exports === 'object' && typeof module === 'object')
		module.exports = factory(require("_"));
	else if(typeof define === 'function' && define.amd)
		define(["_"], factory);
	else if(typeof exports === 'object')
		exports["things"] = factory(require("_"));
	else
		root["things"] = factory(root["_"]);
})(this, function(__WEBPACK_EXTERNAL_MODULE_60__) {
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

var __WEBPACK_AMD_DEFINE_ARRAY__, __WEBPACK_AMD_DEFINE_RESULT__;!(__WEBPACK_AMD_DEFINE_ARRAY__ = [__webpack_require__(1), __webpack_require__(7), __webpack_require__(8), __webpack_require__(2), __webpack_require__(3), __webpack_require__(4), __webpack_require__(5), __webpack_require__(6), __webpack_require__(9), __webpack_require__(10), __webpack_require__(11), __webpack_require__(12), __webpack_require__(13), __webpack_require__(14), __webpack_require__(15), __webpack_require__(16), __webpack_require__(17), __webpack_require__(18), __webpack_require__(19), __webpack_require__(20), __webpack_require__(21), __webpack_require__(22), __webpack_require__(23), __webpack_require__(24), __webpack_require__(25), __webpack_require__(26), __webpack_require__(27), __webpack_require__(28), __webpack_require__(29), __webpack_require__(30)], __WEBPACK_AMD_DEFINE_RESULT__ = (function(Controller, Component, Container, Stage, Layer, Group, Shape, Animation, Barcode, Circle, Ellipse, ImageBox, Path, Rect, Ruler, Text, Line, DebugLayer, MagnifyLayer, RulerLayer, SelectionLayer, SlideLayer, WidgetLayer, TestLayer, BoundHandle, CircleHandle, Handle, P2PHandle, PathHandle, RotationHandle) {
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
    },
    Component: Component,
    Container: Container,
    Animation: Animation,
    shape: {
      Barcode: Barcode,
      Circle: Circle,
      Ellipse: Ellipse,
      ImageBox: ImageBox,
      Path: Path,
      Rect: Rect,
      Ruler: Ruler,
      Shape: Shape,
      Text: Text,
      Line: Line
    },
    layer: {
      DebugLayer: DebugLayer,
      Layer: Layer,
      MagnifyLayer: MagnifyLayer,
      RulerLayer: RulerLayer,
      SelectionLayer: SelectionLayer,
      SlideLayer: SlideLayer,
      WidgetLayer: WidgetLayer,
      TestLayer: TestLayer
    },
    group: {
      Group: Group
    },
    handle: {
      BoundHandle: BoundHandle,
      CircleHandle: CircleHandle,
      Handle: Handle,
      P2PHandle: P2PHandle,
      PathHandle: PathHandle,
      RotationHandle: RotationHandle
    },
    stage: {
      Stage: Stage
    }
  };
}.apply(null, __WEBPACK_AMD_DEFINE_ARRAY__)), __WEBPACK_AMD_DEFINE_RESULT__ !== undefined && (module.exports = __WEBPACK_AMD_DEFINE_RESULT__));


/***/ },
/* 1 */
/***/ function(module, exports, __webpack_require__) {

var __WEBPACK_AMD_DEFINE_ARRAY__, __WEBPACK_AMD_DEFINE_RESULT__;!(__WEBPACK_AMD_DEFINE_ARRAY__ = [__webpack_require__(40), __webpack_require__(31), __webpack_require__(2), __webpack_require__(7), __webpack_require__(32), __webpack_require__(33), __webpack_require__(34), __webpack_require__(35), __webpack_require__(36), __webpack_require__(43), __webpack_require__(41)], __WEBPACK_AMD_DEFINE_RESULT__ = (function(_, Global, Stage, Component, ComponentRegistry, ComponentSelector, ComponentFactory, EventEngine, ExportsManager, CommandManager, ControllerBehavior) {
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
      this.componentRegistry.register('stage', Stage);
      this.stage = this.componentFactory.create('stage', options);
      this.eventEngine.setRoot(this.stage);
      this.eventEngine.add(this, ControllerBehavior, this);
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

    Controller.prototype.register = function(type, klass) {
      return this.componentRegistry.register(type, klass);
    };

    Controller.prototype.apply = function(changeset) {
      var component, selections, selector, set, _results;
      _results = [];
      for (selector in changeset) {
        set = changeset[selector];
        selections = this.select(selector);
        _results.push((function() {
          var _i, _len, _results1;
          _results1 = [];
          for (_i = 0, _len = selections.length; _i < _len; _i++) {
            component = selections[_i];
            _results1.push(component.set(set));
          }
          return _results1;
        })());
      }
      return _results;
    };

    Controller.prototype.dispose = function() {
      this.componentFactory.dispose();
      this.commandManager.dispose();
      this.eventEngine.dispose();
      this.componentRegistry.dispose();
      return this.exportsManager.dispose();
    };

    return Controller;

  })();
  return Controller;
}.apply(null, __WEBPACK_AMD_DEFINE_ARRAY__)), __WEBPACK_AMD_DEFINE_RESULT__ !== undefined && (module.exports = __WEBPACK_AMD_DEFINE_RESULT__));


/***/ },
/* 2 */
/***/ function(module, exports, __webpack_require__) {

var __WEBPACK_AMD_DEFINE_ARRAY__, __WEBPACK_AMD_DEFINE_RESULT__;var __hasProp = {}.hasOwnProperty,
  __extends = function(child, parent) { for (var key in parent) { if (__hasProp.call(parent, key)) child[key] = parent[key]; } function ctor() { this.constructor = child; } ctor.prototype = parent.prototype; child.prototype = new ctor(); child.__super__ = parent.prototype; return child; };

!(__WEBPACK_AMD_DEFINE_ARRAY__ = [__webpack_require__(31), __webpack_require__(8), __webpack_require__(44), __webpack_require__(45), __webpack_require__(37), __webpack_require__(38)], __WEBPACK_AMD_DEFINE_RESULT__ = (function(Global, Container, ComponentProps, Bound, MouseEventEngine, TouchEventEngine) {
  'use strict';
  var Stage;
  return Stage = (function(_super) {
    __extends(Stage, _super);

    function Stage() {
      return Stage.__super__.constructor.apply(this, arguments);
    }

    Stage.prototype.draw = function() {
      return this.forEach(function(layer) {
        return layer.draw;
      });
    };

    Stage.prototype.init = function() {
      var container, h, w;
      container = this.get('container');
      console.log('container', container, this.config());
      if (container instanceof HTMLElement) {
        this.client_container = container;
      } else {
        this.client_container = document.getElementById(container);
      }
      this.client_container.innerHTML = '';
      this.html_container = document.createElement('div');
      this.html_container.style.position = 'relative';
      this.html_container.style.display = 'inline-block';
      w = this.config('w');
      h = this.config('h');
      this.html_container.style.width = w === void 0 || w === null ? '100%' : w + 'px';
      this.html_container.style.height = h === void 0 || h === null ? '100%' : h + 'px';
      this.client_container.appendChild(this.html_container);
      if (!Global.mobile) {
        this.mouseEventEngine = new MouseEventEngine(this);
      }
      return this.touchEventEngine = new TouchEventEngine(this);
    };

    Stage.prototype.dispose = function() {
      this.client_container.removeChild(this.html_container);
      this.controller.dispose();
      this.touchEventEngine.dispose();
      if (this.mouseEventEngine) {
        return this.mouseEventEngine.dispose();
      }
    };

    Stage.prototype.capture = function(position) {
      var captured, child, i, _i, _ref;
      if (this.size() > 0) {
        for (i = _i = _ref = this.size() - 1; _ref <= 0 ? _i <= 0 : _i >= 0; i = _ref <= 0 ? ++_i : --_i) {
          child = this.getAt(i);
          captured = child.capture(position);
          if (captured) {
            return captured;
          }
        }
      }
      return this;
    };

    Stage.prototype.position = function() {
      if (this.html_container.getBoundingClientRect) {
        return this.html_container.getBoundingClientRect();
      } else {
        return {
          top: 0,
          left: 0
        };
      }
    };

    Stage.prototype.point = function(e) {
      var div_to_canvas_x, div_to_canvas_y, stagePosition, touch, x, y;
      if (!e) {
        return this.point_pos;
      }
      stagePosition = this.position();
      x = null;
      y = null;
      if (e.touches !== void 0) {
        if (e.touches.length > 0) {
          touch = e.touches[0];
          x = touch.clientX - stagePosition.left;
          y = touch.clientY - stagePosition.top;
        }
      } else {
        div_to_canvas_x = 0;
        div_to_canvas_y = 0;
        if (e.target.tagName === 'CANVAS') {
          div_to_canvas_x = e.target.offsetLeft;
          div_to_canvas_y = e.target.offsetTop;
        }
        if (e.offsetX !== void 0) {
          x = e.offsetX + div_to_canvas_x;
          y = e.offsetY + div_to_canvas_y;
        } else if (Global.UA.browser === 'mozilla') {
          x = e.layerX + div_to_canvas_x;
          y = e.layerY + div_to_canvas_y;
        } else if (e.clientX !== void 0 && stagePosition) {
          x = e.clientX - stagePosition.left + div_to_canvas_x;
          y = e.clientY - stagePosition.top + div_to_canvas_y;
        }
      }
      if (x !== null && y !== null) {
        this.point_pos = {
          x: x,
          y: y
        };
      }
      return this.point_pos;
    };

    Stage.prototype.register = function(type, klass) {
      return this.controller.register(type, klass);
    };

    Stage.prototype.model = function(data) {
      var klass, type, _ref;
      if (data.dependencies) {
        _ref = data.dependencies;
        for (type in _ref) {
          klass = _ref[type];
          this.register(type, klass);
        }
      }
      return this.forEach(function(layer) {
        if (layer.model) {
          return layer.model(data);
        }
      });
    };

    Stage.prototype.apply = function(changeset) {
      return this.controller.apply(changeset);
    };

    Stage.prototype.objectify = function() {
      var components, dependencies;
      components = [];
      this.forEach(function(child) {
        return components.push(child.objectify());
      });
      dependencies = {};
      this.controller.componentRegistry.forEach(function(name, spec) {
        return dependencies[name] = spec.spec.source;
      }, this);
      return {
        dependencies: dependencies,
        components: components,
        config: _.omit(this.config(), 'container')
      };
    };

    Stage.spec = {
      type: 'stage',
      source: 'core:stage.Stage',
      containable: true,
      container_type: 'stage',
      description: 'Stage',
      dependencies: {},
      properties: [
        ComponentProps, Bound, {
          alpha: {
            type: 'number',
            "default": 100
          },
          container: {
            type: 'string'
          }
        }
      ]
    };

    return Stage;

  })(Container);
}.apply(null, __WEBPACK_AMD_DEFINE_ARRAY__)), __WEBPACK_AMD_DEFINE_RESULT__ !== undefined && (module.exports = __WEBPACK_AMD_DEFINE_RESULT__));


/***/ },
/* 3 */
/***/ function(module, exports, __webpack_require__) {

var __WEBPACK_AMD_DEFINE_ARRAY__, __WEBPACK_AMD_DEFINE_RESULT__;var __hasProp = {}.hasOwnProperty,
  __extends = function(child, parent) { for (var key in parent) { if (__hasProp.call(parent, key)) child[key] = parent[key]; } function ctor() { this.constructor = child; } ctor.prototype = parent.prototype; child.prototype = new ctor(); child.__super__ = parent.prototype; return child; };

!(__WEBPACK_AMD_DEFINE_ARRAY__ = [__webpack_require__(6), __webpack_require__(8), __webpack_require__(42), __webpack_require__(44), __webpack_require__(45), __webpack_require__(46)], __WEBPACK_AMD_DEFINE_RESULT__ = (function(Animation, Container, LayerBehavior, ComponentProps, Bound, Graphic) {
  'use strict';
  var Layer, batch, batchDraw, layers;
  layers = [];
  batch = new Animation(function(frame) {
    var layer, _results;
    if (layers.length === 0) {
      return batch.stop();
    }
    _results = [];
    while (layer = layers.shift()) {
      _results.push(layer._draw());
    }
    return _results;
  });
  batchDraw = function(layer) {
    if (-1 < layers.indexOf(layer)) {
      return;
    }
    layers.push(layer);
    if (layers.length === 1) {
      return batch.start();
    }
  };
  return Layer = (function(_super) {
    __extends(Layer, _super);

    function Layer() {
      return Layer.__super__.constructor.apply(this, arguments);
    }

    Layer.prototype.clearCanvas = function() {
      return this.canvas.getContext('2d').clearRect(0, 0, this.canvas.width, this.canvas.height);
    };

    Layer.prototype._draw = function() {
      var context, offsetx, offsety;
      context = this.canvas.getContext('2d');
      context.clearRect(0, 0, this.canvas.width, this.canvas.height);
      context.save();
      offsetx = this.get('offset-x');
      offsety = this.get('offset-y');
      context.translate(offsetx, offsety);
      this.forEach(function(child) {
        return child.draw(context);
      });
      return context.restore();
    };

    Layer.prototype.draw = function() {
      return batchDraw(this);
    };

    Layer.prototype.shape = function(context) {
      return context.rect(this.get('x'), this.get('y'), this.get('w'), this.get('h'));
    };

    Layer.prototype.capture = function(position) {
      var captured, child, context, i, translated_position, _i, _ref;
      context = this.canvas.getContext('2d');
      context.beginPath();
      translated_position = {
        x: position.x - this.get('offset-x') - this.get('x'),
        y: position.y - this.get('offset-y') - this.get('y')
      };
      this.shape(context);
      if (this.size() > 0) {
        for (i = _i = _ref = this.size() - 1; _ref <= 0 ? _i <= 0 : _i >= 0; i = _ref <= 0 ? ++_i : --_i) {
          child = this.getAt(i);
          captured = child.capture(translated_position, context);
          if (captured) {
            return captured;
          }
        }
      }
      if (this.get('capturable')) {
        return this;
      } else {
        return null;
      }
    };

    Layer.prototype.init = function() {
      var app_attrs, h, w, x, y;
      this.html_container = this.controller.getStage().html_container;
      this.canvas = document.createElement('canvas');
      app_attrs = this.controller.options;
      x = this.get('x') || 0;
      y = this.get('y') || 0;
      w = this.get('w') || (app_attrs.w && app_attrs.w - x) || (this.html_container.offsetWidth - x);
      h = this.get('h') || (app_attrs.h && app_attrs.h - y) || (this.html_container.offsetHeight - y);
      this.set({
        x: x,
        y: y,
        w: w,
        h: h
      });
      if (this.get('visible') !== false) {
        this.canvas.style.display = 'block';
      } else {
        this.canvas.style.display = 'none';
      }
      this.canvas.style.padding = 0;
      this.canvas.style.margin = 0;
      this.canvas.style.border = 0;
      this.canvas.style.background = 'transparent';
      this.canvas.style.position = 'absolute';
      this.canvas.style.top = y + 'px';
      this.canvas.style.left = x + 'px';
      this.canvas.setAttribute('width', w);
      this.canvas.setAttribute('height', h);
      return this.html_container.appendChild(this.canvas);
    };

    Layer.prototype.event_map = function() {
      return LayerBehavior;
    };

    Layer.prototype.dispose = function() {
      this.html_container.removeChild(this.canvas);
      return this.controller = null;
    };

    Layer.spec = {
      type: 'layer',
      source: 'core:layer.Layer',
      containable: true,
      container_type: 'layer',
      description: 'Abstract Layer',
      dependencies: {},
      properties: [
        ComponentProps, Bound, Graphic, {
          'alpha': {
            type: 'number',
            "default": 100
          },
          'offset-x': {
            type: 'number',
            "default": 0
          },
          'offset-y': {
            type: 'number',
            "default": 0
          },
          'resizable': {
            type: 'boolean'
          }
        }
      ]
    };

    return Layer;

  })(Container);
}.apply(null, __WEBPACK_AMD_DEFINE_ARRAY__)), __WEBPACK_AMD_DEFINE_RESULT__ !== undefined && (module.exports = __WEBPACK_AMD_DEFINE_RESULT__));


/***/ },
/* 4 */
/***/ function(module, exports, __webpack_require__) {

var __WEBPACK_AMD_DEFINE_ARRAY__, __WEBPACK_AMD_DEFINE_RESULT__;var __hasProp = {}.hasOwnProperty,
  __extends = function(child, parent) { for (var key in parent) { if (__hasProp.call(parent, key)) child[key] = parent[key]; } function ctor() { this.constructor = child; } ctor.prototype = parent.prototype; child.prototype = new ctor(); child.__super__ = parent.prototype; return child; };

!(__WEBPACK_AMD_DEFINE_ARRAY__ = [__webpack_require__(8), __webpack_require__(47), __webpack_require__(48), __webpack_require__(44), __webpack_require__(45), __webpack_require__(46)], __WEBPACK_AMD_DEFINE_RESULT__ = (function(Container, Dockable, GroupShapable, ComponentProps, Bound, Graphic) {
  'use strict';
  var Group;
  return Group = (function(_super) {
    __extends(Group, _super);

    function Group() {
      return Group.__super__.constructor.apply(this, arguments);
    }

    Group.include(Dockable);

    Group.include(GroupShapable);

    Group.prototype.handles = function() {
      return ['bound-handle', 'rotation-handle'];
    };

    Group.prototype.positions = function() {
      return [['x', 'y']];
    };

    Group.prototype.bound = function() {
      return {
        x: this.get('x'),
        y: this.get('y'),
        w: this.get('w'),
        h: this.get('h')
      };
    };

    Group.prototype.move = function(option, configure) {
      var config, delta, p, positions, to, _i, _j, _len, _len1;
      delta = option.delta;
      if (_.isEmpty(delta)) {
        return;
      }
      to = {};
      positions = this.positions();
      for (_i = 0, _len = positions.length; _i < _len; _i++) {
        p = positions[_i];
        if (delta.x) {
          to[p[0]] = Math.round(this.get(p[0]) + delta.x);
        }
        if (delta.y) {
          to[p[1]] = Math.round(this.get(p[1]) + delta.y);
        }
      }
      this.set(to);
      if (!configure) {
        return;
      }
      config = {};
      for (_j = 0, _len1 = positions.length; _j < _len1; _j++) {
        p = positions[_j];
        config[p[0]] = this.get(p[0]);
        config[p[1]] = this.get(p[1]);
      }
      this.configure(config);
      return console.log(this.type, this.config());
    };

    Group.prototype.event_map = null;

    Group.spec = {
      type: 'group',
      source: 'core:group.Group',
      containable: true,
      container_type: 'group',
      description: 'Group',
      dependencies: {},
      properties: [
        ComponentProps, Bound, Graphic, {
          clip: {
            type: 'boolean',
            "default": true
          }
        }
      ]
    };

    return Group;

  })(Container);
}.apply(null, __WEBPACK_AMD_DEFINE_ARRAY__)), __WEBPACK_AMD_DEFINE_RESULT__ !== undefined && (module.exports = __WEBPACK_AMD_DEFINE_RESULT__));


/***/ },
/* 5 */
/***/ function(module, exports, __webpack_require__) {

var __WEBPACK_AMD_DEFINE_ARRAY__, __WEBPACK_AMD_DEFINE_RESULT__;var __hasProp = {}.hasOwnProperty,
  __extends = function(child, parent) { for (var key in parent) { if (__hasProp.call(parent, key)) child[key] = parent[key]; } function ctor() { this.constructor = child; } ctor.prototype = parent.prototype; child.prototype = new ctor(); child.__super__ = parent.prototype; return child; };

!(__WEBPACK_AMD_DEFINE_ARRAY__ = [__webpack_require__(40), __webpack_require__(7), __webpack_require__(47), __webpack_require__(49), __webpack_require__(50), __webpack_require__(44), __webpack_require__(46)], __WEBPACK_AMD_DEFINE_RESULT__ = (function(_, Component, Dockable, Serializable, Shapable, ComponentProps, Graphic) {
  'use strict';
  var Shape;
  return Shape = (function(_super) {
    __extends(Shape, _super);

    function Shape() {
      return Shape.__super__.constructor.apply(this, arguments);
    }

    Shape.include(Dockable);

    Shape.include(Serializable);

    Shape.include(Shapable);

    Shape.prototype.handles = function() {
      var handles;
      handles = ['rotation-handle'];
      if (this.get('resizable')) {
        handles.push('bound-handle');
      }
      return handles;
    };

    Shape.prototype.positions = function() {
      return [['x', 'y']];
    };

    Shape.prototype.move = function(option, configure) {
      var config, delta, p, path, positions, to, _i, _j, _k, _l, _len, _len1, _len2, _len3;
      delta = option.delta;
      if (_.isEmpty(delta)) {
        return;
      }
      to = {};
      positions = this.positions();
      if (positions instanceof Array) {
        for (_i = 0, _len = positions.length; _i < _len; _i++) {
          p = positions[_i];
          if (delta.x) {
            to[p[0]] = Math.round(this.get(p[0]) + delta.x);
          }
          if (delta.y) {
            to[p[1]] = Math.round(this.get(p[1]) + delta.y);
          }
        }
      } else {
        path = _.clone(this.get(positions));
        for (_j = 0, _len1 = path.length; _j < _len1; _j++) {
          p = path[_j];
          if (delta.x) {
            p[0] += Math.round(delta.x);
          }
          if (delta.y) {
            p[1] += Math.round(delta.y);
          }
        }
        to[positions] = path;
      }
      this.set(to);
      if (!configure) {
        return;
      }
      config = {};
      if (positions instanceof Array) {
        for (_k = 0, _len2 = positions.length; _k < _len2; _k++) {
          p = positions[_k];
          config[p[0]] = this.get(p[0]);
          config[p[1]] = this.get(p[1]);
        }
        return this.configure(config);
      } else {
        for (_l = 0, _len3 = path.length; _l < _len3; _l++) {
          p = path[_l];
          config[p[0]] = this.get(p[0]);
          config[p[1]] = this.get(p[1]);
        }
        return this.configure(positions, path);
      }
    };

    Shape.prototype.event_map = function() {
      return null;
    };

    Shape.spec = {
      type: 'shape',
      source: 'core:shape.Shape',
      containable: false,
      description: 'Abstract Shape',
      dependencies: {},
      properties: [ComponentProps, Graphic]
    };

    return Shape;

  })(Component);
}.apply(null, __WEBPACK_AMD_DEFINE_ARRAY__)), __WEBPACK_AMD_DEFINE_RESULT__ !== undefined && (module.exports = __WEBPACK_AMD_DEFINE_RESULT__));


/***/ },
/* 6 */
/***/ function(module, exports, __webpack_require__) {

var __WEBPACK_AMD_DEFINE_ARRAY__, __WEBPACK_AMD_DEFINE_RESULT__;!(__WEBPACK_AMD_DEFINE_ARRAY__ = [], __WEBPACK_AMD_DEFINE_RESULT__ = (function() {
  'use strict';
  var Animation, RAF, addAnimation, animIdCounter, animRunning, animationLoop, animations, handleAnimation, now, removeAnimation, requestAnimFrame, runFrames;
  animations = [];
  animIdCounter = 0;
  animRunning = false;
  addAnimation = function(anim) {
    animations.push(anim);
    return handleAnimation();
  };
  removeAnimation = function(anim) {
    var animation, id, idx, _i, _len, _results;
    id = anim.id;
    _results = [];
    for (idx = _i = 0, _len = animations.length; _i < _len; idx = ++_i) {
      animation = animations[idx];
      if (animation.id === id) {
        animations.splice(idx, 1);
        break;
      } else {
        _results.push(void 0);
      }
    }
    return _results;
  };
  now = (function() {
    if (window.performance && window.performance.now) {
      return function() {
        return window.performance.now();
      };
    } else {
      return function() {
        return new Date().getTime();
      };
    }
  })();
  RAF = (function() {
    return window.requestAnimationFrame || window.webkitRequestAnimationFrame || window.mozRequestAnimationFrame || window.oRequestAnimationFrame || window.msRequestAnimationFrame || function(callback) {
      return setTimeout(callback, 1000 / 60);
    };
  })();
  requestAnimFrame = function() {
    return RAF.apply(window, arguments);
  };
  runFrames = function() {
    var animation, func, _i, _len, _results;
    _results = [];
    for (_i = 0, _len = animations.length; _i < _len; _i++) {
      animation = animations[_i];
      func = animation.func;
      animation.updateFrameObject(now());
      if (func) {
        _results.push(func.call(animation, animation.frame));
      } else {
        _results.push(void 0);
      }
    }
    return _results;
  };
  animationLoop = function() {
    if (animations.length) {
      requestAnimFrame(animationLoop);
      return runFrames();
    } else {
      return animRunning = false;
    }
  };
  handleAnimation = function() {
    if (!animRunning) {
      animRunning = true;
      return animationLoop();
    }
  };
  return Animation = (function() {
    function Animation(func) {
      this.func = func;
      this.id = animIdCounter++;
      this.frame = {
        time: 0,
        timeDiff: 0,
        lastTime: now()
      };
    }

    Animation.prototype.isRunning = function() {
      var animation, _i, _len;
      for (_i = 0, _len = animations.length; _i < _len; _i++) {
        animation = animations[_i];
        if (animation.id === this.id) {
          return true;
        }
      }
      return false;
    };

    Animation.prototype.start = function() {
      this.stop();
      this.frame.timeDiff = 0;
      this.frame.lastTime = now();
      return addAnimation(this);
    };

    Animation.prototype.stop = function() {
      return removeAnimation(this);
    };

    Animation.prototype.updateFrameObject = function(time) {
      this.frame.timeDiff = time - this.frame.lastTime;
      this.frame.lastTime = time;
      this.frame.time += this.frame.timeDiff;
      return this.frame.frameRate = 1000 / this.frame.timeDiff;
    };

    return Animation;

  })();
}.apply(null, __WEBPACK_AMD_DEFINE_ARRAY__)), __WEBPACK_AMD_DEFINE_RESULT__ !== undefined && (module.exports = __WEBPACK_AMD_DEFINE_RESULT__));


/***/ },
/* 7 */
/***/ function(module, exports, __webpack_require__) {

var __WEBPACK_AMD_DEFINE_ARRAY__, __WEBPACK_AMD_DEFINE_RESULT__;var __hasProp = {}.hasOwnProperty,
  __extends = function(child, parent) { for (var key in parent) { if (__hasProp.call(parent, key)) child[key] = parent[key]; } function ctor() { this.constructor = child; } ctor.prototype = parent.prototype; child.prototype = new ctor(); child.__super__ = parent.prototype; return child; };

!(__WEBPACK_AMD_DEFINE_ARRAY__ = [__webpack_require__(39), __webpack_require__(51), __webpack_require__(52), __webpack_require__(53), __webpack_require__(49)], __WEBPACK_AMD_DEFINE_RESULT__ = (function(Module, WithProperty, WithLifeCycle, WithEvent, Serializable) {
  "use strict";
  var Component;
  return Component = (function(_super) {
    __extends(Component, _super);

    Component.include(WithProperty);

    Component.include(WithLifeCycle);

    Component.include(WithEvent);

    Component.include(Serializable);

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
/* 8 */
/***/ function(module, exports, __webpack_require__) {

var __WEBPACK_AMD_DEFINE_ARRAY__, __WEBPACK_AMD_DEFINE_RESULT__;var __hasProp = {}.hasOwnProperty,
  __extends = function(child, parent) { for (var key in parent) { if (__hasProp.call(parent, key)) child[key] = parent[key]; } function ctor() { this.constructor = child; } ctor.prototype = parent.prototype; child.prototype = new ctor(); child.__super__ = parent.prototype; return child; };

!(__WEBPACK_AMD_DEFINE_ARRAY__ = [__webpack_require__(40), __webpack_require__(7), __webpack_require__(54)], __WEBPACK_AMD_DEFINE_RESULT__ = (function(_, Component, ComponentEvent) {
  "use strict";
  var Container, EMPTY, add, add_component, forEach, getAt, indexOf, isAscendentOf, moveChildAt, moveChildBackward, moveChildForward, moveChildToBack, moveChildToFront, remove, removeAll, remove_component, size;
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
  isAscendentOf = function(component) {
    if (!component) {
      return false;
    }
    if (this === component.getContainer()) {
      return true;
    }
    return this.isAscendentOf(component.getContainer());
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

    Container.prototype.isAscendentOf = isAscendentOf;

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
/* 9 */
/***/ function(module, exports, __webpack_require__) {

var __WEBPACK_AMD_DEFINE_ARRAY__, __WEBPACK_AMD_DEFINE_RESULT__;var __hasProp = {}.hasOwnProperty,
  __extends = function(child, parent) { for (var key in parent) { if (__hasProp.call(parent, key)) child[key] = parent[key]; } function ctor() { this.constructor = child; } ctor.prototype = parent.prototype; child.prototype = new ctor(); child.__super__ = parent.prototype; return child; };

!(__WEBPACK_AMD_DEFINE_ARRAY__ = [__webpack_require__(40), __webpack_require__(5), __webpack_require__(12), __webpack_require__(25), __webpack_require__(30), __webpack_require__(45)], __WEBPACK_AMD_DEFINE_RESULT__ = (function(_, Shape, ImageBox, BoundHandle, RotationHandle, Bound) {
  "use strict";
  var Barcode;
  return Barcode = (function(_super) {
    __extends(Barcode, _super);

    function Barcode() {
      return Barcode.__super__.constructor.apply(this, arguments);
    }

    Barcode.prototype.onadded = function(container) {
      this.set('src', this.makeurl());
      return Barcode.__super__.onadded.call(this, container);
    };

    Barcode.prototype.makeurl = function() {
      var src;
      src = 'http://barcode.hatiolab.com:81/?';
      src += 'text=' + window.escape(this.get('text'));
      src += '&bcid=' + (this.get('symbol') || 'code128');
      src += '&wscale=' + (this.get('scale-w') || 2);
      src += '&hscale=' + (this.get('scale-h') || 2);
      src += '&rotate=' + (this.get('rotation') || 'N');
      if (this.get('alttext')) {
        src += '&alttext=' + window.escape(this.get('alttext'));
      } else if (this.get('includetext')) {
        src += '&alttext=' + window.escape(this.get('text'));
      }
      if (this.get('barcolor') && this.get('barcolor') !== '#000000') {
        src += '&barcolor=' + window.escape(this.get('barcolor'));
      }
      if (this.get('backgroundcolor') && this.get('backgroundcolor') !== '#FFFFFF') {
        src += '&backgroundcolor=' + window.escape(this.get('backgroundcolor'));
      }
      return src;
    };

    Barcode.prototype.event_map = function() {
      var map;
      return map = {
        '(self)': {
          '(self)': {
            change: function(component, before, after) {
              var picked;
              picked = _.pick(after, ['symbol', 'text', 'alttext', 'scale-h', 'scale-w', 'rotation', 'includetext', 'barcolor', 'backgroundcolor']);
              if (!_.isEmpty(picked)) {
                this.silentSet('src', this.makeurl());
                return this.image.src = this.get('src');
              }
            }
          }
        }
      };
    };

    Barcode.spec = {
      type: 'barcode',
      source: 'core:shape.Barcode',
      containable: false,
      description: 'Barcode',
      dependencies: {
        'bound-handle': BoundHandle,
        'rotation-handle': RotationHandle
      },
      properties: [
        Shape.spec.properties, Bound, {
          'symbol': {
            type: 'string'
          },
          'text': {
            type: 'string'
          },
          'alttext': {
            type: 'string'
          },
          'scale-h': {
            type: 'number'
          },
          'scale-w': {
            type: 'number'
          },
          'rotation': {
            type: 'sring'
          },
          'includetext': {
            type: 'boolean'
          },
          'barcolor': {
            type: 'string'
          },
          'backgroundcolor': {
            type: 'string'
          }
        }
      ]
    };

    return Barcode;

  })(ImageBox);
}.apply(null, __WEBPACK_AMD_DEFINE_ARRAY__)), __WEBPACK_AMD_DEFINE_RESULT__ !== undefined && (module.exports = __WEBPACK_AMD_DEFINE_RESULT__));


/***/ },
/* 10 */
/***/ function(module, exports, __webpack_require__) {

var __WEBPACK_AMD_DEFINE_ARRAY__, __WEBPACK_AMD_DEFINE_RESULT__;var __hasProp = {}.hasOwnProperty,
  __extends = function(child, parent) { for (var key in parent) { if (__hasProp.call(parent, key)) child[key] = parent[key]; } function ctor() { this.constructor = child; } ctor.prototype = parent.prototype; child.prototype = new ctor(); child.__super__ = parent.prototype; return child; };

!(__WEBPACK_AMD_DEFINE_ARRAY__ = [__webpack_require__(40), __webpack_require__(5), __webpack_require__(26)], __WEBPACK_AMD_DEFINE_RESULT__ = (function(_, Shape, CircleHandle) {
  'use strict';
  var Circle;
  return Circle = (function(_super) {
    __extends(Circle, _super);

    function Circle() {
      return Circle.__super__.constructor.apply(this, arguments);
    }

    Circle.prototype.center = function() {
      return {
        x: this.get('cx'),
        y: this.get('cy')
      };
    };

    Circle.prototype.shape = function(context) {
      return context.arc(this.get('cx'), this.get('cy'), this.get('r'), 0, 2 * Math.PI, false);
    };

    Circle.prototype.handles = function() {
      return ['circle-handle'];
    };

    Circle.prototype.positions = function() {
      return [['cx', 'cy']];
    };

    Circle.prototype.dockPoints = function() {
      var angle, cx, cy, points, r, _i;
      cx = this.get('cx');
      cy = this.get('cy');
      r = this.get('r');
      points = [];
      for (angle = _i = 0; _i <= 359; angle = _i += 45) {
        points.push([cx + Math.cos(angle * Math.PI / 180) * r, cy - Math.sin(angle * Math.PI / 180) * r]);
      }
      return points;
    };

    Circle.spec = {
      type: 'circle',
      source: 'core:shape.Circle',
      containable: false,
      description: 'Circle',
      dependencies: {
        'circle-handle': CircleHandle
      },
      properties: [
        Shape.spec.properties, {
          cx: {
            type: 'number',
            "default": 0
          },
          cy: {
            type: 'number',
            "default": 0
          },
          r: {
            type: 'number',
            "default": 100
          }
        }
      ]
    };

    return Circle;

  })(Shape);
}.apply(null, __WEBPACK_AMD_DEFINE_ARRAY__)), __WEBPACK_AMD_DEFINE_RESULT__ !== undefined && (module.exports = __WEBPACK_AMD_DEFINE_RESULT__));


/***/ },
/* 11 */
/***/ function(module, exports, __webpack_require__) {

var __WEBPACK_AMD_DEFINE_ARRAY__, __WEBPACK_AMD_DEFINE_RESULT__;var __hasProp = {}.hasOwnProperty,
  __extends = function(child, parent) { for (var key in parent) { if (__hasProp.call(parent, key)) child[key] = parent[key]; } function ctor() { this.constructor = child; } ctor.prototype = parent.prototype; child.prototype = new ctor(); child.__super__ = parent.prototype; return child; };

!(__WEBPACK_AMD_DEFINE_ARRAY__ = [__webpack_require__(5), __webpack_require__(25), __webpack_require__(30), __webpack_require__(45)], __WEBPACK_AMD_DEFINE_RESULT__ = (function(Shape, BoundHandle, RotationHandle, Bound) {
  'use strict';
  var Ellipse;
  return Ellipse = (function(_super) {
    __extends(Ellipse, _super);

    function Ellipse() {
      return Ellipse.__super__.constructor.apply(this, arguments);
    }

    Ellipse.prototype.shape = function(context) {
      var cx, cy, h, r, w, x, y;
      x = this.get('x');
      y = this.get('y');
      w = this.get('w');
      h = this.get('h');
      cx = x + w / 2;
      cy = y + h / 2;
      r = w / 2;
      context.save();
      context.scale(1, h / w);
      context.arc(cx, cy * w / h, r, 0, 2 * Math.PI, false);
      return context.restore();
    };

    Ellipse.spec = {
      type: 'ellipse',
      source: 'core:shape.Ellipse',
      containable: false,
      description: 'Ellipse',
      dependencies: {
        'bound-handle': BoundHandle,
        'rotation-handle': RotationHandle
      },
      properties: [Shape.spec.properties, Bound]
    };

    return Ellipse;

  })(Shape);
}.apply(null, __WEBPACK_AMD_DEFINE_ARRAY__)), __WEBPACK_AMD_DEFINE_RESULT__ !== undefined && (module.exports = __WEBPACK_AMD_DEFINE_RESULT__));


/***/ },
/* 12 */
/***/ function(module, exports, __webpack_require__) {

var __WEBPACK_AMD_DEFINE_ARRAY__, __WEBPACK_AMD_DEFINE_RESULT__;var __hasProp = {}.hasOwnProperty,
  __extends = function(child, parent) { for (var key in parent) { if (__hasProp.call(parent, key)) child[key] = parent[key]; } function ctor() { this.constructor = child; } ctor.prototype = parent.prototype; child.prototype = new ctor(); child.__super__ = parent.prototype; return child; };

!(__WEBPACK_AMD_DEFINE_ARRAY__ = [__webpack_require__(5), __webpack_require__(25), __webpack_require__(30), __webpack_require__(45)], __WEBPACK_AMD_DEFINE_RESULT__ = (function(Shape, BoundHandle, RotationHandle, Bound) {
  "use strict";
  var ImageBox, error_image, error_image_url, loading_image, loading_image_url;
  error_image_url = 'data:image/png;base64,iVBORw0KGgoAAAANSUhEUgAAAEAAAABACAYAAACqaXHeAAAAGXRFWHRTb2Z0d2FyZQBBZG9iZSBJbWFnZVJlYWR5ccllPAAAAyRpVFh0WE1MOmNvbS5hZG9iZS54bXAAAAAAADw/eHBhY2tldCBiZWdpbj0i77u/IiBpZD0iVzVNME1wQ2VoaUh6cmVTek5UY3prYzlkIj8+IDx4OnhtcG1ldGEgeG1sbnM6eD0iYWRvYmU6bnM6bWV0YS8iIHg6eG1wdGs9IkFkb2JlIFhNUCBDb3JlIDUuMy1jMDExIDY2LjE0NTY2MSwgMjAxMi8wMi8wNi0xNDo1NjoyNyAgICAgICAgIj4gPHJkZjpSREYgeG1sbnM6cmRmPSJodHRwOi8vd3d3LnczLm9yZy8xOTk5LzAyLzIyLXJkZi1zeW50YXgtbnMjIj4gPHJkZjpEZXNjcmlwdGlvbiByZGY6YWJvdXQ9IiIgeG1sbnM6eG1wPSJodHRwOi8vbnMuYWRvYmUuY29tL3hhcC8xLjAvIiB4bWxuczp4bXBNTT0iaHR0cDovL25zLmFkb2JlLmNvbS94YXAvMS4wL21tLyIgeG1sbnM6c3RSZWY9Imh0dHA6Ly9ucy5hZG9iZS5jb20veGFwLzEuMC9zVHlwZS9SZXNvdXJjZVJlZiMiIHhtcDpDcmVhdG9yVG9vbD0iQWRvYmUgUGhvdG9zaG9wIENTNiAoTWFjaW50b3NoKSIgeG1wTU06SW5zdGFuY2VJRD0ieG1wLmlpZDoxQjE5RkJCRDBDNTgxMUU0QTVGNEQ5RDg5NURCQUE1MSIgeG1wTU06RG9jdW1lbnRJRD0ieG1wLmRpZDoxQjE5RkJCRTBDNTgxMUU0QTVGNEQ5RDg5NURCQUE1MSI+IDx4bXBNTTpEZXJpdmVkRnJvbSBzdFJlZjppbnN0YW5jZUlEPSJ4bXAuaWlkOjkwNTBFREMwMEMyOTExRTRBNUY0RDlEODk1REJBQTUxIiBzdFJlZjpkb2N1bWVudElEPSJ4bXAuZGlkOjFCMTlGQkJDMEM1ODExRTRBNUY0RDlEODk1REJBQTUxIi8+IDwvcmRmOkRlc2NyaXB0aW9uPiA8L3JkZjpSREY+IDwveDp4bXBtZXRhPiA8P3hwYWNrZXQgZW5kPSJyIj8+EIm4tgAAAM9JREFUeNrs2jEKwjAUBuBGegoFz6KbzjlnZkfPouA5ohG7lA6CVALv+6dH6JB8fa8U2lRrHSJnMwQPAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAgCgZpyKltA0N0FJrfUQ6/Oum77oegfv5uGr9Rpg+j7cRmDqglPLVBnPOq1073/D+cl3E+WW9+w74S1oHfLqgdUBXuZ0Oq9btzIsjEOkhOM4Xok1A8o+QV2EAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAIfIUYAC90yH3CRmYMwAAAABJRU5ErkJggg==';
  loading_image_url = 'data:image/png;base64,iVBORw0KGgoAAAANSUhEUgAAAEAAAABACAYAAACqaXHeAAAAGXRFWHRTb2Z0d2FyZQBBZG9iZSBJbWFnZVJlYWR5ccllPAAAAyRpVFh0WE1MOmNvbS5hZG9iZS54bXAAAAAAADw/eHBhY2tldCBiZWdpbj0i77u/IiBpZD0iVzVNME1wQ2VoaUh6cmVTek5UY3prYzlkIj8+IDx4OnhtcG1ldGEgeG1sbnM6eD0iYWRvYmU6bnM6bWV0YS8iIHg6eG1wdGs9IkFkb2JlIFhNUCBDb3JlIDUuMy1jMDExIDY2LjE0NTY2MSwgMjAxMi8wMi8wNi0xNDo1NjoyNyAgICAgICAgIj4gPHJkZjpSREYgeG1sbnM6cmRmPSJodHRwOi8vd3d3LnczLm9yZy8xOTk5LzAyLzIyLXJkZi1zeW50YXgtbnMjIj4gPHJkZjpEZXNjcmlwdGlvbiByZGY6YWJvdXQ9IiIgeG1sbnM6eG1wPSJodHRwOi8vbnMuYWRvYmUuY29tL3hhcC8xLjAvIiB4bWxuczp4bXBNTT0iaHR0cDovL25zLmFkb2JlLmNvbS94YXAvMS4wL21tLyIgeG1sbnM6c3RSZWY9Imh0dHA6Ly9ucy5hZG9iZS5jb20veGFwLzEuMC9zVHlwZS9SZXNvdXJjZVJlZiMiIHhtcDpDcmVhdG9yVG9vbD0iQWRvYmUgUGhvdG9zaG9wIENTNiAoTWFjaW50b3NoKSIgeG1wTU06SW5zdGFuY2VJRD0ieG1wLmlpZDo5MDUwRURCRTBDMjkxMUU0QTVGNEQ5RDg5NURCQUE1MSIgeG1wTU06RG9jdW1lbnRJRD0ieG1wLmRpZDo5MDUwRURCRjBDMjkxMUU0QTVGNEQ5RDg5NURCQUE1MSI+IDx4bXBNTTpEZXJpdmVkRnJvbSBzdFJlZjppbnN0YW5jZUlEPSJ4bXAuaWlkOjkwNTBFREJDMEMyOTExRTRBNUY0RDlEODk1REJBQTUxIiBzdFJlZjpkb2N1bWVudElEPSJ4bXAuZGlkOjkwNTBFREJEMEMyOTExRTRBNUY0RDlEODk1REJBQTUxIi8+IDwvcmRmOkRlc2NyaXB0aW9uPiA8L3JkZjpSREY+IDwveDp4bXBtZXRhPiA8P3hwYWNrZXQgZW5kPSJyIj8+7sUUWAAAAJxJREFUeNrs1rENgDAMBMAYZQoYg9UYg9UYgzkCNKkoaKDA92WUNKeXnWitlcwJAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAABypHaJiDE1wJWzDXuq+kdMQ0meene4bvHo8TK31+5+lfQN6FvgGoJmQPYG+AgBAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAADgrzkEGABRjr72QvS8kQAAAABJRU5ErkJggg==';
  loading_image = new Image();
  loading_image.src = loading_image_url;
  error_image = new Image();
  error_image.src = error_image_url;
  return ImageBox = (function(_super) {
    __extends(ImageBox, _super);

    function ImageBox() {
      return ImageBox.__super__.constructor.apply(this, arguments);
    }

    ImageBox.prototype.capture_shape = function(context) {
      return context.rect(this.get('x'), this.get('y'), this.get('w'), this.get('h'));
    };

    ImageBox.prototype.resize = function() {
      var image;
      switch (this.state) {
        case 'loaded':
          image = this.image;
          break;
        case 'error':
          image = error_image;
          break;
        default:
          image = loading_image;
      }
      return this.set({
        w: !this.config('w') ? image.width : this.get('w'),
        h: !this.config('h') ? image.width : this.get('g')
      });
    };

    ImageBox.prototype.onadded = function(container) {
      var self;
      this.image = new Image();
      this.state = 'loading';
      this.resize();
      self = this;
      this.image.onload = function() {
        self.state = 'loaded';
        return self.resize();
      };
      this.image.onerror = function() {
        self.state = 'error';
        return self.resize();
      };
      return this.image.src = this.get('src');
    };

    ImageBox.prototype.shape = function(context) {
      var image;
      switch (this.state) {
        case 'loaded':
          image = this.image;
          break;
        case 'error':
          image = error_image;
          break;
        default:
          image = loading_image;
      }
      return context.drawImage(image, this.get('x'), this.get('y'), this.get('w'), this.get('h'));
    };

    ImageBox.prototype.event_map = function() {
      var map;
      return map = {
        '(self)': {
          '(self)': {
            change: function(component, before, after) {
              if (!after.hasOwnProperty('src')) {
                return;
              }
              this.state = 'loading';
              return this.image.src = after['src'];
            }
          }
        }
      };
    };

    ImageBox.spec = {
      type: 'image',
      source: 'core:shape.ImageBox',
      containable: false,
      description: 'ImageBox',
      dependencies: {
        'bound-handle': BoundHandle,
        'rotation-handle': RotationHandle
      },
      properties: [
        Shape.spec.properties, Bound, {
          src: {
            type: 'string'
          }
        }
      ]
    };

    return ImageBox;

  })(Shape);
}.apply(null, __WEBPACK_AMD_DEFINE_ARRAY__)), __WEBPACK_AMD_DEFINE_RESULT__ !== undefined && (module.exports = __WEBPACK_AMD_DEFINE_RESULT__));


/***/ },
/* 13 */
/***/ function(module, exports, __webpack_require__) {

var __WEBPACK_AMD_DEFINE_ARRAY__, __WEBPACK_AMD_DEFINE_RESULT__;var __hasProp = {}.hasOwnProperty,
  __extends = function(child, parent) { for (var key in parent) { if (__hasProp.call(parent, key)) child[key] = parent[key]; } function ctor() { this.constructor = child; } ctor.prototype = parent.prototype; child.prototype = new ctor(); child.__super__ = parent.prototype; return child; };

!(__WEBPACK_AMD_DEFINE_ARRAY__ = [__webpack_require__(40), __webpack_require__(5), __webpack_require__(29), __webpack_require__(55)], __WEBPACK_AMD_DEFINE_RESULT__ = (function(_, Shape, PathHandle, PathProps) {
  'use strict';
  var Path;
  return Path = (function(_super) {
    __extends(Path, _super);

    function Path() {
      return Path.__super__.constructor.apply(this, arguments);
    }

    Path.prototype.center = function() {
      var i, path, size, sum_x, sum_y, _i, _len;
      path = this.get('path');
      size = path.length;
      sum_x = 0;
      sum_y = 0;
      for (_i = 0, _len = path.length; _i < _len; _i++) {
        i = path[_i];
        sum_x += i[0];
        sum_y += i[1];
      }
      return {
        x: sum_x / size,
        y: sum_y / size
      };
    };

    Path.prototype.shape = function(context) {
      var i, path, size, start, _i, _results;
      path = this.get('path');
      size = path.length;
      start = path[0];
      context.moveTo(start[0], start[1]);
      _results = [];
      for (i = _i = 0; 0 <= size ? _i < size : _i > size; i = 0 <= size ? ++_i : --_i) {
        _results.push(context.lineTo(path[i][0], path[i][1]));
      }
      return _results;
    };

    Path.prototype.handles = function() {
      return ['path-handle'];
    };

    Path.prototype.positions = function() {
      return 'path';
    };

    Path.prototype.dockPoints = function() {
      return this.get('path');
    };

    Path.prototype.event_map = function() {};

    Path.spec = {
      type: 'path',
      source: 'core:shape.Path',
      containable: false,
      description: 'Path',
      dependencies: {
        'path-handle': PathHandle
      },
      properties: [Shape.spec.properties, PathProps]
    };

    return Path;

  })(Shape);
}.apply(null, __WEBPACK_AMD_DEFINE_ARRAY__)), __WEBPACK_AMD_DEFINE_RESULT__ !== undefined && (module.exports = __WEBPACK_AMD_DEFINE_RESULT__));


/***/ },
/* 14 */
/***/ function(module, exports, __webpack_require__) {

var __WEBPACK_AMD_DEFINE_ARRAY__, __WEBPACK_AMD_DEFINE_RESULT__;var __hasProp = {}.hasOwnProperty,
  __extends = function(child, parent) { for (var key in parent) { if (__hasProp.call(parent, key)) child[key] = parent[key]; } function ctor() { this.constructor = child; } ctor.prototype = parent.prototype; child.prototype = new ctor(); child.__super__ = parent.prototype; return child; };

!(__WEBPACK_AMD_DEFINE_ARRAY__ = [__webpack_require__(5), __webpack_require__(25), __webpack_require__(30), __webpack_require__(45)], __WEBPACK_AMD_DEFINE_RESULT__ = (function(Shape, BoundHandle, RotationHandle, Bound) {
  'use strict';
  var Rect;
  return Rect = (function(_super) {
    __extends(Rect, _super);

    function Rect() {
      return Rect.__super__.constructor.apply(this, arguments);
    }

    Rect.prototype.shape = function(context) {
      return context.rect(this.get('x'), this.get('y'), this.get('w'), this.get('h'));
    };

    Rect.spec = {
      type: 'rect',
      source: 'core:shape.Rect',
      containable: false,
      description: 'Rectangle',
      dependencies: {
        'bound-handle': BoundHandle,
        'rotation-handle': RotationHandle
      },
      properties: [Shape.spec.properties, Bound]
    };

    return Rect;

  })(Shape);
}.apply(null, __WEBPACK_AMD_DEFINE_ARRAY__)), __WEBPACK_AMD_DEFINE_RESULT__ !== undefined && (module.exports = __WEBPACK_AMD_DEFINE_RESULT__));


/***/ },
/* 15 */
/***/ function(module, exports, __webpack_require__) {

var __WEBPACK_AMD_DEFINE_ARRAY__, __WEBPACK_AMD_DEFINE_RESULT__;var __hasProp = {}.hasOwnProperty,
  __extends = function(child, parent) { for (var key in parent) { if (__hasProp.call(parent, key)) child[key] = parent[key]; } function ctor() { this.constructor = child; } ctor.prototype = parent.prototype; child.prototype = new ctor(); child.__super__ = parent.prototype; return child; };

!(__WEBPACK_AMD_DEFINE_ARRAY__ = [__webpack_require__(5), __webpack_require__(25), __webpack_require__(30), __webpack_require__(45), __webpack_require__(56)], __WEBPACK_AMD_DEFINE_RESULT__ = (function(Shape, BoundHandle, RotationHandle, Bound, Font) {
  "use strict";
  var PIXEL_PER_MM, Ruler;
  PIXEL_PER_MM = 3.779527559;
  return Ruler = (function(_super) {
    __extends(Ruler, _super);

    function Ruler() {
      return Ruler.__super__.constructor.apply(this, arguments);
    }

    Ruler.prototype.capture_shape = function(context) {
      return context.rect(this.get('x'), this.get('y'), this.get('w'), this.get('h'));
    };

    Ruler.prototype.shape = function(context) {
      var dimension;
      dimension = this.bound();
      context.rect(dimension.x, dimension.y, dimension.w, dimension.h);
      if (this.get('direction') !== 'vertical') {
        return this.drawHorizontal(context, dimension);
      } else {
        return this.drawVertical(context, dimension);
      }
    };

    Ruler.prototype.drawHorizontal = function(context, dimension) {
      var baseY, bottomY, i, marginLeft, marginRight, minusCount, minusWidth, plusCount, plusWidth, startX, x, zeropos, _i, _j, _k, _l, _ref, _ref1, _ref2, _ref3, _results;
      zeropos = parseInt(this.get('zeropos'));
      startX = dimension.x + zeropos;
      marginLeft = dimension.x + this.get('margin')[0];
      marginRight = dimension.x + dimension.w - this.get('margin')[1];
      baseY = dimension.y + dimension.h - 15;
      bottomY = dimension.y + dimension.h;
      plusWidth = dimension.w - zeropos;
      plusCount = Math.ceil(plusWidth / PIXEL_PER_MM);
      for (i = _i = 0, _ref = plusCount - 1; 0 <= _ref ? _i <= _ref : _i >= _ref; i = 0 <= _ref ? ++_i : --_i) {
        x = startX + i * PIXEL_PER_MM;
        if (x > marginRight) {
          break;
        }
        if (x < marginLeft) {
          continue;
        }
        if (i % 10 === 0) {
          context.moveTo(x, baseY);
          context.lineTo(x, bottomY);
        } else if (i % 5 === 0) {
          context.moveTo(x, baseY + 8);
          context.lineTo(x, bottomY);
        } else {
          context.moveTo(x, baseY + 11);
          context.lineTo(x, bottomY);
        }
      }
      minusWidth = zeropos;
      minusCount = Math.floor(minusWidth / PIXEL_PER_MM);
      for (i = _j = 1, _ref1 = minusCount - 1; 1 <= _ref1 ? _j <= _ref1 : _j >= _ref1; i = 1 <= _ref1 ? ++_j : --_j) {
        x = startX - i * PIXEL_PER_MM;
        if (x < marginLeft) {
          break;
        }
        if (x > marginRight) {
          continue;
        }
        if (i % 10 === 0) {
          context.moveTo(x, baseY);
          context.lineTo(x, bottomY);
        } else if (i % 5 === 0) {
          context.moveTo(x, baseY + 8);
          context.lineTo(x, bottomY);
        } else {
          context.moveTo(x, baseY + 11);
          context.lineTo(x, bottomY);
        }
      }
      context.textAlign = 'left';
      context.textBaseline = 'bottom';
      for (i = _k = 0, _ref2 = plusCount - 1; _k <= _ref2; i = _k += 10) {
        x = startX + i * PIXEL_PER_MM;
        if (x > marginRight) {
          break;
        }
        if (x < marginLeft) {
          continue;
        }
        context.fillText("" + (i / 10), x + 2, baseY + 10);
      }
      _results = [];
      for (i = _l = 10, _ref3 = minusCount - 1; _l <= _ref3; i = _l += 10) {
        x = startX - i * PIXEL_PER_MM;
        if (x < marginLeft) {
          break;
        }
        if (x > marginRight) {
          continue;
        }
        _results.push(context.fillText("-" + (i / 10), x + 2, baseY + 10));
      }
      return _results;
    };

    Ruler.prototype.drawVertical = function(context, dimension) {
      var baseX, endX, i, marginBottom, marginTop, minusArea, minusCount, plusArea, plusCount, startY, y, zeropos, _i, _j, _k, _l, _ref, _ref1, _ref2, _ref3, _results;
      zeropos = parseInt(this.get('zeropos'));
      startY = dimension.y + zeropos;
      marginTop = dimension.y + this.get('margin')[0];
      marginBottom = dimension.y + dimension.h - this.get('margin')[1];
      baseX = dimension.x + dimension.w - 15;
      endX = dimension.x + dimension.w;
      plusArea = dimension.h - zeropos;
      plusCount = Math.ceil(plusArea / PIXEL_PER_MM);
      for (i = _i = 0, _ref = plusCount - 1; 0 <= _ref ? _i <= _ref : _i >= _ref; i = 0 <= _ref ? ++_i : --_i) {
        y = startY + i * PIXEL_PER_MM;
        if (y > marginBottom) {
          break;
        }
        if (y < marginTop) {
          continue;
        }
        if (i % 10 === 0) {
          context.moveTo(baseX, y);
          context.lineTo(endX, y);
        } else if (i % 5 === 0) {
          context.moveTo(baseX + 8, y);
          context.lineTo(endX, y);
        } else {
          context.moveTo(baseX + 11, y);
          context.lineTo(endX, y);
        }
      }
      minusArea = zeropos;
      minusCount = Math.floor(minusArea / PIXEL_PER_MM);
      for (i = _j = 1, _ref1 = minusCount - 1; 1 <= _ref1 ? _j <= _ref1 : _j >= _ref1; i = 1 <= _ref1 ? ++_j : --_j) {
        y = startY - i * PIXEL_PER_MM;
        if (y > marginBottom) {
          continue;
        }
        if (y < marginTop) {
          break;
        }
        if (i % 10 === 0) {
          context.moveTo(baseX, y);
          context.lineTo(endX, y);
        } else if (i % 5 === 0) {
          context.moveTo(baseX + 8, y);
          context.lineTo(endX, y);
        } else {
          context.moveTo(baseX + 11, y);
          context.lineTo(endX, y);
        }
      }
      context.textAlign = 'right';
      context.textBaseline = 'top';
      for (i = _k = 0, _ref2 = plusCount - 1; _k <= _ref2; i = _k += 10) {
        y = startY + i * PIXEL_PER_MM;
        if (y > marginBottom) {
          break;
        }
        if (y < marginTop) {
          continue;
        }
        context.fillText("" + (i / 10), baseX + 10, y + 2);
      }
      _results = [];
      for (i = _l = 10, _ref3 = minusCount - 1; _l <= _ref3; i = _l += 10) {
        y = startY - i * PIXEL_PER_MM;
        if (y < marginTop) {
          break;
        }
        if (y > marginBottom) {
          continue;
        }
        _results.push(context.fillText("-" + (i / 10), baseX + 10, y + 2));
      }
      return _results;
    };

    Ruler.spec = {
      type: 'ruler',
      source: 'core:shape.Ruler',
      containable: false,
      description: 'Ruler',
      dependencies: {
        'bound-handle': BoundHandle,
        'rotation-handle': RotationHandle
      },
      properties: [
        Shape.spec.properties, Bound, Font, {
          'zeropos': {
            type: 'number',
            "default": 0
          },
          'direction': {
            type: 'string',
            "default": 'horizontal'
          },
          'margin': {
            type: 'array',
            "default": [0, 0]
          }
        }
      ]
    };

    return Ruler;

  })(Shape);
}.apply(null, __WEBPACK_AMD_DEFINE_ARRAY__)), __WEBPACK_AMD_DEFINE_RESULT__ !== undefined && (module.exports = __WEBPACK_AMD_DEFINE_RESULT__));


/***/ },
/* 16 */
/***/ function(module, exports, __webpack_require__) {

var __WEBPACK_AMD_DEFINE_ARRAY__, __WEBPACK_AMD_DEFINE_RESULT__;var __hasProp = {}.hasOwnProperty,
  __extends = function(child, parent) { for (var key in parent) { if (__hasProp.call(parent, key)) child[key] = parent[key]; } function ctor() { this.constructor = child; } ctor.prototype = parent.prototype; child.prototype = new ctor(); child.__super__ = parent.prototype; return child; };

!(__WEBPACK_AMD_DEFINE_ARRAY__ = [__webpack_require__(5), __webpack_require__(45), __webpack_require__(56)], __WEBPACK_AMD_DEFINE_RESULT__ = (function(Shape, Bound, Font) {
  'use strict';
  var Text;
  return Text = (function(_super) {
    __extends(Text, _super);

    function Text() {
      return Text.__super__.constructor.apply(this, arguments);
    }

    Text.prototype._wrap = function(context, text, x, y, max_width, line_height) {
      var i, line, metrics, testLine, testWidth, word, words, _i, _len;
      words = text.split(' ');
      line = '';
      for (i = _i = 0, _len = words.length; _i < _len; i = ++_i) {
        word = words[i];
        testLine = line + word + ' ';
        metrics = context.measureText(testLine);
        testWidth = metrics.width;
        if (testWidth > max_width && i > 0) {
          context.fillText(line, x, y);
          line = word + ' ';
          y += line_height;
        } else {
          line = testLine;
        }
      }
      return context.fillText(line, x, y);
    };

    Text.prototype.shape = function(context) {
      this._wrap(context, this.get('text'), this.get('x'), this.get('y'), this.get('w'), 10);
      return context.font = this.get('font');
    };

    Text.spec = {
      type: 'text',
      source: 'core:shape.Text',
      containable: false,
      description: 'Text Box',
      dependencies: {},
      properties: [
        Shape.spec.properties, Bound, Font, {
          text: {
            type: 'string',
            "default": ''
          }
        }
      ]
    };

    return Text;

  })(Shape);
}.apply(null, __WEBPACK_AMD_DEFINE_ARRAY__)), __WEBPACK_AMD_DEFINE_RESULT__ !== undefined && (module.exports = __WEBPACK_AMD_DEFINE_RESULT__));


/***/ },
/* 17 */
/***/ function(module, exports, __webpack_require__) {

var __WEBPACK_AMD_DEFINE_ARRAY__, __WEBPACK_AMD_DEFINE_RESULT__;var __hasProp = {}.hasOwnProperty,
  __extends = function(child, parent) { for (var key in parent) { if (__hasProp.call(parent, key)) child[key] = parent[key]; } function ctor() { this.constructor = child; } ctor.prototype = parent.prototype; child.prototype = new ctor(); child.__super__ = parent.prototype; return child; };

!(__WEBPACK_AMD_DEFINE_ARRAY__ = [__webpack_require__(40), __webpack_require__(5), __webpack_require__(28), __webpack_require__(57)], __WEBPACK_AMD_DEFINE_RESULT__ = (function(_, Shape, P2PHandle, P2P) {
  'use strict';
  var Line;
  return Line = (function(_super) {
    __extends(Line, _super);

    function Line() {
      return Line.__super__.constructor.apply(this, arguments);
    }

    Line.prototype.center = function() {
      return {
        x: (this.get('x1') + this.get('x2')) / 2,
        y: (this.get('y1') + this.get('y2')) / 2
      };
    };

    Line.prototype.shape = function(context) {
      context.moveTo(this.get('x1'), this.get('y1'));
      return context.lineTo(this.get('x2'), this.get('y2'));
    };

    Line.prototype.handles = function() {
      return ['p2p-handle'];
    };

    Line.prototype.positions = function() {
      return [['x1', 'y1'], ['x2', 'y2']];
    };

    Line.prototype.dockPoints = function() {
      return [[this.get('x1'), this.get('y1')], [this.get('x2'), this.get('y2')]];
    };

    Line.prototype.event_map = function() {};

    Line.spec = {
      type: 'line',
      source: 'core:shape.Line',
      containable: false,
      description: 'Direct Line',
      dependencies: {
        'p2p-handle': P2PHandle
      },
      properties: [Shape.spec.properties, P2P]
    };

    return Line;

  })(Shape);
}.apply(null, __WEBPACK_AMD_DEFINE_ARRAY__)), __WEBPACK_AMD_DEFINE_RESULT__ !== undefined && (module.exports = __WEBPACK_AMD_DEFINE_RESULT__));


/***/ },
/* 18 */
/***/ function(module, exports, __webpack_require__) {

var __WEBPACK_AMD_DEFINE_ARRAY__, __WEBPACK_AMD_DEFINE_RESULT__;var __hasProp = {}.hasOwnProperty,
  __extends = function(child, parent) { for (var key in parent) { if (__hasProp.call(parent, key)) child[key] = parent[key]; } function ctor() { this.constructor = child; } ctor.prototype = parent.prototype; child.prototype = new ctor(); child.__super__ = parent.prototype; return child; };

!(__WEBPACK_AMD_DEFINE_ARRAY__ = [__webpack_require__(3), __webpack_require__(16), __webpack_require__(58)], __WEBPACK_AMD_DEFINE_RESULT__ = (function(Layer, Text, pp) {
  'use strict';
  var DebugLayer, exports;
  exports = {
    debug: function(category, content) {
      var get_debug_layer, get_debug_text;
      get_debug_layer = (function(_this) {
        return function() {
          return _this.debug_layer || (!_this.debug_layer ? _this.debug_layer = _this.select('debug-layer')[0] : void 0);
        };
      })(this);
      get_debug_text = (function(_this) {
        return function() {
          return _this.debug_text || (!_this.debug_text ? _this.debug_text = _this.select('text', get_debug_layer())[0] : void 0);
        };
      })(this);
      get_debug_text().set('text', category + ':' + pp(content));
      return get_debug_layer().draw();
    }
  };
  return DebugLayer = (function(_super) {
    __extends(DebugLayer, _super);

    function DebugLayer() {
      return DebugLayer.__super__.constructor.apply(this, arguments);
    }

    DebugLayer.spec = {
      type: 'debug-layer',
      source: 'core:layer.DebugLayer',
      containable: true,
      container_type: 'layer',
      description: 'Debug Layer',
      dependencies: {
        'text': Text
      },
      properties: [Layer.spec.properties],
      components: [
        {
          type: 'text',
          name: 'debug-text',
          config: {
            text: '',
            x: 0,
            y: 20,
            w: 300,
            h: 300,
            capturable: false
          }
        }
      ],
      exports: exports
    };

    return DebugLayer;

  })(Layer);
}.apply(null, __WEBPACK_AMD_DEFINE_ARRAY__)), __WEBPACK_AMD_DEFINE_RESULT__ !== undefined && (module.exports = __WEBPACK_AMD_DEFINE_RESULT__));


/***/ },
/* 19 */
/***/ function(module, exports, __webpack_require__) {

var __WEBPACK_AMD_DEFINE_ARRAY__, __WEBPACK_AMD_DEFINE_RESULT__;var __hasProp = {}.hasOwnProperty,
  __extends = function(child, parent) { for (var key in parent) { if (__hasProp.call(parent, key)) child[key] = parent[key]; } function ctor() { this.constructor = child; } ctor.prototype = parent.prototype; child.prototype = new ctor(); child.__super__ = parent.prototype; return child; };

!(__WEBPACK_AMD_DEFINE_ARRAY__ = [__webpack_require__(3), __webpack_require__(42), __webpack_require__(10)], __WEBPACK_AMD_DEFINE_RESULT__ = (function(Layer, LayerBehavior, Circle) {
  'use strict';
  var EVENT_MAP, MagnifyLayer, edge, handle, onchange, ontargetchange;
  handle = {
    ondragstart: function(e) {
      return this.handle_last_position = {
        x: e.offsetX,
        y: e.offsetY
      };
    },
    ondrag: function(e) {
      var delta, pos_x, pos_y, position;
      delta = {
        x: e.offsetX - this.handle_last_position.x,
        y: e.offsetY - this.handle_last_position.y
      };
      pos_x = this.get('x') + delta.x;
      pos_y = this.get('y') + delta.y;
      position = {
        'x': pos_x,
        'y': pos_y
      };
      this.set(position);
      this.handle_last_position = {
        x: e.offsetX,
        y: e.offsetY
      };
      return this.draw();
    },
    ondragend: function(e) {
      return this.handle_last_position = null;
    }
  };
  edge = {
    ondragstart: function(e) {
      this.edge_last_position = {
        x: e.offsetX,
        y: e.offsetY
      };
      return this.last_ratio = this.get('ratio');
    },
    ondrag: function(e) {
      var delta, ratio;
      delta = e.offsetY - this.edge_last_position.y;
      ratio = Math.min(Math.max(this.last_ratio + delta / 20, 0.5), 4);
      this.set('ratio', ratio);
      return this.draw();
    },
    ondragend: function(e) {
      return this.edge_last_position = null;
    }
  };
  ontargetchange = function(target, before, after) {
    return this.draw();
  };
  onchange = function(target, before, after) {
    if (after.hasOwnProperty('x')) {
      this.canvas.style.left = after['x'] + 'px';
    }
    if (after.hasOwnProperty('y')) {
      this.canvas.style.top = after['y'] + 'px';
    }
    if (after.hasOwnProperty('r')) {
      this.set({
        w: 2 * after.r,
        h: 2 * after.r
      });
      this.canvas.setAttribute('width', 2 * after.r);
      return this.canvas.setAttribute('height', 2 * after.r);
    }
  };
  EVENT_MAP = {
    '?target': {
      '(all)': {
        'change': ontargetchange
      }
    },
    '(self)': {
      '(self)': {
        'change': onchange
      },
      '#magnify-handle': {
        'dragstart': handle.ondragstart,
        'drag': handle.ondrag,
        'dragend': handle.ondragend
      },
      '#magnify-edge': {
        'dragstart': edge.ondragstart,
        'drag': edge.ondrag,
        'dragend': edge.ondragend
      }
    }
  };
  return MagnifyLayer = (function(_super) {
    __extends(MagnifyLayer, _super);

    function MagnifyLayer() {
      return MagnifyLayer.__super__.constructor.apply(this, arguments);
    }

    MagnifyLayer.prototype.onadded = function(container) {
      var r;
      this.target = this.select(this.get('target'))[0];
      this.magnify_edge = this.select('#magnify-edge')[0];
      r = this.get('r');
      this.set({
        'resizable': false,
        'w': 2 * r,
        'h': 2 * r,
        'x': (this.target.canvas.width / 2) - r,
        'y': (this.target.canvas.height / 2) - r
      });
      this.canvas.setAttribute('width', 2 * r);
      this.canvas.setAttribute('height', 2 * r);
      return this.magnify_edge.set({
        'cx': r,
        'cy': r,
        'r': r - 5
      });
    };

    MagnifyLayer.prototype._draw = function() {
      var context, exceed_h, exceed_w, from_h, from_w, from_x, from_y, max_x, max_y, r, ratio, target_h, target_w, target_x, target_y, to_h, to_w, to_x, to_y;
      if (!this.target) {
        return;
      }
      this.clearCanvas();
      context = this.canvas.getContext('2d');
      context.save();
      context.beginPath();
      r = this.get('r');
      ratio = this.get('ratio');
      context.arc(r, r, r - 1, 0, Math.PI * 2, false);
      context.clip();
      context.rect(0, 0, r * 2, r * 2);
      if (this.get('fillStyle')) {
        context.fillStyle = this.get('fillStyle');
        context.fill();
      }
      target_x = this.get('x') - this.target.get('x') + r;
      target_y = this.get('y') - this.target.get('y') + r;
      target_w = Math.round(r / ratio);
      target_h = target_w;
      from_x = target_x - target_w;
      from_y = target_y - target_h;
      from_w = target_w * 2;
      from_h = target_h * 2;
      to_x = 0;
      to_y = 0;
      to_w = 2 * r;
      to_h = 2 * r;
      if (from_x < 0) {
        to_x += Math.round(-from_x * ratio);
        to_w -= to_x;
        from_w -= -from_x;
        from_x = 0;
      }
      if (from_y < 0) {
        to_y += Math.round(-from_y * ratio);
        to_h -= to_y;
        from_h -= -from_y;
        from_y = 0;
      }
      max_x = this.target.canvas.width;
      exceed_w = (from_x + from_w) - max_x;
      if (exceed_w > 0) {
        from_w -= exceed_w;
        to_w -= Math.round(exceed_w * ratio);
      }
      max_y = this.target.canvas.height;
      exceed_h = (from_y + from_h) - max_y;
      if (exceed_h > 0) {
        from_h -= exceed_h;
        to_h -= Math.round(exceed_h * ratio);
      }
      context.drawImage(this.target.canvas, from_x, from_y, from_w, from_h, to_x, to_y, to_w, to_h);
      context.restore();
      return this.forEach(function(child) {
        return child.draw(context);
      });
    };

    MagnifyLayer.prototype.event_map = function() {
      return [EVENT_MAP, LayerBehavior];
    };

    MagnifyLayer.spec = {
      type: 'magnify-layer',
      source: 'core:layer.MagnifyLayer',
      containable: true,
      container_type: 'layer',
      description: 'Magnify Layer',
      dependencies: {
        'circle': Circle
      },
      properties: [
        Layer.spec.properties, {
          target: {
            type: 'string'
          },
          r: {
            type: 'number'
          },
          ratio: {
            type: 'number'
          }
        }
      ],
      components: [
        {
          type: 'circle',
          config: {
            'id': 'magnify-edge',
            'cx': 100,
            'cy': 100,
            'r': 95,
            'lineWidth': 10,
            'strokeStyle': 'black',
            capturable: true,
            draggable: true
          }
        }, {
          type: 'circle',
          config: {
            'id': 'magnify-handle',
            'cx': 180,
            'cy': 180,
            'r': 16,
            'lineWidth': 8,
            'strokeStyle': 'black',
            'fillStyle': 'red',
            capturable: true,
            draggable: true
          }
        }
      ]
    };

    return MagnifyLayer;

  })(Layer);
}.apply(null, __WEBPACK_AMD_DEFINE_ARRAY__)), __WEBPACK_AMD_DEFINE_RESULT__ !== undefined && (module.exports = __WEBPACK_AMD_DEFINE_RESULT__));


/***/ },
/* 20 */
/***/ function(module, exports, __webpack_require__) {

var __WEBPACK_AMD_DEFINE_ARRAY__, __WEBPACK_AMD_DEFINE_RESULT__;var __hasProp = {}.hasOwnProperty,
  __extends = function(child, parent) { for (var key in parent) { if (__hasProp.call(parent, key)) child[key] = parent[key]; } function ctor() { this.constructor = child; } ctor.prototype = parent.prototype; child.prototype = new ctor(); child.__super__ = parent.prototype; return child; };

!(__WEBPACK_AMD_DEFINE_ARRAY__ = [__webpack_require__(3), __webpack_require__(15), __webpack_require__(42)], __WEBPACK_AMD_DEFINE_RESULT__ = (function(Layer, Ruler, LayerBehavior) {
  "use strict";
  var RulerLayer;
  return RulerLayer = (function(_super) {
    __extends(RulerLayer, _super);

    function RulerLayer() {
      return RulerLayer.__super__.constructor.apply(this, arguments);
    }

    RulerLayer.prototype.onadded = function(container) {
      var rulers;
      this.target = this.select(this.get('target'))[0];
      rulers = this.select('ruler', this);
      this.hori = rulers[0];
      this.vert = rulers[1];
      this.hori.set({
        w: this.target.canvas.width,
        h: 20,
        zeropos: this.target.get('offset-x')
      });
      this.vert.set({
        w: 20,
        h: this.target.canvas.height,
        zeropos: this.target.get('offset-y')
      });
      return this.set({
        x: this.target.get('x'),
        y: this.target.get('y'),
        w: this.target.get('w'),
        h: this.target.get('h')
      });
    };

    RulerLayer.prototype.event_map = function() {
      return [
        LayerBehavior, {
          '?target': {
            '?target': {
              'change': this.onchange
            }
          }
        }
      ];
    };

    RulerLayer.prototype.onchange = function(target, before, after) {
      var hset, picked, vset;
      hset = {};
      vset = {};
      if (after.hasOwnProperty('offset-x')) {
        hset['zeropos'] = after['offset-x'];
      }
      if (after.hasOwnProperty('offset-y')) {
        vset['zeropos'] = after['offset-y'];
      }
      if (after.hasOwnProperty('w')) {
        hset['w'] = after['w'];
      }
      if (after.hasOwnProperty('h')) {
        vset['h'] = after['h'];
      }
      picked = _.pick(after, ['x', 'y', 'w', 'h']);
      if (!_.isEmpty(picked)) {
        this.silentSet(picked);
      }
      if (!_.isEmpty(hset)) {
        this.hori.silentSet(hset);
      }
      if (!_.isEmpty(vset)) {
        this.vert.silentSet(vset);
      }
      return this.draw();
    };

    RulerLayer.spec = {
      type: 'ruler-layer',
      source: 'core:layer.RulerLayer',
      containable: true,
      container_type: 'layer',
      description: 'Ruler Layer',
      dependencies: {
        'ruler': Ruler
      },
      properties: [
        Layer.spec.properties, {
          target: {
            type: 'string'
          }
        }
      ],
      components: [
        {
          type: 'ruler',
          config: {
            direction: 'horizontal',
            margin: [20, 0],
            opacity: 0.8,
            x: 0,
            y: 0,
            zeropos: 20,
            strokeStyle: 'navy',
            lineWidth: 1
          }
        }, {
          type: 'ruler',
          config: {
            direction: 'vertical',
            margin: [20, 0],
            opacity: 0.8,
            x: 0,
            y: 0,
            zeropos: 20,
            strokeStyle: 'navy',
            lineWidth: 1
          }
        }
      ]
    };

    return RulerLayer;

  })(Layer);
}.apply(null, __WEBPACK_AMD_DEFINE_ARRAY__)), __WEBPACK_AMD_DEFINE_RESULT__ !== undefined && (module.exports = __WEBPACK_AMD_DEFINE_RESULT__));


/***/ },
/* 21 */
/***/ function(module, exports, __webpack_require__) {

var __WEBPACK_AMD_DEFINE_ARRAY__, __WEBPACK_AMD_DEFINE_RESULT__;var __hasProp = {}.hasOwnProperty,
  __extends = function(child, parent) { for (var key in parent) { if (__hasProp.call(parent, key)) child[key] = parent[key]; } function ctor() { this.constructor = child; } ctor.prototype = parent.prototype; child.prototype = new ctor(); child.__super__ = parent.prototype; return child; };

!(__WEBPACK_AMD_DEFINE_ARRAY__ = [__webpack_require__(3), __webpack_require__(42)], __WEBPACK_AMD_DEFINE_RESULT__ = (function(Layer, LayerBehavior) {
  'use strict';
  var EVENT_MAP, SelectionLayer, WIDGETS_HANDLER, WIDGET_LAYER_HANDLER, onselfchange, parent_groups_translate, select, select_add, select_toggle;
  select_toggle = function(selections, target) {
    if (_.contains(selections, target)) {
      _.pull(selections, target);
    } else {
      selections.unshift(target);
    }
    return selections;
  };
  select = function(selections, target) {
    if (_.contains(selections, target)) {
      return selections;
    }
    return [target];
  };
  select_add = function(selections, target) {
    if (_.contains(selections, target)) {
      return selections;
    }
    selections.unshift(target);
    return selections;
  };
  WIDGETS_HANDLER = {
    ondragstart: function(e) {
      if (e.origin.shiftKey) {
        this.selections = select_add(this.selections, e.target);
      } else {
        this.selections = select(this.selections, e.target);
      }
      this.setFocus(this.selections[0]);
      return this.draglast_position = {
        x: e.offsetX,
        y: e.offsetY
      };
    },
    ondrag: function(e) {
      this.offset = {
        x: e.offsetX - this.draglast_position.x,
        y: e.offsetY - this.draglast_position.y
      };
      return this.draw();
    },
    ondragend: function(e) {
      var item, _i, _len, _ref;
      _ref = this.selections;
      for (_i = 0, _len = _ref.length; _i < _len; _i++) {
        item = _ref[_i];
        if (item.move) {
          item.move({
            delta: this.offset
          }, true);
        }
      }
      this.offset = null;
      return this.draw();
    },
    onclick: function(e) {
      if (e.origin.shiftKey) {
        this.selections = select_toggle(this.selections, e.target);
      } else {
        this.selections = select(this.selections, e.target);
      }
      this.setFocus(this.selections[0]);
      return this.draw();
    }
  };
  WIDGET_LAYER_HANDLER = {
    ondragstart: function(e) {
      this.selections = [];
      this.setFocus();
      this.select_last_position = {
        x: e.offsetX,
        y: e.offsetY
      };
      return this.selection_box = this.build({
        type: 'rect',
        config: {
          x: this.select_last_position.x - this.target.get('offset-x'),
          y: this.select_last_position.y - this.target.get('offset-y'),
          w: 0,
          h: 0,
          strokeStyle: 'black',
          lineWidth: 1,
          lineJoin: 'round',
          lineDash: [12, 3, 3, 3],
          lineDashOffset: 0
        }
      });
    },
    ondrag: function(e) {
      var delta;
      delta = {
        x: e.offsetX - this.select_last_position.x,
        y: e.offsetY - this.select_last_position.y
      };
      this.select_last_position = {
        x: e.offsetX,
        y: e.offsetY
      };
      if (this.selection_box) {
        this.selection_box.set({
          w: this.select_last_position.x - this.selection_box.get('x') - this.target.get('offset-x'),
          h: this.select_last_position.y - this.selection_box.get('y') - this.target.get('offset-y')
        });
      }
      return this.draw();
    },
    ondragend: function(e) {
      this.select_last_position = null;
      if (this.selection_box) {
        this.selection_box.dispose();
        return this.selection_box = null;
      }
    },
    onclick: function(e) {
      this.selections = [];
      return this.setFocus();
    },
    onchange: function(target, before, after) {
      var picked;
      picked = _.pick(after, ['offset-x', 'offset-y', 'x', 'y']);
      if (!_.isEmpty(picked)) {
        return this.set(picked);
      }
    }
  };
  onselfchange = function(target, before, after) {
    if (after.hasOwnProperty('x')) {
      this.canvas.style.left = after['x'] + 'px';
    }
    if (after.hasOwnProperty('y')) {
      this.canvas.style.top = after['y'] + 'px';
    }
    return this.draw();
  };
  EVENT_MAP = {
    '?target': {
      '(:child)': {
        'click': WIDGETS_HANDLER.onclick,
        'tap': WIDGETS_HANDLER.onclick,
        'dragstart': WIDGETS_HANDLER.ondragstart,
        'drag': WIDGETS_HANDLER.ondrag,
        'dragend': WIDGETS_HANDLER.ondragend
      },
      '(:self)': {
        'click': WIDGET_LAYER_HANDLER.onclick,
        'tap': WIDGET_LAYER_HANDLER.onclick,
        'dragstart': WIDGET_LAYER_HANDLER.ondragstart,
        'drag': WIDGET_LAYER_HANDLER.ondrag,
        'dragend': WIDGET_LAYER_HANDLER.ondragend,
        'change': WIDGET_LAYER_HANDLER.onchange
      }
    },
    '(self)': {
      '(self)': {
        'change': onselfchange
      }
    }
  };
  parent_groups_translate = function(item, context, container) {
    var center, parent, rotate;
    parent = item.getContainer();
    if (!parent.canvas) {
      parent_groups_translate(parent, context, true);
    }
    if (!container) {
      return;
    }
    rotate = item.get('rotate') || 0;
    center = item.center();
    context.translate(center.x, center.y);
    context.rotate(rotate * Math.PI / 180);
    context.translate(-center.x, -center.y);
    return context.translate(item.get('x'), item.get('y'));
  };
  return SelectionLayer = (function(_super) {
    __extends(SelectionLayer, _super);

    function SelectionLayer() {
      return SelectionLayer.__super__.constructor.apply(this, arguments);
    }

    SelectionLayer.prototype.capture = function(position) {
      var captured, child, context, i, translated_position, _i, _ref;
      context = this.canvas.getContext('2d');
      context.beginPath();
      translated_position = {
        x: position.x - this.get('offset-x') - this.get('x'),
        y: position.y - this.get('offset-y') - this.get('y')
      };
      this.shape(context);
      if (this.size() > 0) {
        for (i = _i = _ref = this.size() - 1; _ref <= 0 ? _i <= 0 : _i >= 0; i = _ref <= 0 ? ++_i : --_i) {
          child = this.getAt(i);
          captured = child.capture(translated_position, context);
          if (captured) {
            return captured;
          }
        }
      }
      return null;
    };

    SelectionLayer.prototype.onadded = function(container) {
      var position;
      this.selections = [];
      this.target = this.select(this.get('target'))[0];
      position = {
        'offset-x': this.get('offset-x') || this.target.get('offset-x'),
        'offset-y': this.get('offset-y') || this.target.get('offset-y'),
        'x': this.get('x') || this.target.get('x'),
        'y': this.get('y') || this.target.get('y'),
        'w': this.target.get('w'),
        'h': this.target.get('h')
      };
      return this.set(position);
    };

    SelectionLayer.prototype._draw = function() {
      var context, item, _i, _len, _ref;
      if (!this.selections) {
        return;
      }
      this.clearCanvas();
      context = this.canvas.getContext('2d');
      context.save();
      context.translate(this.get('offset-x'), this.get('offset-y'));
      context.globalAlpha = 0.4;
      if (this.selections.length > 0) {
        context.save();
        if (this.offset) {
          context.translate(this.offset.x, this.offset.y);
        }
        _ref = this.selections;
        for (_i = 0, _len = _ref.length; _i < _len; _i++) {
          item = _ref[_i];
          context.save();
          parent_groups_translate(item, context);
          item.draw(context);
          context.restore();
        }
        context.restore();
      }
      context.globalAlpha = 1;
      this.forEach(function(child) {
        return child.draw(context);
      });
      return context.restore();
    };

    SelectionLayer.prototype.buildHandles = function() {
      var handle, _i, _len, _ref, _results;
      _ref = this.focus.handles();
      _results = [];
      for (_i = 0, _len = _ref.length; _i < _len; _i++) {
        handle = _ref[_i];
        _results.push(this.build({
          type: handle,
          config: {
            target: '#' + this.focus.get('id')
          }
        }));
      }
      return _results;
    };

    SelectionLayer.prototype.setFocus = function(focus) {
      if (this.focus === focus) {
        return;
      }
      this.removeAll();
      this.focus = focus;
      if (!this.focus) {
        return;
      }
      this.buildHandles();
      return this.draw();
    };

    SelectionLayer.prototype.event_map = function() {
      return [EVENT_MAP, LayerBehavior];
    };

    SelectionLayer.spec = {
      type: 'selection-layer',
      source: 'core:layer.SelectionLayer',
      containable: true,
      container_type: 'layer',
      description: 'Selection Layer',
      dependencies: {},
      properties: [
        Layer.spec.properties, {
          target: {
            type: 'string'
          }
        }
      ]
    };

    return SelectionLayer;

  })(Layer);
}.apply(null, __WEBPACK_AMD_DEFINE_ARRAY__)), __WEBPACK_AMD_DEFINE_RESULT__ !== undefined && (module.exports = __WEBPACK_AMD_DEFINE_RESULT__));


/***/ },
/* 22 */
/***/ function(module, exports, __webpack_require__) {

var __WEBPACK_AMD_DEFINE_ARRAY__, __WEBPACK_AMD_DEFINE_RESULT__;var __hasProp = {}.hasOwnProperty,
  __extends = function(child, parent) { for (var key in parent) { if (__hasProp.call(parent, key)) child[key] = parent[key]; } function ctor() { this.constructor = child; } ctor.prototype = parent.prototype; child.prototype = new ctor(); child.__super__ = parent.prototype; return child; };

!(__WEBPACK_AMD_DEFINE_ARRAY__ = [__webpack_require__(3), __webpack_require__(42), __webpack_require__(10)], __WEBPACK_AMD_DEFINE_RESULT__ = (function(Layer, LayerBehavior, Circle) {
  'use strict';
  var EVENT_MAP, SlideLayer, onhandle_drag, onhandle_dragend, onhandle_dragstart;
  onhandle_dragstart = function(e) {
    return this.slide_last_position = {
      x: e.offsetX,
      y: e.offsetY
    };
  };
  onhandle_drag = function(e) {
    var delta, offset;
    delta = {
      x: e.offsetX - this.slide_last_position.x,
      y: e.offsetY - this.slide_last_position.y
    };
    this.slide_target = this.slide_target || this.select(this.get('target'))[0];
    offset = {
      x: this.slide_target.get('offset-x'),
      y: this.slide_target.get('offset-y')
    };
    this.slide_target.set({
      'offset-x': offset.x + delta.x,
      'offset-y': offset.y + delta.y
    });
    return this.slide_last_position = {
      x: e.offsetX,
      y: e.offsetY
    };
  };
  onhandle_dragend = function(e) {
    return this.slide_last_position = null;
  };
  EVENT_MAP = {
    '(self)': {
      '(self)': {
        'dragstart': onhandle_dragstart,
        'drag': onhandle_drag,
        'dragend': onhandle_dragend,
        'click': function(e) {
          return console.log('clickxxx');
        }
      }
    }
  };
  return SlideLayer = (function(_super) {
    __extends(SlideLayer, _super);

    function SlideLayer() {
      return SlideLayer.__super__.constructor.apply(this, arguments);
    }

    SlideLayer.prototype.onadded = function(container) {
      this.set('draggable', true);
      return this.aaaaaa = 1;
    };

    SlideLayer.prototype.event_map = function() {
      return [EVENT_MAP, LayerBehavior];
    };

    SlideLayer.spec = {
      type: 'slide-layer',
      source: 'core:layer.SlideLayer',
      containable: true,
      container_type: 'layer',
      description: 'Slide Layer',
      dependencies: null,
      properties: [
        Layer.spec.properties, {
          target: {
            type: 'string'
          }
        }
      ]
    };

    return SlideLayer;

  })(Layer);
}.apply(null, __WEBPACK_AMD_DEFINE_ARRAY__)), __WEBPACK_AMD_DEFINE_RESULT__ !== undefined && (module.exports = __WEBPACK_AMD_DEFINE_RESULT__));


/***/ },
/* 23 */
/***/ function(module, exports, __webpack_require__) {

var __WEBPACK_AMD_DEFINE_ARRAY__, __WEBPACK_AMD_DEFINE_RESULT__;var __hasProp = {}.hasOwnProperty,
  __extends = function(child, parent) { for (var key in parent) { if (__hasProp.call(parent, key)) child[key] = parent[key]; } function ctor() { this.constructor = child; } ctor.prototype = parent.prototype; child.prototype = new ctor(); child.__super__ = parent.prototype; return child; };

!(__WEBPACK_AMD_DEFINE_ARRAY__ = [__webpack_require__(3), __webpack_require__(42)], __WEBPACK_AMD_DEFINE_RESULT__ = (function(Layer, LayerBehavior) {
  'use strict';
  var WidgetLayer;
  return WidgetLayer = (function(_super) {
    __extends(WidgetLayer, _super);

    function WidgetLayer() {
      return WidgetLayer.__super__.constructor.apply(this, arguments);
    }

    WidgetLayer.prototype.onadded = function(container) {
      this.set('capturable', true);
      return this.set('draggable', true);
    };

    WidgetLayer.prototype.model = function(data, reset) {
      var widget, _i, _len, _ref, _results;
      if (reset) {
        this.removeAll();
      }
      if (!data.components) {
        return;
      }
      _ref = data.components;
      _results = [];
      for (_i = 0, _len = _ref.length; _i < _len; _i++) {
        widget = _ref[_i];
        _results.push(this.build(widget, this));
      }
      return _results;
    };

    WidgetLayer.prototype.event_map = function() {
      return [LayerBehavior];
    };

    WidgetLayer.spec = {
      type: 'widget-layer',
      source: 'core:layer.WidgetLayer',
      containable: true,
      container_type: 'layer',
      description: 'Widgets Layer',
      dependencies: {},
      properties: [Layer.spec.properties]
    };

    return WidgetLayer;

  })(Layer);
}.apply(null, __WEBPACK_AMD_DEFINE_ARRAY__)), __WEBPACK_AMD_DEFINE_RESULT__ !== undefined && (module.exports = __WEBPACK_AMD_DEFINE_RESULT__));


/***/ },
/* 24 */
/***/ function(module, exports, __webpack_require__) {

var __WEBPACK_AMD_DEFINE_ARRAY__, __WEBPACK_AMD_DEFINE_RESULT__;var __hasProp = {}.hasOwnProperty,
  __extends = function(child, parent) { for (var key in parent) { if (__hasProp.call(parent, key)) child[key] = parent[key]; } function ctor() { this.constructor = child; } ctor.prototype = parent.prototype; child.prototype = new ctor(); child.__super__ = parent.prototype; return child; };

!(__WEBPACK_AMD_DEFINE_ARRAY__ = [__webpack_require__(3), __webpack_require__(42), __webpack_require__(10)], __WEBPACK_AMD_DEFINE_RESULT__ = (function(Layer, LayerBehavior, Circle) {
  'use strict';
  var EVENT_MAP, TestLayer, onclick_move, onclick_point, onclick_redo, onclick_undo;
  onclick_point = function(e) {
    return this.slider.set('capturable', false);
  };
  onclick_move = function(e) {
    return this.slider.set('capturable', true);
  };
  onclick_undo = function(e) {
    return console.log('undo click');
  };
  onclick_redo = function(e) {
    return console.log('redo click');
  };
  EVENT_MAP = {
    '(self)': {
      '#point-button': {
        'click': onclick_point
      },
      '#move-button': {
        'click': onclick_move
      },
      '#undo-button': {
        'click': onclick_undo
      },
      '#redo-button': {
        'click': onclick_redo
      }
    }
  };
  return TestLayer = (function(_super) {
    __extends(TestLayer, _super);

    function TestLayer() {
      return TestLayer.__super__.constructor.apply(this, arguments);
    }

    TestLayer.prototype.onadded = function(container) {
      this.slider = this.select(this.get('slider'))[0];
      this.move_button = this.select('#point-button')[0];
      this.move_button.set({
        cx: this.canvas.width - 25,
        cy: 25
      });
      this.move_button = this.select('#move-button')[0];
      this.move_button.set({
        cx: this.canvas.width - 25,
        cy: 75
      });
      this.undo_button = this.select('#undo-button')[0];
      this.undo_button.set({
        cx: this.canvas.width - 25,
        cy: 125
      });
      this.redo_button = this.select('#redo-button')[0];
      this.redo_button.set({
        cx: this.canvas.width - 25,
        cy: 175
      });
      return this.draw();
    };

    TestLayer.prototype.event_map = function() {
      return [EVENT_MAP, LayerBehavior];
    };

    TestLayer.spec = {
      type: 'test-layer',
      source: 'core:layer.TestLayer',
      containable: true,
      container_type: 'layer',
      description: 'Test Layer',
      dependencies: {
        'circle': Circle
      },
      properties: [
        Layer.spec.properties, {
          'slider': {
            type: 'string'
          }
        }
      ],
      components: [
        {
          type: 'circle',
          config: {
            'id': 'point-button',
            'cx': 100,
            'cy': 100,
            'r': 20,
            'lineWidth': 5,
            'strokeStyle': 'red',
            'fillStyle': 'black',
            capturable: true,
            draggable: true,
            alpha: 0.4
          }
        }, {
          type: 'circle',
          config: {
            'id': 'move-button',
            'cx': 100,
            'cy': 100,
            'r': 20,
            'lineWidth': 5,
            'strokeStyle': 'red',
            'fillStyle': 'black',
            capturable: true,
            draggable: true,
            alpha: 0.4
          }
        }, {
          type: 'circle',
          config: {
            'id': 'undo-button',
            'cx': 100,
            'cy': 100,
            'r': 20,
            'lineWidth': 5,
            'strokeStyle': 'red',
            'fillStyle': 'black',
            capturable: true,
            draggable: true,
            alpha: 0.4
          }
        }, {
          type: 'circle',
          config: {
            'id': 'redo-button',
            'cx': 100,
            'cy': 100,
            'r': 20,
            'lineWidth': 5,
            'strokeStyle': 'red',
            'fillStyle': 'black',
            capturable: true,
            draggable: true,
            alpha: 0.4
          }
        }
      ]
    };

    return TestLayer;

  })(Layer);
}.apply(null, __WEBPACK_AMD_DEFINE_ARRAY__)), __WEBPACK_AMD_DEFINE_RESULT__ !== undefined && (module.exports = __WEBPACK_AMD_DEFINE_RESULT__));


/***/ },
/* 25 */
/***/ function(module, exports, __webpack_require__) {

var __WEBPACK_AMD_DEFINE_ARRAY__, __WEBPACK_AMD_DEFINE_RESULT__;var __hasProp = {}.hasOwnProperty,
  __extends = function(child, parent) { for (var key in parent) { if (__hasProp.call(parent, key)) child[key] = parent[key]; } function ctor() { this.constructor = child; } ctor.prototype = parent.prototype; child.prototype = new ctor(); child.__super__ = parent.prototype; return child; };

!(__WEBPACK_AMD_DEFINE_ARRAY__ = [__webpack_require__(27), __webpack_require__(4)], __WEBPACK_AMD_DEFINE_RESULT__ = (function(Handle, Group) {
  'use strict';
  var BOTTOM, BoundHandle, CENTER, LEFT, MIDDLE, RIGHT, TOP, points;
  TOP = -1;
  MIDDLE = 0;
  BOTTOM = 1;
  LEFT = -1;
  CENTER = 0;
  RIGHT = 1;
  points = [[LEFT, TOP], [CENTER, TOP], [RIGHT, TOP], [LEFT, MIDDLE], [RIGHT, MIDDLE], [LEFT, BOTTOM], [CENTER, BOTTOM], [RIGHT, BOTTOM]];
  return BoundHandle = (function(_super) {
    __extends(BoundHandle, _super);

    function BoundHandle() {
      return BoundHandle.__super__.constructor.apply(this, arguments);
    }

    BoundHandle.prototype.align = function() {
      var bound, cx, cy, rh, rw;
      bound = this.target.bound();
      rw = Math.round(bound.w / 2);
      rh = Math.round(bound.h / 2);
      cx = Math.round(bound.x + rw);
      cy = Math.round(bound.y + rh);
      return this.forEach(function(component) {
        var index;
        index = component.get('index');
        return component.set({
          x: cx + points[index][0] * rw,
          y: cy + points[index][1] * rh
        });
      });
    };

    BoundHandle.prototype.onadded = function(container) {
      var i, point, _i, _len;
      this.set('clip', false);
      this.target = this.select(this.get('target'))[0];
      if (!this.target.get('resizable')) {
        return;
      }
      for (i = _i = 0, _len = points.length; _i < _len; i = ++_i) {
        point = points[i];
        this.build({
          type: 'handle',
          config: {
            r: 8,
            strokeStyle: 'red',
            lineWidth: 2,
            capturable: false,
            fillStyle: 'black',
            index: i,
            draggable: true
          }
        });
      }
      return this.align();
    };

    BoundHandle.prototype.onchange = function(e) {
      this.align();
      return this.draw();
    };

    BoundHandle.prototype.ondragstart = function(e) {
      return this.startpos = {
        x: e.offsetX,
        y: e.offsetY
      };
    };

    BoundHandle.prototype.ondrag = function(e) {
      var delta, handle, index, target_to;
      handle = e.target;
      delta = {
        x: e.offsetX - this.startpos.x,
        y: e.offsetY - this.startpos.y
      };
      index = handle.get('index');
      target_to = {
        w: this.target.get('w') + delta.x * points[index][0],
        h: this.target.get('h') + delta.y * points[index][1]
      };
      if (points[index][0] === LEFT) {
        target_to['x'] = this.target.get('x') + delta.x;
      }
      if (points[index][1] === TOP) {
        target_to['y'] = this.target.get('y') + delta.y;
      }
      this.target.set(target_to);
      return this.startpos = {
        x: e.offsetX,
        y: e.offsetY
      };
    };

    BoundHandle.prototype.ondragend = function(e) {
      return this.target.configure(this.target.bound());
    };

    BoundHandle.prototype.event_map = function() {
      return {
        '?target': {
          '?target': {
            change: this.onchange
          }
        },
        '(self)': {
          'handle': {
            dragstart: this.ondragstart,
            drag: this.ondrag,
            dragend: this.ondragend
          }
        }
      };
    };

    BoundHandle.spec = {
      type: 'bound-handle',
      source: 'core:handle.BoundHandle',
      containable: true,
      description: 'Bound Handle',
      dependencies: {
        'handle': Handle
      },
      properties: [
        {
          target: {
            type: 'string'
          }
        }
      ]
    };

    return BoundHandle;

  })(Group);
}.apply(null, __WEBPACK_AMD_DEFINE_ARRAY__)), __WEBPACK_AMD_DEFINE_RESULT__ !== undefined && (module.exports = __WEBPACK_AMD_DEFINE_RESULT__));


/***/ },
/* 26 */
/***/ function(module, exports, __webpack_require__) {

var __WEBPACK_AMD_DEFINE_ARRAY__, __WEBPACK_AMD_DEFINE_RESULT__;var __hasProp = {}.hasOwnProperty,
  __extends = function(child, parent) { for (var key in parent) { if (__hasProp.call(parent, key)) child[key] = parent[key]; } function ctor() { this.constructor = child; } ctor.prototype = parent.prototype; child.prototype = new ctor(); child.__super__ = parent.prototype; return child; };

!(__WEBPACK_AMD_DEFINE_ARRAY__ = [__webpack_require__(27), __webpack_require__(4)], __WEBPACK_AMD_DEFINE_RESULT__ = (function(Handle, Group) {
  'use strict';
  var CircleHandle;
  return CircleHandle = (function(_super) {
    __extends(CircleHandle, _super);

    function CircleHandle() {
      return CircleHandle.__super__.constructor.apply(this, arguments);
    }

    CircleHandle.prototype.align = function() {
      var cx, cy, r, theta;
      r = this.target.get('r');
      cx = this.target.get('cx');
      cy = this.target.get('cy');
      theta = this.get('theta') || 0;
      return this.handle.set({
        x: cx + Math.round(Math.cos(theta) * r),
        y: cy + Math.round(Math.sin(theta) * r)
      });
    };

    CircleHandle.prototype.onadded = function(container) {
      this.set('clip', false);
      this.set('theta', 0);
      this.target = this.select(this.get('target'))[0];
      this.handle = this.build({
        type: 'handle',
        config: {
          r: 8,
          index: 0,
          strokeStyle: 'red',
          fillStyle: 'black',
          lineWidth: 1,
          draggable: true
        }
      });
      return this.align();
    };

    CircleHandle.prototype.onchange = function(e) {
      this.align();
      return this.draw();
    };

    CircleHandle.prototype.ondragstart = function(e) {
      return this.startpos = {
        x: e.offsetX,
        y: e.offsetY
      };
    };

    CircleHandle.prototype.ondrag = function(e) {
      var delta, dx, dy, handle, newcx, newcy, r;
      handle = e.target;
      delta = {
        x: e.offsetX - this.startpos.x,
        y: e.offsetY - this.startpos.y
      };
      newcx = handle.get('x') + delta.x;
      newcy = handle.get('y') + delta.y;
      handle.set({
        x: newcx,
        y: newcy
      });
      dx = newcx - this.target.get('cx');
      dy = newcy - this.target.get('cy');
      this.set({
        theta: Math.atan2(dy, dx)
      });
      r = Math.round(Math.sqrt(dx * dx + dy * dy));
      this.target.set({
        r: r
      });
      return this.startpos = {
        x: e.offsetX,
        y: e.offsetY
      };
    };

    CircleHandle.prototype.ondragend = function(e) {};

    CircleHandle.prototype.event_map = function() {
      return {
        '?target': {
          '?target': {
            change: this.onchange
          }
        },
        '(self)': {
          'handle': {
            dragstart: this.ondragstart,
            drag: this.ondrag,
            dragend: this.ondragend
          }
        }
      };
    };

    CircleHandle.spec = {
      type: 'circle-handle',
      source: 'core:handle.CircleHandle',
      containable: true,
      description: 'Circle Handle',
      dependencies: {
        'handle': Handle
      },
      properties: [
        {
          target: {
            type: 'string'
          }
        }
      ]
    };

    return CircleHandle;

  })(Group);
}.apply(null, __WEBPACK_AMD_DEFINE_ARRAY__)), __WEBPACK_AMD_DEFINE_RESULT__ !== undefined && (module.exports = __WEBPACK_AMD_DEFINE_RESULT__));


/***/ },
/* 27 */
/***/ function(module, exports, __webpack_require__) {

var __WEBPACK_AMD_DEFINE_ARRAY__, __WEBPACK_AMD_DEFINE_RESULT__;var __hasProp = {}.hasOwnProperty,
  __extends = function(child, parent) { for (var key in parent) { if (__hasProp.call(parent, key)) child[key] = parent[key]; } function ctor() { this.constructor = child; } ctor.prototype = parent.prototype; child.prototype = new ctor(); child.__super__ = parent.prototype; return child; };

!(__WEBPACK_AMD_DEFINE_ARRAY__ = [__webpack_require__(7), __webpack_require__(50), __webpack_require__(44), __webpack_require__(46)], __WEBPACK_AMD_DEFINE_RESULT__ = (function(Component, Shapable, ComponentProps, Graphic) {
  'use strict';
  var Handle, parent_groups_translate;
  parent_groups_translate = function(item, context, container) {
    var center, parent, rotate;
    parent = item.getContainer();
    if (!parent.canvas) {
      parent_groups_translate(parent, context, true);
    }
    if (!container) {
      return;
    }
    rotate = item.get('rotate') || 0;
    center = item.center();
    context.translate(center.x, center.y);
    context.rotate(rotate * Math.PI / 180);
    context.translate(-center.x, -center.y);
    return context.translate(item.get('x'), item.get('y'));
  };
  return Handle = (function(_super) {
    __extends(Handle, _super);

    function Handle() {
      return Handle.__super__.constructor.apply(this, arguments);
    }

    Handle.include(Shapable);

    Handle.prototype.center = function() {
      return {
        x: this.get('x'),
        y: this.get('y')
      };
    };

    Handle.prototype.shape = function(context) {
      var center, rotate, target;
      target = this.getContainer().target;
      context.save();
      parent_groups_translate(target, context);
      center = target.center();
      rotate = target.get('rotate');
      context.translate(center.x, center.y);
      context.rotate(rotate * Math.PI / 180);
      context.translate(-center.x, -center.y);
      context.arc(this.get('x'), this.get('y'), this.get('r'), 0, 2 * Math.PI, false);
      return context.restore();
    };

    Handle.prototype.event_map = function() {
      return [];
    };

    Handle.spec = {
      type: 'handle',
      source: 'core:handle.Handle',
      containable: false,
      description: 'Base Handle',
      dependencies: {},
      properties: [
        ComponentProps, Graphic, {
          x: {
            type: 'number'
          },
          y: {
            type: 'number'
          },
          r: {
            type: 'number'
          },
          index: {
            type: 'string'
          }
        }
      ]
    };

    return Handle;

  })(Component);
}.apply(null, __WEBPACK_AMD_DEFINE_ARRAY__)), __WEBPACK_AMD_DEFINE_RESULT__ !== undefined && (module.exports = __WEBPACK_AMD_DEFINE_RESULT__));


/***/ },
/* 28 */
/***/ function(module, exports, __webpack_require__) {

var __WEBPACK_AMD_DEFINE_ARRAY__, __WEBPACK_AMD_DEFINE_RESULT__;var __hasProp = {}.hasOwnProperty,
  __extends = function(child, parent) { for (var key in parent) { if (__hasProp.call(parent, key)) child[key] = parent[key]; } function ctor() { this.constructor = child; } ctor.prototype = parent.prototype; child.prototype = new ctor(); child.__super__ = parent.prototype; return child; };

!(__WEBPACK_AMD_DEFINE_ARRAY__ = [__webpack_require__(27), __webpack_require__(4), __webpack_require__(44), __webpack_require__(46)], __WEBPACK_AMD_DEFINE_RESULT__ = (function(Handle, Group, ComponentProps, Graphic) {
  'use strict';
  var P2PHandle;
  return P2PHandle = (function(_super) {
    __extends(P2PHandle, _super);

    function P2PHandle() {
      return P2PHandle.__super__.constructor.apply(this, arguments);
    }

    P2PHandle.prototype.align = function() {
      var points;
      points = [[this.target.get('x1'), this.target.get('y1')], [this.target.get('x2'), this.target.get('y2')]];
      return this.forEach(function(component) {
        var index;
        index = component.get('index');
        return component.set({
          x: points[index][0],
          y: points[index][1]
        });
      });
    };

    P2PHandle.prototype.onadded = function(container) {
      var i, _i;
      this.set('clip', false);
      this.target = this.select(this.get('target'))[0];
      for (i = _i = 0; _i <= 1; i = ++_i) {
        this.build({
          type: 'handle',
          config: {
            r: 8,
            index: i,
            strokeStyle: 'red',
            fillStyle: 'black',
            lineWidth: 2,
            draggable: true
          }
        });
      }
      return this.align();
    };

    P2PHandle.prototype.onchange = function(e) {
      this.align();
      return this.draw();
    };

    P2PHandle.prototype.ondragstart = function(e) {
      return this.startpos = {
        x: e.offsetX,
        y: e.offsetY
      };
    };

    P2PHandle.prototype.ondrag = function(e) {
      var delta, handle, index, newcx, newcy, to;
      handle = e.target;
      delta = {
        x: e.offsetX - this.startpos.x,
        y: e.offsetY - this.startpos.y
      };
      newcx = handle.get('x') + delta.x;
      newcy = handle.get('y') + delta.y;
      handle.set({
        x: newcx,
        y: newcy
      });
      index = handle.get('index');
      switch (index) {
        case 0:
          to = {
            x1: this.target.get('x1') + delta.x,
            y1: this.target.get('y1') + delta.y
          };
          break;
        case 1:
          to = {
            x2: this.target.get('x2') + delta.x,
            y2: this.target.get('y2') + delta.y
          };
      }
      this.target.set(to);
      return this.startpos = {
        x: e.offsetX,
        y: e.offsetY
      };
    };

    P2PHandle.prototype.ondragend = function(e) {
      return this.target.configure({
        x1: this.target.get('x1'),
        y1: this.target.get('y1'),
        x2: this.target.get('x2'),
        y2: this.target.get('y2')
      });
    };

    P2PHandle.prototype.event_map = function() {
      return {
        '?target': {
          '?target': {
            change: this.onchange
          }
        },
        '(self)': {
          'handle': {
            dragstart: this.ondragstart,
            drag: this.ondrag,
            dragend: this.ondragend
          }
        }
      };
    };

    P2PHandle.spec = {
      type: 'p2p-handle',
      source: 'core:handle.P2PHandle',
      containable: true,
      description: 'Point-to-Point Handle',
      dependencies: {
        'handle': Handle
      },
      properties: [
        {
          target: {
            type: 'string'
          }
        }
      ]
    };

    return P2PHandle;

  })(Group);
}.apply(null, __WEBPACK_AMD_DEFINE_ARRAY__)), __WEBPACK_AMD_DEFINE_RESULT__ !== undefined && (module.exports = __WEBPACK_AMD_DEFINE_RESULT__));


/***/ },
/* 29 */
/***/ function(module, exports, __webpack_require__) {

var __WEBPACK_AMD_DEFINE_ARRAY__, __WEBPACK_AMD_DEFINE_RESULT__;var __hasProp = {}.hasOwnProperty,
  __extends = function(child, parent) { for (var key in parent) { if (__hasProp.call(parent, key)) child[key] = parent[key]; } function ctor() { this.constructor = child; } ctor.prototype = parent.prototype; child.prototype = new ctor(); child.__super__ = parent.prototype; return child; };

!(__WEBPACK_AMD_DEFINE_ARRAY__ = [__webpack_require__(40), __webpack_require__(27), __webpack_require__(59), __webpack_require__(4)], __WEBPACK_AMD_DEFINE_RESULT__ = (function(_, Handle, SplitHandle, Group) {
  'use strict';
  var PathHandle;
  return PathHandle = (function(_super) {
    __extends(PathHandle, _super);

    function PathHandle() {
      return PathHandle.__super__.constructor.apply(this, arguments);
    }

    PathHandle.prototype.align = function() {
      var points, points_count;
      points = this.target.get('path');
      points_count = points.length;
      return this.forEach(function(component) {
        var first_point_index, index;
        index = component.get('index');
        if (index < points_count) {
          return component.set({
            x: points[index][0],
            y: points[index][1]
          });
        } else {
          first_point_index = index - points_count;
          return component.set({
            x: (points[first_point_index][0] + points[first_point_index + 1][0]) / 2,
            y: (points[first_point_index][1] + points[first_point_index + 1][1]) / 2
          });
        }
      });
    };

    PathHandle.prototype.buildHandles = function() {
      var i, path, _i, _j, _ref, _ref1;
      this.removeAll();
      path = this.target.get('path');
      for (i = _i = 0, _ref = path.length - 1; 0 <= _ref ? _i <= _ref : _i >= _ref; i = 0 <= _ref ? ++_i : --_i) {
        this.build({
          type: 'handle',
          config: {
            r: 8,
            index: i,
            strokeStyle: 'red',
            fillStyle: 'black',
            lineWidth: 2,
            draggable: true
          }
        });
      }
      for (i = _j = 0, _ref1 = path.length - 2; 0 <= _ref1 ? _j <= _ref1 : _j >= _ref1; i = 0 <= _ref1 ? ++_j : --_j) {
        this.build({
          type: 'split-handle',
          config: {
            r: 8,
            index: path.length + i,
            strokeStyle: 'red',
            fillStyle: 'black',
            lineWidth: 2,
            draggable: true
          }
        });
      }
      return this.align();
    };

    PathHandle.prototype.onadded = function(container) {
      this.set('clip', false);
      this.target = this.select(this.get('target'))[0];
      return this.buildHandles();
    };

    PathHandle.prototype.onchange = function(e) {
      if (!this._split_mode) {
        this.align();
      }
      return this.draw();
    };

    PathHandle.prototype.path_handle = {
      ondragstart: function(e) {
        return this.startpos = {
          x: e.offsetX,
          y: e.offsetY
        };
      },
      ondrag: function(e) {
        var delta, handle, index, newcx, newcy, newpath;
        handle = e.target;
        delta = {
          x: e.offsetX - this.startpos.x,
          y: e.offsetY - this.startpos.y
        };
        newcx = handle.get('x') + delta.x;
        newcy = handle.get('y') + delta.y;
        handle.set({
          x: newcx,
          y: newcy
        });
        index = handle.get('index');
        newpath = _.clone(this.target.get('path'));
        newpath[index][0] = newcx;
        newpath[index][1] = newcy;
        this.target.set('path', newpath);
        return this.startpos = {
          x: e.offsetX,
          y: e.offsetY
        };
      },
      ondragend: function(e) {
        return this.target.configure('path', this.target.get('path'));
      }
    };

    PathHandle.prototype.split_handle = {
      ondragstart: function(e) {
        var handle, index, newpath;
        this._split_mode = true;
        this.startpos = {
          x: e.offsetX,
          y: e.offsetY
        };
        handle = e.target;
        newpath = _.clone(this.target.get('path'));
        index = handle.get('index') - newpath.length;
        newpath.splice(index + 1, 0, [e.offsetX, e.offsetY]);
        return this.target.set('path', newpath);
      },
      ondrag: function(e) {
        var delta, handle, index, newcx, newcy, newpath;
        handle = e.target;
        delta = {
          x: e.offsetX - this.startpos.x,
          y: e.offsetY - this.startpos.y
        };
        newcx = handle.get('x') + delta.x;
        newcy = handle.get('y') + delta.y;
        handle.set({
          x: newcx,
          y: newcy
        });
        newpath = _.clone(this.target.get('path'));
        index = handle.get('index') - newpath.length + 2;
        newpath[index][0] = newcx;
        newpath[index][1] = newcy;
        this.target.set('path', newpath);
        return this.startpos = {
          x: e.offsetX,
          y: e.offsetY
        };
      },
      ondragend: function(e) {
        this._split_mode = false;
        this.target.configure('path', this.target.get('path'));
        return this.buildHandles();
      }
    };

    PathHandle.prototype.event_map = function() {
      return {
        '?target': {
          '?target': {
            change: this.onchange
          }
        },
        '(self)': {
          'handle': {
            dragstart: this.path_handle.ondragstart,
            drag: this.path_handle.ondrag,
            dragend: this.path_handle.ondragend
          },
          'split-handle': {
            dragstart: this.split_handle.ondragstart,
            drag: this.split_handle.ondrag,
            dragend: this.split_handle.ondragend
          }
        }
      };
    };

    PathHandle.spec = {
      type: 'path-handle',
      source: 'core:handle.PathHandle',
      containable: true,
      description: 'Path Handle',
      dependencies: {
        'handle': Handle,
        'split-handle': SplitHandle
      },
      properties: [
        {
          target: {
            type: 'string'
          }
        }
      ]
    };

    return PathHandle;

  })(Group);
}.apply(null, __WEBPACK_AMD_DEFINE_ARRAY__)), __WEBPACK_AMD_DEFINE_RESULT__ !== undefined && (module.exports = __WEBPACK_AMD_DEFINE_RESULT__));


/***/ },
/* 30 */
/***/ function(module, exports, __webpack_require__) {

var __WEBPACK_AMD_DEFINE_ARRAY__, __WEBPACK_AMD_DEFINE_RESULT__;var __hasProp = {}.hasOwnProperty,
  __extends = function(child, parent) { for (var key in parent) { if (__hasProp.call(parent, key)) child[key] = parent[key]; } function ctor() { this.constructor = child; } ctor.prototype = parent.prototype; child.prototype = new ctor(); child.__super__ = parent.prototype; return child; };

!(__WEBPACK_AMD_DEFINE_ARRAY__ = [__webpack_require__(27), __webpack_require__(4)], __WEBPACK_AMD_DEFINE_RESULT__ = (function(Handle, Group) {
  'use strict';
  var RotationHandle;
  return RotationHandle = (function(_super) {
    __extends(RotationHandle, _super);

    function RotationHandle() {
      return RotationHandle.__super__.constructor.apply(this, arguments);
    }

    RotationHandle.prototype.align = function() {
      var bound, cx, cy, rh, rw;
      bound = this.target.bound();
      rw = Math.round(bound.w / 2);
      rh = Math.round(bound.h / 2);
      cx = Math.round(bound.x + bound.w / 2);
      cy = Math.round(bound.y - 20);
      return this.handle.set({
        x: cx,
        y: cy
      });
    };

    RotationHandle.prototype.onadded = function(container) {
      this.set('clip', false);
      this.target = this.select(this.get('target'))[0];
      this.handle = this.build({
        type: 'handle',
        config: {
          r: 8,
          draggable: true,
          strokeStyle: 'red',
          fillStyle: 'black',
          lineWidth: 1
        }
      });
      return this.align();
    };

    RotationHandle.prototype.onchange = function(e) {
      this.align();
      return this.draw();
    };

    RotationHandle.prototype.ondragstart = function(e) {
      return this.startpos = {
        x: e.offsetX,
        y: e.offsetY
      };
    };

    RotationHandle.prototype.ondrag = function(e) {
      var bound, delta, handle, index, ox, oy, rotate, theta;
      handle = e.target;
      delta = {
        x: e.offsetX - this.startpos.x,
        y: e.offsetY - this.startpos.y
      };
      index = handle.get('index');
      bound = this.target.bound();
      ox = Math.round(bound.x + bound.w / 2);
      oy = Math.round(bound.y + bound.h / 2);
      theta = Math.atan2(e.offsetY - oy, e.offsetX - ox);
      theta -= Math.atan2(this.startpos.y - oy, this.startpos.x - ox);
      rotate = this.target.get('rotate') || 0;
      this.target.set({
        rotate: rotate + (theta * 180 / Math.PI)
      });
      return this.startpos = {
        x: e.offsetX,
        y: e.offsetY
      };
    };

    RotationHandle.prototype.ondragend = function(e) {
      return this.target.configure('rotate', this.target.get('rotate'));
    };

    RotationHandle.prototype.event_map = function() {
      return {
        '?target': {
          '?target': {
            change: this.onchange
          }
        },
        '(self)': {
          'handle': {
            dragstart: this.ondragstart,
            drag: this.ondrag,
            dragend: this.ondragend
          }
        }
      };
    };

    RotationHandle.spec = {
      type: 'rotation-handle',
      source: 'core:handle.RotationHandle',
      containable: true,
      description: 'Rotation Handle',
      dependencies: {
        'handle': Handle
      },
      properties: [
        {
          target: {
            type: 'string'
          }
        }
      ]
    };

    return RotationHandle;

  })(Group);
}.apply(null, __WEBPACK_AMD_DEFINE_ARRAY__)), __WEBPACK_AMD_DEFINE_RESULT__ !== undefined && (module.exports = __WEBPACK_AMD_DEFINE_RESULT__));


/***/ },
/* 31 */
/***/ function(module, exports, __webpack_require__) {

var __WEBPACK_AMD_DEFINE_ARRAY__, __WEBPACK_AMD_DEFINE_RESULT__;!(__WEBPACK_AMD_DEFINE_ARRAY__ = [], __WEBPACK_AMD_DEFINE_RESULT__ = (function() {
  var Global, calcDpi, dppx, h, w;
  dppx = window.devicePixelRatio;
  if (!dppx) {
    dppx = (window.matchMedia && window.matchMedia("(min-resolution: 2dppx), (-webkit-min-device-pixel-ratio: 1.5),(-moz-min-device-pixel-ratio: 1.5),(min-device-pixel-ratio: 1.5)").matches ? 2 : 1) || 1;
  }
  w = Math.round(screen.width * dppx);
  h = Math.round(screen.height * dppx);
  calcDpi = function(d) {
    var dpi;
    w > 0 || (w = 1);
    h > 0 || (h = 1);
    dpi = Math.sqrt(w * w + h * h) / d;
    if (dpi > 0) {
      return Math.round(dpi);
    } else {
      return 0;
    }
  };
  Global = {
    version: '@@version',
    calcDpi: calcDpi,
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
/* 32 */
/***/ function(module, exports, __webpack_require__) {

var __WEBPACK_AMD_DEFINE_ARRAY__, __WEBPACK_AMD_DEFINE_RESULT__;var __hasProp = {}.hasOwnProperty;

!(__WEBPACK_AMD_DEFINE_ARRAY__ = [__webpack_require__(40)], __WEBPACK_AMD_DEFINE_RESULT__ = (function(_) {
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

    ComponentRegistry.prototype.register = function(type, klass) {
      var depspec, i, name, props, _i, _len, _ref, _ref1;
      if (this.componentSpecs[type]) {
        return;
      }
      if (klass.spec.dependencies) {
        _ref = klass.spec.dependencies;
        for (name in _ref) {
          depspec = _ref[name];
          this.register(name, depspec);
        }
      }
      if (klass.spec.properties instanceof Array) {
        props = {};
        _ref1 = _.flatten(klass.spec.properties);
        for (_i = 0, _len = _ref1.length; _i < _len; _i++) {
          i = _ref1[_i];
          _.merge(props, i);
        }
        klass.spec.properties = props;
      }
      this.componentSpecs[type] = klass;
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
/* 33 */
/***/ function(module, exports, __webpack_require__) {

var __WEBPACK_AMD_DEFINE_ARRAY__, __WEBPACK_AMD_DEFINE_RESULT__;!(__WEBPACK_AMD_DEFINE_ARRAY__ = [__webpack_require__(7), __webpack_require__(8)], __WEBPACK_AMD_DEFINE_RESULT__ = (function(Component, Container) {
  "use strict";
  var match, match_by_id, match_by_special, match_by_tag, match_by_type, select, select_recurse;
  match_by_id = function(selector, component, listener, root) {
    return (selector.substr(1)) === component.get('id');
  };
  match_by_tag = function(selector, component, listener, root) {
    var tags;
    tags = component.get('tag');
    if (!tags) {
      return false;
    }
    return tags.indexOf(selector.substr(1)) > -1;
  };
  match_by_special = function(selector, component, listener, root) {
    switch (selector) {
      case '(all)':
        return true;
      case '(child)':
        return listener.isAscendentOf && listener.isAscendentOf(component);
      case '(:child)':
        return root.isAscendentOf && root.isAscendentOf(component);
      case '(self)':
        return listener === component;
      case '(:self)':
        return root === component;
      case '(root)':
        return root === component;
      default:
        return false;
    }
  };
  match_by_type = function(selector, component, listener, root) {
    return selector === component.type;
  };
  match = function(selector, component, listener, root) {
    switch (selector.charAt(0)) {
      case '#':
        return match_by_id(selector, component, listener, root);
      case '.':
        return match_by_tag(selector, component, listener, root);
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
          return match_by_tag;
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
/* 34 */
/***/ function(module, exports, __webpack_require__) {

var __WEBPACK_AMD_DEFINE_ARRAY__, __WEBPACK_AMD_DEFINE_RESULT__;!(__WEBPACK_AMD_DEFINE_ARRAY__ = [__webpack_require__(40)], __WEBPACK_AMD_DEFINE_RESULT__ = (function(_) {
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
      component = this.createByModel(model);
      this.setupDescendant(component, model.components);
      if (onto_container) {
        onto_container.add(component);
      }
      return component;
    };

    ComponentFactory.prototype.create = function(type, config) {
      var c, component, klass, _i, _len, _ref;
      klass = this.componentRegistry.get(type);
      if (!klass) {
        throw new Error('module (' + model.type + ') is not registered yet.');
      }
      if (!config) {
        config = {};
      }
      if (!config.hasOwnProperty('id')) {
        config.id = _.uniqueId();
      }
      component = new klass(type).initialize(config, klass.spec.properties);
      component.setController(this.controller);
      if (component.init) {
        component.init();
      }
      if (klass.spec.components) {
        _ref = klass.spec.components;
        for (_i = 0, _len = _ref.length; _i < _len; _i++) {
          c = _ref[_i];
          this.build(c, component);
        }
      }
      return component;
    };

    ComponentFactory.prototype.createByModel = function(model) {
      var depspec, deptype, _ref;
      if (model.dependencies) {
        _ref = model.dependencies;
        for (deptype in _ref) {
          depspec = _ref[deptype];
          this.componentRegistry.register(deptype, depspec);
        }
      }
      return this.create(model.type, model.config);
    };

    ComponentFactory.prototype.setupDescendant = function(container, components) {
      var c, klass, spec, _i, _len;
      klass = this.componentRegistry.get(container.type);
      spec = klass.spec;
      if (components) {
        for (_i = 0, _len = components.length; _i < _len; _i++) {
          c = components[_i];
          this.build(c, container);
        }
      }
      return container;
    };

    return ComponentFactory;

  })();
}.apply(null, __WEBPACK_AMD_DEFINE_ARRAY__)), __WEBPACK_AMD_DEFINE_RESULT__ !== undefined && (module.exports = __WEBPACK_AMD_DEFINE_RESULT__));


/***/ },
/* 35 */
/***/ function(module, exports, __webpack_require__) {

var __WEBPACK_AMD_DEFINE_ARRAY__, __WEBPACK_AMD_DEFINE_RESULT__;var __hasProp = {}.hasOwnProperty;

!(__WEBPACK_AMD_DEFINE_ARRAY__ = [__webpack_require__(40), __webpack_require__(61), __webpack_require__(33)], __WEBPACK_AMD_DEFINE_RESULT__ = (function(_, EventPump, ComponentSelector) {
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
/* 36 */
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
/* 37 */
/***/ function(module, exports, __webpack_require__) {

var __WEBPACK_AMD_DEFINE_ARRAY__, __WEBPACK_AMD_DEFINE_RESULT__;!(__WEBPACK_AMD_DEFINE_ARRAY__ = [__webpack_require__(62), __webpack_require__(63)], __WEBPACK_AMD_DEFINE_RESULT__ = (function(DragAndDrop, PointEvent) {
  "use strict";
  var MouseEventEngine, oncontextmenu, onmousedown, onmouseenter, onmouseleave, onmousemove, onmouseup;
  onmousedown = function(e) {
    var position;
    position = this.stage.point(e);
    this.captured = this.stage.capture(position);
    this.click_target = this.captured;
    if (this.captured.get('draggable')) {
      DragAndDrop.draggable = true;
    }
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
/* 38 */
/***/ function(module, exports, __webpack_require__) {

var __WEBPACK_AMD_DEFINE_ARRAY__, __WEBPACK_AMD_DEFINE_RESULT__;!(__WEBPACK_AMD_DEFINE_ARRAY__ = [__webpack_require__(63), __webpack_require__(62)], __WEBPACK_AMD_DEFINE_RESULT__ = (function(PointEvent, DragAndDrop) {
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
/* 39 */
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
/* 40 */
/***/ function(module, exports, __webpack_require__) {

var __WEBPACK_AMD_DEFINE_ARRAY__, __WEBPACK_AMD_DEFINE_RESULT__;!(__WEBPACK_AMD_DEFINE_ARRAY__ = [__webpack_require__(60)], __WEBPACK_AMD_DEFINE_RESULT__ = (function(_) {
  'use strict';
  return _;
}.apply(null, __WEBPACK_AMD_DEFINE_ARRAY__)), __WEBPACK_AMD_DEFINE_RESULT__ !== undefined && (module.exports = __WEBPACK_AMD_DEFINE_RESULT__));


/***/ },
/* 41 */
/***/ function(module, exports, __webpack_require__) {

var __WEBPACK_AMD_DEFINE_ARRAY__, __WEBPACK_AMD_DEFINE_RESULT__;!(__WEBPACK_AMD_DEFINE_ARRAY__ = [__webpack_require__(66)], __WEBPACK_AMD_DEFINE_RESULT__ = (function(ContextMenu) {
  'use strict';
  var onadd, onchange, oncontextmenu, onremove;
  onadd = function(container, component, index, e) {
    var maps;
    if (component.event_map) {
      maps = component.event_map();
      this.eventEngine.add(component, maps, component);
    }
    if (component.onadded) {
      component.onadded(container);
    }
    return component.draw();
  };
  onremove = function(container, component) {
    if (component.onremoved) {
      component.onremoved(container);
    }
    return this.eventEngine.remove(component);
  };
  oncontextmenu = function(e, context) {
    return ContextMenu.show({
      x: e.origin.pageX,
      y: e.origin.pageY
    });
  };
  onchange = function(target, before, after) {
    console.log('TODO', 'think about html container on stage width/height change', after);
    if (after.hasOwnProperty('w')) {
      this.stage.html_container.style.width = after['w'] + 'px';
    }
    if (after.hasOwnProperty('h')) {
      return this.stage.html_container.style.height = after['h'] + 'px';
    }
  };
  return [
    ContextMenu, {
      '(root)': {
        '(root)': {
          'change': onchange
        },
        '(all)': {
          'add': onadd,
          'remove': onremove,
          'contextmenu': oncontextmenu,
          'longtouch': oncontextmenu
        }
      }
    }
  ];
}.apply(null, __WEBPACK_AMD_DEFINE_ARRAY__)), __WEBPACK_AMD_DEFINE_RESULT__ !== undefined && (module.exports = __WEBPACK_AMD_DEFINE_RESULT__));


/***/ },
/* 42 */
/***/ function(module, exports, __webpack_require__) {

var __WEBPACK_AMD_DEFINE_ARRAY__, __WEBPACK_AMD_DEFINE_RESULT__;!(__WEBPACK_AMD_DEFINE_ARRAY__ = [], __WEBPACK_AMD_DEFINE_RESULT__ = (function() {
  'use strict';
  var onchange, onrootchange, redraw;
  redraw = function(e) {
    return this.draw();
  };
  onchange = function(target, before, after) {
    if (after.hasOwnProperty('x')) {
      this.canvas.style.left = after['x'] + 'px';
    }
    if (after.hasOwnProperty('y')) {
      this.canvas.style.top = after['y'] + 'px';
    }
    if (after.hasOwnProperty('w')) {
      this.canvas.setAttribute('width', after['w']);
    }
    if (after.hasOwnProperty('h')) {
      this.canvas.setAttribute('height', after['h']);
    }
    return this.draw();
  };
  onrootchange = function(target, before, after) {
    var set, x, y;
    if (this.get('resizable') === false) {
      return;
    }
    set = {};
    x = this.get('x') || 0;
    y = this.get('y') || 0;
    if (after.hasOwnProperty('w')) {
      set.w = after.w - x;
    }
    if (after.hasOwnProperty('h')) {
      set.h = after.h - y;
    }
    return this.set(set);
  };
  return {
    '(root)': {
      '(root)': {
        'change': onrootchange
      }
    },
    '(self)': {
      '(all)': {
        'added': redraw,
        'removed': redraw,
        'change': redraw
      },
      '(self)': {
        'change': onchange
      }
    }
  };
}.apply(null, __WEBPACK_AMD_DEFINE_ARRAY__)), __WEBPACK_AMD_DEFINE_RESULT__ !== undefined && (module.exports = __WEBPACK_AMD_DEFINE_RESULT__));


/***/ },
/* 43 */
/***/ function(module, exports, __webpack_require__) {

var __WEBPACK_AMD_DEFINE_ARRAY__, __WEBPACK_AMD_DEFINE_RESULT__;!(__WEBPACK_AMD_DEFINE_ARRAY__ = [__webpack_require__(65)], __WEBPACK_AMD_DEFINE_RESULT__ = (function(Command) {
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
/* 44 */
/***/ function(module, exports, __webpack_require__) {

var __WEBPACK_AMD_DEFINE_ARRAY__, __WEBPACK_AMD_DEFINE_RESULT__;!(__WEBPACK_AMD_DEFINE_ARRAY__ = [], __WEBPACK_AMD_DEFINE_RESULT__ = (function() {
  'use strict';
  var properties;
  return properties = {
    'id': {
      'type': 'string'
    },
    'capturable': {
      'type': 'boolean'
    },
    'draggable': {
      'type': 'boolean'
    },
    'resizable': {
      'type': 'boolean'
    },
    'tag': {
      'type': 'array'
    }
  };
}.apply(null, __WEBPACK_AMD_DEFINE_ARRAY__)), __WEBPACK_AMD_DEFINE_RESULT__ !== undefined && (module.exports = __WEBPACK_AMD_DEFINE_RESULT__));


/***/ },
/* 45 */
/***/ function(module, exports, __webpack_require__) {

var __WEBPACK_AMD_DEFINE_ARRAY__, __WEBPACK_AMD_DEFINE_RESULT__;!(__WEBPACK_AMD_DEFINE_ARRAY__ = [], __WEBPACK_AMD_DEFINE_RESULT__ = (function() {
  'use strict';
  var properties;
  return properties = {
    x: {
      type: 'number',
      "default": 0
    },
    y: {
      type: 'number',
      "default": 0
    },
    w: {
      type: 'number'
    },
    h: {
      type: 'number'
    },
    rotate: {
      type: 'number',
      "default": 0
    }
  };
}.apply(null, __WEBPACK_AMD_DEFINE_ARRAY__)), __WEBPACK_AMD_DEFINE_RESULT__ !== undefined && (module.exports = __WEBPACK_AMD_DEFINE_RESULT__));


/***/ },
/* 46 */
/***/ function(module, exports, __webpack_require__) {

var __WEBPACK_AMD_DEFINE_ARRAY__, __WEBPACK_AMD_DEFINE_RESULT__;!(__WEBPACK_AMD_DEFINE_ARRAY__ = [], __WEBPACK_AMD_DEFINE_RESULT__ = (function() {
  'use strict';
  var properties;
  return properties = {
    lineWidth: {
      type: 'number'
    },
    lineJoin: {
      type: 'string'
    },
    lineDash: {
      type: 'array'
    },
    lineDashOffset: {
      type: 'number'
    },
    fillStyle: {
      type: 'string'
    },
    strokeStyle: {
      type: 'string'
    },
    alpha: {
      type: 'number'
    }
  };
}.apply(null, __WEBPACK_AMD_DEFINE_ARRAY__)), __WEBPACK_AMD_DEFINE_RESULT__ !== undefined && (module.exports = __WEBPACK_AMD_DEFINE_RESULT__));


/***/ },
/* 47 */
/***/ function(module, exports, __webpack_require__) {

var __WEBPACK_AMD_DEFINE_ARRAY__, __WEBPACK_AMD_DEFINE_RESULT__;!(__WEBPACK_AMD_DEFINE_ARRAY__ = [], __WEBPACK_AMD_DEFINE_RESULT__ = (function() {
  "use strict";
  var Dockable;
  return Dockable = {
    dockType: function() {},
    dockPoints: function() {
      var h, w, x, y;
      x = this.get('x');
      y = this.get('y');
      w = this.get('w');
      h = this.get('h');
      return [[x, y], [x + w, y], [x, y + h], [x + w, y + h]];
    }
  };
}.apply(null, __WEBPACK_AMD_DEFINE_ARRAY__)), __WEBPACK_AMD_DEFINE_RESULT__ !== undefined && (module.exports = __WEBPACK_AMD_DEFINE_RESULT__));


/***/ },
/* 48 */
/***/ function(module, exports, __webpack_require__) {

var __WEBPACK_AMD_DEFINE_ARRAY__, __WEBPACK_AMD_DEFINE_RESULT__;!(__WEBPACK_AMD_DEFINE_ARRAY__ = [], __WEBPACK_AMD_DEFINE_RESULT__ = (function() {
  "use strict";
  var GroupShapable;
  return GroupShapable = {
    center: function() {
      return {
        x: this.get('x') + this.get('w') / 2,
        y: this.get('y') + this.get('h') / 2
      };
    },
    shape: function(context) {
      return context.rect(this.get('x'), this.get('y'), this.get('w'), this.get('h'));
    },
    draw: function(context) {
      var center, rotate;
      if (!context) {
        return this.getContainer().draw();
      }
      context.beginPath();
      rotate = this.get('rotate') || 0;
      center = this.center();
      context.save();
      context.translate(center.x, center.y);
      context.rotate(rotate * Math.PI / 180);
      context.translate(-center.x, -center.y);
      this.shape(context);
      if (this.get('fillStyle')) {
        context.fillStyle = this.get('fillStyle');
        context.fill();
      }
      if (this.get('strokeStyle')) {
        context.lineWidth = this.get('lineWidth');
        context.strokeStyle = this.get('strokeStyle');
        context.stroke();
      }
      if (this.get('clip')) {
        context.clip();
      }
      context.translate(this.get('x'), this.get('y'));
      this.forEach(function(child) {
        return child.draw(context);
      });
      return context.restore();
    },
    capture: function(position, context) {
      var captured, center, child, i, inbound, rotate, _i, _ref;
      context.beginPath();
      center = this.center();
      rotate = (this.get('rotate') || 0) * Math.PI / 180;
      context.save();
      context.translate(center.x, center.y);
      context.rotate(rotate);
      context.translate(-center.x, -center.y);
      this.shape(context);
      context.lineWidth = this.get('lineWidth');
      captured = null;
      inbound = context.isPointInPath(position.x, position.y) || (!!this.get('strokeStyle') && context.isPointInStroke(position.x, position.y));
      if (!this.get('clip') || inbound) {
        if (this.size() > 0) {
          context.translate(this.get('x'), this.get('y'));
          for (i = _i = _ref = this.size() - 1; _ref <= 0 ? _i <= 0 : _i >= 0; i = _ref <= 0 ? ++_i : --_i) {
            child = this.getAt(i);
            captured = child.capture(position, context);
            if (captured) {
              break;
            }
          }
        }
      }
      context.restore();
      if (captured) {
        return captured;
      }
      if (this.get('capturable') === false) {
        return null;
      }
      if (inbound) {
        return this;
      }
      return null;
    }
  };
}.apply(null, __WEBPACK_AMD_DEFINE_ARRAY__)), __WEBPACK_AMD_DEFINE_RESULT__ !== undefined && (module.exports = __WEBPACK_AMD_DEFINE_RESULT__));


/***/ },
/* 49 */
/***/ function(module, exports, __webpack_require__) {

var __WEBPACK_AMD_DEFINE_ARRAY__, __WEBPACK_AMD_DEFINE_RESULT__;!(__WEBPACK_AMD_DEFINE_ARRAY__ = [], __WEBPACK_AMD_DEFINE_RESULT__ = (function() {
  "use strict";
  var Serializable;
  return Serializable = {
    objectify: function() {
      var components, content;
      if (typeof this.forEach === 'function') {
        components = [];
        this.forEach(function(child) {
          return components.push(child.objectify());
        });
      }
      content = {
        type: this.type,
        config: this.config()
      };
      if (components) {
        content.components = components;
      }
      return content;
    },
    serialize: function() {
      return JSON.stringify(this.objectify());
    }
  };
}.apply(null, __WEBPACK_AMD_DEFINE_ARRAY__)), __WEBPACK_AMD_DEFINE_RESULT__ !== undefined && (module.exports = __WEBPACK_AMD_DEFINE_RESULT__));


/***/ },
/* 50 */
/***/ function(module, exports, __webpack_require__) {

var __WEBPACK_AMD_DEFINE_ARRAY__, __WEBPACK_AMD_DEFINE_RESULT__;!(__WEBPACK_AMD_DEFINE_ARRAY__ = [], __WEBPACK_AMD_DEFINE_RESULT__ = (function() {
  "use strict";
  var Shapable;
  return Shapable = {
    bound: function() {
      return {
        x: this.get('x'),
        y: this.get('y'),
        w: this.get('w'),
        h: this.get('h')
      };
    },
    center: function() {
      var bound;
      bound = this.bound();
      return {
        x: bound.x + bound.w / 2,
        y: bound.y + bound.h / 2
      };
    },
    shape: function(context) {},
    capture_shape: function(context) {
      return this.shape(context);
    },
    draw: function(context) {
      var center, rotate;
      if (!context) {
        return this.getContainer().draw();
      }
      context.beginPath();
      rotate = this.get('rotate') || 0;
      center = this.center();
      context.save();
      context.translate(center.x, center.y);
      context.rotate(rotate * Math.PI / 180);
      context.translate(-center.x, -center.y);
      if (this.get('alpha')) {
        context.globalAlpha = this.get('alpha') * context.globalAlpha;
      }
      this.shape(context);
      if (this.get('fillStyle')) {
        context.fillStyle = this.get('fillStyle');
        context.fill();
      }
      if (this.get('strokeStyle')) {
        context.lineWidth = this.get('lineWidth');
        context.lineJoin = this.get('lineJoin');
        if (this.get('lineDash')) {
          context.setLineDash(this.get('lineDash'));
          context.lineDashOffset = this.get('lineDashOffset');
        }
        context.strokeStyle = this.get('strokeStyle');
        context.stroke();
      }
      return context.restore();
    },
    capture: function(position, context) {
      var center, itsme, rotate;
      context.beginPath();
      rotate = this.get('rotate') || 0;
      center = this.center();
      context.save();
      context.translate(center.x, center.y);
      context.rotate(rotate * Math.PI / 180);
      context.translate(-center.x, -center.y);
      this.capture_shape(context);
      if (this.get('lineWidth')) {
        context.lineWidth = this.get('lineWidth') + 10;
      }
      itsme = (!!this.get('strokeStyle') && context.isPointInStroke(position.x, position.y)) || (!!this.get('fillStyle') && context.isPointInPath(position.x, position.y));
      context.restore();
      if (itsme) {
        return this;
      }
      return null;
    }
  };
}.apply(null, __WEBPACK_AMD_DEFINE_ARRAY__)), __WEBPACK_AMD_DEFINE_RESULT__ !== undefined && (module.exports = __WEBPACK_AMD_DEFINE_RESULT__));


/***/ },
/* 51 */
/***/ function(module, exports, __webpack_require__) {

var __WEBPACK_AMD_DEFINE_ARRAY__, __WEBPACK_AMD_DEFINE_RESULT__;var __hasProp = {}.hasOwnProperty;

!(__WEBPACK_AMD_DEFINE_ARRAY__ = [__webpack_require__(40)], __WEBPACK_AMD_DEFINE_RESULT__ = (function(_) {
  "use strict";
  var WithProperty;
  return WithProperty = {
    config: function(attr) {
      if (attr) {
        return this.configs[attr];
      } else {
        return this.configs;
      }
    },
    configure: function(key, val) {
      var attrs, configs, spec;
      if (!key) {
        return this;
      }
      if (arguments.length > 1 && typeof arguments[0] === 'string') {
        configs = {};
        configs[key] = val;
        return this.configure(configs);
      }
      this.configs || (this.configs = {});
      console.log('configure', key);
      configs = key;
      attrs = {};
      for (key in configs) {
        if (!__hasProp.call(configs, key)) continue;
        val = configs[key];
        spec = this.property_spec[key];
        if (!spec) {
          continue;
        }
        this.configs[key] = val;
        attrs[key] = spec.transform ? spec.transform(val) : val;
      }
      this.set(attrs);
      return this;
    },
    silentSet: function(key, val) {
      var attrs;
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
      _.assign(this.attrs, attrs);
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
      return this.attrs[attr];
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
/* 52 */
/***/ function(module, exports, __webpack_require__) {

var __WEBPACK_AMD_DEFINE_ARRAY__, __WEBPACK_AMD_DEFINE_RESULT__;!(__WEBPACK_AMD_DEFINE_ARRAY__ = [], __WEBPACK_AMD_DEFINE_RESULT__ = (function() {
  "use strict";
  var WithLifeCycle;
  return WithLifeCycle = {
    initialize: function(configs, property_spec) {
      var property, spec, value, _ref;
      this.configs = configs;
      this.property_spec = property_spec;
      this.attrs = {};
      _ref = this.property_spec;
      for (property in _ref) {
        spec = _ref[property];
        value = null;
        if (this.configs.hasOwnProperty(property)) {
          value = this.configs[property];
        } else if (spec.hasOwnProperty('default')) {
          value = spec["default"];
        }
        this.attrs[property] = value;
      }
      return this;
    },
    dispose: function() {}
  };
}.apply(null, __WEBPACK_AMD_DEFINE_ARRAY__)), __WEBPACK_AMD_DEFINE_RESULT__ !== undefined && (module.exports = __WEBPACK_AMD_DEFINE_RESULT__));


/***/ },
/* 53 */
/***/ function(module, exports, __webpack_require__) {

var __WEBPACK_AMD_DEFINE_ARRAY__, __WEBPACK_AMD_DEFINE_RESULT__;!(__WEBPACK_AMD_DEFINE_ARRAY__ = [__webpack_require__(40), __webpack_require__(64)], __WEBPACK_AMD_DEFINE_RESULT__ = (function(_, Collection) {
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
/* 54 */
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
/* 55 */
/***/ function(module, exports, __webpack_require__) {

var __WEBPACK_AMD_DEFINE_ARRAY__, __WEBPACK_AMD_DEFINE_RESULT__;!(__WEBPACK_AMD_DEFINE_ARRAY__ = [], __WEBPACK_AMD_DEFINE_RESULT__ = (function() {
  'use strict';
  var properties;
  return properties = {
    path: {
      type: 'array'
    }
  };
}.apply(null, __WEBPACK_AMD_DEFINE_ARRAY__)), __WEBPACK_AMD_DEFINE_RESULT__ !== undefined && (module.exports = __WEBPACK_AMD_DEFINE_RESULT__));


/***/ },
/* 56 */
/***/ function(module, exports, __webpack_require__) {

var __WEBPACK_AMD_DEFINE_ARRAY__, __WEBPACK_AMD_DEFINE_RESULT__;!(__WEBPACK_AMD_DEFINE_ARRAY__ = [], __WEBPACK_AMD_DEFINE_RESULT__ = (function() {
  'use strict';
  var properties;
  return properties = {
    font: {
      type: 'string',
      "default": 'normal 10px verdana'
    }
  };
}.apply(null, __WEBPACK_AMD_DEFINE_ARRAY__)), __WEBPACK_AMD_DEFINE_RESULT__ !== undefined && (module.exports = __WEBPACK_AMD_DEFINE_RESULT__));


/***/ },
/* 57 */
/***/ function(module, exports, __webpack_require__) {

var __WEBPACK_AMD_DEFINE_ARRAY__, __WEBPACK_AMD_DEFINE_RESULT__;!(__WEBPACK_AMD_DEFINE_ARRAY__ = [], __WEBPACK_AMD_DEFINE_RESULT__ = (function() {
  'use strict';
  var properties;
  return properties = {
    x1: {
      type: 'number',
      "default": 0
    },
    y1: {
      type: 'number',
      "default": 0
    },
    x2: {
      type: 'number',
      "default": 100
    },
    y2: {
      type: 'number',
      "default": 100
    }
  };
}.apply(null, __WEBPACK_AMD_DEFINE_ARRAY__)), __WEBPACK_AMD_DEFINE_RESULT__ !== undefined && (module.exports = __WEBPACK_AMD_DEFINE_RESULT__));


/***/ },
/* 58 */
/***/ function(module, exports, __webpack_require__) {

var __WEBPACK_AMD_DEFINE_ARRAY__, __WEBPACK_AMD_DEFINE_RESULT__;!(__WEBPACK_AMD_DEFINE_ARRAY__ = [], __WEBPACK_AMD_DEFINE_RESULT__ = (function() {
  'use strict';
  var prettyprint;
  return prettyprint = function(object, depth, embedded) {
    var content, item, k, key, newline, pretty, spacer;
    if (depth > 2) {
      return object;
    }
    typeof depth === "number" || (depth = 0);
    typeof embedded === "boolean" || (embedded = false);
    newline = false;
    spacer = function(depth) {
      var i, spaces, _i, _ref;
      spaces = "";
      for (i = _i = 0, _ref = depth - 1; 0 <= _ref ? _i <= _ref : _i >= _ref; i = 0 <= _ref ? ++_i : --_i) {
        spaces += "  ";
        return spaces;
      }
    };
    pretty = "";
    if (typeof object === "undefined") {
      pretty += "undefined";
    } else if (typeof object === "boolean" || typeof object === "number") {
      pretty += object.toString();
    } else if (typeof object === "string") {
      pretty += "\"" + object + "\"";
    } else if (object === null) {
      pretty += "null";
    } else if (object instanceof Array) {
      if (object.length > 0) {
        if (embedded) {
          newline = true;
        }
        content = "";
        for (k in object) {
          item = object[k];
          content += pp(item, depth + 1) + ",\n" + spacer(depth + 1);
        }
        content = content.replace(/,\n\s*$/, "").replace(/^\s*/, "");
        pretty += "[ " + content + "\n" + spacer(depth) + "]";
      } else {
        pretty += "[]";
      }
    } else if (typeof object === "object") {
      if (Object.keys(object).length > 0) {
        if (embedded) {
          newline = true;
        }
        content = "";
        for (key in object) {
          content += spacer(depth + 1) + key.toString() + ": " + pp(object[key], depth + 2, true) + ",\n";
        }
        content = content.replace(/,\n\s*$/, "").replace(/^\s*/, "");
        pretty += "{ " + content + "\n" + spacer(depth) + "}";
      } else {
        pretty += "{}";
      }
    } else {
      pretty += object.toString();
    }
    return (newline ? "\n" + spacer(depth) : "") + pretty;
  };
}.apply(null, __WEBPACK_AMD_DEFINE_ARRAY__)), __WEBPACK_AMD_DEFINE_RESULT__ !== undefined && (module.exports = __WEBPACK_AMD_DEFINE_RESULT__));


/***/ },
/* 59 */
/***/ function(module, exports, __webpack_require__) {

var __WEBPACK_AMD_DEFINE_ARRAY__, __WEBPACK_AMD_DEFINE_RESULT__;var __hasProp = {}.hasOwnProperty,
  __extends = function(child, parent) { for (var key in parent) { if (__hasProp.call(parent, key)) child[key] = parent[key]; } function ctor() { this.constructor = child; } ctor.prototype = parent.prototype; child.prototype = new ctor(); child.__super__ = parent.prototype; return child; };

!(__WEBPACK_AMD_DEFINE_ARRAY__ = [__webpack_require__(27), __webpack_require__(50), __webpack_require__(44), __webpack_require__(46)], __WEBPACK_AMD_DEFINE_RESULT__ = (function(Handle, Shapable, ComponentProps, Graphic) {
  'use strict';
  var SplitHandle, parent_groups_translate;
  parent_groups_translate = function(item, context, container) {
    var center, parent, rotate;
    parent = item.getContainer();
    if (!parent.canvas) {
      parent_groups_translate(parent, context, true);
    }
    if (!container) {
      return;
    }
    rotate = item.get('rotate') || 0;
    center = item.center();
    context.translate(center.x, center.y);
    context.rotate(rotate * Math.PI / 180);
    context.translate(-center.x, -center.y);
    return context.translate(item.get('x'), item.get('y'));
  };
  return SplitHandle = (function(_super) {
    __extends(SplitHandle, _super);

    function SplitHandle() {
      return SplitHandle.__super__.constructor.apply(this, arguments);
    }

    SplitHandle.include(Shapable);

    SplitHandle.prototype.center = function() {
      return {
        x: this.get('x'),
        y: this.get('y')
      };
    };

    SplitHandle.prototype.shape = function(context) {
      var center, radius, rotate, target;
      target = this.getContainer().target;
      context.save();
      parent_groups_translate(target, context);
      center = target.center();
      rotate = target.get('rotate');
      context.translate(center.x, center.y);
      context.rotate(rotate * Math.PI / 180);
      context.translate(-center.x, -center.y);
      radius = this.get('r');
      context.rect(this.get('x') - radius, this.get('y') - radius, 2 * radius, 2 * radius);
      return context.restore();
    };

    SplitHandle.prototype.event_map = function() {
      return [];
    };

    SplitHandle.spec = {
      type: 'handle',
      source: 'core:handle.SplitHandle',
      containable: false,
      description: 'Path Splitter Handle',
      dependencies: {},
      properties: [
        ComponentProps, Graphic, {
          x: {
            type: 'number'
          },
          y: {
            type: 'number'
          },
          r: {
            type: 'number'
          },
          index: {
            type: 'string'
          }
        }
      ]
    };

    return SplitHandle;

  })(Handle);
}.apply(null, __WEBPACK_AMD_DEFINE_ARRAY__)), __WEBPACK_AMD_DEFINE_RESULT__ !== undefined && (module.exports = __WEBPACK_AMD_DEFINE_RESULT__));


/***/ },
/* 60 */
/***/ function(module, exports, __webpack_require__) {

module.exports = __WEBPACK_EXTERNAL_MODULE_60__;

/***/ },
/* 61 */
/***/ function(module, exports, __webpack_require__) {

var __WEBPACK_AMD_DEFINE_ARRAY__, __WEBPACK_AMD_DEFINE_RESULT__;var __hasProp = {}.hasOwnProperty;

!(__WEBPACK_AMD_DEFINE_ARRAY__ = [__webpack_require__(40), __webpack_require__(33)], __WEBPACK_AMD_DEFINE_RESULT__ = (function(dou, ComponentSelector) {
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
/* 62 */
/***/ function(module, exports, __webpack_require__) {

var __WEBPACK_AMD_DEFINE_ARRAY__, __WEBPACK_AMD_DEFINE_RESULT__;!(__WEBPACK_AMD_DEFINE_ARRAY__ = [__webpack_require__(63)], __WEBPACK_AMD_DEFINE_RESULT__ = (function(PointEvent) {
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
/* 63 */
/***/ function(module, exports, __webpack_require__) {

var __WEBPACK_AMD_DEFINE_ARRAY__, __WEBPACK_AMD_DEFINE_RESULT__;!(__WEBPACK_AMD_DEFINE_ARRAY__ = [__webpack_require__(40)], __WEBPACK_AMD_DEFINE_RESULT__ = (function(_) {
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
/* 64 */
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


/***/ },
/* 65 */
/***/ function(module, exports, __webpack_require__) {

var __WEBPACK_AMD_DEFINE_ARRAY__, __WEBPACK_AMD_DEFINE_RESULT__;!(__WEBPACK_AMD_DEFINE_ARRAY__ = [__webpack_require__(40)], __WEBPACK_AMD_DEFINE_RESULT__ = (function(_) {
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
/* 66 */
/***/ function(module, exports, __webpack_require__) {

var __WEBPACK_AMD_DEFINE_ARRAY__, __WEBPACK_AMD_DEFINE_RESULT__;!(__WEBPACK_AMD_DEFINE_ARRAY__ = [], __WEBPACK_AMD_DEFINE_RESULT__ = (function() {
  'use strict';
  var container, contextmenu, handler, hide, show, template;
  template = '<ul id="context-menu" class="things-context-menu"> <li><a href="http://cooking.hatiolab.com/">Cooking</a></li> <li><a href="http://www.naver.com">Naver</a></li> </ul>';
  container = document.createElement('div');
  container.style.position = 'absolute';
  container.style.display = 'inline-block';
  container.style.zIndex = 1000;
  document.body.appendChild(container);
  container.innerHTML = template;
  contextmenu = document.getElementById('context-menu');
  handler = function(e) {
    document.removeEventListener('click', handler);
    document.removeEventListener('touchstart', handler);
    return setTimeout(hide, 100);
  };
  show = function(position) {
    container.style.top = position.y + 'px';
    container.style.left = position.x + 'px';
    contextmenu.style.display = 'block';
    document.addEventListener('click', handler);
    return document.addEventListener('touchstart', handler);
  };
  hide = function() {
    return contextmenu.style.display = 'none';
  };
  return {
    show: show,
    hide: hide
  };
}.apply(null, __WEBPACK_AMD_DEFINE_ARRAY__)), __WEBPACK_AMD_DEFINE_RESULT__ !== undefined && (module.exports = __WEBPACK_AMD_DEFINE_RESULT__));


/***/ }
/******/ ])
})
