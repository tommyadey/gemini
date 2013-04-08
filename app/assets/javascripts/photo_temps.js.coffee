# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://jashkenas.github.com/coffee-script/
jQuery ->
  $('#photo_temp_photo_path').fileupload
  	dataType: "script"
  	add: (e, data) ->
      types = /(\.|\/)(gif|jpe?g|png)$/i
      file = data.files[0]
      if types.test(file.type) || types.test(file.name)
        $('#photo_temp_photo_path').append(data.context)
        data.submit()
      else
        alert("#{file.name} is not a gif, jpeg, or png image file")