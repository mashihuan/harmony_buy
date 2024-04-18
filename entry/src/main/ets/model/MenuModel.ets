import { baseRequest } from '../utils/Request'

class MenuModel {
  requestMenu(data?: unknown) {
    return baseRequest({
      url: '/menu',
      method: 'GET',
      params: data
    })
  }

  requestMenuDetail(data?: unknown) {
    return baseRequest({
      url: '/menu/detail',
      method: 'GET',
      params: data
    })
  }
}

 export default new MenuModel