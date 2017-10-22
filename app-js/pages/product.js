import { post } from '../utility/http'

const AddUrl = () => {
  $('.add-url button').click((e) => {
    const url = $('.add-url input').val()
    post('/api/private/products', { url: url})
      .then( ()=> $('.add-url input').val(''))
  })
}

export default AddUrl
