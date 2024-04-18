import GoodsItem from './GoodsItem'

@Observed
export default class CartItem {
  id: number
  goods_id: number
  num: number
  goods: GoodsItem
  user_id?: number

  constructor(id: number, goods_id: number, num: number, goods: GoodsItem, user_id?: number) {
    this.id = id
    this.goods_id = goods_id
    this.num = num
    this.goods = goods
    this.user_id = user_id
  }
}