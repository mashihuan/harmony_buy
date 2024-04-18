import Empty from '../../components/Empty'
import OrderItem from '../../viewmodel/OrderItem'
import OrderList from './List'

@Component
export default struct OrderIndex {
  @Link orderList: OrderItem[]

  build() {
    if (this.orderList.length) {
      OrderList({orderList: $orderList})
    } else {
      Empty({ desc: '暂无此类订单...' })
    }
  }
}