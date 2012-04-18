# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://jashkenas.github.com/coffee-script/
jQuery ->
  Stripe.setPublishableKey($('meta[name="stripe-key"]').attr('content'))
  transaction.setupForm()

transaction =
  setupForm: ->
    $('#new_transaction').submit ->
      if $('input[type=submit]').attr('disabled', true)
        transaction.processCard()
        false
      else
        true

  processCard: ->
    card = 
      number: '4242424242424242'
      cvc: '123'
      expMonth: '1'
      expYear: '2020'
    Stripe.createToken(card, transaction.handleStripeResponse)

  handleStripeResponse: (status, response) ->
    if status == 200
      $('#transaction_stripe_card_token').val(response.id)
      $('#new_transaction')[0].submit()
    else
      $('#stripe_error').text(response.error.message)
      $('input[type=submit]').attr('disabled', false)
