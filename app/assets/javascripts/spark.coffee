@App = @App || {}

@Spark =
  exec: (controller, action) ->
    ns = App
    action = (if (action is undefined) then 'init' else action)
    new ns[controller][action] if controller isnt '' and ns[controller] and typeof ns[controller][action] is 'function'

  init: ->
    body = document.body
    controller = body.getAttribute('data-controller')
    action = body.getAttribute('data-action')
    Spark.exec 'shared'
    Spark.exec controller
    Spark.exec controller, action
