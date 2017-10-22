import http from 'axios'
import Notify from './notify'

const ok = (response, { data } = {}) =>{
  Notify.success(data || response.data)
}

const fail = (error, { data } = {}) => {
  Notify.error(error)
}

const get = (path, opts = {}) =>
  http
    .get(path, opts)
    .then(ok)
    .catch(fail)

const post = (path, opts = {}) =>
  http
    .post(path, opts)
    .then(ok)
    .catch(fail)

const patch = (path, opts = {}) =>
  http
    .patch(path, opts)
    .then(ok)
    .catch(fail)

const destroy = (path, opts = {}) =>
  http
    .delete(path, opts)
    .then(ok)
    .catch(fail)

export {
  http,
  ok,
  fail,
  get,
  post,
  patch,
  destroy
}
