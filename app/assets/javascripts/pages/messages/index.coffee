App.messages = App.messages || {}

class App.messages.index

  constructor: (@options = {}) ->
    @make()

  make: () ->
    new App.messages.index.archiveMessage