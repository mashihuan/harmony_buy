import { baseRequest } from '../utils/Request'

class CategoryModel {
  getCategory(data?: unknown) {
    return baseRequest({
      url: '/category',
      method: 'GET',
      params: data
    })
  }

  getHomeCategory(data?: unknown) {
    return baseRequest({
      url: '/category/home',
      method: 'GET',
      params: data
    })
  }
}

 export default new CategoryModel