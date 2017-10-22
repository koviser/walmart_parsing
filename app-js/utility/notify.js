import alertify              from 'alertify.js'
import { isArray, isString } from 'lodash'

class Notify {
  static success (message) {
    alertify.success(message)
  }

  static error (error) {
    const { data } = error.response || {}

    let msg
    if (isArray(data)) {
      msg = data.join('<br />')
      alertify.alert(msg)
    } else if (data.message) {
      alertify.error(data.message)
    } else if (isString(data)) {
      alertify.alert(data)
    } else {
      alertify.error(error)
    }
  }
}

export default Notify
