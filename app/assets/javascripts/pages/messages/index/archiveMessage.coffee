App.messages.index = App.messages.index || {}

class App.messages.index.archiveMessage

  constructor: (@options = {}) ->
    @make()
    @bind()

  make: () ->
    @elementClass = '.js-archive-message'
    @$element = $(@elementClass)

  bind: () ->
    @$element.on 'click', (event) =>
      @row = $(event.target).closest('tr')
      event.preventDefault()
      $.ajax({
        url: @$element.attr('href'),
        type: 'put'
      }).always( =>
        @row.hide()
      )
