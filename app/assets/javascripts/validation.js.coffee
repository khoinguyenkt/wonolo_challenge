@validateSearchForm = ->
  $('#search-form').validate
    rules:
      "lat":
        required: true
        number: true
      "lng":
        required: true
        number: true
      "radius":
        min: 1
        max: 10
        number: true
