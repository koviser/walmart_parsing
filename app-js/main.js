require('./requireFiles')
import { AddUrl } from './pages'
import alertify              from 'alertify.js'
import { CustomDataTables } from './plugins'

$(window).ready( () => {
  alertify.parent(document.body)
  AddUrl()
  new CustomDataTables()
})
