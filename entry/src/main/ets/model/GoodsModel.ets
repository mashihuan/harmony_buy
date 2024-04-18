import { baseRequest } from '../utils/Request'

class GoodsModel {
  getGoodsByCategory(data: unknown) {
    return baseRequest({
      url: '/goods',
      method: 'GET',
      params: data
    })
  }

  requestGoodsByCategory(data: unknown) {
    return baseRequest({
      url: '/goods/search',
      method: 'GET',
      params: data
    })
  }

  requestGoodsDetail(data: unknown) {
    return baseRequest({
      url: '/goods/detail',
      method: 'GET',
      params: data
    })
  }

  requestGoodsComment(data: unknown) {
    return baseRequest({
      url: '/comment',
      method: 'GET',
      params: data
    })
  }

  requestAllGoods() {
    return baseRequest({
      url: '/goods/search',
      method: 'GET',
      params: { keyword: '' }
    })
  }
}

 export default new GoodsModel