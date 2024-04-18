import { baseRequest } from '../utils/Request'

class BannerModel {
  requestBanner(data?: unknown) {
    return baseRequest({
      url: '/banner',
      method: 'GET',
      params: data
    })
  }
}

 export default new BannerModel