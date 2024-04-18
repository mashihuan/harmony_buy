import AddressItem from './AddressItem'
import OrderGoodsItem from './OrderGoodsItem'

@Observed
export default class OrderItem {
  id: number
  address_id: number
  total_num: number
  price: number
  status: number
  goods: OrderGoodsItem[]
  user_id?: number
  address?: AddressItem[]
}