App.messages.index = App.messages.index || {}

class App.messages.index.archiveAllMessages

  constructor: (@options = {}) ->
    @make()
    @bind()

  make: () ->
    @elementClass = '.js-archive-all-messages'
    @$element = $(@elementClass)

  bind: () ->
    @$element.on 'click', (event) =>
      @rows = $('.table tr')
      event.preventDefault()
      $.ajax({
        url: @$element.attr('href'),
        type: 'delete'
      }).always( =>
        @rows.remove()
        $('#notice').html('Mensagens removidas.')
      )
