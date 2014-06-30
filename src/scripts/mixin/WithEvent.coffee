# ==========================================
# Copyright 2014 Hatio, Lab.
# Licensed under The MIT License
# http://opensource.org/licenses/MIT
# ==========================================

define [
  '../util/Util'
  './Collection'
], (
  _
  Collection
) ->

  "use strict"

  WithEvent =
    # withEvent: ->
    #     (@[method] = Event[method]) for method in ['on', 'off', 'once', 'delegate_on', 'delegate_off', 'trigger']

    on: (name, callback, context) ->
      return @ if (!eventsApi(@, 'on', name, [callback, context]) || !callback)

      @_listeners || (@_listeners = {});
      events = @_listeners[name] || (@_listeners[name] = []);
      events.push
        callback: callback
        context: context
        ctx: context || @
      @

    # Bind an event to only be triggered a single time. After the first time
    # the callback is invoked, it will be removed.
    once: (name, callback, context) ->
      return @ if (!eventsApi(@, 'once', name, [callback, context]) || !callback)

      self = @

      once = _.once ->
        self.off name, once
        callback.apply @, arguments

      once._callback = callback

      @on name, once, context

    # Remove one or many callbacks. If `context` is null, removes all
    # callbacks with that function. If `callback` is null, removes all
    # callbacks for the event. If `name` is null, removes all bound
    # callbacks for all events.
    off: (name, callback, context) ->
      return @ if (!@_listeners || !eventsApi(@, 'off', name, [callback, context]))

      if (!name && !callback && !context)
        @_listeners = undefined;
        return @;

      names = if name then [name] else Object.keys(@_listeners);

      for name, i in names
        if (events = @_listeners[name])
          @_listeners[name] = retain = []
          if (callback || context)
            for ev, j in events
              if ((callback && callback isnt ev.callback && callback isnt ev.callback._callback) || (context && context isnt ev.context))
                retain.push ev

          delete @_listeners[name] if (!retain.length)

      @

    delegate_on: (delegator) ->
      @_delegators || (@_delegators = new Collection.List());
      @_delegators.append delegator

      @

    delegate_off: (delegator) ->
      return @ if not @_delegators
      @_delegators.remove delegator

      @

    delegate: ->
      delegateEvents(@_delegators, arguments) if @_delegators and @_delegators.size() > 0

      return @ if (!@_listeners)

      event = arguments[arguments.length - 1]
      event.deliverer = @

      listeners = @_listeners[event.name]
      listenersForAll = @_listeners.all

      triggerEvents(listeners, arguments) if (listeners)
      triggerEvents(listenersForAll, arguments) if (listenersForAll)

      @

    # Trigger one or many events, firing all bound callbacks. Callbacks are
    # passed the same arguments as `trigger` is, apart from the event name
    # (unless you're listening on `"all"`, which will cause your callback to
    # receive the true name of the event as the first argument).
    trigger: (name) ->
      args = [].slice.call(arguments, 1)

      args.push({
        origin: @,
        name: name,
        deliverer: @
      });

      delegateEvents(@_delegators, args) if @_delegators and @_delegators.size() > 0

      return @ if not @_listeners

      return @ if (!eventsApi(@, 'trigger', name, args))

      listeners = @_listeners[name]
      listenersForAll = @_listeners.all

      triggerEvents(listeners, args) if (listeners)
      triggerEvents(listenersForAll, args) if (listenersForAll)

      @

    # Tell @ object to stop listening to either specific events ... or
    # to every object it's currently listening to.
    stopListening: (obj, name, callback) ->
      listeningTo = @_listeningTo

      return @ if (!listeningTo)

      remove = !name && !callback;

      callback = @ if (!callback && typeof name is 'object')

      (listeningTo = {})[obj._listenId] = obj if (obj)

      for id, obj of listeningTo
        obj.off(name, callback, @)
        delete @_listeningTo[id] if (remove || _.isEmpty(obj._events))

      @

  # Regular expression used to split event strings.
  eventSplitter = /\s+/

  # Implement fancy features of the Event API such as multiple event
  # names `"change blur"` and jQuery-style event maps `{change: action}`
  # in terms of the existing API.
  eventsApi = (obj, action, name, rest) ->
    return true if !name

    # Handle event maps.
    if typeof name is 'object'
      obj[action].apply(obj, [key, val].concat(rest)) for key, val of name
      return false;

    # Handle space separated event names.
    if eventSplitter.test(name)
      names = name.split(eventSplitter)

      obj[action].apply(obj, [val].concat(rest)) for val in names

      return false;

    true

  triggerEvents = (listeners, args) ->
    ev.callback.apply(ev.ctx, args) for ev in listeners

  delegateEvents = (delegators, args) ->
    delegators.forEach (delegator) ->
      WithEvent.delegate.apply(delegator, args)

  listenMethods =
    listenTo: 'on'
    listenToOnce: 'once'

  # Inversion-of-control versions of `on` and `once`. Tell *@* object to
  # listen to an event in another object ... keeping track of what it's
  # listening to.
  for method, implementation of listenMethods
    WithEvent[method] = (obj, name, callback) ->
      listeningTo = @_listeningTo || (@_listeningTo = {})
      id = obj._listenId || (obj._listenId = _.uniqueId('l'))
      listeningTo[id] = obj
      callback = @ if (!callback && typeof name is 'object')
      obj[implementation](name, callback, @)

      return @

  WithEvent
