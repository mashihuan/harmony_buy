export class GoodsBanner {
  id: number
  goods_id: number
  url: string
}

export default class GoodsItem {
  id: number
  name: string
  desc: string
  icon: string
  new_price: number
  old_price: number
  category_id: number
  banner?: GoodsBanner[]
}