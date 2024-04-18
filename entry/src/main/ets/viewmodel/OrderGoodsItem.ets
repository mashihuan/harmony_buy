import GoodsItem from './GoodsItem'

@Observed
export default class OrderGoodsItem {
  id: number
  order_id: number
  goods_id: number
  num: number
  price: number
  goods?: GoodsItem
  user_id?: number
}