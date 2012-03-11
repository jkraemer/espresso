$ ->
  $('#new_asset').fileupload()
  $('#new_asset').fileupload('option', {
    autoUpload: true,
    filesContainer: $('table tbody.files'),
    previewMaxWidth: 50,
    previewMaxHeight: 50
  })

  $('a.download').each (idx, link) ->
    link = $(link)
    url = link.attr('download')
    name = link.attr('title')
    type = 'application/octet-stream'
    arg = [type, name, url].join(':')
    link.bind 'dragstart', (ev) ->
      try
        console.log arg
        console.log 'dragstart: '
        console.log ev
        ev.originalEvent.dataTransfer.setData 'DownloadURL', arg
      catch e
        console.log e
