def valid_card_data
  exp_date = 3.months.from_now
  {
    number:      '4242424242424242',
    cvc:         '123',
    address_zip: '12312',
    exp_month:   exp_date.month,
    exp_year:    exp_date.year
  }
end